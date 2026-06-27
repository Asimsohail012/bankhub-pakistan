import '../services/live_data/api_cache_service.dart';
import '../services/live_data/exchange_rate_service.dart';
import '../services/live_data/gold_price_service.dart';
import '../services/live_data/kibor_service.dart';
import '../services/live_data/banking_news_service.dart';
import '../services/live_data/live_data_result.dart';
import '../services/live_data/models.dart';
import '../services/live_data/sync_manager.dart';

/// Container for dashboard data
class DashboardData {
  final LiveDataResult<List<ExchangeRateData>> exchangeRates;
  final LiveDataResult<GoldPriceData> goldPrice;
  final LiveDataResult<List<KiborData>> kiborRates;
  final LiveDataResult<List<BankingNewsArticle>> news;

  const DashboardData({
    required this.exchangeRates,
    required this.goldPrice,
    required this.kiborRates,
    required this.news,
  });

  /// Returns true if any data source encountered an error
  bool hasErrors() =>
      exchangeRates.hasError ||
      goldPrice.hasError ||
      kiborRates.hasError ||
      news.hasError;

  /// Returns true if all data is cached
  bool isAllCached() =>
      exchangeRates.isCached &&
      goldPrice.isCached &&
      kiborRates.isCached &&
      news.isCached;

  /// Returns true if loading was successful or has fallback data
  bool hasData() =>
      (exchangeRates.data != null || exchangeRates.isCached) &&
      (goldPrice.data != null || goldPrice.isCached) &&
      (kiborRates.data != null || kiborRates.isCached) &&
      (news.data != null || news.isCached);
}

/// Aggregates all live data services for the dashboard
///
/// Loads data in parallel using Future.wait() and manages caching
/// with ApiCacheService. Designed for graceful error handling with
/// fallback to cached data when network requests fail.
class DashboardDataProvider {
  final ExchangeRateService _exchangeRateService;
  final GoldPriceService _goldPriceService;
  final KiborService _kiborService;
  final BankingNewsService _bankingNewsService;
  final ApiCacheService _cacheService;
  final SyncManager _syncManager;

  DashboardDataProvider({
    ExchangeRateService? exchangeRateService,
    GoldPriceService? goldPriceService,
    KiborService? kiborService,
    BankingNewsService? bankingNewsService,
    ApiCacheService? cacheService,
    SyncManager? syncManager,
  })  : _exchangeRateService =
            exchangeRateService ?? ExchangeRateServiceImpl(),
        _goldPriceService = goldPriceService ?? GoldPriceServiceImpl(),
        _kiborService = kiborService ?? KiborServiceImpl(),
        _bankingNewsService = bankingNewsService ?? BankingNewsServiceImpl(),
        _cacheService = cacheService ?? ApiCacheService(),
        _syncManager = syncManager ?? SyncManager();

  /// Loads all dashboard data in parallel
  Future<DashboardData> loadDashboardData({bool forceRefresh = false}) async {
    final List<LiveDataResult> results = await Future.wait([
      _loadExchangeRates(forceRefresh),
      _loadGoldPrice(forceRefresh),
      _loadKiborRates(forceRefresh),
      _loadBankingNews(forceRefresh),
    ]);

    return DashboardData(
      exchangeRates: results[0] as LiveDataResult<List<ExchangeRateData>>,
      goldPrice: results[1] as LiveDataResult<GoldPriceData>,
      kiborRates: results[2] as LiveDataResult<List<KiborData>>,
      news: results[3] as LiveDataResult<List<BankingNewsArticle>>,
    );
  }

  /// Loads exchange rates with cache fallback
  Future<LiveDataResult<List<ExchangeRateData>>> _loadExchangeRates(
    bool forceRefresh,
  ) async {
    try {
      if (!forceRefresh) {
        final cached = _cacheService.get(
          'exchange_rates',
          ttl: const Duration(hours: 1),
        ) as List<ExchangeRateData>?;
        if (cached != null) {
          return LiveDataResult.cached(
            data: cached,
            source: 'cache',
            lastUpdated:
                _cacheService.getCacheTimestamp('exchange_rates')?.toIso8601String(),
          );
        }
      }

      final result = await _exchangeRateService.getExchangeRates();
      if (!result.hasError && result.data != null) {
        _cacheService.cache('exchange_rates', result.data);
      }
      return result;
    } catch (e) {
      final cached = _cacheService.get('exchange_rates')
          as List<ExchangeRateData>?;
      if (cached != null) {
        return LiveDataResult.cached(
          data: cached,
          source: 'cache',
          lastUpdated:
              _cacheService.getCacheTimestamp('exchange_rates')?.toIso8601String(),
        );
      }
      return LiveDataResult.error(
        message: 'Failed to load exchange rates: ${e.toString()}',
      );
    }
  }

