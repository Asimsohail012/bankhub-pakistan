import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/section_header.dart';

class FinancialCalculatorsDashboardScreen extends StatefulWidget {
  const FinancialCalculatorsDashboardScreen({super.key});

  @override
  State<FinancialCalculatorsDashboardScreen> createState() => _FinancialCalculatorsDashboardScreenState();
}

class _FinancialCalculatorsDashboardScreenState extends State<FinancialCalculatorsDashboardScreen> {
  final List<_CalculatorItem> calculators = [
    _CalculatorItem(
      id: 'savings',
      title: 'Savings Calculator',
      description: 'Plan your savings goals with interest calculations',
      icon: Icons.savings,
      color: Colors.blue,
      isFavorite: false,
    ),
    _CalculatorItem(
      id: 'deposit',
      title: 'Deposit Calculator',
      description: 'Calculate profit on fixed deposits',
      icon: Icons.account_balance,
      color: Colors.green,
      isFavorite: false,
    ),
    _CalculatorItem(
      id: 'loan',
      title: 'Loan EMI Calculator',
      description: 'Calculate monthly loan payments and total cost',
      icon: Icons.money,
      color: Colors.orange,
      isFavorite: false,
    ),
    _CalculatorItem(
      id: 'zakat',
      title: 'Zakat Calculator',
      description: 'Calculate annual zakat obligation as per Islamic principles',
      icon: Icons.mosque,
      color: AppColors.gold,
      isFavorite: false,
    ),
  ];

  void _toggleFavorite(int index) {
    setState(() {
      calculators[index] = calculators[index].copyWith(
        isFavorite: !calculators[index].isFavorite,
      );
    });
  }

  void _openCalculator(String id) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Calculator Feature'),
        content: const Text('Detailed calculator screens are coming soon. This feature will provide comprehensive calculations for your financial planning.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCount = calculators.where((c) => c.isFavorite).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Calculators'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          SectionHeader(
            title: 'Financial Calculators',
            subtitle: 'Smart tools to plan your finances and investments',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$favoriteCount favorites',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...calculators.asMap().entries.map((entry) {
            final idx = entry.key;
            final calc = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _CalculatorCard(
                calculator: calc,
                onTap: () => _openCalculator(calc.id),
                onFavoriteTap: () => _toggleFavorite(idx),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CalculatorCard extends StatelessWidget {
  final _CalculatorItem calculator;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const _CalculatorCard({
    required this.calculator,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: calculator.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  calculator.icon,
                  color: calculator.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      calculator.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      calculator.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onFavoriteTap,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      calculator.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: calculator.isFavorite ? Colors.red : Colors.grey.shade400,
                      size: 20,
                    ),
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

class _CalculatorItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isFavorite;

  _CalculatorItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isFavorite,
  });

  _CalculatorItem copyWith({bool? isFavorite}) {
    return _CalculatorItem(
      id: id,
      title: title,
      description: description,
      icon: icon,
      color: color,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
