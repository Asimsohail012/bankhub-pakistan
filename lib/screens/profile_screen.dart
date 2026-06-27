import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/section_header.dart';
import '../widgets/pro_dashboard_card.dart';
import 'profile_edit_screen.dart';
import 'settings_screen.dart';
import 'notification_center_screen.dart';
import '../widgets/premium_unlock_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          showPremiumUnlockSheet(context);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(
            title: 'Premium Profile',
            subtitle: 'Manage your account, notifications, and preferences.',
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F1729), Color(0xFF2563EB)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    user == null ? Icons.person_outline_rounded : Icons.verified_user_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user == null ? 'Guest Mode' : 'Premium banking customer',
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _StatsCard(title: 'Favorites', value: '0'),
              _StatsCard(title: 'Sync', value: 'Guest'),
              _StatsCard(title: 'Alerts', value: '0'),
            ],
          ),
          const SizedBox(height: 20),
          ProDashboardCard(
            title: 'Account Settings',
            subtitle: 'Update your profile and security settings',
            icon: Icons.settings,
            color: const Color(0xFF3949AB),
            onTap: () {
              if (user == null) {
                showPremiumUnlockSheet(context);
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileEditScreen(user: user),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Notifications',
            subtitle: 'View and manage alerts',
            icon: Icons.notifications,
            color: const Color(0xFF0D6EFD),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationCenterScreen()),
              );
            },
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Settings',
            subtitle: 'Preferences and app configuration',
            icon: Icons.settings,
            color: const Color(0xFF6B7280),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(height: 14),
          ProDashboardCard(
            title: 'Security Center',
            subtitle: 'Protect your account with stronger security',
            icon: Icons.lock,
            color: const Color(0xFF7B2EFF),
            onTap: () => showPremiumUnlockSheet(context),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatsCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }
}