  /// Loads gold prices with cache fallback
  Future<LiveDataResult<GoldPriceData>> _loadGoldPrice(
    bool forceRefresh,
  ) async {
    try {
      if (!forceRefresh) {
        final cached = _cacheService.get(
          'gold_price',
          ttl: const Duration(hours: 1),
        ) as GoldPriceData?;
        if (cached != null) {
          return LiveDataResult.cached(
            data: cached,
            source: 'cache',
            lastUpdated:
                _cacheService.getCacheTimestamp('gold_price')?.toIso8601String(),
          );
        }
      }

      final result = await _goldPriceService.getGoldPrices();
      if (!result.hasError && result.data != null) {
        _cacheService.cache('gold_price', result.data);
      }
      return result;
    } catch (e) {
      final cached = _cacheService.get('gold_price') as GoldPriceData?;
      if (cached != null) {
        return LiveDataResult.cached(
          data: cached,
          source: 'cache',
          lastUpdated:
              _cacheService.getCacheTimestamp('gold_price')?.toIso8601String(),
        );
      }
      return LiveDataResult.error(
        message: 'Failed to load gold prices: ${e.toString()}',
      );
    }
  }

  /// Loads KIBOR rates with cache fallback
  Future<LiveDataResult<List<KiborData>>> _loadKiborRates(
    bool forceRefresh,
  ) async {
    try {
      if (!forceRefresh) {
        final cached = _cacheService.get(
          'kibor_rates',
          ttl: const Duration(hours: 1),
        ) as List<KiborData>?;
        if (cached != null) {
          return LiveDataResult.cached(
            data: cached,
            source: 'cache',
            lastUpdated:
                _cacheService.getCacheTimestamp('kibor_rates')?.toIso8601String(),
          );
        }
      }

      final result = await _kiborService.getKiborRates();
      if (!result.hasError && result.data != null) {
        _cacheService.cache('kibor_rates', result.data);
      }
      return result;
    } catch (e) {
      final cached = _cacheService.get('kibor_rates')
          as List<KiborData>?;
      if (cached != null) {
        return LiveDataResult.cached(
          data: cached,
          source: 'cache',
          lastUpdated:
              _cacheService.getCacheTimestamp('kibor_rates')?.toIso8601String(),
        );
      }
      return LiveDataResult.error(
        message: 'Failed to load KIBOR rates: ${e.toString()}',
      );
    }
  }

  /// Loads banking news with cache fallback
  Future<LiveDataResult<List<BankingNewsArticle>>> _loadBankingNews(
    bool forceRefresh,
  ) async {
    try {
      if (!forceRefresh) {
        final cached = _cacheService.get(
          'banking_news',
          ttl: const Duration(hours: 2),
        ) as List<BankingNewsArticle>?;
        if (cached != null) {
          return LiveDataResult.cached(
            data: cached,
            source: 'cache',
            lastUpdated:
                _cacheService.getCacheTimestamp('banking_news')?.toIso8601String(),
          );
        }
      }

      final result = await _bankingNewsService.getLatestNews();
      if (!result.hasError && result.data != null) {
        _cacheService.cache('banking_news', result.data);
      }
      return result;
    } catch (e) {
      final cached = _cacheService.get('banking_news')
          as List<BankingNewsArticle>?;
      if (cached != null) {
        return LiveDataResult.cached(
          data: cached,
          source: 'cache',
          lastUpdated:
              _cacheService.getCacheTimestamp('banking_news')?.toIso8601String(),
        );
      }
      return LiveDataResult.error(
        message: 'Failed to load banking news: ${e.toString()}',
      );
    }
  }

  /// Refreshes all dashboard data and performs full sync
  Future<DashboardData> refreshAll() async {
    await _syncManager.refreshAll();
    _cacheService.invalidate('exchange_rates');
    _cacheService.invalidate('gold_price');
    _cacheService.invalidate('kibor_rates');
    _cacheService.invalidate('banking_news');
    return loadDashboardData(forceRefresh: true);
  }

  /// Clears all cached data
  void clearCache() {
    _cacheService.clearAll();
  }
}
