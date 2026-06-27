/// User preferences model for tracking favorites and recently viewed items.
class UserPreferences {
  final Set<String> favoriteBanks;
  final Set<String> favoriteCalculators;
  final List<String> recentlyViewedBanks;
  final List<String> recentlySearched;
  final bool floatingAIAssistant;
  final bool animationsEnabled;
  final bool darkMode;

  UserPreferences({
    Set<String>? favoriteBanks,
    Set<String>? favoriteCalculators,
    List<String>? recentlyViewedBanks,
    List<String>? recentlySearched,
    this.floatingAIAssistant = true,
    this.animationsEnabled = true,
    this.darkMode = false,
  })  : favoriteBanks = favoriteBanks ?? {},
        favoriteCalculators = favoriteCalculators ?? {},
        recentlyViewedBanks = recentlyViewedBanks ?? [],
        recentlySearched = recentlySearched ?? [];

  /// Create a copy with modified fields
  UserPreferences copyWith({
    Set<String>? favoriteBanks,
    Set<String>? favoriteCalculators,
    List<String>? recentlyViewedBanks,
    List<String>? recentlySearched,
    bool? floatingAIAssistant,
    bool? animationsEnabled,
    bool? darkMode,
  }) {
    return UserPreferences(
      favoriteBanks: favoriteBanks ?? this.favoriteBanks,
      favoriteCalculators: favoriteCalculators ?? this.favoriteCalculators,
      recentlyViewedBanks: recentlyViewedBanks ?? this.recentlyViewedBanks,
      recentlySearched: recentlySearched ?? this.recentlySearched,
      floatingAIAssistant: floatingAIAssistant ?? this.floatingAIAssistant,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  int get favoriteCount => favoriteBanks.length + favoriteCalculators.length;
  int get recentlyViewedCount => recentlyViewedBanks.length;
  int get recentlySearchedCount => recentlySearched.length;
}
