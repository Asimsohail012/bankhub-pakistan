import '../models/news_article.dart';
import '../data/news_data.dart';
import 'api_client.dart';

class BankingNewsService {
  final ApiClient _apiClient;

  BankingNewsService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<NewsArticle>> fetchNewsArticles() async {
    const cacheKey = 'banking_news';
    final uri = Uri.parse('https://api.example.com/banking-news');

    final result = await _apiClient.fetchListWithCache<NewsArticle>(
      cacheKey,
      uri,
      (json) => NewsArticle.fromJson(json),
      fallback: liveNewsArticles,
    );

    return result.data ?? [];
  }
}
