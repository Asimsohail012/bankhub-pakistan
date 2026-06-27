/// License status enumeration for financial institutions.
/// 
/// Tracks the regulatory license status of financial institutions as recognized
/// by the State Bank of Pakistan and other financial regulators.
enum LicenseStatus {
  /// Institution is actively licensed and operational
  active,

  /// Institution is licensed but temporarily suspended
  suspended,

  /// Institution license has been revoked or closed
  closed,

  /// Institution has applied for license (pending approval)
  pending,

  /// Institution is in provisional or conditional license status
  provisional,

  /// License status is under review or modification
  underReview,

  /// License status is unknown or unavailable
  unknown,
}

/// Extension on LicenseStatus to get display properties
extension LicenseStatusExtension on LicenseStatus {
  /// Returns human-readable display name
  String get displayName {
    switch (this) {
      case LicenseStatus.active:
        return 'Active';
      case LicenseStatus.suspended:
        return 'Suspended';
      case LicenseStatus.closed:
        return 'Closed';
      case LicenseStatus.pending:
        return 'Pending';
      case LicenseStatus.provisional:
        return 'Provisional';
      case LicenseStatus.underReview:
        return 'Under Review';
      case LicenseStatus.unknown:
        return 'Unknown';
    }
  }

  /// Returns description for the license status
  String get description {
    switch (this) {
      case LicenseStatus.active:
        return 'Fully licensed and operational';
      case LicenseStatus.suspended:
        return 'Temporarily suspended by regulator';
      case LicenseStatus.closed:
        return 'License revoked or permanently closed';
      case LicenseStatus.pending:
        return 'License application pending';
      case LicenseStatus.provisional:
        return 'Provisional or conditional license';
      case LicenseStatus.underReview:
        return 'License under regulatory review';
      case LicenseStatus.unknown:
        return 'Status not available';
    }
  }

  /// Returns true if institution is allowed to operate
  bool get isOperating => this == LicenseStatus.active || this == LicenseStatus.provisional;

  /// Returns true if institution operations are restricted
  bool get isRestricted => this == LicenseStatus.suspended || this == LicenseStatus.underReview;

  /// Returns true if institution is no longer operational
  bool get isClosed => this == LicenseStatus.closed;
}
