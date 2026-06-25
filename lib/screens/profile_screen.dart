import 'package:flutter/material.dart';

import '../widgets/section_header.dart';
import '../widgets/pro_dashboard_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const SectionHeader(
            title: 'Your Profile',
            subtitle: 'Manage your account, notifications, and preferences.',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.indigo.shade50,
                  child: const Icon(
                    Icons.person,
                    color: Colors.indigo,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Saima Ahmed',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Premium banking customer',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ProDashboardCard(
            title: 'Account Settings',
            subtitle: 'Update your profile and security settings',
            icon: Icons.settings,
            color: const Color(0xFF3949AB),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Notifications',
            subtitle: 'Manage alerts and app notifications',
            icon: Icons.notifications,
            color: const Color(0xFF0D6EFD),
            onTap: () {},
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Security Center',
            subtitle: 'Protect your account with stronger security',
            icon: Icons.lock,
            color: const Color(0xFF7B2EFF),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

