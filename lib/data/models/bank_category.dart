/// Categories of banks operating in Pakistan.
enum BankCategory {
  commercialBank,
  islamicBank,
  digitalBank,
  governmentBank,
  microfinanceBank,
  developmentFinanceInstitution,
  foreignBank;

  String get displayName {
    switch (this) {
      case BankCategory.commercialBank:
        return 'Commercial Bank';
      case BankCategory.islamicBank:
        return 'Islamic Bank';
      case BankCategory.digitalBank:
        return 'Digital Bank';
      case BankCategory.governmentBank:
        return 'Government Bank';
      case BankCategory.microfinanceBank:
        return 'Microfinance Bank';
      case BankCategory.developmentFinanceInstitution:
        return 'Development Finance Institution (DFI)';
      case BankCategory.foreignBank:
        return 'Foreign Bank';
    }
  }

  static BankCategory fromJson(String value) {
    return BankCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BankCategory.commercialBank,
    );
  }

  String toJson() => name;
}
