import 'package:flutter/material.dart';

/// Displays card products and services offered.
///
/// Shows: credit cards, debit cards, prepaid cards, virtual cards, etc.
/// Supports feature badges with icons.
/// Null-safe: section not shown if no card services.
class CardServicesSection extends StatelessWidget {
  final List<String>? cardServices;
  final String? title;

  const CardServicesSection({
    super.key,
    this.cardServices,
    this.title = 'Card Services',
  });

  IconData _cardIcon(String card) {
    final lower = card.toLowerCase();
    if (lower.contains('credit')) return Icons.credit_card_rounded;
    if (lower.contains('debit')) return Icons.credit_card_rounded;
    if (lower.contains('virtual')) return Icons.phonelink_lock_rounded;
    if (lower.contains('prepaid')) return Icons.card_giftcard_rounded;
    if (lower.contains('corporate')) return Icons.business_center_rounded;
    if (lower.contains('travel')) return Icons.flight_rounded;
    if (lower.contains('contactless')) return Icons.nfc_rounded;
    return Icons.credit_card_rounded;
  }

  Color _cardColor(String card) {
    final lower = card.toLowerCase();
    if (lower.contains('credit')) return const Color(0xFFEDE7F6);
    if (lower.contains('debit')) return const Color(0xFFE0F2F1);
    if (lower.contains('virtual')) return const Color(0xFFFFF3E0);
    return const Color(0xFFEDE7F6);
  }

  Color _cardTextColor(String card) {
    final lower = card.toLowerCase();
    if (lower.contains('credit')) return const Color(0xFF512DA8);
    if (lower.contains('debit')) return const Color(0xFF00695C);
    if (lower.contains('virtual')) return const Color(0xFFF57C00);
    return const Color(0xFF512DA8);
  }

  @override
  Widget build(BuildContext context) {
    if (cardServices == null || cardServices!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(
            title!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: cardServices!
                      .map(
                        (card) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _cardColor(card),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _cardTextColor(card).withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _cardIcon(card),
                                color: _cardTextColor(card),
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                card,
                                style: TextStyle(
                                  color: _cardTextColor(card),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
