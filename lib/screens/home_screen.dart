import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/banks_data.dart';
import '../data/news_data.dart';
import '../models/bank_model.dart';
import '../models/news_item.dart';
import '../providers/dashboard_data_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/premium_unlock_sheet.dart';
import '../widgets/section_header.dart';
import 'ai_assistant_screen.dart';
import 'banks_screen.dart';
import 'compare_banks_screen.dart';
import 'feature_screen.dart';
import 'premium_analytics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late final DashboardDataProvider _dashboardProvider;
  late Future<DashboardData> _dashboardDataFuture;

  @override
  void initState() {
    super.initState();
    _dashboardProvider = DashboardDataProvider();
    _dashboardDataFuture = _dashboardProvider.loadDashboardData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshDashboard() async {
    setState(() {
      _dashboardDataFuture = _dashboardProvider.refreshAll();
    });
  }

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  Future<void> _showPremium() async {
    await showPremiumUnlockSheet(context);
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _PremiumDrawer(onPremiumTap: _showPremium),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshDashboard,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
            children: [
              Row(
                children: [
                  _RoundIconButton(icon: Icons.menu_rounded, onTap: () => _scaffoldKey.currentState?.openDrawer()),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BankHub Pakistan', style: TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.w800)),
                        Text("Pakistan's Smart Banking Platform", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      ],
                    ),
                  ),
                  _RoundIconButton(icon: Icons.notifications_none_rounded, onTap: _showPremium),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search banks, IBAN, cards, branches...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none_rounded)),
                      if (_searchController.text.isNotEmpty)
                        IconButton(onPressed: () => setState(() => _searchController.clear()), icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.premiumGradient,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [BoxShadow(color: AppColors.secondary.withValues(alpha: 0.2), blurRadius: 24, offset: const Offset(0, 14))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_greeting(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          const Text('Good banking decisions start here.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 10),
                          Text(dateLabel, style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(22)),
                      child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 44),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: "Today's Financial Snapshot", subtitle: 'Live market highlights for quick decision making.'),
              const SizedBox(height: 12),
              FutureBuilder<DashboardData>(
                future: _dashboardDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildDashboardSkeleton();
                  }

                  if (snapshot.hasError) {
                    return _buildDashboardError(snapshot.error.toString());
                  }

                  final dashboardData = snapshot.data;
                  if (dashboardData == null) {
                    return _buildDashboardError('No data available');
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: crossAxisCount == 4 ? 1.2 : 1.0,
                        children: [
                          _SnapshotCardLiveData(
                            title: 'USD',
                            data: dashboardData.exchangeRates,
                            valueExtractor: (data) {
                              final usd = (data as List).firstWhere((x) => x.currency == 'USD/PKR', orElse: () => data.first);
                              return usd.rate.toStringAsFixed(2);
                            },
                            trendExtractor: (data) {
                              final usd = (data as List).firstWhere((x) => x.currency == 'USD/PKR', orElse: () => data.first);
                              return '${usd.change > 0 ? '+' : ''}${usd.change.toStringAsFixed(2)}';
                            },
                            icon: Icons.attach_money_rounded,
                            colors: const [Color(0xFF2563EB), Color(0xFF60A5FA)],
                          ),
                          _SnapshotCardLiveData(
                            title: 'Gold (10g)',
                            data: dashboardData.goldPrice,
                            valueExtractor: (data) => 'PKR ${data.pricePerTola.toStringAsFixed(0)}',
                            trendExtractor: (data) => '${data.dailyChange > 0 ? '+' : ''}${data.dailyChange.toStringAsFixed(0)} today',
                            icon: Icons.workspace_premium_rounded,
                            colors: const [Color(0xFFB45309), Color(0xFFF59E0B)],
                          ),
                          _SnapshotCardLiveData(
                            title: 'KIBOR (1M)',
                            data: dashboardData.kiborRates,
                            valueExtractor: (data) {
                              final oneMonth = (data as List).firstWhere((x) => x.tenor == '1M', orElse: () => data.first);
                              return '${oneMonth.rate.toStringAsFixed(2)}%';
                            },
                            trendExtractor: (data) {
                              final oneMonth = (data as List).firstWhere((x) => x.tenor == '1M', orElse: () => data.first);
                              return '${oneMonth.change > 0 ? '+' : ''}${oneMonth.change.toStringAsFixed(2)}%';
                            },
                            icon: Icons.trending_up_rounded,
                            colors: const [Color(0xFF0F766E), Color(0xFF14B8A6)],
                          ),
                          _SnapshotCardLiveData(
                            title: 'Latest News',
                            data: dashboardData.news,
                            valueExtractor: (data) => 'Read',
                            trendExtractor: (data) => '${(data as List).length} articles',
                            icon: Icons.newspaper_rounded,
                            colors: const [Color(0xFF4F46E5), Color(0xFF8B5CF6)],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: 'Quick Actions', subtitle: 'Access core banking tools with one tap.'),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
                  final actions = [
                    _ActionData('Banks', Icons.account_balance_rounded, AppColors.blue, () => _open(const BanksScreen())),
                    _ActionData('Compare', Icons.compare_arrows_rounded, AppColors.purple, () => _open(const CompareBanksScreen())),
                    _ActionData('Exchange', Icons.currency_exchange_rounded, AppColors.cyan, () => _open(const FeatureScreen(title: 'Exchange Rates', subtitle: 'Track live foreign exchange insights across Pakistan.', icon: Icons.currency_exchange, color: AppColors.blue))),
                    _ActionData('Gold', Icons.workspace_premium_rounded, AppColors.gold, () => _open(const FeatureScreen(title: 'Gold Prices', subtitle: 'View precious metal price trends and market context.', icon: Icons.workspace_premium, color: AppColors.gold))),
                    _ActionData('Credit Cards', Icons.credit_card_rounded, AppColors.green, () => _open(const FeatureScreen(title: 'Credit Cards', subtitle: 'Explore premium and cashback card options.', icon: Icons.credit_card, color: AppColors.purple))),
                    _ActionData('Careers', Icons.work_outline_rounded, AppColors.darkBlue, () => _open(const FeatureScreen(title: 'Banking Careers', subtitle: 'Find opportunities across the financial sector.', icon: Icons.work_outline, color: AppColors.darkBlue))),
                    _ActionData('Branch Locator', Icons.location_on_outlined, AppColors.orange, () => _open(const FeatureScreen(title: 'Branch Locator', subtitle: 'Locate branches and ATMs nearby.', icon: Icons.location_on_outlined, color: AppColors.green))),
                    _ActionData('Banking Tools', Icons.calculate_rounded, AppColors.indigo, () => _open(const FeatureScreen(title: 'Banking Tools', subtitle: 'Use calculators and planning tools for everyday finance.', icon: Icons.calculate_outlined, color: AppColors.cyan))),
                  ];

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: actions.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.06,
                    ),
                    itemBuilder: (context, index) => _QuickActionCard(action: actions[index]),
                  );
                },
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: 'Featured Banks', subtitle: "A curated look at Pakistan's leading banks."),
              const SizedBox(height: 12),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: pakistanBanks.take(6).length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _BankCard(bank: pakistanBanks[index], onTap: () => _open(const BanksScreen())),
                ),
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: 'Trending Banking News', subtitle: 'Recent updates from across the sector.'),
              const SizedBox(height: 12),
              ...bankingNews.take(3).map((news) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _NewsCard(news: news))),
              const SizedBox(height: 8),
              const SectionHeader(title: 'Banking Tools Preview', subtitle: 'Popular utilities for planning and calculations.'),
              const SizedBox(height: 12),
              SizedBox(
                height: 124,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _ToolChip(label: 'Loan Calculator', icon: Icons.calculate_rounded),
                    _ToolChip(label: 'IBAN Generator', icon: Icons.qr_code_rounded),
                    _ToolChip(label: 'Profit Calculator', icon: Icons.payments_outlined),
                    _ToolChip(label: 'ATM Finder', icon: Icons.atm_rounded),
                    _ToolChip(label: 'Branch Locator', icon: Icons.location_on_outlined),
                    _ToolChip(label: 'Zakat Calculator', icon: Icons.account_balance_wallet_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SectionHeader(title: 'Ask BankHub AI', subtitle: 'Fast answers for banking research and comparisons.'),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => _open(const AIAssistantScreen()),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0F1729), Color(0xFF1E3A8A), Color(0xFF2563EB)]),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.smart_toy_rounded, color: Colors.white, size: 36),
                      SizedBox(width: 12),
                      Expanded(child: Text('Open BankHub AI Assistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16))),
                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  TextButton(onPressed: _showPremium, child: const Text('Privacy')),
                  TextButton(onPressed: _showPremium, child: const Text('About')),
                  TextButton(onPressed: _showPremium, child: const Text('Terms')),
                  TextButton(onPressed: () => _open(const PremiumAnalyticsScreen()), child: const Text('Premium Analytics')),
                ],
              ),
              Center(child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey.shade600, fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardSkeleton() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 4 ? 1.2 : 1.0,
          children: List.generate(
            4,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey.shade200,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboardError(String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red.shade700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Dashboard Loading Error',
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load dashboard data. Using placeholder values.',
            style: TextStyle(color: Colors.red.shade700, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: IconButton(onPressed: onTap, icon: Icon(icon, color: AppColors.primary)),
    );
  }
}

class _SnapshotCardLiveData extends StatelessWidget {
  final String title;
  final dynamic data;
  final String Function(dynamic) valueExtractor;
  final String Function(dynamic) trendExtractor;
  final IconData icon;
  final List<Color> colors;

  const _SnapshotCardLiveData({
    required this.title,
    required this.data,
    required this.valueExtractor,
    required this.trendExtractor,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final hasData = data.data != null;
    final isCached = data.isCached;

    String value = 'N/A';
    String trend = 'No data';
    String source = data.source;

    if (hasData) {
      try {
        value = valueExtractor(data.data);
        trend = trendExtractor(data.data);
      } catch (_) {}
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
        boxShadow: [BoxShadow(color: colors.first.withValues(alpha: 0.24), blurRadius: 16, offset: const Offset(0, 10))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const Spacer(),
                if (isCached)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Cached', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            const Spacer(),
            Text(title, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 11)),
            const SizedBox(height: 4),
            Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(trend, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 10)),
            const SizedBox(height: 6),
            Text(source, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white60, fontSize: 8)),
          ],
        ),
      ),
    );
  }
}

