import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for banking news service.
abstract class BankingNewsService {
  /// Fetches latest banking and financial news articles.
  Future<LiveDataResult<List<BankingNewsArticle>>> getLatestNews();

  /// Searches news by keyword.
  Future<LiveDataResult<List<BankingNewsArticle>>> searchNews(String query);

  /// Refreshes news from source.
  Future<LiveDataResult<List<BankingNewsArticle>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankingNewsService.
///
/// Currently returns placeholder data. In production, this would
/// connect to banking news aggregators or financial news APIs.
class BankingNewsServiceImpl implements BankingNewsService {
  static final _placeholderData = [
    BankingNewsArticle(
      id: 'news_001',
      title: 'SBP Announces New Digital Payment Guidelines',
      summary: 'State Bank of Pakistan has released updated guidelines for digital payment systems...',
      source: 'Banking Times',
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      imageUrl: null,
    ),
    BankingNewsArticle(
      id: 'news_002',
      title: 'HBL Reports Strong Q2 Earnings',
      summary: 'Habib Bank Limited announced robust financial results for the second quarter...',
      source: 'Financial News',
      publishedAt: DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
      imageUrl: null,
    ),
    BankingNewsArticle(
      id: 'news_003',
      title: 'Digital Banking Adoption Increases in Pakistan',
      summary: 'Latest survey shows significant growth in mobile and online banking usage...',
      source: 'Tech Finance Daily',
      publishedAt: DateTime.now().subtract(const Duration(hours: 6)).toIso8601String(),
      imageUrl: null,
    ),
  ];

  DateTime? _lastUpdated;

  BankingNewsServiceImpl();

  @override
  Future<LiveDataResult<List<BankingNewsArticle>>> getLatestNews() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 800));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_banking_news',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingNewsArticle>>> searchNews(String query) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 700));

    final lower = query.toLowerCase();
    final filtered = _placeholderData
        .where(
          (article) =>
              article.title.toLowerCase().contains(lower) ||
              article.summary.toLowerCase().contains(lower),
        )
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_news',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingNewsArticle>>> refresh() =>
      getLatestNews();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'banking_news_api';
}
