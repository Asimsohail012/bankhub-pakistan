/// Common wrapper for all live data service responses.
///
/// Provides consistent handling of data, metadata, caching information,
/// and error states across all live data services.
class LiveDataResult<T> {
  /// The actual data returned by the service (null if error occurred).
  final T? data;

  /// Timestamp of when the data was last updated (ISO 8601 format).
  final String? lastUpdated;

  /// Source of the data (e.g., 'api', 'cache', 'placeholder').
  final String source;

  /// Whether this data came from cache rather than live fetch.
  final bool isCached;

  /// Whether an error occurred during the fetch.
  final bool hasError;

  /// Error message if [hasError] is true.
  final String? errorMessage;

  const LiveDataResult({
    required this.data,
    this.lastUpdated,
    required this.source,
    required this.isCached,
    required this.hasError,
    this.errorMessage,
  });

  /// Creates a successful result from fresh data.
  factory LiveDataResult.success({
    required T data,
    required String source,
    String? lastUpdated,
  }) {
    return LiveDataResult(
      data: data,
      lastUpdated: lastUpdated ?? DateTime.now().toIso8601String(),
      source: source,
      isCached: false,
      hasError: false,
      errorMessage: null,
    );
  }

  /// Creates a result from cached data.
  factory LiveDataResult.cached({
    required T data,
    required String source,
    String? lastUpdated,
  }) {
    return LiveDataResult(
      data: data,
      lastUpdated: lastUpdated,
      source: source,
      isCached: true,
      hasError: false,
      errorMessage: null,
    );
  }

  /// Creates an error result.
  factory LiveDataResult.error({
    required String message,
    T? cachedData,
    String? lastUpdated,
    String source = 'error',
  }) {
    return LiveDataResult(
      data: cachedData,
      lastUpdated: lastUpdated,
      source: source,
      isCached: cachedData != null,
      hasError: true,
      errorMessage: message,
    );
  }

  /// Creates a placeholder result (no data available).
  factory LiveDataResult.placeholder({
    String source = 'placeholder',
  }) {
    return LiveDataResult(
      data: null,
      lastUpdated: null,
      source: source,
      isCached: false,
      hasError: false,
      errorMessage: null,
    );
  }

  @override
  String toString() =>
      'LiveDataResult(source: $source, isCached: $isCached, hasError: $hasError, lastUpdated: $lastUpdated)';
}
