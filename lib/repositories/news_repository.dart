import '../models/news_article.dart';
import '../services/banking_news_service.dart';

class NewsRepository {
  final BankingNewsService _service;

  NewsRepository({BankingNewsService? service}) : _service = service ?? BankingNewsService();

  Future<List<NewsArticle>> getNewsArticles() async {
    return _service.fetchNewsArticles();
  }
}
