import 'package:flutter/material.dart';

class AppColors {
  static const darkNavy = Color(0xFF07172C);
  static const primary = Color(0xFF0F1729);
  static const secondary = Color(0xFF2563EB);
  static const accent = Color(0xFFDAA520);
  static const card = Color(0xFFFFFFFF);
  static const background = Color(0xFFF5F7FB);

  static const blue = Color(0xFF2563EB);
  static const orange = Color(0xFFF59E0B);
  static const purple = Color(0xFF4F46E5);
  static const green = Color(0xFF059669);
  static const red = Color(0xFFDC2626);
  static const cyan = Color(0xFF0891B2);
  static const indigo = Color(0xFF1D4ED8);
  static const gold = Color(0xFFDAA520);
  static const brown = Color(0xFF8B5E34);
  static const darkBlue = Color(0xFF0B1F44);

  static const premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFD54F), Color(0xFFDAA520)],
  );
}