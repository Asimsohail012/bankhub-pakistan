import 'package:flutter/material.dart';

/// Displays verification status badge with color coding.
///
/// Supports three states:
/// - verified: Green badge, "Verified by SBP"
/// - pending: Orange badge, "Verification Pending"
/// - outdated: Red badge, "Information Outdated"
class VerificationBadge extends StatelessWidget {
  /// Verification status: 'verified', 'pending', 'outdated', or null
  final String? status;

  /// Optional verification date to display
  final String? verificationDate;

  const VerificationBadge({
    super.key,
    this.status,
    this.verificationDate,
  });

  Color _backgroundColor() {
    switch (status?.toLowerCase()) {
      case 'verified':
        return const Color(0xFFE8F5E9);
      case 'pending':
        return const Color(0xFFFFF3E0);
      case 'outdated':
        return const Color(0xFFFFEBEE);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _foregroundColor() {
    switch (status?.toLowerCase()) {
      case 'verified':
        return const Color(0xFF2E7D32);
      case 'pending':
        return const Color(0xFFF57C00);
      case 'outdated':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF616161);
    }
  }

  IconData _statusIcon() {
    switch (status?.toLowerCase()) {
      case 'verified':
        return Icons.check_circle_rounded;
      case 'pending':
        return Icons.schedule_rounded;
      case 'outdated':
        return Icons.warning_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _statusLabel() {
    switch (status?.toLowerCase()) {
      case 'verified':
        return 'Verified by SBP';
      case 'pending':
        return 'Verification Pending';
      case 'outdated':
        return 'Information Outdated';
      default:
        return 'Status Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status == null) {
      return const SizedBox.shrink();
    }

    final bgColor = _backgroundColor();
    final fgColor = _foregroundColor();
    final icon = _statusIcon();
    final label = _statusLabel();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: fgColor.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: fgColor, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (verificationDate != null) ...[
          const SizedBox(height: 4),
          Text(
            'Last verified: $verificationDate',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }
}
