import '../models/news_article.dart';
import '../models/news_item.dart';

const List<NewsItem> bankingNews = [
  NewsItem(
    title: 'Digital wallets see record growth in Pakistan',
    summary:
        'Mobile banking adoption surged, with digital wallets reaching new monthly active user highs across major banks.',
    date: 'Today · 2 min read',
  ),
  NewsItem(
    title: 'New Islamic banking regulations announced',
    summary:
        'The SBP released updated guidelines for Islamic finance operations, emphasizing transparency and customer protection.',
    date: 'Yesterday · 3 min read',
  ),
  NewsItem(
    title: 'Top banks expand branch networks in 2026',
    summary:
        'Several banks announced expansion plans targeting underserved areas and improved digital branch experiences.',
    date: '2 days ago · 4 min read',
  ),
];

const List<NewsArticle> liveNewsArticles = [
  NewsArticle(
    headline: 'SBP signals steady policy with measured guidance',
    summary:
        'The State Bank of Pakistan indicated stability in monetary policy as inflationary pressures remain elevated across the economy.',
    source: 'SBP Update',
    publishedAt: 'Today · 10:15 AM',
  ),
  NewsArticle(
    headline: 'Commercial banks post strong quarter in digital transactions',
    summary:
        'Top Pakistani banks reported double-digit growth in mobile and internet banking volumes, signaling robust digital adoption.',
    source: 'MarketWatch Pakistan',
    publishedAt: 'Today · 09:40 AM',
  ),
  NewsArticle(
    headline: 'KIBOR edges higher as liquidity tightness continues',
    summary:
        'Short-term interbank rates moved upward amid lower than expected deposit inflows and continued government borrowing.',
    source: 'Financial Daily',
    publishedAt: 'Today · 08:55 AM',
  ),
];
