import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/bank_model.dart';

class BankDetailScreen extends StatelessWidget {
  final BankModel bank;

  const BankDetailScreen({
    super.key,
    required this.bank,
  });

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Widget buildInfoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.open_in_new),
        onTap: () async {
          if (value.startsWith('http')) {
            await openUrl(value);
          } else if (title == 'Helpline' || title == 'WhatsApp Banking') {
            await openUrl('tel:$value');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bank.name),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E3A8A),
                    Color(0xFF2563EB),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Hero(
                      tag: 'bank-logo-${bank.name}',
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white..withValues(alpha: 46),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          bank.logoAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bank.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              bank.slogan,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Chip(
                        backgroundColor: Colors.white..withValues(alpha: 46),
                        label: const Text(
                          'Trusted Partner',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.white..withValues(alpha: 46),
                        label: const Text(
                          'Digital Ready',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Banking Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            buildInfoTile(Icons.language, 'Website', bank.website),
            buildInfoTile(Icons.computer, 'Internet Banking', bank.internetBanking),
            buildInfoTile(Icons.phone_android, 'Mobile App', bank.mobileApp),
            buildInfoTile(Icons.call, 'Helpline', bank.helpline),
            buildInfoTile(Icons.sms, 'SMS Banking', bank.smsBanking),
            buildInfoTile(Icons.chat, 'WhatsApp Banking', bank.whatsappBanking),
            buildInfoTile(Icons.location_on, 'Branch Locator', bank.branchLocator),
            buildInfoTile(Icons.credit_card, 'Credit Cards', bank.creditCards),
            buildInfoTile(Icons.mosque, 'Islamic Banking', bank.islamicBanking),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => openUrl(bank.openAccountUrl),
                icon: const Icon(Icons.person_add),
                label: const Text('Open Account'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => openUrl(bank.downloadAppUrl),
                icon: const Icon(Icons.download),
                label: const Text('Download App'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

