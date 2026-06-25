import 'package:flutter/material.dart';

import '../models/exchange_rate.dart';
import 'premium_info_card.dart';

class ExchangeRateCard extends StatelessWidget {
  final List<ExchangeRate> rates;

  const ExchangeRateCard({
    super.key,
    required this.rates,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumInfoCard(
      title: 'Exchange Rates',
      subtitle: 'Live FX updates ready for SBP API integration.',
      child: Column(
        children: rates.map((rate) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${rate.currency} (${rate.code})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Buy ${rate.buyRate.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Sell ${rate.sellRate.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  rate.change,
                  style: TextStyle(
                    color: rate.change.startsWith('+') ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
