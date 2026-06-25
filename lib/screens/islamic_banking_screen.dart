import 'package:flutter/material.dart';

import '../data/banks_data.dart';
import '../models/bank_model.dart';
import '../screens/bank_detail_screen.dart';
import '../widgets/bank_list_tile.dart';
import '../widgets/section_header.dart';

class IslamicBankingScreen extends StatelessWidget {
  const IslamicBankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BankModel> banks = pakistanBanks.where((bank) => bank.islamicBanking.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Islamic Banking'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Shariah Compliant Banking',
              subtitle: 'Explore Islamic banking options that fit your values and financial goals.',
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey..withValues(alpha: 31),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Islamic banking provides products designed in compliance with Shariah principles.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Find accounts, financing, and digital services with ethical finance options.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: banks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final bank = banks[index];
                  return BankListTile(
                    bank: bank,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BankDetailScreen(bank: bank),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

