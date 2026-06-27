/// Immutable official banking profile model.
///
/// Designed to hold SBP-verified banking data and future synchronization fields.
/// Maintains null safety throughout with sensible defaults.
///
/// This model is distinct from [lib/models/bank_model.dart] (UI layer) and
/// [lib/data/models/bank_model.dart] (data layer for PakistanBankRepository).
/// It supports future SBP verification integration without modifying existing models.
class BankProfile {
  /// Unique bank identifier.
  final String bankId;

  /// Official bank name per SBP records or public registry.
  final String officialName;

  /// Official short name or abbreviation.
  final String shortName;

  /// Banking category (Commercial, Islamic, Government, etc.).
  final String category;

  /// Current license status (Active, Suspended, etc.).
  final String licenseStatus;

  /// Whether the bank is verified by SBP (State Bank of Pakistan).
  final bool sbpVerified;

  /// Date of SBP verification (ISO 8601 format or null).
  final String? verificationDate;

  /// Official bank website.
  final String officialWebsite;

  /// Official corporate email address.
  final String officialEmail;

  /// Customer helpline or support phone number.
  final String helpline;

  /// Registered head office address.
  final String headOffice;

  /// SWIFT/BIC code for international transfers.
  final String swiftCode;

  /// IBAN prefix used by the bank (e.g., "PKxx").
  final String ibanPrefix;

  /// Year the bank was founded or established.
  final int? foundedYear;

  /// Number of branches (null if unavailable).
  final int? branchCount;

  /// Number of ATMs in the network (null if unavailable).
  final int? atmCount;

  /// Supports RAAST (real-time payment system).
  final bool supportsRaast;

  /// Supports Roshan Digital Account.
  final bool supportsRoshan;

  /// Offers internet banking services.
  final bool supportsInternetBanking;

  /// Offers mobile banking application.
  final bool supportsMobileBanking;

  /// Offers debit card products.
  final bool supportsDebitCards;

  /// Offers credit card products.
  final bool supportsCreditCards;

  /// Whether the bank operates under Islamic banking principles.
  final bool isIslamic;

  /// Whether the bank is a digital-only or digital-first institution.
  final bool isDigital;

  /// Last data update timestamp (ISO 8601 format).
  final String lastUpdated;

  const BankProfile({
    required this.bankId,
    required this.officialName,
    required this.shortName,
    required this.category,
    required this.licenseStatus,
    required this.sbpVerified,
    this.verificationDate,
    required this.officialWebsite,
    required this.officialEmail,
    required this.helpline,
    required this.headOffice,
    required this.swiftCode,
    required this.ibanPrefix,
    this.foundedYear,
    this.branchCount,
    this.atmCount,
    required this.supportsRaast,
    required this.supportsRoshan,
    required this.supportsInternetBanking,
    required this.supportsMobileBanking,
    required this.supportsDebitCards,
    required this.supportsCreditCards,
    required this.isIslamic,
    required this.isDigital,
    required this.lastUpdated,
  });

