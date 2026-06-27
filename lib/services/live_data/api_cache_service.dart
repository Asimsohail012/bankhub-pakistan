/// Service for managing offline cache for live data.
///
/// Provides hooks for caching and retrieving data when offline or
/// when network requests fail. Currently uses in-memory storage.
///
/// In production, this would integrate with local storage solutions
/// like SharedPreferences or Hive for persistent caching.
class ApiCacheService {
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};

  ApiCacheService();

  /// Stores data in cache with a timestamp.
  void cache(String key, dynamic value) {
    _cache[key] = value;
    _cacheTimestamps[key] = DateTime.now();
  }

  /// Retrieves cached data if available and not expired.
  ///
  /// Returns null if data is not cached or has expired (default 24 hours).
  dynamic get(String key, {Duration ttl = const Duration(hours: 24)}) {
    if (!_cache.containsKey(key)) return null;

    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return null;

    final age = DateTime.now().difference(timestamp);
    if (age > ttl) {
      _cache.remove(key);
      _cacheTimestamps.remove(key);
      return null;
    }

    return _cache[key];
  }

  /// Checks if data is cached and still valid.
  bool isCached(String key, {Duration ttl = const Duration(hours: 24)}) {
    return get(key, ttl: ttl) != null;
  }

  /// Removes specific cache entry.
  void invalidate(String key) {
    _cache.remove(key);
    _cacheTimestamps.remove(key);
  }

  /// Clears all cached data.
  void clearAll() {
    _cache.clear();
    _cacheTimestamps.clear();
  }

  /// Returns the timestamp of cached data, or null if not cached.
  DateTime? getCacheTimestamp(String key) => _cacheTimestamps[key];

  /// Returns all cached keys.
  List<String> getCachedKeys() => _cache.keys.toList();

  /// Returns the number of items in cache.
  int get cacheSize => _cache.length;
}
