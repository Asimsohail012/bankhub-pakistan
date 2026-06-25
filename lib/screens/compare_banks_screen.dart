import 'package:flutter/material.dart';

import '../data/banks_data.dart';
import '../models/bank_model.dart';
import '../widgets/bank_list_tile.dart';
import '../widgets/section_header.dart';

class CompareBanksScreen extends StatefulWidget {
  const CompareBanksScreen({super.key});

  @override
  State<CompareBanksScreen> createState() => _CompareBanksScreenState();
}

class _CompareBanksScreenState extends State<CompareBanksScreen> {
  final List<BankModel> _selectedBanks = [];

  void _toggleBank(BankModel bank) {
    setState(() {
      if (_selectedBanks.contains(bank)) {
        _selectedBanks.remove(bank);
      } else {
        if (_selectedBanks.length < 3) {
          _selectedBanks.add(bank);
        }
      }
    });
  }

  void _showComparison() {
    if (_selectedBanks.length < 2) return;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bank Comparison'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _selectedBanks.map<Widget>((bank) {
              return ListTile(
                title: Text(bank.name),
                subtitle: Text(bank.slogan),
                leading: const Icon(Icons.account_balance),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Banks'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Compare Banks',
              subtitle: 'Select up to 3 banks to review features side by side',
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
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
                children: [
                  Text(
                    'Selected banks',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedBanks.map<Widget>((bank) {
                      return Chip(
                        label: Text(bank.name),
                        backgroundColor: Colors.indigo.shade50,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: pakistanBanks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final bank = pakistanBanks[index];
                  final isSelected = _selectedBanks.contains(bank);

                  return Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.indigo.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? Colors.indigo : Colors.grey.shade200,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _toggleBank(bank),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: BankListTile(
                          bank: bank,
                          onTap: () => _toggleBank(bank),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedBanks.length >= 2 ? _showComparison : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Compare Selected'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