  /// Creates a copy of this profile with optionally replaced fields.
  BankProfile copyWith({
    String? bankId,
    String? officialName,
    String? shortName,
    String? category,
    String? licenseStatus,
    bool? sbpVerified,
    String? verificationDate,
    String? officialWebsite,
    String? officialEmail,
    String? helpline,
    String? headOffice,
    String? swiftCode,
    String? ibanPrefix,
    int? foundedYear,
    int? branchCount,
    int? atmCount,
    bool? supportsRaast,
    bool? supportsRoshan,
    bool? supportsInternetBanking,
    bool? supportsMobileBanking,
    bool? supportsDebitCards,
    bool? supportsCreditCards,
    bool? isIslamic,
    bool? isDigital,
    String? lastUpdated,
  }) {
    return BankProfile(
      bankId: bankId ?? this.bankId,
      officialName: officialName ?? this.officialName,
      shortName: shortName ?? this.shortName,
      category: category ?? this.category,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      sbpVerified: sbpVerified ?? this.sbpVerified,
      verificationDate: verificationDate ?? this.verificationDate,
      officialWebsite: officialWebsite ?? this.officialWebsite,
      officialEmail: officialEmail ?? this.officialEmail,
      helpline: helpline ?? this.helpline,
      headOffice: headOffice ?? this.headOffice,
      swiftCode: swiftCode ?? this.swiftCode,
      ibanPrefix: ibanPrefix ?? this.ibanPrefix,
      foundedYear: foundedYear ?? this.foundedYear,
      branchCount: branchCount ?? this.branchCount,
      atmCount: atmCount ?? this.atmCount,
      supportsRaast: supportsRaast ?? this.supportsRaast,
      supportsRoshan: supportsRoshan ?? this.supportsRoshan,
      supportsInternetBanking: supportsInternetBanking ?? this.supportsInternetBanking,
      supportsMobileBanking: supportsMobileBanking ?? this.supportsMobileBanking,
      supportsDebitCards: supportsDebitCards ?? this.supportsDebitCards,
      supportsCreditCards: supportsCreditCards ?? this.supportsCreditCards,
      isIslamic: isIslamic ?? this.isIslamic,
      isDigital: isDigital ?? this.isDigital,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Converts to JSON for serialization.
  Map<String, dynamic> toJson() {
    return {
      'bankId': bankId,
      'officialName': officialName,
      'shortName': shortName,
      'category': category,
      'licenseStatus': licenseStatus,
      'sbpVerified': sbpVerified,
      'verificationDate': verificationDate,
      'officialWebsite': officialWebsite,
      'officialEmail': officialEmail,
      'helpline': helpline,
      'headOffice': headOffice,
      'swiftCode': swiftCode,
      'ibanPrefix': ibanPrefix,
      'foundedYear': foundedYear,
      'branchCount': branchCount,
      'atmCount': atmCount,
      'supportsRaast': supportsRaast,
      'supportsRoshan': supportsRoshan,
      'supportsInternetBanking': supportsInternetBanking,
      'supportsMobileBanking': supportsMobileBanking,
      'supportsDebitCards': supportsDebitCards,
      'supportsCreditCards': supportsCreditCards,
      'isIslamic': isIslamic,
      'isDigital': isDigital,
      'lastUpdated': lastUpdated,
    };
  }

  /// Creates from JSON.
  factory BankProfile.fromJson(Map<String, dynamic> json) {
    return BankProfile(
      bankId: json['bankId'] as String,
      officialName: json['officialName'] as String,
      shortName: json['shortName'] as String,
      category: json['category'] as String,
      licenseStatus: json['licenseStatus'] as String? ?? 'Active',
      sbpVerified: json['sbpVerified'] as bool? ?? false,
      verificationDate: json['verificationDate'] as String?,
      officialWebsite: json['officialWebsite'] as String,
      officialEmail: json['officialEmail'] as String,
      helpline: json['helpline'] as String,
      headOffice: json['headOffice'] as String,
      swiftCode: json['swiftCode'] as String,
      ibanPrefix: json['ibanPrefix'] as String? ?? 'PKxx',
      foundedYear: json['foundedYear'] as int?,
      branchCount: json['branchCount'] as int?,
      atmCount: json['atmCount'] as int?,
      supportsRaast: json['supportsRaast'] as bool? ?? false,
      supportsRoshan: json['supportsRoshan'] as bool? ?? false,
      supportsInternetBanking: json['supportsInternetBanking'] as bool? ?? true,
      supportsMobileBanking: json['supportsMobileBanking'] as bool? ?? true,
      supportsDebitCards: json['supportsDebitCards'] as bool? ?? true,
      supportsCreditCards: json['supportsCreditCards'] as bool? ?? true,
      isIslamic: json['isIslamic'] as bool? ?? false,
      isDigital: json['isDigital'] as bool? ?? false,
      lastUpdated: json['lastUpdated'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankProfile &&
          runtimeType == other.runtimeType &&
          bankId == other.bankId;

  @override
  int get hashCode => bankId.hashCode;

  @override
  String toString() =>
      'BankProfile(bankId: $bankId, officialName: $officialName, sbpVerified: $sbpVerified)';
}
