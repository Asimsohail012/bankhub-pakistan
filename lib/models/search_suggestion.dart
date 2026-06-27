/// Represents a search suggestion for autocomplete and instant search.
class SearchSuggestion {
  final String text;
  final String type; // 'bank', 'news', 'job', 'circular', 'recent', 'popular'
  final String? id;
  final String? icon;
  final String? subtitle;

  const SearchSuggestion({
    required this.text,
    required this.type,
    this.id,
    this.icon,
    this.subtitle,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchSuggestion &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          type == other.type &&
          id == other.id;

  @override
  int get hashCode => text.hashCode ^ type.hashCode ^ (id?.hashCode ?? 0);
}
