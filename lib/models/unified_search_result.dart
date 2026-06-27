import '../data/models/financial_institution.dart';
import '../services/live_data/models.dart';

/// Aggregated search results from multiple sources.
///
/// Combines search results from institutions, news, jobs, and circulars
/// into a unified data structure for display in search UI.
class UnifiedSearchResult {
  final List<FinancialInstitution> institutions;
  final List<BankingNewsArticle> news;
  final List<BankJob> jobs;
  final List<BankCircular> circulars;
  final String query;
  final DateTime timestamp;
  final bool hasError;
  final String? errorMessage;

  const UnifiedSearchResult({
    required this.institutions,
    required this.news,
    required this.jobs,
    required this.circulars,
    required this.query,
    required this.timestamp,
    this.hasError = false,
    this.errorMessage,
  });

  /// Total count of all results across all sources.
  int get totalResults =>
      institutions.length + news.length + jobs.length + circulars.length;

  /// Returns true if any results were found.
  bool get hasResults => totalResults > 0;

  /// Returns true if the query is empty or whitespace.
  bool get isEmptyQuery => query.trim().isEmpty;

  /// Creates a result with no data (empty state).
  factory UnifiedSearchResult.empty(String query) => UnifiedSearchResult(
        institutions: [],
        news: [],
        jobs: [],
        circulars: [],
        query: query,
        timestamp: DateTime.now(),
      );

  /// Creates a result representing an error state.
  factory UnifiedSearchResult.error(
    String query, {
    required String message,
  }) =>
      UnifiedSearchResult(
        institutions: [],
        news: [],
        jobs: [],
        circulars: [],
        query: query,
        timestamp: DateTime.now(),
        hasError: true,
        errorMessage: message,
      );

  /// Creates a copy with modified fields.
  UnifiedSearchResult copyWith({
    List<FinancialInstitution>? institutions,
    List<BankingNewsArticle>? news,
    List<BankJob>? jobs,
    List<BankCircular>? circulars,
    String? query,
    DateTime? timestamp,
    bool? hasError,
    String? errorMessage,
  }) =>
      UnifiedSearchResult(
        institutions: institutions ?? this.institutions,
        news: news ?? this.news,
        jobs: jobs ?? this.jobs,
        circulars: circulars ?? this.circulars,
        query: query ?? this.query,
        timestamp: timestamp ?? this.timestamp,
        hasError: hasError ?? this.hasError,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  String toString() =>
      'UnifiedSearchResult(query: $query, institutions: ${institutions.length}, '
      'news: ${news.length}, jobs: ${jobs.length}, circulars: ${circulars.length})';
}
