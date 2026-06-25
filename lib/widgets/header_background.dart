import 'package:flutter/material.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.14,
        child: Stack(
          children: [

            // MOON
            const Positioned(
              top: 35,
              right: 120,
              child: Icon(
                Icons.nightlight_round,
                color: Colors.white,
                size: 70,
              ),
            ),

            // STARS
            const Positioned(
              top: 40,
              left: 80,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 10,
              ),
            ),

            const Positioned(
              top: 70,
              left: 260,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              ),
            ),

            const Positioned(
              top: 95,
              left: 520,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 9,
              ),
            ),

            const Positioned(
              top: 55,
              right: 260,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 11,
              ),
            ),

            const Positioned(
              top: 110,
              right: 140,
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 10,
              ),
            ),

            // MINAR-E-PAKISTAN STYLE SILHOUETTE
            Positioned(
              right: 80,
              bottom: 18,
              child: Container(
                width: 42,
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            Positioned(
              right: 92,
              bottom: 115,
              child: Container(
                width: 18,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            // SKYLINE
            Positioned(
              left: 60,
              right: 60,
              bottom: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  12,
                  (index) => Container(
                    width: 22,
                    height: 25 + (index % 4) * 18,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}