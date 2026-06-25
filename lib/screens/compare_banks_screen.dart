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

  DataRow _buildRow(String label, Iterable<String> values) {
    return DataRow(
      cells: [
        DataCell(Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
        ...values.map((value) => DataCell(Text(value))),
      ],
    );
  }

  Widget _comparisonContent() {
    if (_selectedBanks.length < 2) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select two or three banks to compare their services side by side.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    final columns = [
      const DataColumn(label: Text('Feature')),
      ..._selectedBanks.map((bank) => DataColumn(label: Text(bank.name))),
    ];

    final rows = [
      _buildRow(
        'Category',
        _selectedBanks.map((bank) => bank.category),
      ),
      _buildRow(
        'Headquarters',
        _selectedBanks.map((bank) => bank.headquarters).toList(),
      ),
      _buildRow(
        'SWIFT Code',
        _selectedBanks.map((bank) => bank.swiftCode).toList(),
      ),
      _buildRow(
        'Branches',
        _selectedBanks.map((bank) => bank.branchCount > 0 ? '${bank.branchCount}' : 'N/A').toList(),
      ),
      _buildRow(
        'ATMs',
        _selectedBanks.map((bank) => bank.atmCount > 0 ? '${bank.atmCount}' : 'N/A').toList(),
      ),
      _buildRow(
        'Islamic Banking',
        _selectedBanks.map((bank) => bank.islamicBanking.isNotEmpty ? 'Yes' : 'No').toList(),
      ),
      _buildRow(
        'Roshan Digital',
        _selectedBanks.map((bank) => bank.roshanDigitalAccount ? 'Available' : 'No').toList(),
      ),
      _buildRow(
        'Mobile App',
        _selectedBanks.map((bank) => bank.mobileApp).toList(),
      ),
      _buildRow(
        'Rating',
        _selectedBanks.map((bank) => bank.rating.toStringAsFixed(1)).toList(),
      ),
      _buildRow(
        'Top Products',
        _selectedBanks.map(
          (bank) => bank.productSections.keys.take(4).join(', '),
        ),
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns,
        rows: rows,
        headingRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return Colors.indigo.shade50;
        }),
        dataRowMinHeight: 56,
        dataRowMaxHeight: 72,
      ),
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
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey..withValues(alpha: 24),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: _comparisonContent(),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Tap banks below to add or remove them from the comparison list.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 280,
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
          ],
        ),
      ),
    );
  }
}

