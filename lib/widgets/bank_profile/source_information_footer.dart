import 'package:flutter/material.dart';

/// Displays data source metadata information.
///
/// Shows: source name, source URL, retrieved date, last verified date, verification status.
/// Phase 6+ ready: all fields are optional and null-safe.
/// Typically displayed at the bottom of the bank profile.
class SourceInformationFooter extends StatelessWidget {
  final String? sourceName;
  final String? sourceUrl;
  final String? retrievedDate;
  final String? verifiedDate;
  final String? verificationStatus;

  const SourceInformationFooter({
    super.key,
    this.sourceName,
    this.sourceUrl,
    this.retrievedDate,
    this.verifiedDate,
    this.verificationStatus,
  });

  @override
  Widget build(BuildContext context) {
    // If no data, don't show section
    if (sourceName == null &&
        sourceUrl == null &&
        retrievedDate == null &&
        verifiedDate == null &&
        verificationStatus == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Information',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          if (sourceName != null && sourceName!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.source_rounded,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Source: $sourceName',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          if (verificationStatus != null && verificationStatus!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.verified_rounded,
                  size: 14,
                  color: verificationStatus == 'verified'
                      ? Colors.green.shade600
                      : Colors.orange.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Verification: $verificationStatus',
                    style: TextStyle(
                      fontSize: 11,
                      color: verificationStatus == 'verified'
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          if (retrievedDate != null && retrievedDate!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.schedule_rounded,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Retrieved: $retrievedDate',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
          if (verifiedDate != null && verifiedDate!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Verified: $verifiedDate',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
