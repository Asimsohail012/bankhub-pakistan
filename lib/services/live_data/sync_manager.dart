import 'exchange_rate_service.dart';
import 'gold_price_service.dart';
import 'kibor_service.dart';
import 'banking_news_service.dart';
import 'bank_holidays_service.dart';
import 'bank_circulars_service.dart';
import 'bank_jobs_service.dart';
import 'financial_calendar_service.dart';
import 'banking_alerts_service.dart';
import 'live_data_result.dart';

/// Coordinate refresh operations for all live data services.
///
/// Designed as a central hub for managing data synchronization across
/// multiple services. Supports individual and bulk refresh operations.
/// Ready for dependency injection patterns in future implementations.
class SyncManager {
  final ExchangeRateService _exchangeRateService;
  final GoldPriceService _goldPriceService;
  final KiborService _kiborService;
  final BankingNewsService _bankingNewsService;
  final BankHolidaysService _bankHolidaysService;
  final BankCircularsService _bankCircularsService;
  final BankJobsService _bankJobsService;
  final FinancialCalendarService _financialCalendarService;
  final BankingAlertsService _bankingAlertsService;

  /// Tracks the timestamp of the last full sync.
  DateTime? _lastFullSyncTime;

  SyncManager({
    ExchangeRateService? exchangeRateService,
    GoldPriceService? goldPriceService,
    KiborService? kiborService,
    BankingNewsService? bankingNewsService,
    BankHolidaysService? bankHolidaysService,
    BankCircularsService? bankCircularsService,
    BankJobsService? bankJobsService,
    FinancialCalendarService? financialCalendarService,
    BankingAlertsService? bankingAlertsService,
  })  : _exchangeRateService =
            exchangeRateService ?? ExchangeRateServiceImpl(),
        _goldPriceService = goldPriceService ?? GoldPriceServiceImpl(),
        _kiborService = kiborService ?? KiborServiceImpl(),
        _bankingNewsService =
            bankingNewsService ?? BankingNewsServiceImpl(),
        _bankHolidaysService =
            bankHolidaysService ?? BankHolidaysServiceImpl(),
        _bankCircularsService =
            bankCircularsService ?? BankCircularsServiceImpl(),
        _bankJobsService = bankJobsService ?? BankJobsServiceImpl(),
        _financialCalendarService =
            financialCalendarService ??
                FinancialCalendarServiceImpl(),
        _bankingAlertsService =
            bankingAlertsService ?? BankingAlertsServiceImpl();

  /// Refreshes all live data services.
  ///
  /// Performs a comprehensive sync of all available data sources.
  /// Returns true if all refreshes succeeded, false if any failed.
  Future<bool> refreshAll() async {
    _lastFullSyncTime = DateTime.now();

    final results = await Future.wait([
      refreshExchangeRates(),
      refreshGold(),
      refreshNews(),
      refreshKibor(),
      refreshCirculars(),
      refreshJobs(),
      refreshHolidays(),
      refreshFinancialCalendar(),
      refreshAlerts(),
    ]);

    return results.every((result) => !result.hasError);
  }

  /// Refreshes exchange rate data.
  Future<LiveDataResult> refreshExchangeRates() async {
    try {
      return await _exchangeRateService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh exchange rates: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes gold price data.
  Future<LiveDataResult> refreshGold() async {
    try {
      return await _goldPriceService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh gold prices: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes banking news data.
  Future<LiveDataResult> refreshNews() async {
    try {
      return await _bankingNewsService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh banking news: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes KIBOR rate data.
  Future<LiveDataResult> refreshKibor() async {
    try {
      return await _kiborService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh KIBOR rates: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes bank circulars data.
  Future<LiveDataResult> refreshCirculars() async {
    try {
      return await _bankCircularsService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh bank circulars: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes bank jobs data.
  Future<LiveDataResult> refreshJobs() async {
    try {
      return await _bankJobsService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh bank jobs: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes bank holidays data.
  Future<LiveDataResult> refreshHolidays() async {
    try {
      return await _bankHolidaysService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh bank holidays: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes financial calendar data.
  Future<LiveDataResult> refreshFinancialCalendar() async {
    try {
      return await _financialCalendarService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh financial calendar: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Refreshes banking alerts data.
  Future<LiveDataResult> refreshAlerts() async {
    try {
      return await _bankingAlertsService.refresh();
    } catch (e) {
      return LiveDataResult.error(
        message: 'Failed to refresh banking alerts: ${e.toString()}',
        source: 'sync_manager',
      );
    }
  }

  /// Returns the timestamp of the last full sync, or null if never synced.
  DateTime? getLastFullSyncTime() => _lastFullSyncTime;

  /// Returns whether a full sync has been performed.
  bool hasPerformedSync() => _lastFullSyncTime != null;
}
