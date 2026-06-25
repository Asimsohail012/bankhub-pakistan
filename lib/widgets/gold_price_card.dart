import 'package:flutter/material.dart';

import '../models/gold_price.dart';
import 'premium_info_card.dart';

class GoldPriceCard extends StatelessWidget {
  final List<GoldPrice> metals;

  const GoldPriceCard({
    super.key,
    required this.metals,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumInfoCard(
      title: 'Gold & Silver',
      subtitle: 'Precious metals pricing ready for live market feeds.',
      child: Column(
        children: metals.map((metal) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  metal.karat == '-' ? metal.metal : '${metal.metal} (${metal.karat})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      metal.pricePer10g,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      metal.change,
                      style: TextStyle(
                        color: metal.change.startsWith('+') ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
