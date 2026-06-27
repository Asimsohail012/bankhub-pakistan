import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About BankHub Pakistan'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          // App Logo & Name
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'BankHub Pakistan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Description
          Text(
            'About This App',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'BankHub Pakistan is your comprehensive guide to Pakistani banking. '
            'Discover services from all major banks, compare offerings, stay updated with '
            'banking news, and access advanced financial tools - all in one place.\n\n'
            'Our mission is to empower Pakistanis with transparent, accurate, and '
            'up-to-date banking information.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Features
          Text(
            'Features',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _FeatureItem(
            icon: Icons.account_balance,
            title: 'Bank Directory',
            description: 'Browse all Pakistani banks with detailed information',
          ),
          _FeatureItem(
            icon: Icons.compare,
            title: 'Bank Comparison',
            description: 'Compare multiple banks side by side',
          ),
          _FeatureItem(
            icon: Icons.trending_up,
            title: 'Live Market Data',
            description: 'Real-time exchange rates, gold prices, and KIBOR',
          ),
          _FeatureItem(
            icon: Icons.newspaper,
            title: 'Banking News',
            description: 'Latest news and circulars from SBP',
          ),
          _FeatureItem(
            icon: Icons.calculate,
            title: 'Financial Calculators',
            description: 'Calculate EMI, interest, and investments',
          ),
          _FeatureItem(
            icon: Icons.smart_toy,
            title: 'AI Assistant',
            description: 'Get personalized banking recommendations',
          ),
          const SizedBox(height: 24),
          
          // Data Sources
          Text(
            'Data Sources',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'All data is sourced from official Pakistani banking institutions and '
            'the State Bank of Pakistan (SBP). We ensure accuracy and compliance '
            'with SBP guidelines.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          
          // Team
          Text(
            'Our Team',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'BankHub Pakistan is developed with ❤️ by a dedicated team '
            'committed to improving financial accessibility in Pakistan.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
