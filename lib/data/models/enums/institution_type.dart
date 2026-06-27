/// Institution type enumeration for SBP-recognized financial entities.
/// 
/// Supports all categories of financial institutions regulated or recognized
/// by the State Bank of Pakistan (SBP).
enum InstitutionType {
  /// Commercial Banks: Full-service banking with deposits, lending, and investments
  commercialBank,

  /// Islamic Banks: Sharia-compliant banking institutions
  islamicBank,

  /// Digital Banks: Banks operating primarily or exclusively online
  digitalBank,

  /// Microfinance Banks: Institutions providing microfinance services
  microfmanceBank,

  /// Development Finance Institutions: Specialized long-term financing institutions
  dfi,

  /// Foreign Banks: International banks operating in Pakistan with SBP approval
  foreignBank,

  /// Electronic Money Institutions: Non-bank entities providing payment services
  emi,

  /// Digital Wallet Providers: Mobile and digital payment wallet providers
  digitalWallet,
}

/// Extension on InstitutionType to get display name and properties
extension InstitutionTypeExtension on InstitutionType {
  /// Returns human-readable display name
  String get displayName {
    switch (this) {
      case InstitutionType.commercialBank:
        return 'Commercial Bank';
      case InstitutionType.islamicBank:
        return 'Islamic Bank';
      case InstitutionType.digitalBank:
        return 'Digital Bank';
      case InstitutionType.microfmanceBank:
        return 'Microfinance Bank';
      case InstitutionType.dfi:
        return 'Development Finance Institution';
      case InstitutionType.foreignBank:
        return 'Foreign Bank';
      case InstitutionType.emi:
        return 'Electronic Money Institution';
      case InstitutionType.digitalWallet:
        return 'Digital Wallet Provider';
    }
  }

  /// Returns description for the institution type
  String get description {
    switch (this) {
      case InstitutionType.commercialBank:
        return 'Full-service banking with comprehensive financial products';
      case InstitutionType.islamicBank:
        return 'Sharia-compliant banking services';
      case InstitutionType.digitalBank:
        return 'Online-first banking platform';
      case InstitutionType.microfmanceBank:
        return 'Microfinance services for underserved populations';
      case InstitutionType.dfi:
        return 'Specialized development financing';
      case InstitutionType.foreignBank:
        return 'International bank with Pakistan operations';
      case InstitutionType.emi:
        return 'Electronic payment and money services';
      case InstitutionType.digitalWallet:
        return 'Digital payment wallet services';
    }
  }
}
