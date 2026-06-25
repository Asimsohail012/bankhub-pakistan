class NewsArticle {
  final String headline;
  final String summary;
  final String source;
  final String publishedAt;

  const NewsArticle({
    required this.headline,
    required this.summary,
    required this.source,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      headline: json['title'] as String,
      summary: json['description'] as String,
      source: json['source'] as String,
      publishedAt: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': headline,
      'description': summary,
      'source': source,
      'date': publishedAt,
    };
  }
}
