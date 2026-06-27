import 'package:flutter/material.dart';

/// Displays digital banking services and channels.
///
/// Shows: mobile app, internet banking, digital onboarding, etc.
/// Supports feature badges with icons.
/// Null-safe: section not shown if no digital services.
class DigitalBankingSection extends StatelessWidget {
  final List<String>? digitalServices;
  final String? title;

  const DigitalBankingSection({
    super.key,
    this.digitalServices,
    this.title = 'Digital Banking',
  });

  IconData _serviceIcon(String service) {
    final lower = service.toLowerCase();
    if (lower.contains('mobile')) return Icons.smartphone_rounded;
    if (lower.contains('internet')) return Icons.language_rounded;
    if (lower.contains('online')) return Icons.web_rounded;
    if (lower.contains('ekyc')) return Icons.verified_user_rounded;
    if (lower.contains('wallet')) return Icons.account_balance_wallet_rounded;
    if (lower.contains('qr')) return Icons.qr_code_rounded;
    if (lower.contains('biometric')) return Icons.fingerprint_rounded;
    return Icons.check_circle_rounded;
  }

  @override
  Widget build(BuildContext context) {
    if (digitalServices == null || digitalServices!.isEmpty) {
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
                  children: digitalServices!
                      .map(
                        (service) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E5F5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF7B1FA2).withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _serviceIcon(service),
                                color: const Color(0xFF7B1FA2),
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                service,
                                style: const TextStyle(
                                  color: Color(0xFF7B1FA2),
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
