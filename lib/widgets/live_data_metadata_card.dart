import 'package:flutter/material.dart';
import '../services/live_data/metadata.dart';

/// Widget to display live data metadata including verification status,
/// last updated time, source information, and refresh capability.
class LiveDataMetadataCard extends StatelessWidget {
  final DataSourceMetadata metadata;
  final VoidCallback? onRefresh;
  final bool isLoading;

  const LiveDataMetadataCard({
    Key? key,
    required this.metadata,
    this.onRefresh,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: _getBackgroundColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getBorderColor(),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Verification Badge
            _buildVerificationBadge(),
            const SizedBox(width: 12),
            
            // Metadata Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source Name
                  Text(
                    metadata.sourceName,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  
                  // Last Updated / Cache Status
                  Text(
                    _getStatusText(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Refresh Button
            if (onRefresh != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.refresh,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    onPressed: isLoading ? null : onRefresh,
                    tooltip: 'Refresh data',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the verification status badge
  Widget _buildVerificationBadge() {
    final icon = _getVerificationIcon();
    final color = _getVerificationColor();

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 18,
          color: color,
        ),
      ),
    );
  }

  /// Returns appropriate icon for verification status
  IconData _getVerificationIcon() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.cached:
        return Icons.schedule;
      case VerificationStatus.placeholder:
        return Icons.info_outline;
      case VerificationStatus.pending:
        return Icons.pending;
      case VerificationStatus.unverified:
        return Icons.warning_outlined;
    }
  }

  /// Returns color for verification status
  Color _getVerificationColor() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.cached:
        return Colors.amber;
      case VerificationStatus.placeholder:
        return Colors.orange;
      case VerificationStatus.pending:
        return Colors.blue;
      case VerificationStatus.unverified:
        return Colors.red;
    }
  }

  /// Returns background color based on status
  Color _getBackgroundColor() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Colors.green.withOpacity(0.05);
      case VerificationStatus.cached:
        return Colors.amber.withOpacity(0.05);
      case VerificationStatus.placeholder:
        return Colors.orange.withOpacity(0.05);
      case VerificationStatus.pending:
        return Colors.blue.withOpacity(0.05);
      case VerificationStatus.unverified:
        return Colors.red.withOpacity(0.05);
    }
  }

  /// Returns border color based on status
  Color _getBorderColor() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Colors.green.withOpacity(0.3);
      case VerificationStatus.cached:
        return Colors.amber.withOpacity(0.3);
      case VerificationStatus.placeholder:
        return Colors.orange.withOpacity(0.3);
      case VerificationStatus.pending:
        return Colors.blue.withOpacity(0.3);
      case VerificationStatus.unverified:
        return Colors.red.withOpacity(0.3);
    }
  }

  /// Generates status text with last updated time
  String _getStatusText() {
    final age = metadata.ageSeconds;
    final ageStr = age < 60
        ? '$age seconds ago'
        : age < 3600
            ? '${(age / 60).floor()} minutes ago'
            : '${(age / 3600).floor()} hours ago';

    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return '✓ Live • Updated $ageStr';
      case VerificationStatus.cached:
        return '📦 Cached • $ageStr';
      case VerificationStatus.placeholder:
        return '⊘ Offline mode • Placeholder data';
      case VerificationStatus.pending:
        return '⏳ Pending • $ageStr';
      case VerificationStatus.unverified:
        return '⚠ Unverified • $ageStr';
    }
  }
}

/// Compact version of metadata display for inline use
class CompactMetadataIndicator extends StatelessWidget {
  final DataSourceMetadata metadata;

  const CompactMetadataIndicator({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getTooltipText(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getColor().withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _getColor().withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              size: 14,
              color: _getColor(),
            ),
            const SizedBox(width: 4),
            Text(
              _getLabel(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _getColor(),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Colors.green;
      case VerificationStatus.cached:
        return Colors.amber;
      case VerificationStatus.placeholder:
        return Colors.orange;
      case VerificationStatus.pending:
        return Colors.blue;
      case VerificationStatus.unverified:
        return Colors.red;
    }
  }

  IconData _getIcon() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return Icons.verified;
      case VerificationStatus.cached:
        return Icons.schedule;
      case VerificationStatus.placeholder:
        return Icons.info_outline;
      case VerificationStatus.pending:
        return Icons.pending;
      case VerificationStatus.unverified:
        return Icons.warning_outlined;
    }
  }

  String _getLabel() {
    switch (metadata.verificationStatus) {
      case VerificationStatus.verified:
        return 'Live';
      case VerificationStatus.cached:
        return 'Cached';
      case VerificationStatus.placeholder:
        return 'Offline';
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.unverified:
        return 'Unverified';
    }
  }

  String _getTooltipText() {
    final age = metadata.ageSeconds;
    final ageStr = age < 60
        ? '$age seconds ago'
        : age < 3600
            ? '${(age / 60).floor()} minutes ago'
            : '${(age / 3600).floor()} hours ago';

    return '${metadata.sourceName}\nUpdated: $ageStr\nStatus: ${metadata.verificationStatus.toString().split('.').last}';
  }
}
