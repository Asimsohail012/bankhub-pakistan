import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          _SectionHeader('Important Disclaimer'),
          _SectionBody(
            'PLEASE READ THIS DISCLAIMER CAREFULLY BEFORE USING BANKHUB PAKISTAN',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('1. General Information'),
          _SectionBody(
            'BankHub Pakistan provides banking information, comparison tools, and financial calculators for educational and informational purposes only. The information provided is not professional financial advice.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('2. No Financial Advice'),
          _SectionBody(
            'Nothing on BankHub Pakistan constitutes professional financial advice, investment advice, or tax advice. Before making any financial decisions, please consult with qualified financial advisors, tax professionals, or the relevant banking institutions directly.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('3. Data Accuracy'),
          _SectionBody(
            'While we strive to provide accurate and up-to-date information sourced from official banking institutions and the State Bank of Pakistan, we do not guarantee the accuracy, completeness, or timeliness of all information. Financial products, rates, and terms change frequently.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('4. No Liability'),
          _SectionBody(
            'BankHub Pakistan shall not be liable for any direct, indirect, incidental, special, or consequential damages resulting from:\n\n'
            '• Use of or inability to use the Service\n'
            '• Reliance on any information provided\n'
            '• Inaccuracies or omissions in the information\n'
            '• Decisions made based on the information\n'
            '• Third-party content or services',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('5. Third-Party Services'),
          _SectionBody(
            'BankHub Pakistan may contain links to third-party websites and services. We are not responsible for the content, accuracy, or practices of these external sites. Use of third-party services is at your own risk.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('6. Banking Institution Independence'),
          _SectionBody(
            'BankHub Pakistan is an independent informational service and is not affiliated with, endorsed by, or sponsored by any banking institution or the State Bank of Pakistan, except where explicitly stated.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('7. Changes Without Notice'),
          _SectionBody(
            'BankHub Pakistan reserves the right to modify, suspend, or discontinue the Service at any time without notice. We may also modify these terms and conditions without notice.',
          ),
          const SizedBox(height: 24),
          
          _SectionHeader('8. User Responsibility'),
          _SectionBody(
            'You acknowledge that you are using BankHub Pakistan at your own risk. You are responsible for verifying all information with the relevant banking institutions before making any financial decisions.',
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
