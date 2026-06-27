import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

/// Service for managing user preferences (favorites, recently viewed, settings).
/// Uses in-memory storage with optional persistence to SharedPreferences.
class UserPreferencesService extends ChangeNotifier {
  UserPreferences _preferences = UserPreferences();

  UserPreferences get preferences => _preferences;

  // Favorite operations
  void toggleFavoriteBank(String bankId) {
    final favorites = {..._preferences.favoriteBanks};
    if (favorites.contains(bankId)) {
      favorites.remove(bankId);
    } else {
      favorites.add(bankId);
    }
    _preferences = _preferences.copyWith(favoriteBanks: favorites);
    notifyListeners();
  }

  void toggleFavoriteCalculator(String calculatorId) {
    final favorites = {..._preferences.favoriteCalculators};
    if (favorites.contains(calculatorId)) {
      favorites.remove(calculatorId);
    } else {
      favorites.add(calculatorId);
    }
    _preferences = _preferences.copyWith(favoriteCalculators: favorites);
    notifyListeners();
  }

  bool isFavoriteBank(String bankId) => _preferences.favoriteBanks.contains(bankId);
  bool isFavoriteCalculator(String calculatorId) => _preferences.favoriteCalculators.contains(calculatorId);

  // Recently viewed operations
  void addRecentlyViewedBank(String bankId) {
    final recent = [..._preferences.recentlyViewedBanks];
    recent.remove(bankId); // Remove if exists to avoid duplicates
    recent.insert(0, bankId); // Add to front
    if (recent.length > 10) {
      recent.removeLast(); // Keep only 10 recent items
    }
    _preferences = _preferences.copyWith(recentlyViewedBanks: recent);
    notifyListeners();
  }

  // Recently searched operations
  void addRecentlySearched(String query) {
    if (query.trim().isEmpty) return;
    final recent = [..._preferences.recentlySearched];
    recent.remove(query); // Remove if exists to avoid duplicates
    recent.insert(0, query); // Add to front
    if (recent.length > 10) {
      recent.removeLast(); // Keep only 10 recent items
    }
    _preferences = _preferences.copyWith(recentlySearched: recent);
    notifyListeners();
  }

  void clearRecentlySearched() {
    _preferences = _preferences.copyWith(recentlySearched: []);
    notifyListeners();
  }

  // Settings operations
  void setFloatingAIAssistant(bool value) {
    _preferences = _preferences.copyWith(floatingAIAssistant: value);
    notifyListeners();
  }

  void setAnimationsEnabled(bool value) {
    _preferences = _preferences.copyWith(animationsEnabled: value);
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _preferences = _preferences.copyWith(darkMode: value);
    notifyListeners();
  }
}

/// Singleton instance
UserPreferencesService? _instance;

/// Get singleton instance
UserPreferencesService get userPreferencesService {
  return _instance ??= UserPreferencesService();
}
