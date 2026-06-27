import 'package:flutter/material.dart';

/// Displays a single statistic with icon, label, and value.
///
/// Used for showing branch count, ATM count, or similar metrics.
/// Shows fallback "—" when value is null or zero.
class StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  /// Value to display. If null or empty, shows "—"
  final String? value;

  /// Color for the icon (defaults to grey)
  final Color? iconColor;

  const StatChip({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = (value?.isEmpty ?? true) ? '—' : value!;
    final color = iconColor ?? Colors.grey.shade600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          displayValue,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color.withValues(alpha: 0.7),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
