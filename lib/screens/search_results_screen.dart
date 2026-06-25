import 'package:flutter/material.dart';

import '../data/banks_data.dart';
import '../data/news_data.dart';
import '../models/bank_model.dart';
import '../models/news_item.dart';
import '../screens/bank_detail_screen.dart';
import '../widgets/bank_list_tile.dart';
import '../widgets/news_card.dart';
import '../widgets/section_header.dart';

class SearchResultsScreen extends StatefulWidget {
  final String initialQuery;

  const SearchResultsScreen({
    super.key,
    this.initialQuery = '',
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery;
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BankModel> get _bankResults {
    final query = _query.toLowerCase();
    if (query.isEmpty) {
      return [];
    }
    return pakistanBanks.where((bank) {
      return bank.name.toLowerCase().contains(query) ||
          bank.slogan.toLowerCase().contains(query) ||
          bank.website.toLowerCase().contains(query) ||
          bank.internetBanking.toLowerCase().contains(query);
    }).toList();
  }

  List<NewsItem> get _newsResults {
    final query = _query.toLowerCase();
    if (query.isEmpty) {
      return [];
    }
    return bankingNews.where((item) {
      return item.title.toLowerCase().contains(query) ||
          item.summary.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Search BankHub',
              subtitle: 'Search banks, products, and news across Pakistan’s financial ecosystem.',
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search banks, cards, news...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {
                            _query = '';
                          });
                        },
                        child: const Icon(Icons.close),
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_query.isEmpty) ...[
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  'HBL',
                  'Islamic banking',
                  'Mobile app',
                  'Credit cards',
                  'Digital wallet',
                ].map<Widget>((text) {
                  return ActionChip(
                    label: Text(text),
                    backgroundColor: Colors.indigo.shade50,
                    onPressed: () {
                      _searchController.text = text;
                      setState(() {
                        _query = text;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Search suggestions',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Type a query to see bank and news results in real time.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ] else ...[
              if (_bankResults.isNotEmpty) ...[
                const Text(
                  'Banks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: _bankResults.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final bank = _bankResults[index];
                      return BankListTile(
                        bank: bank,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BankDetailScreen(bank: bank),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ] else ...[
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        color: Colors.grey.shade400,
                        size: 60,
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'No matching banks found.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
              if (_newsResults.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'News',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: _newsResults.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return NewsCard(newsItem: _newsResults[index]);
                    },
                  ),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}
