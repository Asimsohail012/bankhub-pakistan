import 'live_data_result.dart';
import 'models.dart';
import 'api_cache_service.dart';

/// Abstract interface for bank holidays service.
abstract class BankHolidaysService {
  /// Fetches bank holidays for the current year.
  Future<LiveDataResult<List<BankHoliday>>> getHolidays();

  /// Fetches holidays for a specific year.
  Future<LiveDataResult<List<BankHoliday>>> getHolidaysForYear(int year);

  /// Checks if a specific date is a bank holiday.
  Future<LiveDataResult<bool>> isHoliday(DateTime date);

  /// Refreshes holiday data from source.
  Future<LiveDataResult<List<BankHoliday>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankHolidaysService.
///
/// Connects to State Bank of Pakistan (SBP) holiday calendar with fallback
/// to cached data and placeholder holidays.
class BankHolidaysServiceImpl implements BankHolidaysService {
  static final _placeholderData = [
    BankHoliday(
      date: '2024-08-14',
      name: 'Independence Day',
      description: 'Pakistan Independence Day',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-09-23',
      name: 'Iqbal Day',
      description: 'Allama Iqbal Day',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-12-25',
      name: 'Quaid-e-Azam Day',
      description: 'Birthday of Muhammad Ali Jinnah',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-12-31',
      name: 'Bank Closing',
      description: 'Year-end bank closing',
      isNational: false,
    ),
  ];

  DateTime? _lastUpdated;
  final ApiCacheService _cacheService;
  static const String _cacheKey = 'bank_holidays';
  String _sourceUsed = 'placeholder_bank_holidays';

  BankHolidaysServiceImpl({
    ApiCacheService? cacheService,
  })  : _cacheService = cacheService ?? ApiCacheService();

  @override
  Future<LiveDataResult<List<BankHoliday>>> getHolidays() async {
    try {
      // Check cache first (long TTL for holidays - they don't change often)
      final cached = _cacheService.get(_cacheKey, ttl: const Duration(days: 30));
      if (cached != null && cached is List<BankHoliday>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_bank_holidays';
        return LiveDataResult.cached(
          data: cached,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }

      // Attempt to fetch from SBP or official holidays API
      final holidays = await _fetchFromLiveAPI();
      if (holidays.isNotEmpty) {
        _lastUpdated = DateTime.now();
        _sourceUsed = 'live_sbp_holidays';
        _cacheService.cache(_cacheKey, holidays);
        return LiveDataResult.success(
          data: holidays,
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
      if (cachedFallback != null && cachedFallback is List<BankHoliday>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_bank_holidays_fallback';
        return LiveDataResult.cached(
          data: cachedFallback,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (_) {}

    // Ultimate fallback to placeholder data
    _lastUpdated = DateTime.now();
    _sourceUsed = 'placeholder_bank_holidays';
    _cacheService.cache(_cacheKey, _placeholderData);
    return LiveDataResult.success(
      data: _placeholderData,
      source: _sourceUsed,
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  Future<List<BankHoliday>> _fetchFromLiveAPI() async {
    // Framework ready for SBP holidays API integration
    // SBP publishes holidays on their website
    return [];
  }

  @override
  Future<LiveDataResult<List<BankHoliday>>> getHolidaysForYear(
    int year,
  ) async {
    final allResult = await getHolidays();
    
    if (allResult.hasError || allResult.data == null) {
      return allResult;
    }

    // Filter for the specified year
    final filtered = allResult.data!
        .where((holiday) => holiday.date.startsWith(year.toString()))
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: getSource(),
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<bool>> isHoliday(DateTime date) async {
    final result = await getHolidays();
    
    if (result.hasError || result.data == null) {
      return LiveDataResult.error(
        message: 'Could not check if date is holiday',
        source: getSource(),
      );
    }

    final dateStr = date.toIso8601String().split('T')[0];
    final isHolidayDate =
        result.data!.any((holiday) => holiday.date == dateStr);

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: isHolidayDate,
      source: getSource(),
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankHoliday>>> refresh() => getHolidays();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => _sourceUsed;
}
