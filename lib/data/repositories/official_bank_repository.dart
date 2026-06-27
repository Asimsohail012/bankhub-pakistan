import '../models/bank_profile.dart';

/// Sample official banking profiles for SBP-verified data foundation.
///
/// These are placeholder values to demonstrate the data structure.
/// In production, this data would be synchronized with SBP or official bank registries.
const List<BankProfile> _officialBankProfiles = [
  BankProfile(
    bankId: 'hbl',
    officialName: 'Habib Bank Limited',
    shortName: 'HBL',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-15',
    officialWebsite: 'https://www.hbl.com',
    officialEmail: 'support@hbl.com',
    helpline: '111-111-425',
    headOffice: 'HBL Tower, I.I. Chundrigar Road, Karachi',
    swiftCode: 'HABBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1941,
    branchCount: 1800,
    atmCount: 3500,
    supportsRaast: true,
    supportsRoshan: true,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-01T00:00:00Z',
  ),
  BankProfile(
    bankId: 'ubl',
    officialName: 'United Bank Limited',
    shortName: 'UBL',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-16',
    officialWebsite: 'https://www.ubldigital.com',
    officialEmail: 'support@ubl.com.pk',
    helpline: '111-825-888',
    headOffice: 'UBL Head Office, Karachi',
    swiftCode: 'UBLPPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1959,
    branchCount: 1400,
    atmCount: 2800,
    supportsRaast: true,
    supportsRoshan: false,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-02T00:00:00Z',
  ),
  BankProfile(
    bankId: 'meezan',
    officialName: 'Meezan Bank Limited',
    shortName: 'Meezan Bank',
    category: 'Islamic',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-17',
    officialWebsite: 'https://www.meezanbank.com',
    officialEmail: 'support@meezanbank.com',
    helpline: '111-331-331',
    headOffice: 'Meezan House, Karachi',
    swiftCode: 'MEZNPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2002,
    branchCount: 900,
    atmCount: 1900,
    supportsRaast: true,
    supportsRoshan: true,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: true,
    isDigital: false,
    lastUpdated: '2024-06-03T00:00:00Z',
  ),
  BankProfile(
    bankId: 'bank_alfalah',
    officialName: 'Bank Alfalah Limited',
    shortName: 'Bank Alfalah',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-18',
    officialWebsite: 'https://www.bankalfalah.com',
    officialEmail: 'support@bankalfalah.com',
    helpline: '111-225-225',
    headOffice: 'Karachi',
    swiftCode: 'ALFHPKKAXXX',
    ibanPrefix: 'PKXX',
    foundedYear: 1997,
    branchCount: 800,
    atmCount: 1600,
    supportsRaast: true,
    supportsRoshan: false,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-04T00:00:00Z',
  ),
  BankProfile(
    bankId: 'mcb',
    officialName: 'MCB Bank Limited',
    shortName: 'MCB',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-19',
    officialWebsite: 'https://www.mcb.com.pk',
    officialEmail: 'support@mcb.com.pk',
    helpline: '111-000-622',
    headOffice: 'MCB House, Lahore',
    swiftCode: 'MUCBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1947,
    branchCount: 2000,
    atmCount: 4000,
    supportsRaast: true,
    supportsRoshan: true,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-05T00:00:00Z',
  ),
  BankProfile(
    bankId: 'nbp',
    officialName: 'National Bank of Pakistan',
    shortName: 'NBP',
    category: 'Government',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-20',
    officialWebsite: 'https://www.nbp.com.pk',
    officialEmail: 'support@nbp.com.pk',
    helpline: '111-627-627',
    headOffice: 'NBP Building, Karachi',
    swiftCode: 'NBBPPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1949,
    branchCount: 1600,
    atmCount: 3200,
    supportsRaast: true,
    supportsRoshan: true,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: false,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-06T00:00:00Z',
  ),
  BankProfile(
    bankId: 'bank_islami',
    officialName: 'BankIslami Pakistan Limited',
    shortName: 'BankIslami',
    category: 'Islamic',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-21',
    officialWebsite: 'https://www.bankislami.com.pk',
    officialEmail: 'support@bankislami.com.pk',
    helpline: '021-111-000-786',
    headOffice: 'Karachi',
    swiftCode: 'BISSPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2006,
    branchCount: 500,
    atmCount: 1000,
    supportsRaast: true,
    supportsRoshan: false,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: true,
    isDigital: false,
    lastUpdated: '2024-06-07T00:00:00Z',
  ),
  BankProfile(
    bankId: 'faysal',
    officialName: 'Faysal Bank Limited',
    shortName: 'Faysal Bank',
    category: 'Islamic',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-22',
    officialWebsite: 'https://www.faysalbank.com',
    officialEmail: 'support@faysalbank.com',
    helpline: '111-001-002',
    headOffice: 'Karachi',
    swiftCode: 'FAYSRPKK',
    ibanPrefix: 'PKXX',
    foundedYear: 1987,
    branchCount: 700,
    atmCount: 1400,
    supportsRaast: true,
    supportsRoshan: true,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: true,
    isDigital: false,
    lastUpdated: '2024-06-08T00:00:00Z',
  ),
  BankProfile(
    bankId: 'allied',
    officialName: 'Allied Bank Limited',
    shortName: 'Allied Bank',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-23',
    officialWebsite: 'https://www.alliedbank.com.pk',
    officialEmail: 'support@alliedbank.com.pk',
    helpline: '111-425-425',
    headOffice: 'Karachi',
    swiftCode: 'ALIAPKKX',
    ibanPrefix: 'PKXX',
    foundedYear: 1942,
    branchCount: 600,
    atmCount: 1200,
    supportsRaast: true,
    supportsRoshan: false,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-09T00:00:00Z',
  ),
  BankProfile(
    bankId: 'js',
    officialName: 'JS Bank Limited',
    shortName: 'JS Bank',
    category: 'Commercial',
    licenseStatus: 'Active',
    sbpVerified: true,
    verificationDate: '2024-01-24',
    officialWebsite: 'https://www.jsbl.com',
    officialEmail: 'support@jsbl.com',
    helpline: '111-573-573',
    headOffice: 'Karachi',
    swiftCode: 'JSBKPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2006,
    branchCount: 400,
    atmCount: 800,
    supportsRaast: true,
    supportsRoshan: false,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    isIslamic: false,
    isDigital: false,
    lastUpdated: '2024-06-10T00:00:00Z',
  ),
];

