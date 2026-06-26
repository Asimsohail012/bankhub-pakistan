import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';
import 'app_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      title: 'Welcome to BankHub Pakistan',
      description: 'Your one-stop platform for banking information, financial tools and banking services across Pakistan.',
      chips: ['Pakistan', 'Banks', 'Mobile Banking'],
      icon: Icons.account_balance_rounded,
      illustration: Icons.location_city_rounded,
    ),
    _OnboardingPageData(
      title: 'Powerful Features',
      description: 'Explore premium banking cards, live exchange data, market insights, news, and AI-powered guidance.',
      chips: ['Bank Directory', 'Exchange Rates', 'Gold Prices', 'Banking News', 'AI Assistant', 'Credit Cards', 'Banking Careers'],
      icon: Icons.auto_awesome_rounded,
      illustration: Icons.grid_view_rounded,
    ),
    _OnboardingPageData(
      title: 'Built for Everyone',
      description: 'Designed for bankers, students, job seekers, families and businesses who want a smarter banking experience.',
      chips: ['Bankers', 'Students', 'Job Seekers', 'Families', 'Businesses'],
      icon: Icons.groups_rounded,
      illustration: Icons.verified_rounded,
    ),
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bankhub_seen_onboarding', true);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const AppShell()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _pageIndex == _pages.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF8FAFC), Color(0xFFEAF2FF), Color(0xFFFDF9EF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  children: [
                    TextButton(onPressed: _finishOnboarding, child: const Text('Skip')),
                    const Spacer(),
                    Text(
                      'BankHub Pakistan',
                      style: TextStyle(color: AppColors.primary.withValues(alpha: 0.8), fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _pageIndex = index),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: _OnboardingCard(page: page, index: index),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (index) {
                        final selected = _pageIndex == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: selected ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.secondary : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: _finishOnboarding, child: const Text('Get Started'))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (isLastPage) {
                                _finishOnboarding();
                                return;
                              }
                              _pageController.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOut);
                            },
                            child: Text(isLastPage ? 'Get Started' : 'Next'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  final _OnboardingPageData page;
  final int index;

  const _OnboardingCard({required this.page, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 28, offset: const Offset(0, 16)),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: index == 0
                            ? [const Color(0xFF0F1729), const Color(0xFF2563EB)]
                            : index == 1
                                ? [const Color(0xFF2563EB), AppColors.gold]
                                : [const Color(0xFF0F1729), const Color(0xFF0EA5E9)],
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(page.illustration, size: 74, color: AppColors.primary),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: Icon(page.icon, color: AppColors.secondary, size: 26),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(page.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.15)),
          const SizedBox(height: 14),
          Text(page.description, style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.6)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: page.chips
                .map(
                  (chip) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(chip, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String description;
  final List<String> chips;
  final IconData icon;
  final IconData illustration;

  const _OnboardingPageData({required this.title, required this.description, required this.chips, required this.icon, required this.illustration});
}