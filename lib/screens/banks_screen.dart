import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/banks_data.dart';
import '../models/bank_model.dart';
import '../screens/bank_detail_screen.dart';
import '../services/bank_persistence_service.dart';
import '../widgets/banks/bank_card.dart';
import '../widgets/banks/bank_logo.dart';
import '../widgets/premium_unlock_sheet.dart';

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
    if (FirebaseAuth.instance.currentUser == null) {
      await showPremiumUnlockSheet(context);
      return;
    }
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

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Banks Directory'),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          // ── Search bar ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name, product, SWIFT...',
                hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          // ── All / Favorites toggle ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _FilterChip(
                  label: 'All Banks',
                  selected: !showFavoritesOnly,
                  onSelected: (_) => setState(() => showFavoritesOnly = false),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Favorites',
                  selected: showFavoritesOnly,
                  icon: Icons.star_rounded,
                  onSelected: (_) {
                    if (FirebaseAuth.instance.currentUser == null) {
                      showPremiumUnlockSheet(context);
                      return;
                    }
                    setState(() => showFavoritesOnly = true);
                  },
                ),
              ],
            ),
          ),
          // ── Category chips ────────────────────────────────────────────────
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return _FilterChip(
                  label: category,
                  selected: isSelected,
                  onSelected: (_) => setState(() => selectedCategory = category),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredBanks.length} bank${filteredBanks.length == 1 ? '' : 's'} found',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (favoriteBanks.isNotEmpty && !showFavoritesOnly)
            _HorizontalBankStrip(
              title: 'Favorite Banks',
              banks: favoriteBanks.toList(),
              onBankTap: _openBank,
              showFavoriteIcon: true,
            ),
          if (recentlyViewedIds.isNotEmpty && !showFavoritesOnly)
            _HorizontalBankStrip(
              title: 'Recently Viewed',
              banks: recentlyViewedBanks.toList(),
              onBankTap: _openBank,
            ),
          Expanded(
            child: filteredBanks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'No banks matched your search.',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: filteredBanks.length,
                    itemBuilder: (context, index) {
                      final bank = filteredBanks[index];
                      final isFavorite = favoriteBankIds.contains(bank.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: BankCard(
                          bank: bank,
                          isFavorite: isFavorite,
                          onFavoriteTap: () => _toggleFavorite(bank.id),
                          onTap: () => _openBank(bank),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Private helpers ────────────────────────────────────────────────────────

/// Styled filter / toggle chip used in the Banks Directory toolbar.
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData? icon;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FilterChip(
      label: Text(label),
      selected: selected,
      avatar: icon != null ? Icon(icon, size: 16) : null,
      onSelected: onSelected,
      selectedColor: colorScheme.primaryContainer,
      checkmarkColor: colorScheme.primary,
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        fontSize: 13,
        color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
      ),
      backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.4)
              : Colors.transparent,
          width: 1,
        ),
      ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    );
  }
}

/// Horizontal scrollable strip of compact bank cards.
class _HorizontalBankStrip extends StatelessWidget {
  final String title;
  final List<BankModel> banks;
  final ValueChanged<BankModel> onBankTap;
  final bool showFavoriteIcon;

  const _HorizontalBankStrip({
    required this.title,
    required this.banks,
    required this.onBankTap,
    this.showFavoriteIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 96,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: banks.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final bank = banks[index];
                return _CompactBankChip(
                  bank: bank,
                  onTap: () => onBankTap(bank),
                  showFavoriteIcon: showFavoriteIcon,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact horizontal card chip for the strip sections.
class _CompactBankChip extends StatelessWidget {
  final BankModel bank;
  final VoidCallback onTap;
  final bool showFavoriteIcon;

  const _CompactBankChip({
    required this.bank,
    required this.onTap,
    this.showFavoriteIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            BankLogo(bank: bank, size: 40, borderRadius: 12),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bank.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showFavoriteIcon)
                    const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
