/// Represents a single banking capability with metadata tracking.
///
/// Each capability is nullable and can be extended with source tracking
/// metadata for future Phase 6+ SBP data synchronization.
///
/// Example capabilities:
/// - Accounts: Current Account, Savings Account, Islamic Account
/// - Cards: Credit Card, Debit Card, Virtual Card
/// - Payments: RAAST, QR, Mobile Transfer
/// - Financing: Home Loan, Auto Loan, Personal Loan
///
/// This model supports the 17 capability categories:
/// 1. Accounts
/// 2. Cards
/// 3. Digital Banking
/// 4. Payments
/// 5. Financing
/// 6. Islamic Banking
/// 7. Overseas Pakistanis
/// 8. Remittance
/// 9. Branch Services
/// 10. Customer Support
/// 11. Security
/// 12. Investments
/// 13. SME Services
/// 14. Corporate Banking
/// 15. Agriculture Banking
/// 16. Treasury
/// 17. Trade Finance
class BankCapability {
  /// Display name of the capability (e.g., 'Current Account', 'Home Loan').
  final String name;

  /// Specific type or category of the capability.
  /// Examples: 'Account', 'Card', 'Loan', 'Service'
  final String type;

  /// Optional brief description of the capability.
  /// Examples: 'Zero-balance checking account', 'Competitive home loan rates'
  final String? description;

  // ============================================================================
  // SOURCE METADATA (Phase 6+ Population)
  // ============================================================================

  /// Data source name (Phase 6+).
  ///
  /// Examples: 'SBP Registry', 'Official Website', 'Public Database', 'API'
  /// Null if not yet assigned or source tracking not implemented.
  final String? sourceName;

  /// Data source URL (Phase 6+).
  ///
  /// Full URL where the capability data was retrieved.
  /// Examples: 'https://www.sbp.org.pk/...', 'https://bank.com.pk/...'
  /// Null if not yet assigned or URL not available.
  final String? sourceUrl;

  /// Date and time when capability data was retrieved (Phase 6+).
  ///
  /// ISO 8601 format timestamp indicating when data was fetched.
  /// Example: '2024-06-27T10:30:00Z'
  /// Null if not yet populated or source tracking not implemented.
  final DateTime? retrievedDate;

  /// Date and time when capability was last verified (Phase 6+).
  ///
  /// ISO 8601 format timestamp indicating most recent verification.
  /// Example: '2024-06-27T10:30:00Z'
  /// Null if not yet verified or verification not tracked.
  final DateTime? verifiedDate;

  /// Verification status of the capability (Phase 6+).
  ///
  /// Possible values: 'verified', 'pending', 'outdated', 'unverified'
  /// - 'verified': Data confirmed with official source
  /// - 'pending': Awaiting verification
  /// - 'outdated': Data needs refreshing
  /// - 'unverified': Not yet verified
  /// Null if not yet assigned.
  final String? verificationStatus;

  const BankCapability({
    required this.name,
    required this.type,
    this.description,
    // Source metadata (Phase 6+)
    this.sourceName,
    this.sourceUrl,
    this.retrievedDate,
    this.verifiedDate,
    this.verificationStatus,
  });

  /// Creates a copy with optionally replaced fields.
  BankCapability copyWith({
    String? name,
    String? type,
    String? description,
    String? sourceName,
    String? sourceUrl,
    DateTime? retrievedDate,
    DateTime? verifiedDate,
    String? verificationStatus,
  }) {
    return BankCapability(
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      retrievedDate: retrievedDate ?? this.retrievedDate,
      verifiedDate: verifiedDate ?? this.verifiedDate,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  /// Converts to JSON for serialization.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'retrievedDate': retrievedDate?.toIso8601String(),
      'verifiedDate': verifiedDate?.toIso8601String(),
      'verificationStatus': verificationStatus,
    };
  }

  /// Creates from JSON.
  factory BankCapability.fromJson(Map<String, dynamic> json) {
    return BankCapability(
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      sourceName: json['sourceName'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      retrievedDate: json['retrievedDate'] != null
          ? DateTime.parse(json['retrievedDate'] as String)
          : null,
      verifiedDate: json['verifiedDate'] != null
          ? DateTime.parse(json['verifiedDate'] as String)
          : null,
      verificationStatus: json['verificationStatus'] as String?,
    );
  }

  @override
  String toString() => 'BankCapability(name: $name, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankCapability &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
