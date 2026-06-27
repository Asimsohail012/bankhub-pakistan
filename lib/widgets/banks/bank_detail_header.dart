import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/bank_model.dart';
import 'bank_logo.dart';

/// Returns the gradient colours for the detail header based on bank category.
List<Color> _headerGradient(String category) {
  switch (category) {
    case 'Islamic Banks':
      return const [Color(0xFF1B5E20), Color(0xFF2E7D32)];
    case 'Government Banks':
      return const [Color(0xFF004D40), Color(0xFF00695C)];
    case 'Digital Banks':
      return const [Color(0xFF4A148C), Color(0xFF7B1FA2)];
    case 'Microfinance Banks':
      return const [Color(0xFFBF360C), Color(0xFFE64A19)];
    case 'Specialized Banks':
      return const [Color(0xFF006064), Color(0xFF00838F)];
    default: // Commercial Banks, Foreign Banks
      return const [Color(0xFF1E3A8A), Color(0xFF2563EB)];
  }
}

/// Premium gradient header for the Bank Detail screen.
///
/// Shows: logo (with Hero), bank name, category chip, star rating,
/// established year, branch/ATM stat chips, and action buttons.
///
/// The Hero tag used here is `'bank-logo-${bank.id}'` — the single canonical
/// tag for this bank's logo animation.
class BankDetailHeader extends StatelessWidget {
  final BankModel bank;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const BankDetailHeader({
    super.key,
    required this.bank,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _headerGradient(bank.category);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top section: logo + name + category ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo with Hero animation
                BankLogo(
                  bank: bank,
                  size: 72,
                  borderRadius: 20,
                  heroTag: 'bank-logo-${bank.id}',
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        bank.name,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 19,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Slogan
                      Text(
                        bank.slogan,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Category chip
                      _WhiteChip(label: bank.category),
                      const SizedBox(height: 8),
                      // Star rating
                      _StarRating(rating: bank.rating),
                    ],
                  ),
                ),
                // Favourite button
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      isFavorite
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: isFavorite ? Colors.amber.shade300 : Colors.white60,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ── Divider ──────────────────────────────────────────────────────
          Divider(
            color: Colors.white.withValues(alpha: 0.15),
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          // ── Stats row ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.account_balance_rounded,
                  label: 'Branches',
                  value: bank.branchCount > 0
                      ? bank.branchCount.toString()
                      : '—',
                ),
                _StatDivider(),
                _StatItem(
                  icon: Icons.atm_rounded,
                  label: 'ATMs',
                  value: bank.atmCount > 0 ? bank.atmCount.toString() : '—',
                ),
                _StatDivider(),
                _StatItem(
                  icon: Icons.history_edu_rounded,
                  label: 'Est.',
                  value: bank.establishedYear > 0
                      ? bank.establishedYear.toString()
                      : '—',
                ),
              ],
            ),
          ),
          // ── Divider ──────────────────────────────────────────────────────
          Divider(
            color: Colors.white.withValues(alpha: 0.15),
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          // ── Action buttons ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.language_rounded,
                    label: 'Website',
                    onTap: () => _launch(bank.website),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.phone_rounded,
                    label: bank.helpline.isNotEmpty ? bank.helpline : 'Call',
                    onTap: bank.helpline.isNotEmpty
                        ? () => _launch('tel:${bank.helpline}')
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Private helpers ────────────────────────────────────────────────────────

class _WhiteChip extends StatelessWidget {
  final String label;
  const _WhiteChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          final filled = i < rating.floor();
          final half = !filled && i < rating && (rating - i) >= 0.5;
          return Icon(
            filled
                ? Icons.star_rounded
                : half
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
            size: 15,
            color: Colors.amber.shade300,
          );
        }),
        const SizedBox(width: 5),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 17),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
