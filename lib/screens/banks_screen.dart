import 'package:flutter/material.dart';

import '../data/banks_data.dart';
import '../models/bank_model.dart';
import '../screens/bank_detail_screen.dart';
import '../services/bank_persistence_service.dart';
import '../widgets/bank_list_tile.dart';

class BanksScreen extends StatefulWidget {
  const BanksScreen({super.key});

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  String searchText = '';
  String selectedCategory = 'All';
  bool showFavoritesOnly = false;
  Set<String> favoriteBankIds = {};
  List<String> recentlyViewedIds = [];

  static const List<String> categories = [
    'All',
    'Commercial Banks',
    'Islamic Banks',
    'Digital Banks',
    'Microfinance Banks',
    'Government Banks',
    'Specialized Banks',
  ];

  @override
  void initState() {
    super.initState();
    _loadPersistence();
  }

  Future<void> _loadPersistence() async {
    final favorites = await BankPersistenceService.loadFavorites();
    final recent = await BankPersistenceService.loadRecentlyViewed();
    setState(() {
      favoriteBankIds = favorites;
      recentlyViewedIds = recent;
    });
  }

  Future<void> _toggleFavorite(String bankId) async {
    await BankPersistenceService.toggleFavorite(bankId);
    await _loadPersistence();
  }

  void _openBank(BankModel bank) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BankDetailScreen(bank: bank),
      ),
    ).then((_) => _loadPersistence());
  }

  Iterable<BankModel> get favoriteBanks => pakistanBanks.where((bank) => favoriteBankIds.contains(bank.id));

  Iterable<BankModel> get recentlyViewedBanks => recentlyViewedIds
      .map((id) => pakistanBanks.firstWhere((bank) => bank.id == id, orElse: () => pakistanBanks.first))
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    final List<BankModel> filteredBanks = pakistanBanks.where((bank) {
      final query = searchText.trim();
      final matchesCategory = selectedCategory == 'All' || bank.category == selectedCategory;
      final matchesQuery = query.isEmpty || bank.matchesSearch(query);
      final matchesFavorite = !showFavoritesOnly || favoriteBankIds.contains(bank.id);
      return matchesCategory && matchesQuery && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Banks Directory'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name, product, SWIFT, branch, or keywords...',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ChoiceChip(
                  label: const Text('All Banks'),
                  selected: !showFavoritesOnly,
                  selectedColor: Colors.indigo.shade100,
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) {
                    setState(() {
                      showFavoritesOnly = false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Favorites'),
                  selected: showFavoritesOnly,
                  selectedColor: Colors.indigo.shade100,
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) {
                    setState(() {
                      showFavoritesOnly = true;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: Colors.indigo.shade100,
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredBanks.length} banks found',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          if (favoriteBanks.isNotEmpty && !showFavoritesOnly)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favorite Banks',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: favoriteBanks.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final bank = favoriteBanks.elementAt(index);
                        return GestureDetector(
                          onTap: () => _openBank(bank),
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.indigo.shade50,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Expanded(
                                  child: Text(
                                    bank.slogan,
                                    style: TextStyle(color: Colors.grey.shade700),
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.star, size: 16, color: Colors.amber),
                                    SizedBox(width: 4),
                                    Text('Favorite'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (recentlyViewedIds.isNotEmpty && !showFavoritesOnly)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recently Viewed',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentlyViewedBanks.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final bank = recentlyViewedBanks.elementAt(index);
                        return GestureDetector(
                          onTap: () => _openBank(bank),
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Expanded(
                                  child: Text(
                                    bank.slogan,
                                    style: TextStyle(color: Colors.grey.shade700),
                                  ),
                                ),
                                Text(
                                  bank.category,
                                  style: TextStyle(color: Colors.indigo.shade700),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: filteredBanks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No banks matched your search.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredBanks.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final bank = filteredBanks[index];
                      final isFavorite = favoriteBankIds.contains(bank.id);
                      return BankListTile(
                        bank: bank,
                        isFavorite: isFavorite,
                        onFavoriteTap: () => _toggleFavorite(bank.id),
                        onTap: () => _openBank(bank),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
