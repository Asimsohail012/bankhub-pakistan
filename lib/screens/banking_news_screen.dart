import 'package:flutter/material.dart';

import '../data/news_data.dart';
import '../widgets/news_card.dart';
import '../widgets/section_header.dart';

class BankingNewsScreen extends StatelessWidget {
  const BankingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banking News'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const SectionHeader(
            title: 'Latest Banking News',
            subtitle: 'Stay ahead with market updates, regulation changes and digital banking insights.',
          ),
          const SizedBox(height: 18),
          ...bankingNews.map((newsItem) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: NewsCard(newsItem: newsItem),
            );
          }),
        ],
      ),
    );
  }
}
