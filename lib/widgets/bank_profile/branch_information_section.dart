import 'package:flutter/material.dart';
import 'stat_chip.dart';

/// Displays branch and ATM network information.
///
/// Shows: branch count, ATM count, and service areas.
/// Null-safe: missing information is displayed as "—".
class BranchInformationSection extends StatelessWidget {
  final int? branchCount;
  final int? atmCount;
  final String? serviceArea;
  final String? title;

  const BranchInformationSection({
    super.key,
    this.branchCount,
    this.atmCount,
    this.serviceArea,
    this.title = 'Branch Network',
  });

  @override
  Widget build(BuildContext context) {
    // If no data, don't show section
    if (branchCount == null && atmCount == null && (serviceArea == null || serviceArea!.isEmpty)) {
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatChip(
                      icon: Icons.account_balance_rounded,
                      label: 'Branches',
                      value: branchCount != null && branchCount! > 0
                          ? branchCount.toString()
                          : null,
                      iconColor: Colors.indigo.shade600,
                    ),
                    if (atmCount != null || branchCount != null)
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    StatChip(
                      icon: Icons.atm_rounded,
                      label: 'ATMs',
                      value: atmCount != null && atmCount! > 0 ? atmCount.toString() : null,
                      iconColor: Colors.teal.shade600,
                    ),
                  ],
                ),
                // Service area info
                if (serviceArea != null && serviceArea!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.grey.shade300,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service Area',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        serviceArea!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
