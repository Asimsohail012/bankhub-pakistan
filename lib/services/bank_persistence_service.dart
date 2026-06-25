import 'package:shared_preferences/shared_preferences.dart';

class BankPersistenceService {
  BankPersistenceService._();

  static const String _favoritesKey = 'bankhub_favorites';
  static const String _recentKey = 'bankhub_recently_viewed';
  static const int _recentMaxItems = 8;

  static Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey)?.toSet() ?? <String>{};
  }

  static Future<List<String>> loadRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentKey) ?? <String>[];
  }

  static Future<bool> isFavorite(String bankId) async {
    final favorites = await loadFavorites();
    return favorites.contains(bankId);
  }

  static Future<void> toggleFavorite(String bankId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey)?.toSet() ?? <String>{};
    if (favorites.contains(bankId)) {
      favorites.remove(bankId);
    } else {
      favorites.add(bankId);
    }
    await prefs.setStringList(_favoritesKey, favorites.toList());
  }

  static Future<void> addRecentlyViewed(String bankId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_recentKey) ?? <String>[];
    current.remove(bankId);
    current.insert(0, bankId);
    if (current.length > _recentMaxItems) {
      current.removeRange(_recentMaxItems, current.length);
    }
    await prefs.setStringList(_recentKey, current);
  }

  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }

  static Future<void> clearRecentlyViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentKey);
  }
}
