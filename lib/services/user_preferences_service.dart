import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

/// Service for managing user preferences (favorites, recently viewed, bookmarks, activity).
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

  // Bookmark operations
  void toggleBookmarkBank(String bankId) {
    final bookmarks = {..._preferences.bookmarkedBanks};
    if (bookmarks.contains(bankId)) {
      bookmarks.remove(bankId);
    } else {
      bookmarks.add(bankId);
    }
    _preferences = _preferences.copyWith(bookmarkedBanks: bookmarks);
    notifyListeners();
  }

  void toggleBookmarkNews(String newsId) {
    final bookmarks = {..._preferences.bookmarkedNews};
    if (bookmarks.contains(newsId)) {
      bookmarks.remove(newsId);
    } else {
      bookmarks.add(newsId);
    }
    _preferences = _preferences.copyWith(bookmarkedNews: bookmarks);
    notifyListeners();
  }

  void toggleBookmarkCircular(String circularId) {
    final bookmarks = {..._preferences.bookmarkedCirculars};
    if (bookmarks.contains(circularId)) {
      bookmarks.remove(circularId);
    } else {
      bookmarks.add(circularId);
    }
    _preferences = _preferences.copyWith(bookmarkedCirculars: bookmarks);
    notifyListeners();
  }

  void toggleBookmarkJob(String jobId) {
    final bookmarks = {..._preferences.bookmarkedJobs};
    if (bookmarks.contains(jobId)) {
      bookmarks.remove(jobId);
    } else {
      bookmarks.add(jobId);
    }
    _preferences = _preferences.copyWith(bookmarkedJobs: bookmarks);
    notifyListeners();
  }

  void toggleBookmarkCalculator(String calculatorId) {
    final bookmarks = {..._preferences.bookmarkedCalculators};
    if (bookmarks.contains(calculatorId)) {
      bookmarks.remove(calculatorId);
    } else {
      bookmarks.add(calculatorId);
    }
    _preferences = _preferences.copyWith(bookmarkedCalculators: bookmarks);
    notifyListeners();
  }

  bool isBookmarkedBank(String bankId) => _preferences.bookmarkedBanks.contains(bankId);
  bool isBookmarkedNews(String newsId) => _preferences.bookmarkedNews.contains(newsId);
  bool isBookmarkedCircular(String circularId) => _preferences.bookmarkedCirculars.contains(circularId);
  bool isBookmarkedJob(String jobId) => _preferences.bookmarkedJobs.contains(jobId);
  bool isBookmarkedCalculator(String calculatorId) => _preferences.bookmarkedCalculators.contains(calculatorId);

  // Activity tracking operations
  void addFrequentlyCompared(String bankId) {
    final frequently = [..._preferences.frequentlyCompared];
    frequently.remove(bankId);
    frequently.insert(0, bankId);
    if (frequently.length > 20) {
      frequently.removeLast();
    }
    _preferences = _preferences.copyWith(frequentlyCompared: frequently);
    notifyListeners();
  }

  void addFrequentlySearched(String query) {
    if (query.trim().isEmpty) return;
    final frequently = [..._preferences.frequentlySearched];
    frequently.remove(query);
    frequently.insert(0, query);
    if (frequently.length > 20) {
      frequently.removeLast();
    }
    _preferences = _preferences.copyWith(frequentlySearched: frequently);
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

  void clearAllBookmarks() {
    _preferences = _preferences.copyWith(
      bookmarkedBanks: {},
      bookmarkedNews: {},
      bookmarkedCirculars: {},
      bookmarkedJobs: {},
      bookmarkedCalculators: {},
    );
    notifyListeners();
  }
}

/// Singleton instance
UserPreferencesService? _instance;

/// Get singleton instance
UserPreferencesService get userPreferencesService {
  return _instance ??= UserPreferencesService();
}
