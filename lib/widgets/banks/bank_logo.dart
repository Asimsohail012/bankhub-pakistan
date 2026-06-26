import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/bank_model.dart';

/// Returns the background colour for a bank logo container based on category.
Color bankCategoryLogoColor(String category) {
  switch (category) {
    case 'Islamic Banks':
      return const Color(0xFFE8F5E9); // green 50
    case 'Government Banks':
      return const Color(0xFFE0F2F1); // teal 50
    case 'Digital Banks':
      return const Color(0xFFF3E5F5); // purple 50
    case 'Microfinance Banks':
      return const Color(0xFFFFF3E0); // orange 50
    case 'Specialized Banks':
      return const Color(0xFFE0F7FA); // cyan 50
    default: // Commercial Banks, Foreign Banks
      return const Color(0xFFE8EAF6); // indigo 50
  }
}

/// Reusable bank logo widget.
///
/// Loads the SVG asset and falls back to a coloured container with
/// the bank's initials when the asset cannot be loaded.
class BankLogo extends StatelessWidget {
  final BankModel bank;
  final double size;
  final double borderRadius;

  const BankLogo({
    super.key,
    required this.bank,
    this.size = 52,
    this.borderRadius = 16,
  });

  String _initials() {
    final parts = bank.name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return bank.name.substring(0, bank.name.length.clamp(0, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = bankCategoryLogoColor(bank.category);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(
        bank.logoAsset,
        fit: BoxFit.contain,
        // ignore: deprecated_member_use
        placeholderBuilder: (_) => _FallbackInitials(
          initials: _initials(),
          category: bank.category,
          size: size,
        ),
      ),
    );
  }
}

class _FallbackInitials extends StatelessWidget {
  final String initials;
  final String category;
  final double size;

  const _FallbackInitials({
    required this.initials,
    required this.category,
    required this.size,
  });

  Color _textColor() {
    switch (category) {
      case 'Islamic Banks':
        return const Color(0xFF2E7D32);
      case 'Government Banks':
        return const Color(0xFF00695C);
      case 'Digital Banks':
        return const Color(0xFF6A1B9A);
      case 'Microfinance Banks':
        return const Color(0xFFE65100);
      case 'Specialized Banks':
        return const Color(0xFF006064);
      default:
        return const Color(0xFF283593);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        initials,
        style: TextStyle(
          color: _textColor(),
          fontWeight: FontWeight.w800,
          fontSize: size * 0.32,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