/// Repository providing official SBP-verified banking data.
///
/// This is a read-only interface to support future integration with
/// SBP verification systems. All methods return immutable data.
///
/// Currently uses local sample profiles. In production, data would be
/// loaded from SBP APIs or official bank registries.
class OfficialBankRepository {
  const OfficialBankRepository();

  /// Returns all available official bank profiles.
  List<BankProfile> loadOfficialBanks() => List.unmodifiable(_officialBankProfiles);

  /// Returns a single bank by ID, or null if not found.
  BankProfile? getBank(String bankId) {
    try {
      return _officialBankProfiles.firstWhere((bank) => bank.bankId == bankId);
    } catch (_) {
      return null;
    }
  }

  /// Searches banks by name or short name (case-insensitive).
  List<BankProfile> searchBanks(String query) {
    if (query.trim().isEmpty) return loadOfficialBanks();
    final lower = query.toLowerCase();
    return _officialBankProfiles
        .where(
          (bank) =>
              bank.officialName.toLowerCase().contains(lower) ||
              bank.shortName.toLowerCase().contains(lower),
        )
        .toList();
  }

  /// Filters banks by category.
  List<BankProfile> filterByCategory(String category) {
    return _officialBankProfiles
        .where((bank) => bank.category == category)
        .toList();
  }

  /// Returns only Islamic banks.
  List<BankProfile> filterIslamic() {
    return _officialBankProfiles.where((bank) => bank.isIslamic).toList();
  }

  /// Returns only commercial banks.
  List<BankProfile> filterCommercial() {
    return _officialBankProfiles
        .where((bank) => bank.category == 'Commercial')
        .toList();
  }

  /// Returns banks sorted alphabetically by official name.
  List<BankProfile> sortAlphabetically() {
    final sorted = List<BankProfile>.from(_officialBankProfiles);
    sorted.sort((a, b) => a.officialName.compareTo(b.officialName));
    return sorted;
  }

  /// Returns only SBP-verified banks.
  List<BankProfile> getVerifiedBanks() {
    return _officialBankProfiles
        .where((bank) => bank.sbpVerified)
        .toList();
  }
}
