import '../data/repositories/financial_institution_repository.dart';
import '../data/repositories/i_financial_institution_repository.dart';
import '../models/unified_search_result.dart';
import 'live_data/api_cache_service.dart';
import 'live_data/banking_news_service.dart';
import 'live_data/bank_jobs_service.dart';
import 'live_data/bank_circulars_service.dart';

/// Singleton instance of unified search service.
UnifiedSearchService? _unifiedSearchInstance;

/// Gets the singleton instance of UnifiedSearchService.
UnifiedSearchService get unifiedSearchService {
  _unifiedSearchInstance ??= UnifiedSearchService(
    institutionRepository: FinancialInstitutionRepository(),
    newsService: BankingNewsServiceImpl(),
    jobsService: BankJobsServiceImpl(),
    circularsService: BankCircularsServiceImpl(),
    cacheService: ApiCacheService(),
  );
  return _unifiedSearchInstance!;
}

/// Coordinates searches across multiple data sources.
///
/// Reuses existing repository and service search methods to provide
/// unified search across institutions, news, jobs, and circulars.
/// Implements intelligent caching to avoid redundant API calls.
class UnifiedSearchService {
  final IFinancialInstitutionRepository _institutionRepository;
  final BankingNewsService _newsService;
  final BankJobsService _jobsService;
  final BankCircularsService _circularsService;
  final ApiCacheService _cacheService;

  UnifiedSearchService({
    required this._institutionRepository,
    required this._newsService,
    required this._jobsService,
    required this._circularsService,
    required this._cacheService,
  });

  /// Performs unified search across all sources.
  ///
  /// Searches institutions, news, jobs, and circulars in parallel.
  /// Results are cached with 1-hour TTL to avoid repeated searches.
  /// Returns aggregated UnifiedSearchResult.
  Future<UnifiedSearchResult> search(String query) async {
    if (query.trim().isEmpty) {
      return UnifiedSearchResult.empty(query);
    }

    // Check cache first
    final cacheKey = _getCacheKey(query);
    final cached = _cacheService.get(
      cacheKey,
      ttl: const Duration(hours: 1),
    );
    if (cached != null && cached is UnifiedSearchResult) {
      return cached;
    }

    try {
      // Search all sources in parallel
      final results = await Future.wait([
        _institutionRepository.search(query),
        _newsService.searchNews(query),
        _jobsService.searchJobs(query),
        _circularsService.searchCirculars(query),
      ]);

      // Extract results from parallel execution
      final institutions = results[0] as List;
      final newsResult = results[1] as dynamic;
      final jobsResult = results[2] as dynamic;
      final circularsResult = results[3] as dynamic;

      // Extract data from LiveDataResult wrappers
      final news = (newsResult.data ?? []) as List;
      final jobs = (jobsResult.data ?? []) as List;
      final circulars = (circularsResult.data ?? []) as List;

      final result = UnifiedSearchResult(
        institutions: institutions.cast(),
        news: news.cast(),
        jobs: jobs.cast(),
        circulars: circulars.cast(),
        query: query,
        timestamp: DateTime.now(),
      );

      // Cache the result
      _cacheService.cache(cacheKey, result);

      return result;
    } catch (e) {
      return UnifiedSearchResult.error(
        query,
        message: 'Search failed: ${e.toString()}',
      );
    }
  }

  /// Filters institutions by category.
  ///
  /// Reuses existing repository filter method.
  /// Returns: List of FinancialInstitution
  Future<List> filterByCategory(String category) async {
    try {
      return await _institutionRepository.filterByCategory(category);
    } catch (e) {
      return [];
    }
  }

  /// Filters commercial banks.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterCommercial() async {
    try {
      return await _institutionRepository.filterCommercial();
    } catch (e) {
      return [];
    }
  }

  /// Filters Islamic banks.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterIslamic() async {
    try {
      return await _institutionRepository.filterIslamic();
    } catch (e) {
      return [];
    }
  }

  /// Filters digital banks.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterDigital() async {
    try {
      return await _institutionRepository.filterDigital();
    } catch (e) {
      return [];
    }
  }

  /// Filters microfinance institutions.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterMicrofinance() async {
    try {
      return await _institutionRepository.filterMicrofinance();
    } catch (e) {
      return [];
    }
  }

  /// Filters DFI institutions.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterDFI() async {
    try {
      return await _institutionRepository.filterDFI();
    } catch (e) {
      return [];
    }
  }

  /// Filters digital wallet providers.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterWallets() async {
    try {
      return await _institutionRepository.filterWallets();
    } catch (e) {
      return [];
    }
  }

  /// Filters international banks.
  ///
  /// Reuses existing repository filter method.
  Future<List> filterInternational() async {
    try {
      return await _institutionRepository.filterInternational();
    } catch (e) {
      return [];
    }
  }

  /// Gets SBP-verified institutions only.
  ///
  /// Reuses existing repository method.
  Future<List> getVerifiedInstitutions() async {
    try {
      return await _institutionRepository.getVerifiedInstitutions();
    } catch (e) {
      return [];
    }
  }

  /// Sorts institutions alphabetically.
  ///
  /// Reuses existing repository method.
  Future<List> sortAlphabetically() async {
    try {
      return await _institutionRepository.sortAlphabetically();
    } catch (e) {
      return [];
    }
  }

  /// Sorts institutions by recently updated.
  ///
  /// Reuses existing repository method.
  Future<List> sortByRecentlyUpdated() async {
    try {
      return await _institutionRepository.sortByRecentlyUpdated();
    } catch (e) {
      return [];
    }
  }

  /// Clears all search cache entries.
  void clearCache() {
    _cacheService.clearAll();
  }

  /// Generates cache key for search query.
  String _getCacheKey(String query) => 'unified_search_${query.toLowerCase()}';
}
