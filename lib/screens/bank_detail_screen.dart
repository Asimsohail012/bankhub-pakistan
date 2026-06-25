import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../models/bank_model.dart';

class BankDetailScreen extends StatelessWidget {
  final BankModel bank;
Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
  const BankDetailScreen({
    super.key,
    required this.bank,
  });

  Widget buildInfoTile(
  IconData icon,
  String title,
  String value,
) {
  return Card(
    elevation: 2,
    margin: const EdgeInsets.symmetric(
      vertical: 6,
    ),
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.indigo,
      ),
      title: Text(title),
      subtitle: Text(value),

      trailing: const Icon(
        Icons.open_in_new,
      ),

      onTap: () {
        if (value.startsWith('http')) {
          openUrl(value);
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff0f172a),
                    Color(0xff1e293b),
                  ],
                ),
              ),
              child: Column(
                children: [

                  const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 60,
                  ),

                  const SizedBox(height: 15),

                  Text(
                    bank.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    bank.slogan,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            buildInfoTile(
              Icons.language,
              "Website",
              bank.website,
            ),

            buildInfoTile(
              Icons.computer,
              "Internet Banking",
              bank.internetBanking,
            ),

            buildInfoTile(
              Icons.phone_android,
              "Mobile App",
              bank.mobileApp,
            ),

            buildInfoTile(
              Icons.call,
              "Helpline",
              bank.helpline,
            ),

            buildInfoTile(
              Icons.sms,
              "SMS Banking",
              bank.smsBanking,
            ),

            buildInfoTile(
              Icons.chat,
              'WhatsApp Banking',
              bank.whatsappBanking,
            ),

            buildInfoTile(
              Icons.location_on,
              'Branch Locator',
              bank.branchLocator,
            ),

            buildInfoTile(
              Icons.credit_card,
              'Credit Cards',
              bank.creditCards,
            ),

            buildInfoTile(
              Icons.mosque,
              'Islamic Banking',
              bank.islamicBanking,
            ),

            const SizedBox(height: 20),

            SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton.icon(
    onPressed: () {
  openUrl(bank.openAccountUrl);
},
    icon: const Icon(Icons.person_add),
    label: const Text(
      'Open Account',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

const SizedBox(height: 12),

SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton.icon(
    onPressed: () {
  openUrl(bank.downloadAppUrl);
},
    icon: const Icon(Icons.download),
    label: const Text(
      'Download App',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}