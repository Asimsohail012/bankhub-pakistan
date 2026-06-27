import 'package:flutter/material.dart';

/// Displays Islamic banking products and services.
///
/// Shows: Murabaha, Ijara, Sukuk, Takaful, Islamic cards, etc.
/// Uses green badge theme for Islamic services.
/// Null-safe: section not shown if no Islamic services.
class IslamicBankingSection extends StatelessWidget {
  final List<String>? islamicServices;
  final String? title;

  const IslamicBankingSection({
    super.key,
    this.islamicServices,
    this.title = 'Islamic Banking',
  });

  IconData _serviceIcon(String service) {
    final lower = service.toLowerCase();
    if (lower.contains('murabaha')) return Icons.handshake_rounded;
    if (lower.contains('ijara')) return Icons.house_rounded;
    if (lower.contains('sukuk')) return Icons.local_offer_rounded;
    if (lower.contains('takaful')) return Icons.verified_rounded;
    if (lower.contains('investment')) return Icons.trending_up_rounded;
    if (lower.contains('finance')) return Icons.savings_rounded;
    if (lower.contains('account')) return Icons.account_balance_rounded;
    if (lower.contains('card')) return Icons.credit_card_rounded;
    return Icons.check_circle_rounded;
  }

  @override
  Widget build(BuildContext context) {
    if (islamicServices == null || islamicServices!.isEmpty) {
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
                  children: islamicServices!
                      .map(
                        (service) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF2E7D32).withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _serviceIcon(service),
                                color: const Color(0xFF2E7D32),
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                service,
                                style: const TextStyle(
                                  color: Color(0xFF2E7D32),
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
