import 'enums/institution_type.dart';
import 'enums/institution_category.dart';
import 'enums/license_status.dart';

/// Immutable financial institution model supporting all SBP-recognized entities.
///
/// This model represents banks, microfinance institutions, digital wallets,
/// EMIs, and other financial entities regulated or recognized by SBP.
///
/// Supports multiple institution types and comprehensive fintech features.
class FinancialInstitution {
  /// Unique institution identifier.
  final String institutionId;

  /// Official name of the institution per SBP records.
  final String officialName;

  /// Official short name or abbreviation.
  final String shortName;

  /// Type of institution (e.g., Commercial Bank, Islamic Bank, Microfinance Bank).
  final InstitutionType institutionType;

  /// Regulatory category or classification.
  final InstitutionCategory category;

  /// Current license status (Active, Suspended, Closed, etc.).
  final LicenseStatus licenseStatus;

  /// Whether verified and registered with SBP.
  final bool sbpVerified;

  /// Date of SBP verification (ISO 8601 format or null).
  final String? verificationDate;

  /// Last data update timestamp (ISO 8601 format).
  final String lastUpdated;

  /// Official website URL.
  final String officialWebsite;

  /// Official corporate email address.
  final String officialEmail;

  /// Customer support helpline or phone number.
  final String helpline;

  /// Registered head office address.
  final String headOffice;

  /// SWIFT/BIC code for international transfers.
  final String swiftCode;

  /// IBAN prefix used by the institution.
  final String ibanPrefix;

  /// Year the institution was founded or established.
  final int? foundedYear;

  /// Number of branches in the network (null if unavailable).
  final int? branchCount;

  /// Number of ATMs in the network (null if unavailable).
  final int? atmCount;

  /// Supports internet banking platform.
  final bool supportsInternetBanking;

  /// Supports mobile banking application.
  final bool supportsMobileBanking;

  /// Supports RAAST (real-time payment system).
  final bool supportsRaast;

  /// Supports QR-based payments.
  final bool supportsQR;

  /// Supports Roshan Digital Account.
  final bool supportsRoshan;

  /// Offers Islamic banking products and services.
  final bool supportsIslamicBanking;

  /// Offers debit card products.
  final bool supportsDebitCards;

  /// Offers credit card products.
  final bool supportsCreditCards;

  /// Brief description of the institution.
  final String description;

  /// List of financial products offered (e.g., Current Account, Savings, Cards).
  final List<String> products;

  /// List of services provided (e.g., Foreign Remittance, Trade Finance).
  final List<String> services;

  /// Search keywords for discoverability.
  final List<String> keywords;

  const FinancialInstitution({
    required this.institutionId,
    required this.officialName,
    required this.shortName,
    required this.institutionType,
    required this.category,
    required this.licenseStatus,
    required this.sbpVerified,
    this.verificationDate,
    required this.lastUpdated,
    required this.officialWebsite,
    required this.officialEmail,
    required this.helpline,
    required this.headOffice,
    required this.swiftCode,
    required this.ibanPrefix,
    this.foundedYear,
    this.branchCount,
    this.atmCount,
    required this.supportsInternetBanking,
    required this.supportsMobileBanking,
    required this.supportsRaast,
    required this.supportsQR,
    required this.supportsRoshan,
    required this.supportsIslamicBanking,
    required this.supportsDebitCards,
    required this.supportsCreditCards,
    required this.description,
    required this.products,
    required this.services,
    required this.keywords,
  });

  /// Creates a copy of this institution with optionally replaced fields.
  FinancialInstitution copyWith({
    String? institutionId,
    String? officialName,
    String? shortName,
    InstitutionType? institutionType,
    InstitutionCategory? category,
    LicenseStatus? licenseStatus,
    bool? sbpVerified,
    String? verificationDate,
    String? lastUpdated,
    String? officialWebsite,
    String? officialEmail,
    String? helpline,
    String? headOffice,
    String? swiftCode,
    String? ibanPrefix,
    int? foundedYear,
    int? branchCount,
    int? atmCount,
    bool? supportsInternetBanking,
    bool? supportsMobileBanking,
    bool? supportsRaast,
    bool? supportsQR,
    bool? supportsRoshan,
    bool? supportsIslamicBanking,
    bool? supportsDebitCards,
    bool? supportsCreditCards,
    String? description,
    List<String>? products,
    List<String>? services,
    List<String>? keywords,
  }) {
    return FinancialInstitution(
      institutionId: institutionId ?? this.institutionId,
      officialName: officialName ?? this.officialName,
      shortName: shortName ?? this.shortName,
      institutionType: institutionType ?? this.institutionType,
      category: category ?? this.category,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      sbpVerified: sbpVerified ?? this.sbpVerified,
      verificationDate: verificationDate ?? this.verificationDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      officialWebsite: officialWebsite ?? this.officialWebsite,
      officialEmail: officialEmail ?? this.officialEmail,
      helpline: helpline ?? this.helpline,
      headOffice: headOffice ?? this.headOffice,
      swiftCode: swiftCode ?? this.swiftCode,
      ibanPrefix: ibanPrefix ?? this.ibanPrefix,
      foundedYear: foundedYear ?? this.foundedYear,
      branchCount: branchCount ?? this.branchCount,
      atmCount: atmCount ?? this.atmCount,
      supportsInternetBanking: supportsInternetBanking ?? this.supportsInternetBanking,
      supportsMobileBanking: supportsMobileBanking ?? this.supportsMobileBanking,
      supportsRaast: supportsRaast ?? this.supportsRaast,
      supportsQR: supportsQR ?? this.supportsQR,
      supportsRoshan: supportsRoshan ?? this.supportsRoshan,
      supportsIslamicBanking: supportsIslamicBanking ?? this.supportsIslamicBanking,
      supportsDebitCards: supportsDebitCards ?? this.supportsDebitCards,
      supportsCreditCards: supportsCreditCards ?? this.supportsCreditCards,
      description: description ?? this.description,
      products: products ?? this.products,
      services: services ?? this.services,
      keywords: keywords ?? this.keywords,
    );
  }

