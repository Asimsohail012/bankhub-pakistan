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
      headline: json['headline'] as String,
      summary: json['summary'] as String,
      source: json['source'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'summary': summary,
      'source': source,
      'publishedAt': publishedAt,
    };
  }
}
