import 'package:flutter/material.dart';

import '../models/financial_indicator.dart';
import 'premium_info_card.dart';

class FinancialIndicatorCard extends StatelessWidget {
  final List<FinancialIndicator> indicators;

  const FinancialIndicatorCard({
    super.key,
    required this.indicators,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumInfoCard(
      title: 'Financial Market',
      subtitle: 'Key indicators for policy and market risk.',
      child: Column(
        children: indicators.map((indicator) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  indicator.label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      indicator.value,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      indicator.trend,
                      style: TextStyle(
                        color: indicator.trend.startsWith('+') ? Colors.green : Colors.red,
                        fontSize: 12,
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
