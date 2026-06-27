import 'package:flutter/material.dart';

/// Displays last updated timestamp.
///
/// Shows when the institution information was last updated.
/// Typically displayed at the bottom of the bank profile.
class LastUpdatedFooter extends StatelessWidget {
  /// Last updated timestamp (e.g., "2024-06-27 10:30:00" or "June 27, 2024")
  final String? lastUpdated;

  const LastUpdatedFooter({
    super.key,
    this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (lastUpdated == null || lastUpdated!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.update_rounded,
            size: 14,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Last updated: $lastUpdated',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
