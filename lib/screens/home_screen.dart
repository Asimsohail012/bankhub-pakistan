import 'package:flutter/material.dart';

import '../screens/banks_screen.dart';
import '../screens/coming_soon_screen.dart';

import '../widgets/pro_header.dart';
import '../widgets/pro_dashboard_card.dart';

import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: Column(
        children: [
          const ProHeader(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: GridView.count(
                crossAxisCount: 3,

                crossAxisSpacing: 14,
                mainAxisSpacing: 14,

                childAspectRatio: 1.35,

                children: [
                  ProDashboardCard(
                    title: "Banks Directory",
                    subtitle: "All Pakistani Banks",
                    icon: Icons.account_balance,
                    color: AppColors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BanksScreen(),
                        ),
                      );
                    },
                  ),

                  ProDashboardCard(
                    title: "Credit Cards",
                    subtitle: "Compare & Apply",
                    icon: Icons.credit_card,
                    color: AppColors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ComingSoonScreen(
                            title: "Credit Cards",
                          ),
                        ),
                      );
                    },
                  ),

                  ProDashboardCard(
                    title: "Roshan Digital Accounts",
                    subtitle: "Overseas Pakistanis",
                    icon: Icons.public,
                    color: AppColors.purple,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Islamic Banking",
                    subtitle: "Shariah Compliant",
                    icon: Icons.mosque,
                    color: AppColors.green,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Market Rates",
                    subtitle: "Currency & Rates",
                    icon: Icons.trending_up,
                    color: AppColors.red,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Banking Tools",
                    subtitle: "Calculators & Tools",
                    icon: Icons.calculate,
                    color: AppColors.cyan,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Banking Careers",
                    subtitle: "Jobs in Banking",
                    icon: Icons.work,
                    color: AppColors.indigo,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Banking News",
                    subtitle: "Latest Updates",
                    icon: Icons.newspaper,
                    color: AppColors.gold,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Compare Banks",
                    subtitle: "Compare & Decide",
                    icon: Icons.balance,
                    color: AppColors.purple,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Bankers Community",
                    subtitle: "Connect & Network",
                    icon: Icons.groups,
                    color: AppColors.cyan,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "Settings",
                    subtitle: "Application Settings",
                    icon: Icons.settings,
                    color: AppColors.darkBlue,
                    onTap: () {},
                  ),

                  ProDashboardCard(
                    title: "About BankHub Pakistan",
                    subtitle: "About The Platform",
                    icon: Icons.info,
                    color: AppColors.brown,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}