  /// Converts to JSON for serialization.
  Map<String, dynamic> toJson() {
    return {
      'institutionId': institutionId,
      'officialName': officialName,
      'shortName': shortName,
      'institutionType': institutionType.name,
      'category': category.name,
      'licenseStatus': licenseStatus.name,
      'sbpVerified': sbpVerified,
      'verificationDate': verificationDate,
      'lastUpdated': lastUpdated,
      'officialWebsite': officialWebsite,
      'officialEmail': officialEmail,
      'helpline': helpline,
      'headOffice': headOffice,
      'swiftCode': swiftCode,
      'ibanPrefix': ibanPrefix,
      'foundedYear': foundedYear,
      'branchCount': branchCount,
      'atmCount': atmCount,
      'supportsInternetBanking': supportsInternetBanking,
      'supportsMobileBanking': supportsMobileBanking,
      'supportsRaast': supportsRaast,
      'supportsQR': supportsQR,
      'supportsRoshan': supportsRoshan,
      'supportsIslamicBanking': supportsIslamicBanking,
      'supportsDebitCards': supportsDebitCards,
      'supportsCreditCards': supportsCreditCards,
      'description': description,
      'products': products,
      'services': services,
      'keywords': keywords,
    };
  }

  /// Creates from JSON.
  factory FinancialInstitution.fromJson(Map<String, dynamic> json) {
    return FinancialInstitution(
      institutionId: json['institutionId'] as String,
      officialName: json['officialName'] as String,
      shortName: json['shortName'] as String,
      institutionType: _parseInstitutionType(json['institutionType']),
      category: _parseInstitutionCategory(json['category']),
      licenseStatus: _parseLicenseStatus(json['licenseStatus']),
      sbpVerified: json['sbpVerified'] as bool? ?? false,
      verificationDate: json['verificationDate'] as String?,
      lastUpdated: json['lastUpdated'] as String? ?? DateTime.now().toIso8601String(),
      officialWebsite: json['officialWebsite'] as String,
      officialEmail: json['officialEmail'] as String,
      helpline: json['helpline'] as String,
      headOffice: json['headOffice'] as String,
      swiftCode: json['swiftCode'] as String,
      ibanPrefix: json['ibanPrefix'] as String,
      foundedYear: json['foundedYear'] as int?,
      branchCount: json['branchCount'] as int?,
      atmCount: json['atmCount'] as int?,
      supportsInternetBanking: json['supportsInternetBanking'] as bool? ?? true,
      supportsMobileBanking: json['supportsMobileBanking'] as bool? ?? true,
      supportsRaast: json['supportsRaast'] as bool? ?? false,
      supportsQR: json['supportsQR'] as bool? ?? false,
      supportsRoshan: json['supportsRoshan'] as bool? ?? false,
      supportsIslamicBanking: json['supportsIslamicBanking'] as bool? ?? false,
      supportsDebitCards: json['supportsDebitCards'] as bool? ?? true,
      supportsCreditCards: json['supportsCreditCards'] as bool? ?? true,
      description: json['description'] as String? ?? '',
      products: List<String>.from(json['products'] as List? ?? []),
      services: List<String>.from(json['services'] as List? ?? []),
      keywords: List<String>.from(json['keywords'] as List? ?? []),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialInstitution &&
          runtimeType == other.runtimeType &&
          institutionId == other.institutionId;

  @override
  int get hashCode => institutionId.hashCode;

  @override
  String toString() =>
      'FinancialInstitution(institutionId: $institutionId, officialName: $officialName, institutionType: $institutionType, sbpVerified: $sbpVerified)';
}

/// Converts a dynamic value to [InstitutionType] enum.
/// 
/// Handles both enum values and string representations.
/// Returns a safe default (commercialBank) if parsing fails.
InstitutionType _parseInstitutionType(dynamic value) {
  if (value is InstitutionType) return value;
  if (value is String) {
    try {
      // Try exact match first
      return InstitutionType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => InstitutionType.commercialBank,
      );
    } catch (_) {
      return InstitutionType.commercialBank;
    }
  }
  return InstitutionType.commercialBank;
}

/// Converts a dynamic value to [InstitutionCategory] enum.
/// 
/// Handles both enum values and string representations.
/// Returns a safe default (commercial) if parsing fails.
InstitutionCategory _parseInstitutionCategory(dynamic value) {
  if (value is InstitutionCategory) return value;
  if (value is String) {
    try {
      // Try exact match first
      return InstitutionCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => InstitutionCategory.commercial,
      );
    } catch (_) {
      return InstitutionCategory.commercial;
    }
  }
  return InstitutionCategory.commercial;
}

/// Converts a dynamic value to [LicenseStatus] enum.
/// 
/// Handles both enum values and string representations.
/// Returns a safe default (active) if parsing fails.
LicenseStatus _parseLicenseStatus(dynamic value) {
  if (value is LicenseStatus) return value;
  if (value is String) {
    try {
      // Try exact match first
      return LicenseStatus.values.firstWhere(
        (e) => e.name == value,
        orElse: () => LicenseStatus.active,
      );
    } catch (_) {
      return LicenseStatus.active;
    }
  }
  return LicenseStatus.active;
}
