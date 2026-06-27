import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/bank_model.dart';
import '../services/bank_persistence_service.dart';
import '../widgets/banks/bank_detail_header.dart';
import '../widgets/premium_unlock_sheet.dart';

class BankDetailScreen extends StatefulWidget {
  final BankModel bank;

  const BankDetailScreen({
    super.key,
    required this.bank,
  });

  @override
  State<BankDetailScreen> createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
    BankPersistenceService.addRecentlyViewed(widget.bank.id);
  }

  Future<void> _loadFavorite() async {
    final isFavorite = await BankPersistenceService.isFavorite(widget.bank.id);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await showPremiumUnlockSheet(context);
      return;
    }
    await BankPersistenceService.toggleFavorite(widget.bank.id);
    await _loadFavorite();
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  IconData _socialIcon(String label) {
    final name = label.toLowerCase();
    if (name.contains('twitter')) return Icons.alternate_email;
    if (name.contains('facebook')) return Icons.facebook;
    if (name.contains('instagram')) return Icons.camera_alt;
    if (name.contains('linkedin')) return Icons.business;
    if (name.contains('youtube')) return Icons.play_circle_fill;
    return Icons.link;
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
          } else if (title == 'Email') {
            await openUrl('mailto:$value');
          } else if (title == 'Helpline' || title == 'Customer Care' || title == 'WhatsApp Banking') {
            await openUrl('tel:$value');
          }
        },
      ),
    );
  }

  Widget buildProductSection(String title, List<String> items) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bank = widget.bank;

    return Scaffold(
      appBar: AppBar(
        title: Text(bank.name),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BankDetailHeader(
              bank: bank,
              isFavorite: _isFavorite,
              onFavoriteTap: _toggleFavorite,
            ),
            const SizedBox(height: 24),
            const Text(
              'Official Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            buildInfoTile(
              Icons.calendar_today,
              'Established',
              bank.establishedYear > 0 ? bank.establishedYear.toString() : 'TBD',
            ),
            buildInfoTile(Icons.location_city, 'Headquarters', bank.headquarters),
            buildInfoTile(Icons.code, 'SWIFT Code', bank.swiftCode),
            buildInfoTile(
              Icons.account_tree,
              'Branch Network',
              bank.branchCount > 0 ? '${bank.branchCount} branches' : 'See branch locator',
            ),
            buildInfoTile(
              Icons.atm,
              'ATM Network',
              bank.atmCount > 0 ? '${bank.atmCount} ATMs' : 'See branch locator',
            ),
            buildInfoTile(
              Icons.support_agent,
              'Customer Care',
              bank.customerCare.isNotEmpty ? bank.customerCare : bank.helpline,
            ),
            if (bank.email.isNotEmpty)
              buildInfoTile(Icons.email, 'Email', bank.email),
            const SizedBox(height: 20),
            const Text(
              'Digital Access',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            buildInfoTile(Icons.language, 'Website', bank.website),
            buildInfoTile(Icons.computer, 'Internet Banking', bank.internetBanking),
            buildInfoTile(Icons.phone_android, 'Mobile App', bank.mobileApp),
            buildInfoTile(Icons.download, 'Android App', bank.mobileAppAndroidUrl),
            buildInfoTile(Icons.download, 'iOS App', bank.mobileAppIosUrl),
            const SizedBox(height: 20),
            if (bank.socialMedia.isNotEmpty) ...[
              const Text(
                'Social Media',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 10,
                children: bank.socialMedia.entries.map((entry) {
                  return OutlinedButton.icon(
                    onPressed: () => openUrl(entry.value),
                    icon: Icon(_socialIcon(entry.key), size: 18),
                    label: Text(entry.key),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
            const Text(
              'Product Portfolio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...bank.productSections.entries.map(
              (entry) => buildProductSection(entry.key, entry.value),
            ),
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

