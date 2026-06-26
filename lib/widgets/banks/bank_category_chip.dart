import 'package:flutter/material.dart';

/// Returns the foreground and background colours for a given bank category.
({Color background, Color foreground}) bankCategoryColors(String category) {
  switch (category) {
    case 'Islamic Banks':
      return (
        background: const Color(0xFFE8F5E9),
        foreground: const Color(0xFF2E7D32),
      );
    case 'Government Banks':
      return (
        background: const Color(0xFFE8F5E9),
        foreground: const Color(0xFF1B5E20),
      );
    case 'Digital Banks':
      return (
        background: const Color(0xFFF3E5F5),
        foreground: const Color(0xFF6A1B9A),
      );
    case 'Microfinance Banks':
      return (
        background: const Color(0xFFFFF3E0),
        foreground: const Color(0xFFE65100),
      );
    case 'Specialized Banks':
      return (
        background: const Color(0xFFE0F7FA),
        foreground: const Color(0xFF006064),
      );
    default: // Commercial Banks, Foreign Banks
      return (
        background: const Color(0xFFE8EAF6),
        foreground: const Color(0xFF283593),
      );
  }
}

/// Compact, coloured chip showing the bank category label.
class BankCategoryChip extends StatelessWidget {
  final String category;

  const BankCategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final colors = bankCategoryColors(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: colors.foreground,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
