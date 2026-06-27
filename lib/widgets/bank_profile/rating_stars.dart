import 'package:flutter/material.dart';

/// Displays a star rating visualization.
///
/// Shows filled stars for rating value and empty stars for remainder.
/// Supports half stars via decimal values.
class RatingStars extends StatelessWidget {
  /// Rating value (0.0 to 5.0)
  final double? rating;

  /// Size of each star (default 16)
  final double size;

  /// Color for filled stars (default gold)
  final Color filledColor;

  /// Color for empty stars (default grey)
  final Color emptyColor;

  const RatingStars({
    super.key,
    this.rating,
    this.size = 16,
    this.filledColor = const Color(0xFFFFB81C),
    this.emptyColor = Colors.white60,
  });

  @override
  Widget build(BuildContext context) {
    if (rating == null || rating == 0) {
      return const SizedBox.shrink();
    }

    final displayRating = (rating ?? 0).clamp(0.0, 5.0);
    final fullStars = displayRating.floor();
    final hasHalfStar = (displayRating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon;
        Color color;

        if (index < fullStars) {
          icon = Icons.star_rounded;
          color = filledColor;
        } else if (index == fullStars && hasHalfStar) {
          icon = Icons.star_half_rounded;
          color = filledColor;
        } else {
          icon = Icons.star_outline_rounded;
          color = emptyColor;
        }

        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? 2 : 0),
          child: Icon(icon, color: color, size: size),
        );
      }),
    );
  }
}
