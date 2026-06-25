import 'package:flutter/material.dart';

import '../models/news_article.dart';
import 'premium_info_card.dart';

class BankingNewsCard extends StatelessWidget {
  final List<NewsArticle> articles;

  const BankingNewsCard({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumInfoCard(
      title: 'Banking News',
      subtitle: 'Latest headlines to keep you informed.',
      child: Column(
        children: articles.map((article) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.headline,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article.summary,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${article.source} · ${article.publishedAt}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
