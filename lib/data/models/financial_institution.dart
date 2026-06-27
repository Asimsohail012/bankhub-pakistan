import 'enums/institution_type.dart';
import 'enums/institution_category.dart';
import 'enums/license_status.dart';
import 'bank_capability.dart';

/// Immutable financial institution model supporting all SBP-recognized entities.
///
/// This model represents banks, microfinance institutions, digital wallets,
/// EMIs, and other financial entities regulated or recognized by SBP.
///
/// Supports multiple institution types and comprehensive fintech features.
///
/// ## Field Source Metadata Architecture (Future-Ready)
///
/// This model is designed to support future source tracking metadata for each field.
/// While not populated in Phase 5 CP2, the architecture enables future implementation:
///
/// ### Planned Metadata Per Field (Phase 6+)
/// - **sourceName**: e.g., 'SBP Registry', 'Official Website', 'Public Database'
/// - **sourceUrl**: e.g., 'https://www.sbp.org.pk/institutions/registry'
/// - **dateRetrieved**: ISO 8601 timestamp of when data was fetched
/// - **lastVerifiedDate**: ISO 8601 timestamp of last verification
/// - **verificationStatus**: 'verified', 'unverified', 'pending', 'outdated'
///
/// ### Future Implementation Pattern
/// ```dart
/// class FieldSourceMetadata {
///   final String? sourceName;
///   final String? sourceUrl;
///   final DateTime? dateRetrieved;
///   final DateTime? lastVerifiedDate;
///   final String? verificationStatus;
/// }
///
/// class FinancialInstitutionWithSources extends FinancialInstitution {
///   final Map<String, FieldSourceMetadata>? fieldSources;
///   // Each field can have associated source metadata
/// }
/// ```
///
/// ### Current Fields (Phase 5 CP2)
/// All 42 fields currently support null safety for optional data and are ready
/// for future source metadata attachment without structural changes.
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

  /// SMS banking code or short code for banking via SMS (e.g., '425' for HBL).
  /// Null if institution doesn't support SMS banking.
  final String? smsBankingCode;

  /// WhatsApp banking phone number or contact (e.g., '+92-300-123-456').
  /// Null if institution doesn't support WhatsApp banking.
  final String? whatsappBankingPhone;

  /// URL to branch locator tool or page.
  /// Null if not available online.
  final String? branchLocatorUrl;

  /// URL to ATM locator tool or page.
  /// Null if not available online.
  final String? atmLocatorUrl;

  /// URL to credit cards page or product details.
  /// Null if no credit card products or information unavailable.
  final String? creditCardsUrl;

  /// URL to debit cards page or product details.
  /// Null if no debit card products or information unavailable.
  final String? debitCardsUrl;

  /// Social media links as key-value pairs (e.g., {'facebook': 'https://...', 'twitter': '...'}).
  /// Null if no social links available.
  final Map<String, String>? socialLinks;

  /// Customer care or support phone number (separate from helpline if different).
  /// Null if not available or same as helpline.
  final String? customerCarePhone;

  /// Customer care or support email address (separate from official email if different).
  /// Null if not available or same as officialEmail.
  final String? customerCareEmail;

  /// Official name in Urdu script for regional markets.
  /// Null if not available or not applicable.
  final String? urduName;

  /// Type of ownership (e.g., 'Government', 'Private', 'Foreign', 'Consortium').
  /// Null if classification not available.
  final String? ownershipType;

  /// Name of the Chief Executive Officer or Managing Director.
  /// Null if not publicly available.
  final String? ceoName;

  /// Name of the Chairman or Board President.
  /// Null if not publicly available.
  final String? chairmanName;

  /// Average customer rating on a 0-5 scale.
  /// Null if no ratings available.
  final double? rating;

  // ============================================================================
  // CATEGORY-SPECIFIC CAPABILITIES (Phase 5 CP3)
  // ============================================================================

  /// Commercial Banks: List of deposit products offered (e.g., Savings, Current, Fixed).
  /// Null if not applicable or not a commercial bank.
  final List<String>? depositProducts;

  /// Commercial Banks: Whether consumer finance products are offered.
  /// Null if not applicable or information unavailable.
  final bool? consumerFinanceOffered;

  /// Commercial Banks: Whether corporate banking services are offered.
  /// Null if not applicable or information unavailable.
  final bool? corporateBankingOffered;

  /// Commercial Banks: Whether SME banking services are offered.
  /// Null if not applicable or information unavailable.
  final bool? smeBankingOffered;

  /// Islamic Banks: List of Shariah board members or advisors.
  /// Null if not applicable or not an Islamic bank.
  final List<String>? shariaBoard;

  /// Islamic Banks: List of Islamic product types (Murabaha, Ijara, Sukuk, etc.).
  /// Null if not applicable or not an Islamic bank.
  final List<String>? islamicProductTypes;

  /// Islamic Banks: Whether Takaful (Islamic insurance) products are offered.
  /// Null if not applicable or information unavailable.
  final bool? takafulOffered;

  /// Islamic Banks: Whether Islamic credit cards are offered.
  /// Null if not applicable or information unavailable.
  final bool? islamicCardsOffered;

  /// Digital Banks: URL for digital onboarding process or documentation.
  /// Null if not available or not a digital bank.
  final String? digitalOnboardingUrl;

  /// Digital Banks: Whether eKYC (electronic Know Your Customer) is required.
  /// Null if not applicable or information unavailable.
  final bool? eKycRequired;

  /// Digital Banks: Whether virtual cards are offered.
  /// Null if not applicable or information unavailable.
  final bool? virtualCardsOffered;

  /// Digital Banks: URL with detailed wallet/digital features documentation.
  /// Null if not available or not a digital bank.
  final String? walletFeaturesUrl;

  /// Microfinance: List of micro loan product types (Group Loans, Individual, etc.).
  /// Null if not applicable or not a microfinance institution.
  final List<String>? microLoanProducts;

  /// Microfinance: Whether rural finance programs are available.
  /// Null if not applicable or information unavailable.
  final bool? ruralFinanceOffered;

  /// Microfinance: Whether women-focused banking programs are available.
  /// Null if not applicable or information unavailable.
  final bool? womenBankingOffered;

  /// DFI (Development Finance Institutions): List of development programs offered.
  /// Null if not applicable or not a DFI.
  final List<String>? developmentPrograms;

  /// DFI: Whether agricultural finance products are offered.
  /// Null if not applicable or information unavailable.
  final bool? agriculturalFinanceOffered;

  /// Payment Systems & EMI: URL for payment gateway or merchant portal.
  /// Null if not applicable or not a payment system.
  final String? paymentGatewayUrl;

  /// Payment Systems & EMI: URL for merchant services documentation.
  /// Null if not applicable or not a payment system.
  final String? merchantServicesUrl;

  // ============================================================================
  // FUTURE SBP DATA INTEGRATION (Phase 6+)
  // ============================================================================

  /// SBP Reference ID: Official State Bank identifier in future integrations.
  /// Used for cross-referencing with official SBP registry.
  /// Null if not yet assigned or not integrated with SBP.
  final String? sbpReferenceId;

  /// Official Category Code: SBP's official classification code for future use.
  /// Enables standardized category mapping in automated integrations.
  /// Null if not yet assigned or code not available.
  final String? officialCategoryCode;

  /// API Mapping Key: Future reference key for SBP API integrations.
  /// Placeholder for Phase 6+ API synchronization architecture.
  /// Null if not yet defined or no API mapping exists.
  final String? apiMappingKey;

  /// Source Metadata: Placeholder for tracking data source and verification status (Phase 6+).
  /// Structure prepared for future implementation:
  /// ```dart
  /// {
  ///   'sourceName': 'SBP Registry',
  ///   'sourceUrl': 'https://...',
  ///   'dateRetrieved': '2024-06-27T...',
  ///   'verificationStatus': 'verified'
  /// }
  /// ```
  /// Null if not yet populated or source tracking not implemented.
  final Map<String, dynamic>? sourceMetadata;

  // ============================================================================
  // CAPABILITY MATRICES (Phase 5 CP4)
  // ============================================================================
  // Each category contains a list of BankCapability objects with optional
  // metadata for future Phase 6+ SBP integration and source tracking.
  // All lists are optional and null-safe for backward compatibility.

  /// Account Products & Services
  /// Examples: Current Account, Savings Account, Islamic Account, Fixed Deposits
  final List<BankCapability>? accountCapabilities;

  /// Card Products & Services
  /// Examples: Credit Card, Debit Card, Virtual Card, Prepaid Card
  final List<BankCapability>? cardCapabilities;

  /// Digital Banking & Online Services
  /// Examples: Internet Banking, Mobile Banking, Digital Onboarding, eKYC
  final List<BankCapability>? digitalBankingCapabilities;

  /// Payment & Transfer Services
  /// Examples: RAAST, QR Payments, Mobile Transfers, Bill Payments, SWIFT
  final List<BankCapability>? paymentCapabilities;

  /// Financing & Lending Products
  /// Examples: Home Loan, Auto Loan, Personal Loan, Business Loan, SME Financing
  final List<BankCapability>? financingCapabilities;

  /// Islamic Banking Products & Services
  /// Examples: Murabaha, Ijara, Sukuk, Takaful, Islamic Cards, Halal Investment
  final List<BankCapability>? islamicBankingCapabilities;

  /// Overseas Pakistanis & NRV Services
  /// Examples: Roshan Digital Account, NRV Account, Remittance to Pakistan
  final List<BankCapability>? overseasPakistanisCapabilities;

  /// Remittance & Money Transfer Services
  /// Examples: Inbound Remittance, Outbound Remittance, Express Transfer
  final List<BankCapability>? remittanceCapabilities;

  /// Branch & ATM Services
  /// Examples: Branch Banking, ATM Services, Extended Counters, Service Centers
  final List<BankCapability>? branchServiceCapabilities;

  /// Customer Support & Service Channels
  /// Examples: Call Center, Email Support, Live Chat, Social Media Support, SMS Banking
  final List<BankCapability>? customerSupportCapabilities;

  /// Security & Data Protection
  /// Examples: SSL Encryption, 2FA, Biometric Authentication, Data Privacy, Fraud Protection
  final List<BankCapability>? securityCapabilities;

  /// Investment & Wealth Management Services
  /// Examples: Stocks, Mutual Funds, Bonds, Gold Trading, Insurance Products
  final List<BankCapability>? investmentCapabilities;

  /// SME & Business Services
  /// Examples: Business Account, Trade Finance, Payroll Services, Business Loans
  final List<BankCapability>? smeServicesCapabilities;

  /// Corporate Banking Services
  /// Examples: Corporate Lending, Cash Management, Treasury Services, M&A Advisory
  final List<BankCapability>? corporateBankingCapabilities;

  /// Agriculture & Rural Banking Services
  /// Examples: Agricultural Loans, Crop Insurance, Rural Finance, Livestock Financing
  final List<BankCapability>? agricultureCapabilities;

  /// Treasury & Foreign Exchange Services
  /// Examples: Forex Trading, Currency Exchange, Derivatives, Bond Trading
  final List<BankCapability>? treasuryCapabilities;

  /// Trade Finance Services
  /// Examples: Letters of Credit, Bank Guarantees, Trade Facilitation, Import/Export Financing
  final List<BankCapability>? tradeFinanceCapabilities;

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
    this.smsBankingCode,
    this.whatsappBankingPhone,
    this.branchLocatorUrl,
    this.atmLocatorUrl,
    this.creditCardsUrl,
    this.debitCardsUrl,
    this.socialLinks,
    this.customerCarePhone,
    this.customerCareEmail,
    this.urduName,
    this.ownershipType,
    this.ceoName,
    this.chairmanName,
    this.rating,
    // Category-specific capabilities (CP3)
    this.depositProducts,
    this.consumerFinanceOffered,
    this.corporateBankingOffered,
    this.smeBankingOffered,
    this.shariaBoard,
    this.islamicProductTypes,
    this.takafulOffered,
    this.islamicCardsOffered,
    this.digitalOnboardingUrl,
    this.eKycRequired,
    this.virtualCardsOffered,
    this.walletFeaturesUrl,
    this.microLoanProducts,
    this.ruralFinanceOffered,
    this.womenBankingOffered,
    this.developmentPrograms,
    this.agriculturalFinanceOffered,
    this.paymentGatewayUrl,
    this.merchantServicesUrl,
    // Future SBP integration (Phase 6+)
    this.sbpReferenceId,
    this.officialCategoryCode,
    this.apiMappingKey,
    this.sourceMetadata,
    // Capability matrices (CP4)
    this.accountCapabilities,
    this.cardCapabilities,
    this.digitalBankingCapabilities,
    this.paymentCapabilities,
    this.financingCapabilities,
    this.islamicBankingCapabilities,
    this.overseasPakistanisCapabilities,
    this.remittanceCapabilities,
    this.branchServiceCapabilities,
    this.customerSupportCapabilities,
    this.securityCapabilities,
    this.investmentCapabilities,
    this.smeServicesCapabilities,
    this.corporateBankingCapabilities,
    this.agricultureCapabilities,
    this.treasuryCapabilities,
    this.tradeFinanceCapabilities,
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
    String? smsBankingCode,
    String? whatsappBankingPhone,
    String? branchLocatorUrl,
    String? atmLocatorUrl,
    String? creditCardsUrl,
    String? debitCardsUrl,
    Map<String, String>? socialLinks,
    String? customerCarePhone,
    String? customerCareEmail,
    String? urduName,
    String? ownershipType,
    String? ceoName,
    String? chairmanName,
    double? rating,
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
    // Category-specific capabilities (CP3)
    List<String>? depositProducts,
    bool? consumerFinanceOffered,
    bool? corporateBankingOffered,
    bool? smeBankingOffered,
    List<String>? shariaBoard,
    List<String>? islamicProductTypes,
    bool? takafulOffered,
    bool? islamicCardsOffered,
    String? digitalOnboardingUrl,
    bool? eKycRequired,
    bool? virtualCardsOffered,
    String? walletFeaturesUrl,
    List<String>? microLoanProducts,
    bool? ruralFinanceOffered,
    bool? womenBankingOffered,
    List<String>? developmentPrograms,
    bool? agriculturalFinanceOffered,
    String? paymentGatewayUrl,
    String? merchantServicesUrl,
    // Future SBP integration (Phase 6+)
    String? sbpReferenceId,
    String? officialCategoryCode,
    String? apiMappingKey,
    Map<String, dynamic>? sourceMetadata,
    // Capability matrices (CP4)
    List<BankCapability>? accountCapabilities,
    List<BankCapability>? cardCapabilities,
    List<BankCapability>? digitalBankingCapabilities,
    List<BankCapability>? paymentCapabilities,
    List<BankCapability>? financingCapabilities,
    List<BankCapability>? islamicBankingCapabilities,
    List<BankCapability>? overseasPakistanisCapabilities,
    List<BankCapability>? remittanceCapabilities,
    List<BankCapability>? branchServiceCapabilities,
    List<BankCapability>? customerSupportCapabilities,
    List<BankCapability>? securityCapabilities,
    List<BankCapability>? investmentCapabilities,
    List<BankCapability>? smeServicesCapabilities,
    List<BankCapability>? corporateBankingCapabilities,
    List<BankCapability>? agricultureCapabilities,
    List<BankCapability>? treasuryCapabilities,
    List<BankCapability>? tradeFinanceCapabilities,
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
      smsBankingCode: smsBankingCode ?? this.smsBankingCode,
      whatsappBankingPhone: whatsappBankingPhone ?? this.whatsappBankingPhone,
      branchLocatorUrl: branchLocatorUrl ?? this.branchLocatorUrl,
      atmLocatorUrl: atmLocatorUrl ?? this.atmLocatorUrl,
      creditCardsUrl: creditCardsUrl ?? this.creditCardsUrl,
      debitCardsUrl: debitCardsUrl ?? this.debitCardsUrl,
      socialLinks: socialLinks ?? this.socialLinks,
      customerCarePhone: customerCarePhone ?? this.customerCarePhone,
      customerCareEmail: customerCareEmail ?? this.customerCareEmail,
      urduName: urduName ?? this.urduName,
      ownershipType: ownershipType ?? this.ownershipType,
      ceoName: ceoName ?? this.ceoName,
      chairmanName: chairmanName ?? this.chairmanName,
      rating: rating ?? this.rating,
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
      // Category-specific capabilities (CP3)
      depositProducts: depositProducts ?? this.depositProducts,
      consumerFinanceOffered: consumerFinanceOffered ?? this.consumerFinanceOffered,
      corporateBankingOffered: corporateBankingOffered ?? this.corporateBankingOffered,
      smeBankingOffered: smeBankingOffered ?? this.smeBankingOffered,
      shariaBoard: shariaBoard ?? this.shariaBoard,
      islamicProductTypes: islamicProductTypes ?? this.islamicProductTypes,
      takafulOffered: takafulOffered ?? this.takafulOffered,
      islamicCardsOffered: islamicCardsOffered ?? this.islamicCardsOffered,
      digitalOnboardingUrl: digitalOnboardingUrl ?? this.digitalOnboardingUrl,
      eKycRequired: eKycRequired ?? this.eKycRequired,
      virtualCardsOffered: virtualCardsOffered ?? this.virtualCardsOffered,
      walletFeaturesUrl: walletFeaturesUrl ?? this.walletFeaturesUrl,
      microLoanProducts: microLoanProducts ?? this.microLoanProducts,
      ruralFinanceOffered: ruralFinanceOffered ?? this.ruralFinanceOffered,
      womenBankingOffered: womenBankingOffered ?? this.womenBankingOffered,
      developmentPrograms: developmentPrograms ?? this.developmentPrograms,
      agriculturalFinanceOffered: agriculturalFinanceOffered ?? this.agriculturalFinanceOffered,
      paymentGatewayUrl: paymentGatewayUrl ?? this.paymentGatewayUrl,
      merchantServicesUrl: merchantServicesUrl ?? this.merchantServicesUrl,
      // Future SBP integration (Phase 6+)
      sbpReferenceId: sbpReferenceId ?? this.sbpReferenceId,
      officialCategoryCode: officialCategoryCode ?? this.officialCategoryCode,
      apiMappingKey: apiMappingKey ?? this.apiMappingKey,
      sourceMetadata: sourceMetadata ?? this.sourceMetadata,
      // Capability matrices (CP4)
      accountCapabilities: accountCapabilities ?? this.accountCapabilities,
      cardCapabilities: cardCapabilities ?? this.cardCapabilities,
      digitalBankingCapabilities: digitalBankingCapabilities ?? this.digitalBankingCapabilities,
      paymentCapabilities: paymentCapabilities ?? this.paymentCapabilities,
      financingCapabilities: financingCapabilities ?? this.financingCapabilities,
      islamicBankingCapabilities: islamicBankingCapabilities ?? this.islamicBankingCapabilities,
      overseasPakistanisCapabilities: overseasPakistanisCapabilities ?? this.overseasPakistanisCapabilities,
      remittanceCapabilities: remittanceCapabilities ?? this.remittanceCapabilities,
      branchServiceCapabilities: branchServiceCapabilities ?? this.branchServiceCapabilities,
      customerSupportCapabilities: customerSupportCapabilities ?? this.customerSupportCapabilities,
      securityCapabilities: securityCapabilities ?? this.securityCapabilities,
      investmentCapabilities: investmentCapabilities ?? this.investmentCapabilities,
      smeServicesCapabilities: smeServicesCapabilities ?? this.smeServicesCapabilities,
      corporateBankingCapabilities: corporateBankingCapabilities ?? this.corporateBankingCapabilities,
      agricultureCapabilities: agricultureCapabilities ?? this.agricultureCapabilities,
      treasuryCapabilities: treasuryCapabilities ?? this.treasuryCapabilities,
      tradeFinanceCapabilities: tradeFinanceCapabilities ?? this.tradeFinanceCapabilities,
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
      'smsBankingCode': smsBankingCode,
      'whatsappBankingPhone': whatsappBankingPhone,
      'branchLocatorUrl': branchLocatorUrl,
      'atmLocatorUrl': atmLocatorUrl,
      'creditCardsUrl': creditCardsUrl,
      'debitCardsUrl': debitCardsUrl,
      'socialLinks': socialLinks,
      'customerCarePhone': customerCarePhone,
      'customerCareEmail': customerCareEmail,
      'urduName': urduName,
      'ownershipType': ownershipType,
      'ceoName': ceoName,
      'chairmanName': chairmanName,
      'rating': rating,
      // Category-specific capabilities (CP3)
      'depositProducts': depositProducts,
      'consumerFinanceOffered': consumerFinanceOffered,
      'corporateBankingOffered': corporateBankingOffered,
      'smeBankingOffered': smeBankingOffered,
      'shariaBoard': shariaBoard,
      'islamicProductTypes': islamicProductTypes,
      'takafulOffered': takafulOffered,
      'islamicCardsOffered': islamicCardsOffered,
      'digitalOnboardingUrl': digitalOnboardingUrl,
      'eKycRequired': eKycRequired,
      'virtualCardsOffered': virtualCardsOffered,
      'walletFeaturesUrl': walletFeaturesUrl,
      'microLoanProducts': microLoanProducts,
      'ruralFinanceOffered': ruralFinanceOffered,
      'womenBankingOffered': womenBankingOffered,
      'developmentPrograms': developmentPrograms,
      'agriculturalFinanceOffered': agriculturalFinanceOffered,
      'paymentGatewayUrl': paymentGatewayUrl,
      'merchantServicesUrl': merchantServicesUrl,
      // Future SBP integration (Phase 6+)
      'sbpReferenceId': sbpReferenceId,
      'officialCategoryCode': officialCategoryCode,
      'apiMappingKey': apiMappingKey,
      'sourceMetadata': sourceMetadata,
      // Capability matrices (CP4)
      'accountCapabilities': accountCapabilities?.map((c) => c.toJson()).toList(),
      'cardCapabilities': cardCapabilities?.map((c) => c.toJson()).toList(),
      'digitalBankingCapabilities': digitalBankingCapabilities?.map((c) => c.toJson()).toList(),
      'paymentCapabilities': paymentCapabilities?.map((c) => c.toJson()).toList(),
      'financingCapabilities': financingCapabilities?.map((c) => c.toJson()).toList(),
      'islamicBankingCapabilities': islamicBankingCapabilities?.map((c) => c.toJson()).toList(),
      'overseasPakistanisCapabilities': overseasPakistanisCapabilities?.map((c) => c.toJson()).toList(),
      'remittanceCapabilities': remittanceCapabilities?.map((c) => c.toJson()).toList(),
      'branchServiceCapabilities': branchServiceCapabilities?.map((c) => c.toJson()).toList(),
      'customerSupportCapabilities': customerSupportCapabilities?.map((c) => c.toJson()).toList(),
      'securityCapabilities': securityCapabilities?.map((c) => c.toJson()).toList(),
      'investmentCapabilities': investmentCapabilities?.map((c) => c.toJson()).toList(),
      'smeServicesCapabilities': smeServicesCapabilities?.map((c) => c.toJson()).toList(),
      'corporateBankingCapabilities': corporateBankingCapabilities?.map((c) => c.toJson()).toList(),
      'agricultureCapabilities': agricultureCapabilities?.map((c) => c.toJson()).toList(),
      'treasuryCapabilities': treasuryCapabilities?.map((c) => c.toJson()).toList(),
      'tradeFinanceCapabilities': tradeFinanceCapabilities?.map((c) => c.toJson()).toList(),
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
      smsBankingCode: json['smsBankingCode'] as String?,
      whatsappBankingPhone: json['whatsappBankingPhone'] as String?,
      branchLocatorUrl: json['branchLocatorUrl'] as String?,
      atmLocatorUrl: json['atmLocatorUrl'] as String?,
      creditCardsUrl: json['creditCardsUrl'] as String?,
      debitCardsUrl: json['debitCardsUrl'] as String?,
      socialLinks: json['socialLinks'] != null
          ? Map<String, String>.from(json['socialLinks'] as Map)
          : null,
      customerCarePhone: json['customerCarePhone'] as String?,
      customerCareEmail: json['customerCareEmail'] as String?,
      urduName: json['urduName'] as String?,
      ownershipType: json['ownershipType'] as String?,
      ceoName: json['ceoName'] as String?,
      chairmanName: json['chairmanName'] as String?,
      rating: json['rating'] as double?,
      // Category-specific capabilities (CP3)
      depositProducts: List<String>.from(json['depositProducts'] as List? ?? []),
      consumerFinanceOffered: json['consumerFinanceOffered'] as bool?,
      corporateBankingOffered: json['corporateBankingOffered'] as bool?,
      smeBankingOffered: json['smeBankingOffered'] as bool?,
      shariaBoard: List<String>.from(json['shariaBoard'] as List? ?? []),
      islamicProductTypes: List<String>.from(json['islamicProductTypes'] as List? ?? []),
      takafulOffered: json['takafulOffered'] as bool?,
      islamicCardsOffered: json['islamicCardsOffered'] as bool?,
      digitalOnboardingUrl: json['digitalOnboardingUrl'] as String?,
      eKycRequired: json['eKycRequired'] as bool?,
      virtualCardsOffered: json['virtualCardsOffered'] as bool?,
      walletFeaturesUrl: json['walletFeaturesUrl'] as String?,
      microLoanProducts: List<String>.from(json['microLoanProducts'] as List? ?? []),
      ruralFinanceOffered: json['ruralFinanceOffered'] as bool?,
      womenBankingOffered: json['womenBankingOffered'] as bool?,
      developmentPrograms: List<String>.from(json['developmentPrograms'] as List? ?? []),
      agriculturalFinanceOffered: json['agriculturalFinanceOffered'] as bool?,
      paymentGatewayUrl: json['paymentGatewayUrl'] as String?,
      merchantServicesUrl: json['merchantServicesUrl'] as String?,
      // Future SBP integration (Phase 6+)
      sbpReferenceId: json['sbpReferenceId'] as String?,
      officialCategoryCode: json['officialCategoryCode'] as String?,
      apiMappingKey: json['apiMappingKey'] as String?,
      sourceMetadata: json['sourceMetadata'] as Map<String, dynamic>?,
      // Capability matrices (CP4)
      accountCapabilities: (json['accountCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      cardCapabilities: (json['cardCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      digitalBankingCapabilities: (json['digitalBankingCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      paymentCapabilities: (json['paymentCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      financingCapabilities: (json['financingCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      islamicBankingCapabilities: (json['islamicBankingCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      overseasPakistanisCapabilities: (json['overseasPakistanisCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      remittanceCapabilities: (json['remittanceCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      branchServiceCapabilities: (json['branchServiceCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      customerSupportCapabilities: (json['customerSupportCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      securityCapabilities: (json['securityCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      investmentCapabilities: (json['investmentCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      smeServicesCapabilities: (json['smeServicesCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      corporateBankingCapabilities: (json['corporateBankingCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      agricultureCapabilities: (json['agricultureCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      treasuryCapabilities: (json['treasuryCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
      tradeFinanceCapabilities: (json['tradeFinanceCapabilities'] as List?)?.map((c) => BankCapability.fromJson(c as Map<String, dynamic>)).toList(),
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