class _ActionData {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _ActionData(this.title, this.icon, this.color, this.onTap);
}

class _QuickActionCard extends StatelessWidget {
  final _ActionData action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: action.onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(colors: [action.color.withValues(alpha: 0.95), action.color]),
            boxShadow: [BoxShadow(color: action.color.withValues(alpha: 0.2), blurRadius: 14, offset: const Offset(0, 8))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                child: Icon(action.icon, color: Colors.white),
              ),
              const Spacer(),
              Text(action.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BankCard extends StatelessWidget {
  final BankModel bank;
  final VoidCallback onTap;

  const _BankCard({required this.bank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(gradient: AppColors.premiumGradient, borderRadius: BorderRadius.circular(16)),
            child: Center(child: Text(bank.name.characters.take(2).toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
          ),
          const SizedBox(height: 12),
          Text(bank.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 6),
          Text(bank.category, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(bank.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: onTap, child: const Text('View Details')),
            ],
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsItem news;

  const _NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 14, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: AppColors.premiumGradient),
            child: const Center(child: Icon(Icons.image_rounded, color: Colors.white, size: 30)),
          ),
          const SizedBox(height: 10),
          Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(news.summary, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(news.date, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Read More')),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ToolChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 14, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(gradient: AppColors.premiumGradient, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white),
          ),
          const Spacer(),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _PremiumDrawer extends StatelessWidget {
  final VoidCallback onPremiumTap;

  const _PremiumDrawer({required this.onPremiumTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(32))),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF07172C), Color(0xFF0F1729)]),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(24)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.person, color: AppColors.primary)),
                  SizedBox(height: 16),
                  Text('Guest User', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('BankHub Pakistan', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _DrawerItem(icon: Icons.home_rounded, title: 'Home', onTap: _noop),
            _DrawerItem(icon: Icons.account_balance_rounded, title: 'Banks Directory', onTap: _noop),
            _DrawerItem(icon: Icons.compare_arrows_rounded, title: 'Compare Banks', onTap: _noop),
            _DrawerItem(icon: Icons.newspaper_rounded, title: 'Banking News', onTap: _noop),
            _DrawerItem(icon: Icons.person_rounded, title: 'Profile', onTap: onPremiumTap),
          ],
        ),
      ),
    );
  }

  static void _noop() {}
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}
