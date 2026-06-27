import 'package:flutter/material.dart';
import '../../data/models/bank_capability.dart';

/// Displays banking capabilities for a specific category.
///
/// Shows list of BankCapability objects with names, types, and descriptions.
/// Supports metadata display (Phase 6+ ready).
/// Null-safe: section not shown if no capabilities.
class CapabilitySection extends StatelessWidget {
  /// Section title (e.g., "Account Capabilities")
  final String title;

  /// List of capabilities to display
  final List<BankCapability>? capabilities;

  /// Background color for badges
  final Color? badgeColor;

  /// Text color for badges
  final Color? badgeTextColor;

  const CapabilitySection({
    super.key,
    required this.title,
    this.capabilities,
    this.badgeColor,
    this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    if (capabilities == null || capabilities!.isEmpty) {
      return const SizedBox.shrink();
    }

    final bgColor = badgeColor ?? const Color(0xFFE8EAF6);
    final textColor = badgeTextColor ?? const Color(0xFF1E3A8A);
    final caps = capabilities!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
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
              children: caps
                  .map(
                    (capability) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      capability.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    if (capability.type.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: bgColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          capability.type,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if ((capability.description ?? '').isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              capability.description!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ],
                          if ((capability.verificationStatus ?? '').isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              'Status: ${capability.verificationStatus}',
                              style: TextStyle(
                                fontSize: 11,
                                color: capability.verificationStatus ==
                                        'verified'
                                    ? Colors.green.shade700
                                    : Colors.orange.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
