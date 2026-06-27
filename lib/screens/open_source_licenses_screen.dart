import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class OpenSourceLicensesScreen extends StatelessWidget {
  const OpenSourceLicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Source Licenses'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          Text(
            'Open Source Libraries',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'BankHub Pakistan is built on top of amazing open-source packages. We gratefully acknowledge the following libraries:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          _LicenseCard(
            name: 'Flutter',
            license: 'BSD 3-Clause License',
            description: 'Open-source mobile application development framework',
            url: 'https://flutter.dev',
          ),
          _LicenseCard(
            name: 'Firebase Core',
            license: 'Apache License 2.0',
            description: 'Firebase backend integration for Flutter',
            url: 'https://firebase.google.com',
          ),
          _LicenseCard(
            name: 'Firebase Auth',
            license: 'Apache License 2.0',
            description: 'Firebase authentication services',
            url: 'https://firebase.google.com/docs/auth',
          ),
          _LicenseCard(
            name: 'Firebase Cloud Firestore',
            license: 'Apache License 2.0',
            description: 'Real-time cloud database',
            url: 'https://firebase.google.com/docs/firestore',
          ),
          _LicenseCard(
            name: 'HTTP',
            license: 'BSD 3-Clause License',
            description: 'A composable, multithreaded, HTTP client for Dart',
            url: 'https://pub.dev/packages/http',
          ),
          _LicenseCard(
            name: 'Intl',
            license: 'BSD 3-Clause License',
            description: 'Internationalization and localization support',
            url: 'https://pub.dev/packages/intl',
          ),
          _LicenseCard(
            name: 'Shared Preferences',
            license: 'BSD 3-Clause License',
            description: 'Local data persistence',
            url: 'https://pub.dev/packages/shared_preferences',
          ),
          _LicenseCard(
            name: 'Flutter SVG',
            license: 'MIT License',
            description: 'SVG rendering support for Flutter',
            url: 'https://pub.dev/packages/flutter_svg',
          ),
          _LicenseCard(
            name: 'Provider',
            license: 'MIT License',
            description: 'State management solution',
            url: 'https://pub.dev/packages/provider',
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Text(
                      'License Information',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'BankHub Pakistan respects the licenses of all open-source projects used. All dependencies comply with their respective licenses. For the full license texts, please visit the project repositories.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _LicenseCard extends StatelessWidget {
  final String name;
  final String license;
  final String description;
  final String url;

  const _LicenseCard({
    required this.name,
    required this.license,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    license,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
