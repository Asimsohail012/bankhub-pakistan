import 'package:flutter/material.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Opacity(
          opacity: .14,
          child: Stack(
            children: [
              const Positioned(
                top: 24,
                right: 30,
                child: Icon(
                  Icons.nightlight_round,
                  color: Colors.white,
                  size: 70,
                ),
              ),
              const Positioned(
                top: 42,
                left: 42,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const Positioned(
                top: 74,
                left: 144,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 9,
                ),
              ),
              const Positioned(
                top: 58,
                right: 165,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 11,
                ),
              ),
              const Positioned(
                top: 108,
                right: 95,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 8,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 16,
                child: Icon(
                  Icons.location_city,
                  color: Colors.white..withValues(alpha: 36),
                  size: 120,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 22,
                child: Icon(
                  Icons.apartment,
                  color: Colors.white..withValues(alpha: 36),
                  size: 100,
                ),
              ),
              Positioned(
                bottom: 30,
                left: 110,
                child: Icon(
                  Icons.business,
                  color: Colors.white..withValues(alpha: 31),
                  size: 92,
                ),
              ),
              Positioned(
                bottom: -16,
                right: 140,
                child: Icon(
                  Icons.domain,
                  color: Colors.white..withValues(alpha: 26),
                  size: 140,
                ),
              ),
              Positioned(
                top: 120,
                left: 90,
                child: Icon(
                  Icons.currency_exchange,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Positioned(
                top: 150,
                right: 110,
                child: Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Positioned(
                top: 110,
                left: 220,
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Positioned(
                top: -40,
                left: -35,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white..withValues(alpha: 26),
                  ),
                ),
              ),
              Positioned(
                bottom: -65,
                right: -50,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white..withValues(alpha: 20),
                  ),
                ),
              ),
              Positioned(
                top: 90,
                right: 190,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white..withValues(alpha: 64),
                  ),
                ),
              ),
              Positioned(
                top: 155,
                left: 185,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white..withValues(alpha: 64),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

