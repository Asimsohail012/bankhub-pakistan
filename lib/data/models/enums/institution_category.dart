/// Institution regulatory category enumeration for SBP framework.
/// 
/// Categorizes financial institutions by regulatory status and classification
/// within Pakistan's banking and financial services ecosystem.
enum InstitutionCategory {
  /// Full-service commercial banking institutions
  commercial,

  /// Islamic banking and financial services
  islamic,

  /// Specialized long-term development financing
  development,

  /// Microfinance and financial inclusion services
  microfinance,

  /// Digital and technology-enabled financial services
  digital,

  /// International or foreign-owned institutions
  international,

  /// Payment and money transfer services
  payment,

  /// Investment and securities institutions
  investment,

  /// Other or unclassified financial institutions
  other,
}

/// Extension on InstitutionCategory to get display properties
extension InstitutionCategoryExtension on InstitutionCategory {
  /// Returns human-readable display name
  String get displayName {
    switch (this) {
      case InstitutionCategory.commercial:
        return 'Commercial';
      case InstitutionCategory.islamic:
        return 'Islamic';
      case InstitutionCategory.development:
        return 'Development Finance';
      case InstitutionCategory.microfinance:
        return 'Microfinance';
      case InstitutionCategory.digital:
        return 'Digital';
      case InstitutionCategory.international:
        return 'International';
      case InstitutionCategory.payment:
        return 'Payment Services';
      case InstitutionCategory.investment:
        return 'Investment';
      case InstitutionCategory.other:
        return 'Other';
    }
  }

  /// Returns description for the category
  String get description {
    switch (this) {
      case InstitutionCategory.commercial:
        return 'Full-service commercial banks';
      case InstitutionCategory.islamic:
        return 'Sharia-compliant institutions';
      case InstitutionCategory.development:
        return 'Long-term development financing';
      case InstitutionCategory.microfinance:
        return 'Microfinance and SME support';
      case InstitutionCategory.digital:
        return 'Digital and fintech solutions';
      case InstitutionCategory.international:
        return 'Foreign-owned institutions';
      case InstitutionCategory.payment:
        return 'Payment and money services';
      case InstitutionCategory.investment:
        return 'Investment and securities';
      case InstitutionCategory.other:
        return 'Other financial institutions';
    }
  }
}
