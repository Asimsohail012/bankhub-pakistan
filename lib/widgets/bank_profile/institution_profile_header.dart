import 'package:flutter/material.dart';
import '../../data/models/financial_institution.dart';
import 'verification_badge.dart';
import 'rating_stars.dart';

/// Premium header for institution profile presentation.
///
/// Displays:
/// - Institution logo with category-based background
/// - Official name
/// - Verification status with date
/// - Star rating (if available)
/// - Category chip
///
/// Reuses BankLogo pattern and maintains premium BankHub design.
/// Null-safe: handles missing logo, rating, and verification data.
class InstitutionProfileHeader extends StatelessWidget {
  final FinancialInstitution institution;

  /// Optional star rating (0-5)
  final double? rating;

  /// Optional callback when favorite is tapped
  final VoidCallback? onFavoriteTap;

  /// Whether the institution is favorited
  final bool isFavorite;

  const InstitutionProfileHeader({
    super.key,
    required this.institution,
    this.rating,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  /// Get gradient colors based on institution category
  List<Color> _getGradient() {
    final category = institution.category.toString();
    if (category.contains('Islamic')) {
      return const [Color(0xFF1B5E20), Color(0xFF2E7D32)];
    } else if (category.contains('Government')) {
      return const [Color(0xFF004D40), Color(0xFF00695C)];
    } else if (category.contains('Digital')) {
      return const [Color(0xFF4A148C), Color(0xFF7B1FA2)];
    } else if (category.contains('Microfinance')) {
      return const [Color(0xFFBF360C), Color(0xFFE64A19)];
    } else if (category.contains('Specialized')) {
      return const [Color(0xFF006064), Color(0xFF00838F)];
    }
    // Default: Commercial Banks
    return const [Color(0xFF1E3A8A), Color(0xFF2563EB)];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getGradient();
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.last.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top section: logo + name + verification ─────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo placeholder (no BankModel available, use initials)
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      institution.shortName.length > 2
                          ? institution.shortName.substring(0, 2).toUpperCase()
                          : institution.shortName.toUpperCase(),
                      style: TextStyle(
                        color: gradient.first,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        institution.officialName,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // Category chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          institution.category.toString().split('.').last,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Star rating
                      if (rating != null && rating! > 0)
                        RatingStars(rating: rating),
                    ],
                  ),
                ),
                // Favorite button
                if (onFavoriteTap != null)
                  GestureDetector(
                    onTap: onFavoriteTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        isFavorite
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color:
                            isFavorite ? Colors.amber.shade300 : Colors.white60,
                        size: 26,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Verification Status ──────────────────────────────────────────
          if (institution.sbpVerified || institution.verificationDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white,
                        ),
                  ),
                  child: VerificationBadge(
                    status: institution.sbpVerified ? 'verified' : null,
                    verificationDate: institution.verificationDate,
                  ),
                ),
              ),
            ),

          // ── Divider ──────────────────────────────────────────────────────
          Divider(
            color: Colors.white.withValues(alpha: 0.15),
            height: 1,
            indent: 20,
            endIndent: 20,
          ),

          // ── License Status ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'License Status',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      institution.licenseStatus.toString().split('.').last,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                if (institution.institutionType.toString().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Institution Type',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        institution.institutionType
                            .toString()
                            .split('.')
                            .last
                            .replaceAllMapped(
                              RegExp(r'([A-Z])'),
                              (match) => ' ${match.group(1)}',
                            )
                            .trim(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
