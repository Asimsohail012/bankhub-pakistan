import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays institution contact information in an organized section.
///
/// Shows: website, email, helpline with icons and url-launching capability.
/// Null-safe: missing information items are simply not displayed.
class InformationSection extends StatelessWidget {
  final String? officialWebsite;
  final String? officialEmail;
  final String? helpline;
  final String? title;

  const InformationSection({
    super.key,
    this.officialWebsite,
    this.officialEmail,
    this.helpline,
    this.title = 'Contact Information',
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String email) async {
    await _launchUrl('mailto:$email');
  }

  Future<void> _launchPhone(String phone) async {
    await _launchUrl('tel:$phone');
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.open_in_new, size: 18),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    if (title != null && title!.isNotEmpty) {
      items.add(
        Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      );
      items.add(const SizedBox(height: 12));
    }

    if (officialWebsite != null && officialWebsite!.isNotEmpty) {
      items.add(
        _buildInfoTile(
          icon: Icons.public,
          label: 'Official Website',
          value: officialWebsite!,
          onTap: () => _launchUrl(officialWebsite!),
        ),
      );
    }

    if (officialEmail != null && officialEmail!.isNotEmpty) {
      items.add(
        _buildInfoTile(
          icon: Icons.email,
          label: 'Email',
          value: officialEmail!,
          onTap: () => _launchEmail(officialEmail!),
        ),
      );
    }

    if (helpline != null && helpline!.isNotEmpty) {
      items.add(
        _buildInfoTile(
          icon: Icons.phone,
          label: 'Customer Care',
          value: helpline!,
          onTap: () => _launchPhone(helpline!),
        ),
      );
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}
