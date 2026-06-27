/// Metadata wrapper for live data responses
class DataSourceMetadata {
  /// Official name of the data source
  final String sourceName;

  /// URL of the data source
  final String sourceUrl;

  /// When the data was retrieved
  final DateTime retrievedDate;

  /// When the data was last verified as accurate
  final DateTime lastVerifiedDate;

  /// Verification status (verified, pending, unverified)
  final VerificationStatus verificationStatus;

  /// Whether this data came from cache
  final bool isCached;

  /// When the data was last updated
  final DateTime lastUpdatedTimestamp;

  /// How long the data is considered fresh (for cache TTL)
  final Duration? cacheDuration;

  /// Additional notes about the data source
  final String? notes;

  const DataSourceMetadata({
    required this.sourceName,
    required this.sourceUrl,
    required this.retrievedDate,
    required this.lastVerifiedDate,
    required this.verificationStatus,
    required this.isCached,
    required this.lastUpdatedTimestamp,
    this.cacheDuration,
    this.notes,
  });

  /// Returns true if data is considered current (within cache duration)
  bool get isFresh {
    if (cacheDuration == null) return false;
    return DateTime.now().difference(lastUpdatedTimestamp) < cacheDuration!;
  }

  /// Returns age of data in seconds
  int get ageSeconds {
    return DateTime.now().difference(lastUpdatedTimestamp).inSeconds;
  }

  /// Converts metadata to JSON for storage
  Map<String, dynamic> toJson() => {
    'sourceName': sourceName,
    'sourceUrl': sourceUrl,
    'retrievedDate': retrievedDate.toIso8601String(),
    'lastVerifiedDate': lastVerifiedDate.toIso8601String(),
    'verificationStatus': verificationStatus.toString(),
    'isCached': isCached,
    'lastUpdatedTimestamp': lastUpdatedTimestamp.toIso8601String(),
    'cacheDuration': cacheDuration?.inSeconds,
    'notes': notes,
  };
}

/// Verification status enum
enum VerificationStatus {
  /// Data verified from official source
  verified,

  /// Data pending verification
  pending,

  /// Data not verified or from unofficial source
  unverified,

  /// Data from cache (may be outdated)
  cached,

  /// Data from placeholder (fallback only)
  placeholder,
}
