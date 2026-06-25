import 'package:flutter/material.dart';

import '../screens/banks_screen.dart';
import '../screens/banking_news_screen.dart';
import '../screens/compare_banks_screen.dart';
import '../screens/islamic_banking_screen.dart';
import '../screens/feature_screen.dart';
import '../utils/app_colors.dart';
import '../widgets/pro_dashboard_card.dart';
import '../widgets/pro_header.dart';
import '../widgets/section_header.dart';
import '../widgets/exchange_rate_card.dart';
import '../widgets/gold_price_card.dart';
import '../widgets/banking_news_card.dart';
import '../widgets/financial_indicator_card.dart';
import '../data/exchange_rate_data.dart';
import '../data/gold_data.dart';
import '../data/news_data.dart';
import '../data/financial_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  void _openBanks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BanksScreen(),
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      ProDashboardCard(
        title: 'Banks Directory',
        subtitle: 'All Pakistani Banks',
        icon: Icons.account_balance,
        color: AppColors.blue,
        onTap: () => _openBanks(context),
      ),
      ProDashboardCard(
        title: 'Credit Cards',
        subtitle: 'Explore card options',
        icon: Icons.credit_card,
        color: AppColors.gold,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Credit Cards',
                subtitle: 'Discover premium credit card products.',
                icon: Icons.credit_card,
                color: AppColors.gold,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Roshan Digital Account',
        subtitle: 'Cross-border digital banking',
        icon: Icons.public,
        color: AppColors.cyan,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Roshan Digital Account',
                subtitle: 'Access digital banking from abroad.',
                icon: Icons.public,
                color: AppColors.cyan,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Islamic Banking',
        subtitle: 'Shariah compliant services',
        icon: Icons.mosque,
        color: AppColors.green,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const IslamicBankingScreen(),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Market Rates',
        subtitle: 'Currency and rate insights',
        icon: Icons.show_chart,
        color: AppColors.purple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Market Rates',
                subtitle: 'Track exchange and interest rates.',
                icon: Icons.show_chart,
                color: AppColors.purple,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Banking Tools',
        subtitle: 'Financial calculators and simulators',
        icon: Icons.calculate,
        color: AppColors.indigo,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Banking Tools',
                subtitle: 'Use calculators and comparison tools.',
                icon: Icons.calculate,
                color: AppColors.indigo,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Banking Careers',
        subtitle: 'Explore opportunities',
        icon: Icons.work,
        color: AppColors.darkBlue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Banking Careers',
                subtitle: 'Find career opportunities across financial services.',
                icon: Icons.work,
                color: AppColors.darkBlue,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Banking News',
        subtitle: 'Latest industry updates',
        icon: Icons.newspaper,
        color: AppColors.gold,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BankingNewsScreen(),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Compare Banks',
        subtitle: 'Choose the best fit',
        icon: Icons.compare_arrows,
        color: AppColors.purple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CompareBanksScreen(),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Bankers Community',
        subtitle: 'Connect with bankers',
        icon: Icons.group,
        color: AppColors.orange,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Bankers Community',
                subtitle: 'Join the community of banking professionals.',
                icon: Icons.group,
                color: AppColors.orange,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'Settings',
        subtitle: 'Manage app preferences',
        icon: Icons.settings,
        color: AppColors.brown,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'Settings',
                subtitle: 'Configure your banking experience.',
                icon: Icons.settings,
                color: AppColors.brown,
              ),
            ),
          );
        },
      ),
      ProDashboardCard(
        title: 'About App',
        subtitle: 'Discover BankHub Pakistan',
        icon: Icons.info,
        color: AppColors.cyan,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeatureScreen(
                title: 'About App',
                subtitle: 'Discover the premium banking platform.',
                icon: Icons.info,
                color: AppColors.cyan,
              ),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6FA),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF0F172A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF2563EB),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'BankHub Pakistan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Pakistan's Smart Banking Platform",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerTile(
                context,
                icon: Icons.home_filled,
                title: 'Home',
                subtitle: 'Premium overview',
                onTap: () => Navigator.pop(context),
              ),
              _buildDrawerTile(
                context,
                icon: Icons.account_balance,
                title: 'Banks Directory',
                subtitle: 'Explore banks',
                onTap: () => _navigateTo(const BanksScreen()),
              ),
              _buildDrawerTile(
                context,
                icon: Icons.compare_arrows,
                title: 'Compare',
                subtitle: 'Find the best fit',
                onTap: () => _navigateTo(const CompareBanksScreen()),
              ),
              _buildDrawerTile(
                context,
                icon: Icons.newspaper,
                title: 'News',
                subtitle: 'Latest banking updates',
                onTap: () => _navigateTo(const BankingNewsScreen()),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProHeader(onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black..withValues(alpha: 15),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search services, cards, news...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.tune),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF6F8FF),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'All premium tools in one place.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth < 760 ? 2 : 3;
                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.96,
                        children: cards,
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  const SectionHeader(
                    title: 'Live Financial Center',
                    subtitle: 'Real-time market snapshots for smarter financial decisions.',
                  ),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth < 760 ? 1 : 2;
                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: constraints.maxWidth < 760 ? 1.02 : 1.15,
                        children: const [
                          ExchangeRateCard(rates: liveExchangeRates),
                          GoldPriceCard(metals: preciousMetals),
                          BankingNewsCard(articles: liveNewsArticles),
                          FinancialIndicatorCard(indicators: financialIndicators),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
      onTap: onTap,
    );
  }
}

