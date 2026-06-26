/// Products offered by banks in Pakistan.
enum BankProduct {
  currentAccount,
  savingsAccount,
  islamicAccount,
  roshanDigitalAccount,
  debitCard,
  creditCard,
  homeFinance,
  autoFinance,
  personalFinance,
  smeBanking;

  String get displayName {
    switch (this) {
      case BankProduct.currentAccount:
        return 'Current Account';
      case BankProduct.savingsAccount:
        return 'Savings Account';
      case BankProduct.islamicAccount:
        return 'Islamic Account';
      case BankProduct.roshanDigitalAccount:
        return 'Roshan Digital Account';
      case BankProduct.debitCard:
        return 'Debit Card';
      case BankProduct.creditCard:
        return 'Credit Card';
      case BankProduct.homeFinance:
        return 'Home Finance';
      case BankProduct.autoFinance:
        return 'Auto Finance';
      case BankProduct.personalFinance:
        return 'Personal Finance';
      case BankProduct.smeBanking:
        return 'SME Banking';
    }
  }

  static BankProduct fromJson(String value) {
    return BankProduct.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BankProduct.currentAccount,
    );
  }

  String toJson() => name;
}
