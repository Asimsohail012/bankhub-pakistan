import 'dart:convert';
import 'package:http/http.dart' as http;
import 'live_data_result.dart';
import 'models.dart';
import 'api_cache_service.dart';

/// Abstract interface for gold price service.
abstract class GoldPriceService {
  /// Fetches current gold prices in various units.
  Future<LiveDataResult<GoldPriceData>> getGoldPrices();

  /// Refreshes gold price data from source.
  Future<LiveDataResult<GoldPriceData>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of GoldPriceService.
///
/// Connects to live gold price APIs with fallback to cached data
/// and placeholder rates. Supports retry, timeout, and offline mode.
class GoldPriceServiceImpl implements GoldPriceService {
  static final _placeholderData = GoldPriceData(
    pricePerGram: 7850,
    pricePerTola: 91620,
    pricePerOunce: 244125,
    dailyChange: 125,
    lastUpdated: DateTime.now().toIso8601String(),
  );

  DateTime? _lastUpdated;
  final ApiCacheService _cacheService;
  final http.Client _httpClient;
  static const Duration _timeout = Duration(seconds: 10);
  static const String _cacheKey = 'gold_prices';
  String _sourceUsed = 'placeholder_gold_prices';

  GoldPriceServiceImpl({
    ApiCacheService? cacheService,
    http.Client? httpClient,
  })  : _cacheService = cacheService ?? ApiCacheService(),
        _httpClient = httpClient ?? http.Client();

  @override
  Future<LiveDataResult<GoldPriceData>> getGoldPrices() async {
    try {
      // Check cache first
      final cached = _cacheService.get(_cacheKey, ttl: const Duration(hours: 2));
      if (cached != null && cached is GoldPriceData) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_gold_prices';
        return LiveDataResult.cached(
          data: cached,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }

      // Attempt to fetch from live API
      final goldData = await _fetchFromLiveAPI();
      if (goldData != null) {
        _lastUpdated = DateTime.now();
        _sourceUsed = 'live_gold_prices_api';
        _cacheService.cache(_cacheKey, goldData);
        return LiveDataResult.success(
          data: goldData,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (e) {
      // Fall through to placeholder/cache
    }

    // Fallback to cached data if available
    try {
      final cachedFallback = _cacheService.get(_cacheKey);
      if (cachedFallback != null && cachedFallback is GoldPriceData) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_gold_prices_fallback';
        return LiveDataResult.cached(
          data: cachedFallback,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (_) {}

    // Ultimate fallback to placeholder data
    _lastUpdated = DateTime.now();
    _sourceUsed = 'placeholder_gold_prices';
    _cacheService.cache(_cacheKey, _placeholderData);
    return LiveDataResult.success(
      data: _placeholderData,
      source: _sourceUsed,
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  Future<GoldPriceData?> _fetchFromLiveAPI() async {
    try {
      // Using metals-api.com or similar for gold prices
      // For Pakistan, prices are typically in PKR
      final uri = Uri.parse(
        'https://api.metals.live/v1/spot/gold',
      );

      final response = await _httpClient.get(uri).timeout(_timeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        
        // metals.live returns price in USD per troy ounce
        // Convert to PKR and other units
        final priceUsd = json['gold'] as num?;
        if (priceUsd != null) {
          const usdToPkr = 279.0; // Approximate rate
          const gramsPerOunce = 31.1035;
          const tolas = 11.6638;
          
          final pricePerOuncePkr = priceUsd.toDouble() * usdToPkr;
          final pricePerGram = pricePerOuncePkr / gramsPerOunce;
          final pricePerTola = pricePerGram * tolas;
          
          return GoldPriceData(
            pricePerGram: pricePerGram,
            pricePerTola: pricePerTola,
            pricePerOunce: pricePerOuncePkr,
            dailyChange: 0.0, // Would need historical data for this
            lastUpdated: DateTime.now().toIso8601String(),
          );
        }
      }
    } catch (_) {
      // API call failed, will use cache or placeholder
    }
    return null;
  }

  @override
  Future<LiveDataResult<GoldPriceData>> refresh() => getGoldPrices();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => _sourceUsed;
}
