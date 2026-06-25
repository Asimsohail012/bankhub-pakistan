import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_result.dart';

class ApiClient {
  ApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const Duration _timeout = Duration(seconds: 10);
  static const int _maxRetries = 2;

  Future<Map<String, dynamic>> getJson(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final response = await _retryRequest(
      () => _httpClient.get(uri, headers: headers),
      retryCount: _maxRetries,
    );

    if (response.statusCode != 200) {
      throw http.ClientException('Unexpected status: ${response.statusCode}', uri);
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<dynamic>> getJsonList(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    final response = await _retryRequest(
      () => _httpClient.get(uri, headers: headers),
      retryCount: _maxRetries,
    );

    if (response.statusCode != 200) {
      throw http.ClientException('Unexpected status: ${response.statusCode}', uri);
    }

    return jsonDecode(response.body) as List<dynamic>;
  }

  Future<http.Response> _retryRequest(
    Future<http.Response> Function() request, {
    required int retryCount,
  }) async {
    late http.Response response;

    for (var attempt = 0; attempt <= retryCount; attempt++) {
      try {
        response = await request().timeout(_timeout);
        return response;
      } on TimeoutException {
        if (attempt == retryCount) rethrow;
      } on http.ClientException {
        if (attempt == retryCount) rethrow;
      }
    }

    return response;
  }

  Future<ApiResult<List<T>>> fetchListWithCache<T>(
    String cacheKey,
    Uri uri,
    T Function(Map<String, dynamic> json) itemParser, {
    Map<String, String>? headers,
    List<T>? fallback,
  }) async {
    try {
      final rawList = await getJsonList(uri, headers: headers);
      final parsed = rawList
          .map((item) => itemParser(item as Map<String, dynamic>))
          .toList(growable: false);
      await _saveCache(cacheKey, jsonEncode(rawList));
      _saveCacheTimestamp(cacheKey);
      return ApiResult(data: parsed, updatedAt: DateTime.now());
    } catch (_) {
      final fallbackResult = await _loadListFromCache(cacheKey, itemParser);
      if (fallbackResult != null) {
        return fallbackResult;
      }
      return ApiResult(
        data: fallback ?? <T>[],
        updatedAt: DateTime.now(),
        fromCache: false,
      );
    }
  }

  Future<ApiResult<T>> fetchObjectWithCache<T>(
    String cacheKey,
    Uri uri,
    T Function(Map<String, dynamic> json) parser, {
    Map<String, String>? headers,
    T? fallback,
  }) async {
    try {
      final rawJson = await getJson(uri, headers: headers);
      final parsed = parser(rawJson);
      await _saveCache(cacheKey, jsonEncode(rawJson));
      _saveCacheTimestamp(cacheKey);
      return ApiResult(data: parsed, updatedAt: DateTime.now());
    } catch (_) {
      final fallbackResult = await _loadObjectFromCache(cacheKey, parser);
      if (fallbackResult != null) {
        return fallbackResult;
      }
      return ApiResult(
        data: fallback as T,
        updatedAt: DateTime.now(),
        fromCache: false,
      );
    }
  }

  Future<void> _saveCache(String key, String rawJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_cache:$key', rawJson);
  }

  Future<void> _saveCacheTimestamp(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_cache_timestamp:$key', DateTime.now().toIso8601String());
  }

  Future<ApiResult<List<T>>?> _loadListFromCache<T>(
    String cacheKey,
    T Function(Map<String, dynamic> json) itemParser,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString('api_cache:$cacheKey');
    final timestampString = prefs.getString('api_cache_timestamp:$cacheKey');
    if (rawJson == null || timestampString == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      final parsed = decoded
          .cast<Map<String, dynamic>>()
          .map(itemParser)
          .toList(growable: false);
      return ApiResult(
        data: parsed,
        updatedAt: DateTime.parse(timestampString),
        fromCache: true,
      );
    } catch (_) {
      return null;
    }
  }

  Future<ApiResult<T>?> _loadObjectFromCache<T>(
    String cacheKey,
    T Function(Map<String, dynamic> json) parser,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString('api_cache:$cacheKey');
    final timestampString = prefs.getString('api_cache_timestamp:$cacheKey');
    if (rawJson == null || timestampString == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
      return ApiResult(
        data: parser(decoded),
        updatedAt: DateTime.parse(timestampString),
        fromCache: true,
      );
    } catch (_) {
      return null;
    }
  }
}
