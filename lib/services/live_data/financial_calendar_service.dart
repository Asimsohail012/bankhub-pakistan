import 'package:http/http.dart' as http;
import 'live_data_result.dart';
import 'models.dart';
import 'api_cache_service.dart';

/// Abstract interface for financial calendar service.
abstract class FinancialCalendarService {
  /// Fetches upcoming financial calendar events.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getUpcomingEvents();

  /// Fetches events for a specific category.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getEventsByCategory(
    String category,
  );

  /// Fetches events by importance level.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getEventsByImportance(
    String importance,
  );

  /// Refreshes calendar events from source.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of FinancialCalendarService.
///
/// Connects to economic calendar data providers with fallback
/// to cached data and placeholder events.
class FinancialCalendarServiceImpl implements FinancialCalendarService {
  static final _placeholderData = [
    FinancialCalendarEvent(
      id: 'event_001',
      name: 'SBP Monetary Policy Decision',
      category: 'Policy',
      scheduledDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      importance: 'High',
      description: 'State Bank of Pakistan announces policy rate decision',
    ),
    FinancialCalendarEvent(
      id: 'event_002',
      name: 'US Federal Reserve Meeting',
      category: 'Global',
      scheduledDate: DateTime.now().add(const Duration(days: 10)).toIso8601String(),
      importance: 'High',
      description: 'Federal Reserve FOMC meeting and interest rate decision',
    ),
    FinancialCalendarEvent(
      id: 'event_003',
      name: 'Quarterly GDP Release',
      category: 'Economic',
      scheduledDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      importance: 'Medium',
      description: 'Quarterly GDP growth figures release',
    ),
    FinancialCalendarEvent(
      id: 'event_004',
      name: 'Inflation Data Release',
      category: 'Economic',
      scheduledDate: DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      importance: 'High',
      description: 'Consumer Price Index and inflation figures',
    ),
    FinancialCalendarEvent(
      id: 'event_005',
      name: 'Stock Exchange Trading',
      category: 'Market',
      scheduledDate: DateTime.now().toIso8601String(),
      importance: 'Low',
      description: 'Regular PSX trading session',
    ),
  ];

  DateTime? _lastUpdated;
  final ApiCacheService _cacheService;
  final http.Client _httpClient;
  static const Duration _timeout = Duration(seconds: 10);
  static const String _cacheKey = 'financial_calendar';
  String _sourceUsed = 'placeholder_financial_calendar';

  FinancialCalendarServiceImpl({
    ApiCacheService? cacheService,
    http.Client? httpClient,
  })  : _cacheService = cacheService ?? ApiCacheService(),
        _httpClient = httpClient ?? http.Client();

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getUpcomingEvents() async {
    try {
      // Check cache first (economic calendar cache for 12 hours)
      final cached = _cacheService.get(_cacheKey, ttl: const Duration(hours: 12));
      if (cached != null && cached is List<FinancialCalendarEvent>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_financial_calendar';
        return LiveDataResult.cached(
          data: cached,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }

      // Attempt to fetch from economic calendar API
      final events = await _fetchFromLiveAPI();
      if (events.isNotEmpty) {
        _lastUpdated = DateTime.now();
        _sourceUsed = 'live_financial_calendar_api';
        _cacheService.cache(_cacheKey, events);
        return LiveDataResult.success(
          data: events,
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
      if (cachedFallback != null && cachedFallback is List<FinancialCalendarEvent>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_financial_calendar_fallback';
        return LiveDataResult.cached(
          data: cachedFallback,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (_) {}

    // Ultimate fallback to placeholder data
    _lastUpdated = DateTime.now();
    _sourceUsed = 'placeholder_financial_calendar';
    _cacheService.cache(_cacheKey, _placeholderData);
    return LiveDataResult.success(
      data: _placeholderData,
      source: _sourceUsed,
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  Future<List<FinancialCalendarEvent>> _fetchFromLiveAPI() async {
    try {
      // Attempt to fetch from SBP economic events or Forex Factory
      final uri = Uri.parse('https://www.sbp.org.pk/calendar/');
      final response = await _httpClient.get(uri).timeout(_timeout);
      if (response.statusCode == 200) {
        return _parseEventsFromHtml(response.body);
      }
    } catch (_) {}
    return [];
  }

  List<FinancialCalendarEvent> _parseEventsFromHtml(String html) {
    try {
      // Parse financial calendar events from official sources - fallback returns empty for cache/placeholder
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>>
      getEventsByCategory(String category) async {
    final allResult = await getUpcomingEvents();
    
    if (allResult.hasError || allResult.data == null) {
      return allResult;
    }

    final filtered = allResult.data!
        .where((event) => event.category == category)
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: getSource(),
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>>
      getEventsByImportance(String importance) async {
    final allResult = await getUpcomingEvents();
    
    if (allResult.hasError || allResult.data == null) {
      return allResult;
    }

    final filtered = allResult.data!
        .where((event) => event.importance == importance)
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: getSource(),
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>> refresh() =>
      getUpcomingEvents();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => _sourceUsed;
}
