import 'package:flutter/material.dart';

import '../../models/bank_model.dart';
import 'bank_category_chip.dart';
import 'bank_logo.dart';

/// Premium bank card for the Bank Directory list.
///
/// Displays: logo, name, category chip, optional badges, rating,
/// favourite icon and a forward arrow.
///
/// Uses a [Hero] with tag `'bank-logo-list-${bank.id}'` for the logo so
/// it does not conflict with any other Hero tags in the app.
class BankCard extends StatelessWidget {
  final BankModel bank;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const BankCard({
    super.key,
    required this.bank,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // ── Logo ──────────────────────────────────────────────────────
              BankLogo(
                bank: bank,
                size: 56,
                borderRadius: 16,
              ),
              const SizedBox(width: 14),
              // ── Main content ──────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row + favourite
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            bank.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: isFavorite ? Colors.amber.shade600 : Colors.grey.shade400,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Category chip + optional badges
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        BankCategoryChip(category: bank.category),
                        if (bank.category == 'Islamic Banks')
                          _Badge(
                            label: 'Islamic',
                            background: const Color(0xFFE8F5E9),
                            foreground: const Color(0xFF2E7D32),
                            icon: Icons.mosque_outlined,
                          ),
                        if (bank.mobileApp.isNotEmpty)
                          _Badge(
                            label: 'Digital',
                            background: const Color(0xFFEDE7F6),
                            foreground: const Color(0xFF512DA8),
                            icon: Icons.smartphone_rounded,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Rating row
                    Row(
                      children: [
                        _RatingBar(rating: bank.rating),
                        const SizedBox(width: 6),
                        Text(
                          bank.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Spacer(),
                        // Arrow
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Private helpers ────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final IconData icon;

  const _Badge({
    required this.label,
    required this.background,
    required this.foreground,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: foreground),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final double rating;
  const _RatingBar({required this.rating});

  @override
  Widget build(BuildContext context) {
    const total = 5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final filled = i < rating.floor();
        final halfFilled = !filled && (i < rating) && (rating - i >= 0.5);
        return Icon(
          filled
              ? Icons.star_rounded
              : halfFilled
                  ? Icons.star_half_rounded
                  : Icons.star_outline_rounded,
          size: 14,
          color: Colors.amber.shade500,
        );
      }),
    );
  }
}
