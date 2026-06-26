import '../models/bank_category.dart';
import '../models/bank_model.dart';
import '../models/bank_product.dart';

/// Local sample data for initial five banks.
const List<PakBankModel> _sampleBanks = [
  PakBankModel(
    id: 'hbl',
    name: 'Habib Bank Limited',
    shortName: 'HBL',
    category: BankCategory.commercialBank,
    description:
        "Pakistan's largest bank by assets, with an extensive domestic "
        'and international network established in 1941.',
    website: 'https://www.hbl.com',
    helpline: '111-111-425',
    headOffice: 'HBL Tower, I.I. Chundrigar Road, Karachi',
    swiftCode: 'HABBPKKA',
    establishedYear: 1941,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.2,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.roshanDigitalAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  PakBankModel(
    id: 'ubl',
    name: 'United Bank Limited',
    shortName: 'UBL',
    category: BankCategory.commercialBank,
    description:
        'A major commercial bank founded in 1959, offering a broad range '
        'of retail, corporate, and digital banking services.',
    website: 'https://www.ubldigital.com',
    helpline: '111-825-888',
    headOffice: 'UBL Head Office, I.I. Chundrigar Road, Karachi',
    swiftCode: 'UBLPPKKA',
    establishedYear: 1959,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.0,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.roshanDigitalAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  PakBankModel(
    id: 'meezan',
    name: 'Meezan Bank Limited',
    shortName: 'Meezan Bank',
    category: BankCategory.islamicBank,
    description:
        "Pakistan's first and largest dedicated Islamic bank, providing "
        'a complete range of Shariah-compliant banking services since 2002.',
    website: 'https://www.meezanbank.com',
    helpline: '111-331-331',
    headOffice: 'Meezan House, C-25, Estate Avenue, SITE, Karachi',
    swiftCode: 'MEZNPKKA',
    establishedYear: 2002,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.4,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.roshanDigitalAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  PakBankModel(
    id: 'bank_alfalah',
    name: 'Bank Alfalah Limited',
    shortName: 'Bank Alfalah',
    category: BankCategory.commercialBank,
    description:
        'A leading commercial bank founded in 1997, known for innovation '
        'in digital banking and a wide product portfolio.',
    website: 'https://www.bankalfalah.com',
    helpline: '111-225-786',
    headOffice: 'B.A. Building, I.I. Chundrigar Road, Karachi',
    swiftCode: 'ALFHPKKAXXX',
    establishedYear: 1997,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.1,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.roshanDigitalAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  PakBankModel(
    id: 'mcb',
    name: 'MCB Bank Limited',
    shortName: 'MCB',
    category: BankCategory.commercialBank,
    description:
        'One of the oldest and most profitable commercial banks in Pakistan, '
        'established in 1947 with a strong retail banking presence.',
    website: 'https://www.mcb.com.pk',
    helpline: '111-000-622',
    headOffice: 'MCB House, 15 Main Gulberg, Lahore',
    swiftCode: 'MUCBPKKA',
    establishedYear: 1947,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.0,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.roshanDigitalAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
];

/// Repository providing access to Pakistan bank data.
///
/// Uses local sample data only — no API connections.
class PakistanBankRepository {
  const PakistanBankRepository();

  /// Returns all available banks.
  List<PakBankModel> getAllBanks() => List.unmodifiable(_sampleBanks);

  /// Returns the bank with the given [id], or null if not found.
  PakBankModel? getBankById(String id) {
    try {
      return _sampleBanks.firstWhere((bank) => bank.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Returns all banks whose [PakBankModel.name], [PakBankModel.shortName],
  /// or [PakBankModel.description] contain [query] (case-insensitive).
  List<PakBankModel> searchBanks(String query) {
    if (query.trim().isEmpty) return getAllBanks();
    final lower = query.toLowerCase();
    return _sampleBanks
        .where(
          (bank) =>
              bank.name.toLowerCase().contains(lower) ||
              bank.shortName.toLowerCase().contains(lower) ||
              bank.description.toLowerCase().contains(lower),
        )
        .toList();
  }
}
