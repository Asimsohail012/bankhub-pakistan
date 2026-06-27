import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          _SectionHeader('Terms & Conditions'),
          _SectionBody(
            'Last Updated: June 2024\n\n'
            'These Terms & Conditions ("Terms") govern your use of the BankHub Pakistan application ("Service"). By accessing and using this Service, you accept and agree to be bound by these Terms.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('1. License and Usage'),
          _SectionBody(
            'We grant you a limited, non-exclusive, revocable license to use the Service for personal, non-commercial purposes. You may not:\n\n'
            '• Modify or copy the materials\n'
            '• Use the materials for any commercial purpose or for any public display\n'
            '• Attempt to decompile or reverse engineer any software\n'
            '• Remove any copyright or other proprietary notations\n'
            '• Transfer the materials to another person or "mirror" the materials on any other server',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('2. Disclaimer of Warranties'),
          _SectionBody(
            'The materials (content) on BankHub Pakistan are provided for informational purposes only. BankHub Pakistan makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation:\n\n'
            '• Implied warranties of merchantability\n'
            '• Fitness for a particular purpose\n'
            '• Non-infringement of intellectual property or other violation of rights',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('3. Limitations of Liability'),
          _SectionBody(
            'In no event shall BankHub Pakistan or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on BankHub Pakistan.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('4. Accuracy of Materials'),
          _SectionBody(
            'The materials appearing on BankHub Pakistan could include technical, typographical, or photographic errors. BankHub Pakistan does not warrant that any of the materials on our Service are accurate, complete, or current. BankHub Pakistan may make changes to the materials contained on its Service at any time without notice.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('5. Links'),
          _SectionBody(
            'BankHub Pakistan has not reviewed all of the sites linked to its website and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by BankHub Pakistan of the site. Use of any such linked website is at the user\'s own risk.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('6. Modifications'),
          _SectionBody(
            'BankHub Pakistan may revise these Terms for its Service at any time without notice. By using this Service, you are agreeing to be bound by the then current version of these Terms.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('7. Governing Law'),
          _SectionBody(
            'These Terms and Conditions are governed by and construed in accordance with the laws of Pakistan, and you irrevocably submit to the exclusive jurisdiction of the courts in Karachi.',
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
