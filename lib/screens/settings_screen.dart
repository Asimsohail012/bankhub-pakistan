import 'package:flutter/material.dart';
import '../services/user_preferences_service.dart';
import '../utils/app_colors.dart';
import '../widgets/section_header.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'contact_us_screen.dart';
import 'disclaimer_screen.dart';
import 'version_info_screen.dart';
import 'open_source_licenses_screen.dart';
import 'user_support_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final prefsService = userPreferencesService;
    final prefs = prefsService.preferences;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          const SectionHeader(
            title: 'Preferences',
            subtitle: 'Customize your app experience',
          ),
          const SizedBox(height: 20),
          // AI Assistant Setting
          _SettingCard(
            icon: Icons.smart_toy_rounded,
            color: AppColors.secondary,
            title: 'AI Assistant Mode',
            subtitle: 'Choose how AI appears in the app',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                prefs.floatingAIAssistant ? 'Floating' : 'Fixed',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ),
            onTap: () => _showAIAssistantOptions(context),
          ),
          const SizedBox(height: 12),
          // Animations Setting
          _SettingToggleCard(
            icon: Icons.animation,
            color: Colors.purple,
            title: 'Animations',
            subtitle: 'Enable smooth transitions and animations',
            value: prefs.animationsEnabled,
            onChanged: (value) {
              userPreferencesService.setAnimationsEnabled(value);
              setState(() {});
            },
          ),
          const SizedBox(height: 12),
          // Dark Mode Setting
          _SettingToggleCard(
            icon: Icons.dark_mode_rounded,
            color: Colors.indigo,
            title: 'Dark Mode',
            subtitle: 'Coming soon in next update',
            value: prefs.darkMode,
            onChanged: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dark mode coming soon!')),
              );
            },
            enabled: false,
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Cache & Storage',
            subtitle: 'Manage app data and performance',
          ),
          const SizedBox(height: 20),
          // Cache Info
          _SettingCard(
            icon: Icons.storage,
            color: Colors.cyan,
            title: 'Cache Size',
            subtitle: 'Clear cached data to free up space',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.cyan.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '~2.4 MB',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan,
                ),
              ),
            ),
            onTap: () => _showClearCacheDialog(context),
          ),
          const SizedBox(height: 12),
          // Recently Searched
          _SettingCard(
            icon: Icons.history,
            color: AppColors.orange,
            title: 'Clear Search History',
            subtitle: '${prefs.recentlySearchedCount} recent searches',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                prefs.recentlySearchedCount.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ),
            ),
            onTap: () => _showClearHistoryDialog(context),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'About',
            subtitle: 'App information and links',
          ),
          const SizedBox(height: 20),
          // About BankHub Pakistan
          _SettingCard(
            icon: Icons.info_outline_rounded,
            color: Colors.blue,
            title: 'About BankHub',
            subtitle: 'Learn about our mission and features',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
          const SizedBox(height: 12),
          // Version Info
          _SettingCard(
            icon: Icons.code_outlined,
            color: Colors.purple,
            title: 'Version Info',
            subtitle: 'Build information and release notes',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VersionInfoScreen())),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Policies & Legal',
            subtitle: 'Important legal information',
          ),
          const SizedBox(height: 20),
          // Privacy Policy
          _SettingCard(
            icon: Icons.privacy_tip_outlined,
            color: Colors.red,
            title: 'Privacy Policy',
            subtitle: 'How we protect your data',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),
          ),
          const SizedBox(height: 12),
          // Terms & Conditions
          _SettingCard(
            icon: Icons.description_outlined,
            color: Colors.orange,
            title: 'Terms & Conditions',
            subtitle: 'App usage terms',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsConditionsScreen())),
          ),
          const SizedBox(height: 12),
          // Disclaimer
          _SettingCard(
            icon: Icons.warning_outlined,
            color: Colors.amber,
            title: 'Disclaimer',
            subtitle: 'Important legal disclaimer',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DisclaimerScreen())),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Support & Feedback',
            subtitle: 'Help us improve',
          ),
          const SizedBox(height: 20),
          // Support & Feedback
          _SettingCard(
            icon: Icons.help_outline_rounded,
            color: Colors.teal,
            title: 'Support & Feedback',
            subtitle: 'Report issues, send feedback, request features',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserSupportScreen())),
          ),
          const SizedBox(height: 12),
          // Contact Us
          _SettingCard(
            icon: Icons.email_outlined,
            color: Colors.green,
            title: 'Contact Us',
            subtitle: 'Get in touch with our team',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsScreen())),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Open Source',
            subtitle: 'Powered by amazing libraries',
          ),
          const SizedBox(height: 20),
          // Open Source Licenses
          _SettingCard(
            icon: Icons.favorite_outline_rounded,
            color: Colors.pink,
            title: 'Open Source Licenses',
            subtitle: 'Third-party libraries and licenses',
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OpenSourceLicensesScreen())),
          ),
        ],
      ),
    );
  }

  void _showAIAssistantOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'AI Assistant Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            _AIAssistantOption(
              title: 'Floating',
              description: 'Widget appears as floating button',
              isSelected: userPreferencesService.preferences.floatingAIAssistant,
              onTap: () {
                userPreferencesService.setFloatingAIAssistant(true);
                Navigator.pop(context);
                setState(() {});
              },
            ),
            const SizedBox(height: 12),
            _AIAssistantOption(
              title: 'Fixed',
              description: 'Always visible in navigation',
              isSelected: !userPreferencesService.preferences.floatingAIAssistant,
              onTap: () {
                userPreferencesService.setFloatingAIAssistant(false);
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache?'),
        content: const Text('This will clear all cached data. You can download it again when needed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Search History?'),
        content: const Text('Your recent searches will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              userPreferencesService.clearRecentlySearched();
              Navigator.pop(context);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Search history cleared')),
                );
                setState(() {});
              }
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _SettingCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  const _SettingCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingToggleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  const _SettingToggleCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeThumbColor: color,
          ),
        ],
      ),
    );
  }
}

class _AIAssistantOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _AIAssistantOption({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.secondary : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected ? AppColors.secondary : Colors.grey.shade400,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
