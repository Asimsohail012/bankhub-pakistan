import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          _SectionHeader('Privacy Policy'),
          _SectionBody(
            'Last Updated: June 2024\n\n'
            'BankHub Pakistan ("we", "us", "our" or "Company") operates the BankHub Pakistan application (the "Service").\n\n'
            'This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Information Collection and Use'),
          _SectionBody(
            'We collect personal information that you provide directly to us, such as:\n\n'
            '• Email address and password\n'
            '• Display name and profile information\n'
            '• Preferences and settings\n'
            '• Bookmarks and saved items\n'
            '• Search history (optional)\n\n'
            'We collect automatic information when you use our Service, including:\n\n'
            '• Device information\n'
            '• Usage analytics\n'
            '• Performance metrics',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Data Security'),
          _SectionBody(
            'The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal data, we cannot guarantee its absolute security.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Use of Data'),
          _SectionBody(
            'BankHub Pakistan uses the collected data for various purposes:\n\n'
            '• To provide and maintain our Service\n'
            '• To notify you about changes to our Service\n'
            '• To provide customer support\n'
            '• To gather analysis or valuable information so that we can improve our Service\n'
            '• To monitor the usage of our Service\n'
            '• To detect, prevent and address technical issues',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Firebase and Third-Party Services'),
          _SectionBody(
            'Our Service uses Google Firebase for authentication and data storage. Firebase has its own privacy policy which you should review at https://firebase.google.com/support/privacy.\n\n'
            'We may also use third-party services for analytics and market data.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Changes to This Privacy Policy'),
          _SectionBody(
            'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "effective date" at the top.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('Contact Us'),
          _SectionBody(
            'If you have any questions about this Privacy Policy, please contact us at support@bankhubpakistan.com',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _SectionBody extends StatelessWidget {
  final String text;

  const _SectionBody(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
