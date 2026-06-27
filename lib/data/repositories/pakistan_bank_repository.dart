import '../models/bank_category.dart';
import '../models/bank_model.dart';
import '../models/bank_product.dart';

/// Local data for all 19 banks. Sources: existing project data + publicly
/// available information. Fields marked 'Unavailable' could not be verified.
const List<PakBankModel> _sampleBanks = [
  // ── 1. HBL ───────────────────────────────────────────────────────────────
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
  // ── 2. UBL ───────────────────────────────────────────────────────────────
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
  // ── 3. Meezan Bank ───────────────────────────────────────────────────────
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
  // ── 4. Bank Alfalah ──────────────────────────────────────────────────────
  PakBankModel(
    id: 'bank_alfalah',
    name: 'Bank Alfalah Limited',
    shortName: 'Bank Alfalah',
    category: BankCategory.commercialBank,
    description:
        'A leading commercial bank founded in 1997, known for innovation '
        'in digital banking and a wide product portfolio.',
    website: 'https://www.bankalfalah.com',
    helpline: '111-225-225',
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
  // ── 5. MCB ───────────────────────────────────────────────────────────────
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
  // ── 6. Allied Bank ───────────────────────────────────────────────────────
  PakBankModel(
    id: 'allied',
    name: 'Allied Bank Limited',
    shortName: 'Allied Bank',
    category: BankCategory.commercialBank,
    description:
        'One of the first Muslim banks in the Indian subcontinent, '
        'Allied Bank has operated in Pakistan since 1942 with a wide '
        'branch network.',
    website: 'https://www.alliedbank.com.pk',
    helpline: '111-425-425',
    headOffice: 'Unavailable',
    swiftCode: 'Unavailable',
    establishedYear: 1942,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.9,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 7. Askari Bank ───────────────────────────────────────────────────────
  PakBankModel(
    id: 'askari',
    name: 'Askari Bank Limited',
    shortName: 'Askari Bank',
    category: BankCategory.commercialBank,
    description:
        'Established in 1991, Askari Bank offers a full range of '
        'commercial banking services with a strong digital offering.',
    website: 'https://www.askari-bank.com',
    helpline: '111-000-787',
    headOffice: 'Unavailable',
    swiftCode: 'Unavailable',
    establishedYear: 1991,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.9,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 8. Bank Al Habib ─────────────────────────────────────────────────────
  PakBankModel(
    id: 'bank_al_habib',
    name: 'Bank Al Habib Limited',
    shortName: 'Bank Al Habib',
    category: BankCategory.commercialBank,
    description:
        'A well-regarded commercial bank established in 1991, known for '
        'personalised service and a growing digital banking platform.',
    website: 'https://www.bankalhabib.com',
    helpline: '021-111-024-024',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1991,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.0,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 9. Faysal Bank ───────────────────────────────────────────────────────
  PakBankModel(
    id: 'faysal',
    name: 'Faysal Bank Limited',
    shortName: 'Faysal Bank',
    category: BankCategory.islamicBank,
    description:
        'A major bank that completed its full conversion to Islamic banking '
        'in 2023, offering a comprehensive Shariah-compliant product range.',
    website: 'https://www.faysalbank.com',
    helpline: '111-001-002',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1987,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.0,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 10. JS Bank ──────────────────────────────────────────────────────────
  PakBankModel(
    id: 'js',
    name: 'JS Bank Limited',
    shortName: 'JS Bank',
    category: BankCategory.commercialBank,
    description:
        'A modern commercial bank established in 2006, part of the JS Group, '
        'offering retail, corporate, and digital banking solutions.',
    website: 'https://www.jsbl.com',
    helpline: '111-573-573',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 2006,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.8,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 11. Soneri Bank ──────────────────────────────────────────────────────
  PakBankModel(
    id: 'soneri',
    name: 'Soneri Bank Limited',
    shortName: 'Soneri Bank',
    category: BankCategory.commercialBank,
    description:
        'Established in 1991, Soneri Bank provides diversified financial '
        'services with a focus on SME and agricultural banking.',
    website: 'https://www.soneribank.com',
    helpline: '021-111-666-888',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1991,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.8,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 12. BankIslami ───────────────────────────────────────────────────────
  PakBankModel(
    id: 'bank_islami',
    name: 'BankIslami Pakistan Limited',
    shortName: 'BankIslami',
    category: BankCategory.islamicBank,
    description:
        'A dedicated Islamic bank established in 2006, offering a full '
        'suite of Shariah-compliant products across Pakistan.',
    website: 'https://www.bankislami.com.pk',
    helpline: '021-111-000-786',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 2006,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.9,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.islamicAccount,
      BankProduct.debitCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 13. Standard Chartered Pakistan ─────────────────────────────────────
  PakBankModel(
    id: 'scb',
    name: 'Standard Chartered Bank Pakistan',
    shortName: 'Standard Chartered',
    category: BankCategory.foreignBank,
    description:
        'An international bank with a presence in Pakistan since 1863, '
        'offering premium retail and corporate banking services.',
    website: 'https://www.sc.com/pk',
    helpline: '111-002-002',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1863,
    mobileBanking: true,
    internetBanking: true,
    rating: 4.1,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 14. National Bank of Pakistan ────────────────────────────────────────
  PakBankModel(
    id: 'nbp',
    name: 'National Bank of Pakistan',
    shortName: 'NBP',
    category: BankCategory.governmentBank,
    description:
        'The largest government-owned bank in Pakistan, established in 1949, '
        'serving as the fiscal agent of the Government of Pakistan.',
    website: 'https://www.nbp.com.pk',
    helpline: '111-627-627',
    headOffice: 'NBP Building, I.I. Chundrigar Road, Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1949,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.7,
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
  // ── 15. Silkbank ─────────────────────────────────────────────────────────
  PakBankModel(
    id: 'silkbank',
    name: 'Silkbank Limited',
    shortName: 'Silkbank',
    category: BankCategory.commercialBank,
    description:
        'A commercial bank operating in Pakistan, focused on retail and '
        'consumer banking products.',
    website: 'https://www.silkbank.com.pk',
    helpline: '021-111-745-745',
    headOffice: 'Unavailable',
    swiftCode: 'Unavailable',
    establishedYear: 0,
    mobileBanking: true,
    internetBanking: true,
    rating: 3.5,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
      BankProduct.debitCard,
      BankProduct.creditCard,
      BankProduct.homeFinance,
      BankProduct.autoFinance,
      BankProduct.personalFinance,
    ],
  ),
  // ── 16. Mobilink Microfinance Bank ───────────────────────────────────────
  PakBankModel(
    id: 'mobilink_microfinance',
    name: 'Mobilink Microfinance Bank',
    shortName: 'Mobilink MFB',
    category: BankCategory.microfinanceBank,
    description:
        'A microfinance bank serving low-income segments in Pakistan, '
        'currently operating as U Microfinance Bank after rebranding.',
    website: 'https://www.umicrofinancebank.com',
    helpline: '021-111-522-522',
    headOffice: 'Unavailable',
    swiftCode: 'Unavailable',
    establishedYear: 2012,
    mobileBanking: true,
    internetBanking: false,
    rating: 3.5,
    products: [
      BankProduct.savingsAccount,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 17. Khushhali Microfinance Bank ──────────────────────────────────────
  PakBankModel(
    id: 'khushhali',
    name: 'Khushhali Microfinance Bank Limited',
    shortName: 'Khushhali MFB',
    category: BankCategory.microfinanceBank,
    description:
        'Established in 2000, Khushhali Microfinance Bank is one of the '
        'largest microfinance banks in Pakistan, serving rural and '
        'low-income populations.',
    website: 'https://www.khushhalibank.com.pk',
    helpline: '021-111-154-154',
    headOffice: 'Islamabad',
    swiftCode: 'Unavailable',
    establishedYear: 2000,
    mobileBanking: true,
    internetBanking: false,
    rating: 3.6,
    products: [
      BankProduct.savingsAccount,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 18. NRSP Microfinance Bank ───────────────────────────────────────────
  PakBankModel(
    id: 'nrsp',
    name: 'NRSP Microfinance Bank Limited',
    shortName: 'NRSP MFB',
    category: BankCategory.microfinanceBank,
    description:
        'NRSP Microfinance Bank commenced operations in 2011, providing '
        'financial services to underserved communities across Pakistan.',
    website: 'https://www.nrsp.com.pk',
    helpline: '111-900-900',
    headOffice: 'Islamabad',
    swiftCode: 'Unavailable',
    establishedYear: 2011,
    mobileBanking: false,
    internetBanking: false,
    rating: 3.4,
    products: [
      BankProduct.savingsAccount,
      BankProduct.personalFinance,
      BankProduct.smeBanking,
    ],
  ),
  // ── 19. First Women Bank ─────────────────────────────────────────────────
  PakBankModel(
    id: 'first_women_bank',
    name: 'First Women Bank Limited',
    shortName: 'FWBL',
    category: BankCategory.governmentBank,
    description:
        'Established in 1989, First Women Bank is a government-owned bank '
        'dedicated to empowering women through financial inclusion across '
        'Pakistan.',
    website: 'https://www.fwbl.com.pk',
    helpline: '021-111-234-111',
    headOffice: 'Karachi',
    swiftCode: 'Unavailable',
    establishedYear: 1989,
    mobileBanking: false,
    internetBanking: true,
    rating: 3.6,
    products: [
      BankProduct.currentAccount,
      BankProduct.savingsAccount,
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
