import 'package:flutter/material.dart';
import '../models/search_suggestion.dart';
import '../data/repositories/financial_institution_repository.dart';
import '../data/repositories/i_financial_institution_repository.dart';
import 'live_data/api_cache_service.dart';
import 'live_data/banking_news_service.dart';
import 'live_data/bank_jobs_service.dart';
import 'live_data/bank_circulars_service.dart';
import 'user_preferences_service.dart';

/// Enhanced search service with instant search, suggestions, and indexing.
/// Extends unified search with instant results, search suggestions, and history.
class EnhancedSearchService extends ChangeNotifier {
  final IFinancialInstitutionRepository _institutionRepository;
  final BankingNewsService _newsService;
  final BankJobsService _jobsService;
  final BankCircularsService _circularsService;
  final ApiCacheService _cacheService;
  final UserPreferencesService _userPreferencesService;

  List<SearchSuggestion> _suggestions = [];
  List<String> _searchIndex = [];

  List<SearchSuggestion> get suggestions => _suggestions;
  List<String> get searchIndex => _searchIndex;

  EnhancedSearchService({
    required this._institutionRepository,
    required this._newsService,
    required this._jobsService,
    required this._circularsService,
    required this._cacheService,
    required this._userPreferencesService,
  }) {
    _initializeIndex();
  }

  /// Initialize search index with all searchable content.
  Future<void> _initializeIndex() async {
    try {
      final institutions = await _institutionRepository.loadInstitutions();
      _searchIndex = institutions
          .map((i) => (i as dynamic).officialName as String? ?? (i as dynamic).shortName as String? ?? '')
          .where((name) => name.isNotEmpty)
          .cast<String>()
          .toList();
      notifyListeners();
    } catch (e) {
      // Silent fail - index will be empty
    }
  }

  /// Get instant search suggestions for the given query.
  /// Returns suggestions from recent searches, popular searches, and matching banks.
  Future<List<SearchSuggestion>> getInstantSuggestions(String query) async {
    if (query.trim().isEmpty) {
      return _getDefaultSuggestions();
    }

    final queryLower = query.toLowerCase();
    final suggestions = <SearchSuggestion>[];

    try {
      // Add recent searches
      for (final recent in _userPreferencesService.preferences.recentlySearched.take(3)) {
        if (recent.toLowerCase().contains(queryLower)) {
          suggestions.add(SearchSuggestion(
            text: recent,
            type: 'recent',
            icon: 'history',
          ));
        }
      }

      // Add matching banks
      try {
        final institutions = await _institutionRepository.search(query);
        for (final inst in institutions.take(3)) {
          final name = (inst as dynamic).officialName ?? (inst as dynamic).shortName ?? '';
          if (name.isNotEmpty) {
            suggestions.add(SearchSuggestion(
              text: name,
              type: 'bank',
              id: (inst as dynamic).institutionId,
              icon: 'account_balance',
            ));
          }
        }
      } catch (e) {
        // Silent fail for institutions
      }

      // Add matching news
      try {
        final newsResult = await _newsService.searchNews(query);
        if (newsResult.data != null) {
          for (final news in (newsResult.data as List).take(2)) {
            final title = (news as dynamic).title ?? '';
            if (title.isNotEmpty) {
              suggestions.add(SearchSuggestion(
                text: title,
                type: 'news',
                id: (news as dynamic).id,
                icon: 'newspaper',
                subtitle: 'News Article',
              ));
            }
          }
        }
      } catch (e) {
        // Silent fail for news
      }

      // Remove duplicates
      final seen = <String>{};
      suggestions.retainWhere((s) => seen.add(s.text));

      _suggestions = suggestions;
      notifyListeners();
      return suggestions;
    } catch (e) {
      return _getDefaultSuggestions();
    }
  }

  /// Get default suggestions for empty query (recent + popular).
  List<SearchSuggestion> _getDefaultSuggestions() {
    final suggestions = <SearchSuggestion>[];

    // Add recent searches
    for (final recent in _userPreferencesService.preferences.recentlySearched.take(5)) {
      suggestions.add(SearchSuggestion(
        text: recent,
        type: 'recent',
        icon: 'history',
      ));
    }

    // Add popular searches (frequently searched terms)
    for (final popular in _userPreferencesService.preferences.frequentlySearched.take(3)) {
      if (!suggestions.any((s) => s.text == popular)) {
        suggestions.add(SearchSuggestion(
          text: popular,
          type: 'popular',
          icon: 'trending_up',
        ));
      }
    }

    _suggestions = suggestions;
    notifyListeners();
    return suggestions;
  }

  /// Perform instant search with minimal latency.
  /// Returns quick results from cache and index without full search.
  Future<Map<String, dynamic>> instantSearch(String query) async {
    if (query.trim().isEmpty) {
      return {
        'institutions': [],
        'news': [],
        'jobs': [],
        'circulars': [],
        'total': 0,
      };
    }

    try {
      // Try cache first  
      final cacheKey = _getCacheKey(query);
      final cached = _cacheService.get(cacheKey);
      if (cached != null && cached is Map<String, dynamic>) {
        return cached;
      }

      // Fallback to full search
      final fullResults = await Future.wait([
        _institutionRepository.search(query),
        _newsService.searchNews(query),
        _jobsService.searchJobs(query),
        _circularsService.searchCirculars(query),
      ], eagerError: false);

      final result = {
        'institutions': (fullResults[0] as List?) ?? [],
        'news': ((fullResults[1] as dynamic)?.data ?? []) as List,
        'jobs': ((fullResults[2] as dynamic)?.data ?? []) as List,
        'circulars': ((fullResults[3] as dynamic)?.data ?? []) as List,
        'total': (fullResults[0] as List).length +
            (((fullResults[1] as dynamic)?.data ?? []) as List).length +
            (((fullResults[2] as dynamic)?.data ?? []) as List).length +
            (((fullResults[3] as dynamic)?.data ?? []) as List).length,
      };

      // Cache result
      _cacheService.cache(cacheKey, result);

      return result;
    } catch (e) {
      return {
        'institutions': [],
        'news': [],
        'jobs': [],
        'circulars': [],
        'total': 0,
        'error': e.toString(),
      };
    }
  }

  /// Record search query for history and analytics.
  void recordSearch(String query) {
    if (query.trim().isEmpty) return;
    _userPreferencesService.addRecentlySearched(query);
    _userPreferencesService.addFrequentlySearched(query);
  }

  /// Get search history (recently searched queries).
  List<String> getSearchHistory() {
    return _userPreferencesService.preferences.recentlySearched;
  }

  /// Get popular searches (frequently searched queries).
  List<String> getPopularSearches() {
    return _userPreferencesService.preferences.frequentlySearched;
  }

  /// Clear all search history.
  void clearHistory() {
    _userPreferencesService.clearRecentlySearched();
  }

  /// Generate cache key for search query.
  String _getCacheKey(String query) => 'search_${query.toLowerCase()}';

  /// Refresh search index (useful after app updates).
  Future<void> refreshIndex() async {
    await _initializeIndex();
  }
}

/// Singleton instance
EnhancedSearchService? _enhancedSearchInstance;

/// Get singleton instance
EnhancedSearchService getEnhancedSearchService() {
  _enhancedSearchInstance ??= EnhancedSearchService(
    institutionRepository: FinancialInstitutionRepository(),
    newsService: BankingNewsServiceImpl(),
    jobsService: BankJobsServiceImpl(),
    circularsService: BankCircularsServiceImpl(),
    cacheService: ApiCacheService(),
    userPreferencesService: userPreferencesService,
  );
  return _enhancedSearchInstance!;
}
