/// User preferences model for tracking favorites, recently viewed items, bookmarks, and activity.
class UserPreferences {
  final Set<String> favoriteBanks;
  final Set<String> favoriteCalculators;
  final List<String> recentlyViewedBanks;
  final List<String> recentlySearched;
  final Set<String> bookmarkedBanks;
  final Set<String> bookmarkedNews;
  final Set<String> bookmarkedCirculars;
  final Set<String> bookmarkedJobs;
  final Set<String> bookmarkedCalculators;
  final List<String> frequentlyCompared;
  final List<String> frequentlySearched;
  final bool floatingAIAssistant;
  final bool animationsEnabled;
  final bool darkMode;

  UserPreferences({
    Set<String>? favoriteBanks,
    Set<String>? favoriteCalculators,
    List<String>? recentlyViewedBanks,
    List<String>? recentlySearched,
    Set<String>? bookmarkedBanks,
    Set<String>? bookmarkedNews,
    Set<String>? bookmarkedCirculars,
    Set<String>? bookmarkedJobs,
    Set<String>? bookmarkedCalculators,
    List<String>? frequentlyCompared,
    List<String>? frequentlySearched,
    this.floatingAIAssistant = true,
    this.animationsEnabled = true,
    this.darkMode = false,
  })  : favoriteBanks = favoriteBanks ?? {},
        favoriteCalculators = favoriteCalculators ?? {},
        recentlyViewedBanks = recentlyViewedBanks ?? [],
        recentlySearched = recentlySearched ?? [],
        bookmarkedBanks = bookmarkedBanks ?? {},
        bookmarkedNews = bookmarkedNews ?? {},
        bookmarkedCirculars = bookmarkedCirculars ?? {},
        bookmarkedJobs = bookmarkedJobs ?? {},
        bookmarkedCalculators = bookmarkedCalculators ?? {},
        frequentlyCompared = frequentlyCompared ?? [],
        frequentlySearched = frequentlySearched ?? [];

  /// Create a copy with modified fields
  UserPreferences copyWith({
    Set<String>? favoriteBanks,
    Set<String>? favoriteCalculators,
    List<String>? recentlyViewedBanks,
    List<String>? recentlySearched,
    Set<String>? bookmarkedBanks,
    Set<String>? bookmarkedNews,
    Set<String>? bookmarkedCirculars,
    Set<String>? bookmarkedJobs,
    Set<String>? bookmarkedCalculators,
    List<String>? frequentlyCompared,
    List<String>? frequentlySearched,
    bool? floatingAIAssistant,
    bool? animationsEnabled,
    bool? darkMode,
  }) {
    return UserPreferences(
      favoriteBanks: favoriteBanks ?? this.favoriteBanks,
      favoriteCalculators: favoriteCalculators ?? this.favoriteCalculators,
      recentlyViewedBanks: recentlyViewedBanks ?? this.recentlyViewedBanks,
      recentlySearched: recentlySearched ?? this.recentlySearched,
      bookmarkedBanks: bookmarkedBanks ?? this.bookmarkedBanks,
      bookmarkedNews: bookmarkedNews ?? this.bookmarkedNews,
      bookmarkedCirculars: bookmarkedCirculars ?? this.bookmarkedCirculars,
      bookmarkedJobs: bookmarkedJobs ?? this.bookmarkedJobs,
      bookmarkedCalculators: bookmarkedCalculators ?? this.bookmarkedCalculators,
      frequentlyCompared: frequentlyCompared ?? this.frequentlyCompared,
      frequentlySearched: frequentlySearched ?? this.frequentlySearched,
      floatingAIAssistant: floatingAIAssistant ?? this.floatingAIAssistant,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  int get favoriteCount => favoriteBanks.length + favoriteCalculators.length;
  int get recentlyViewedCount => recentlyViewedBanks.length;
  int get recentlySearchedCount => recentlySearched.length;
  int get bookmarkCount => bookmarkedBanks.length + bookmarkedNews.length + bookmarkedCirculars.length + bookmarkedJobs.length + bookmarkedCalculators.length;
}
