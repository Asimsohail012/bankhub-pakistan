import '../models/financial_institution.dart';
import '../models/enums/institution_type.dart';
import '../models/enums/institution_category.dart';
import '../models/enums/license_status.dart';
import '../../services/live_data/api_cache_service.dart';
import 'i_financial_institution_repository.dart';

/// Sample SBP-recognized financial institutions for initial data foundation.
///
/// Includes commercial banks, Islamic banks, microfinance institutions,
/// and digital wallet providers. These are placeholder values to demonstrate
/// the data structure. In production, data would be synchronized with SBP registries.
const List<FinancialInstitution> _financialInstitutions = [
  FinancialInstitution(
    institutionId: 'hbl',
    officialName: 'Habib Bank Limited',
    shortName: 'HBL',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-15',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.hbl.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.habibbank.hblmobile',
    officialEmail: 'support@hbl.com',
    helpline: '111-111-425',
    headOffice: 'HBL Tower, I.I. Chundrigar Road, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'HABBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1941,
    branchCount: 1800,
    atmCount: 3500,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Leading commercial bank with comprehensive digital banking services including Islamic banking',
    products: ['Current Account', 'Savings Account', 'Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Financing', 'Islamic Trade Finance', 'Debit Card', 'Islamic Debit Card', 'Credit Card', 'Islamic Credit Card', 'Loans', 'Islamic Project Financing'],
    services: ['Foreign Remittance', 'Islamic Remittance', 'Trade Finance', 'Islamic Trade Finance', 'Investment Advisory', 'Halal Investment Advisory', 'Takaful', 'Shariah Compliance Verification'],
    keywords: ['banking', 'credit', 'savings', 'digital', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: ['United Kingdom', 'United States', 'Middle East', 'Asia'],
  ),
  FinancialInstitution(
    institutionId: 'meezan',
    officialName: 'Meezan Bank Limited',
    shortName: 'Meezan Bank',
    institutionType: InstitutionType.islamicBank,
    category: InstitutionCategory.islamic,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-17',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.meezanbank.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.meezanbank.mobile',
    officialEmail: 'support@meezanbank.com',
    helpline: '111-331-331',
    headOffice: 'Meezan House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'MEZNPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2002,
    branchCount: 900,
    atmCount: 1900,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Pakistan\'s leading Islamic banking institution',
    products: ['Islamic Current Account', 'Islamic Savings', 'Murabaha Financing', 'Takaful'],
    services: ['Halal Investment', 'Islamic Trade Finance'],
    keywords: ['islamic', 'sharia', 'halal', 'banking'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'bank_alfalah',
    officialName: 'Bank Alfalah Limited',
    shortName: 'Bank Alfalah',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-18',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.bankalfalah.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.bankalfalah.bankalfalah',
    officialEmail: 'support@bankalfalah.com',
    helpline: '111-225-225',
    headOffice: 'Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'ALFHPKKAXXX',
    ibanPrefix: 'PKXX',
    foundedYear: 1997,
    branchCount: 800,
    atmCount: 1600,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Progressive commercial bank with focus on retail banking and Islamic banking services',
    products: ['Checking Account', 'Islamic Current Account', 'Savings Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Financing', 'Islamic Auto Finance', 'Islamic Home Finance', 'Debit Card', 'Islamic Debit Card', 'Personal Loan', 'Islamic Personal Finance'],
    services: ['Bill Payment', 'Islamic Bill Payment', 'Remittance', 'Islamic Remittance', 'Investment', 'Halal Investment', 'Takaful', 'Shariah Board Advisory'],
    keywords: ['banking', 'savings', 'personal finance', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // PHASE 6 CP3 BATCH 1 - UNITED BANK LIMITED (NEW ADDITION)
  // ============================================================================
  FinancialInstitution(
    institutionId: 'ubl',
    officialName: 'United Bank Limited',
    shortName: 'UBL',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-06-27',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.ubl.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.ubl.ublandroid',
    officialEmail: 'customercare@ubl.com.pk',
    helpline: '111-825-825',
    headOffice: 'UBL House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'UBBLPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1959,
    branchCount: 1500,
    atmCount: 2500,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Progressive commercial bank with strong corporate and SME focus, offering Islamic banking through UBL Ameen',
    products: ['Current Account', 'UBL Ameen Islamic Current Account', 'Savings Account', 'UBL Ameen Islamic Savings', 'Islamic Term Deposit', 'Murabaha Financing', 'Islamic Trade Finance', 'Islamic Business Loans', 'Credit Card', 'Islamic Credit Card', 'Business Loans', 'Islamic SME Financing'],
    services: ['Trade Finance', 'Islamic Trade Finance', 'Remittance', 'Islamic Remittance', 'Corporate Services', 'Islamic Corporate Banking', 'Takaful Services', 'Shariah Compliance'],
    keywords: ['bank', 'commercial', 'corporate', 'finance', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: ['United Kingdom', 'United Arab Emirates', 'Middle East'],
  ),
  FinancialInstitution(
    institutionId: 'mobilink_mfb',
    officialName: 'Mobilink Microfinance Bank Limited',
    shortName: 'Mobilink MFB',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-10',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.mobilinkbank.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.mobilinkbank.mobile',
    officialEmail: 'support@mobilinkbank.com',
    helpline: '111-877-877',
    headOffice: 'Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'BMLNPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2009,
    branchCount: 250,
    atmCount: 500,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Microfinance bank providing financial services to underserved populations',
    products: ['Savings Account', 'Microfinance Loan', 'Business Account'],
    services: ['Microfinance', 'Financial Inclusion', 'SME Support'],
    keywords: ['microfinance', 'small business', 'digital banking'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'easypaisa',
    officialName: 'Easypaisa (Telenor Microfinance Bank)',
    shortName: 'Easypaisa',
    institutionType: InstitutionType.digitalWallet,
    category: InstitutionCategory.digital,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-03-01',
    lastUpdated: '2024-06-06T00:00:00Z',
    officialWebsite: 'https://www.easypaisa.com.pk',
    officialEmail: 'support@easypaisa.com.pk',
    helpline: '*700#',
    headOffice: 'Karachi',
    swiftCode: 'TMFBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2009,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: false,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Digital wallet and mobile money platform with extensive network',
    products: ['Digital Wallet', 'Mobile Money', 'Bill Payment'],
    services: ['Money Transfer', 'Utility Bill Payment', 'Merchant Services'],
    keywords: ['digital wallet', 'mobile money', 'payments', 'fintech'],
  ),
  FinancialInstitution(
    institutionId: 'nayapay',
    officialName: 'NayaPay',
    shortName: 'NayaPay',
    institutionType: InstitutionType.digitalWallet,
    category: InstitutionCategory.digital,
    licenseStatus: LicenseStatus.active,
    sbpVerified: false,
    verificationDate: null,
    lastUpdated: '2024-06-07T00:00:00Z',
    officialWebsite: 'https://www.nayapay.com',
    officialEmail: 'support@nayapay.com',
    helpline: 'TBD',
    headOffice: 'Karachi',
    swiftCode: 'TBD',
    ibanPrefix: 'PKXX',
    foundedYear: 2019,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: false,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Digital payment platform focused on convenience and accessibility',
    products: ['Digital Wallet', 'Payment Gateway', 'Money Transfer'],
    services: ['Payments', 'Bill Settlement', 'Merchant Integration'],
    keywords: ['digital', 'payments', 'fintech', 'wallet'],
  ),
  // ============================================================================
  // EXTENDED SBP DIRECTORY - ADDITIONAL COMMERCIAL BANKS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'mcb',
    officialName: 'MCB Bank Limited',
    shortName: 'MCB',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-20',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.mcb.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.mcbmobile.android',
    officialEmail: 'info@mcb.com.pk',
    helpline: '111-000-622',
    headOffice: 'MCB House, Lahore',
    city: 'Lahore',
    province: 'Punjab',
    country: 'Pakistan',
    swiftCode: 'MUCBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1947,
    branchCount: 2000,
    atmCount: 4000,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Largest private sector commercial bank with nationwide presence and comprehensive Islamic banking services',
    products: ['Current Account', 'Islamic Current Account', 'Savings Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Auto Finance', 'Murabaha Home Finance', 'Islamic Project Finance', 'Credit Cards', 'Islamic Credit Card', 'Loans', 'Islamic Corporate Financing'],
    services: ['Trade Finance', 'Islamic Trade Finance', 'Investment Advisory', 'Islamic Investment Advisory', 'Remittance', 'Islamic Remittance', 'Takaful', 'Shariah Compliance Services'],
    keywords: ['bank', 'commercial', 'finance', 'digital', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'nbp',
    officialName: 'National Bank of Pakistan',
    shortName: 'NBP',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-21',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.nbp.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.nbp.nbpmobile',
    officialEmail: 'customer.care@nbp.com.pk',
    helpline: '111-627-627',
    headOffice: 'NBP Building, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'NBBPPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1949,
    branchCount: 1600,
    atmCount: 3200,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'State-owned commercial bank with extensive branch network and comprehensive Islamic banking support including NBP Islamic branches',
    products: ['Savings Account', 'Current Account', 'Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Debit Card', 'Islamic Debit Card', 'Trade Finance', 'Auto Finance', 'Home Finance'],
    services: ['Foreign Remittance', 'Islamic Remittance', 'Government Services', 'Trade Finance', 'Islamic Trade Finance', 'Halal Investment Advisory', 'Takaful', 'Shariah Compliance Verification'],
    keywords: ['government', 'bank', 'savings', 'remittance', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'allied_bank',
    officialName: 'Allied Bank Limited',
    shortName: 'ABL',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-22',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.alliedbank.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.alliedbank.android',
    officialEmail: 'info@alliedbank.com.pk',
    helpline: '111-425-425',
    headOffice: 'Allied Bank House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'ALIAPKKX',
    ibanPrefix: 'PKXX',
    foundedYear: 1942,
    branchCount: 600,
    atmCount: 1200,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: false,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Established commercial bank serving retail and corporate markets with Islamic banking services',
    products: ['Savings Account', 'Islamic Savings Account', 'Current Account', 'Islamic Current Account', 'Islamic Term Deposit', 'Islamic Auto Finance', 'Islamic Home Finance', 'Murabaha Financing', 'Credit Cards', 'Islamic Credit Card', 'Islamic Personal Finance'],
    services: ['Trade Services', 'Islamic Trade Services', 'Investment Products', 'Islamic Investment Products', 'Remittance', 'Islamic Remittance', 'Takaful Services', 'Shariah Board Services'],
    keywords: ['commercial', 'banking', 'corporate', 'finance', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // ADDITIONAL ISLAMIC BANKS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'bank_islami',
    officialName: 'BankIslami Pakistan Limited',
    shortName: 'BankIslami',
    institutionType: InstitutionType.islamicBank,
    category: InstitutionCategory.islamic,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-23',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.bankislami.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.bankislami.mobile',
    officialEmail: 'info@bankislami.com.pk',
    helpline: '021-111-000-786',
    headOffice: 'BankIslami House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'BISSPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2006,
    branchCount: 500,
    atmCount: 1000,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Full-fledged Islamic commercial bank offering comprehensive Shariah-compliant products and services',
    products: ['Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Financing', 'Ijara Financing', 'Islamic Deposits', 'Islamic Auto Finance', 'Islamic Home Finance', 'Islamic Debit Card', 'Islamic Credit Card'],
    services: ['Islamic Trade Finance', 'Halal Investments', 'Waqf Services', 'Islamic Remittance', 'Takaful Insurance', 'Shariah Board Services'],

    keywords: ['islamic', 'sharia', 'halal', 'banking'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'faysal_bank',
    officialName: 'Faysal Bank Limited',
    shortName: 'Faysal',
    institutionType: InstitutionType.islamicBank,
    category: InstitutionCategory.islamic,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-01-24',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.faysalbank.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.faysal.mobile',
    officialEmail: 'support@faysalbank.com',
    helpline: '111-001-002',
    headOffice: 'Faysal House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'FAYSRPKK',
    ibanPrefix: 'PKXX',
    foundedYear: 1987,
    branchCount: 700,
    atmCount: 1400,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Islamic bank providing comprehensive Shariah-compliant financial services with full digital banking integration',
    products: ['Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Auto Finance', 'Murabaha Home Finance', 'Ijara Financing', 'Islamic Debit Card', 'Islamic Credit Card', 'Islamic Trade Finance'],
    services: ['Islamic Trade Finance', 'Investment Advisory', 'Halal Investment Portfolio', 'Islamic Remittance', 'Takaful Insurance', 'Shariah Board Services', 'Waqf Management'],
    keywords: ['islamic', 'bank', 'sharia', 'fintech', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // PHASE 6 CP4 BATCH 2 - ASKARI BANK LIMITED (NEW ADDITION)
  // ============================================================================
  FinancialInstitution(
    institutionId: 'askari_bank',
    officialName: 'Askari Bank Limited',
    shortName: 'Askari',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-06-27',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.askaribank.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.askaribank.android',
    officialEmail: 'info@askaribank.com.pk',
    helpline: '111-275-275',
    headOffice: 'Askari Tower, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'ASCBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1992,
    branchCount: 550,
    atmCount: 1100,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Commercial bank with focus on defense, security, and corporate sectors, offering Islamic banking services',
    products: ['Current Account', 'Islamic Current Account', 'Savings Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Murabaha Financing', 'Islamic Auto Finance', 'Islamic Home Finance', 'Credit Card', 'Islamic Credit Card', 'Islamic SME Finance'],
    services: ['Trade Finance', 'Islamic Trade Finance', 'Remittance', 'Islamic Remittance', 'Corporate Services', 'Islamic Corporate Services', 'Takaful Insurance', 'Shariah Compliance'],
    keywords: ['bank', 'commercial', 'corporate', 'secure', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // DIGITAL BANKS & FINTECH
  // ============================================================================
  FinancialInstitution(
    institutionId: 'nu_money',
    officialName: 'Nu Money',
    shortName: 'Nu',
    institutionType: InstitutionType.digitalBank,
    category: InstitutionCategory.digital,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-01',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.nu.money',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.numoney',
    officialEmail: 'hello@nu.money',
    helpline: '+92-300-123-4567',
    headOffice: 'Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'NUMPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2020,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Digital-only bank providing modern banking without branches',
    products: ['Digital Account', 'Debit Card', 'Savings'],
    services: ['Money Transfer', 'Bill Payment', 'Digital Services'],
    keywords: ['digital', 'fintech', 'banking', 'mobile-first'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: false,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // DEVELOPMENT FINANCE INSTITUTIONS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'sme_bank',
    officialName: 'SME Bank Limited',
    shortName: 'SME Bank',
    institutionType: InstitutionType.dfi,
    category: InstitutionCategory.development,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-05',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.smebank.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.smebank.mobile',
    officialEmail: 'info@smebank.com.pk',
    helpline: '111-736-3000',
    headOffice: 'SME Bank House, Lahore',
    city: 'Lahore',
    province: 'Punjab',
    country: 'Pakistan',
    swiftCode: 'SMEBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1997,
    branchCount: 125,
    atmCount: 200,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: false,
    supportsQR: false,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Development finance institution specialized in SME lending',
    products: ['SME Loans', 'Working Capital', 'Term Finance'],
    services: ['Business Advisory', 'Credit Guarantee', 'Financial Training'],
    keywords: ['sme', 'business', 'development', 'lending'],
    consumerFinanceOffered: false,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'ztbl',
    officialName: 'Zarai Taraqiati Bank Limited',
    shortName: 'ZTBL',
    institutionType: InstitutionType.dfi,
    category: InstitutionCategory.development,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-06',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.ztbl.com.pk',
    officialEmail: 'info@ztbl.com.pk',
    helpline: '051-111-825-825',
    headOffice: 'ZTBL House, Islamabad',
    city: 'Islamabad',
    province: 'ICT',
    country: 'Pakistan',
    swiftCode: 'ZTBLPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1961,
    branchCount: 480,
    atmCount: 300,
    supportsInternetBanking: false,
    supportsMobileBanking: false,
    supportsRaast: false,
    supportsQR: false,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Agricultural development bank focused on farmers and agribusiness',
    products: ['Agriculture Loans', 'Seasonal Finance', 'Commodity Loans'],
    services: ['Farm Advisory', 'Crop Insurance', 'Tractor Leasing'],
    keywords: ['agriculture', 'farming', 'rural', 'development'],
    consumerFinanceOffered: false,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // ADDITIONAL MICROFINANCE INSTITUTIONS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'orix_mfb',
    officialName: 'Orix Leasing Limited',
    shortName: 'Orix',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-10',
    lastUpdated: '2024-06-08T00:00:00Z',
    officialWebsite: 'https://www.orixleasing.com',
    officialEmail: 'info@orixleasing.com',
    helpline: '111-826-4000',
    headOffice: 'Orix Tower, Karachi',
    swiftCode: 'ORIXPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1994,
    branchCount: 150,
    atmCount: null,
    supportsInternetBanking: false,
    supportsMobileBanking: false,
    supportsRaast: false,
    supportsQR: false,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Microfinance and leasing services for auto and equipment financing',
    products: ['Auto Leasing', 'Equipment Finance', 'Microfinance Loans'],
    services: ['Vehicle Leasing', 'Business Loans', 'Financial Solutions'],
    keywords: ['leasing', 'microfinance', 'auto', 'equipment'],
  ),
  // ============================================================================
  // ELECTRONIC MONEY INSTITUTIONS (EMIs)
  // ============================================================================
  FinancialInstitution(
    institutionId: 'jazzcash',
    officialName: 'JazzCash (Mobilink Microfinance Bank)',
    shortName: 'JazzCash',
    institutionType: InstitutionType.emi,
    category: InstitutionCategory.payment,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-15',
    lastUpdated: '2024-06-08T00:00:00Z',
    officialWebsite: 'https://www.jazzcash.com.pk',
    officialEmail: 'support@jazzcash.com.pk',
    helpline: '*117#',
    headOffice: 'Karachi',
    swiftCode: 'JCASHPK',
    ibanPrefix: 'PKXX',
    foundedYear: 2012,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Electronic Money Institution providing mobile financial services',
    products: ['Mobile Wallet', 'Money Transfer', 'Bill Payment'],
    services: ['Payment Services', 'Agent Network', 'Financial Inclusion'],
    keywords: ['emi', 'mobile', 'payment', 'digital money'],
  ),
  FinancialInstitution(
    institutionId: 'zong_paisa',
    officialName: 'Zong Paisa',
    shortName: 'Zong Paisa',
    institutionType: InstitutionType.emi,
    category: InstitutionCategory.payment,
    licenseStatus: LicenseStatus.active,
    sbpVerified: false,
    verificationDate: null,
    lastUpdated: '2024-06-08T00:00:00Z',
    officialWebsite: 'https://www.zongpaisa.com.pk',
    officialEmail: 'support@zongpaisa.com.pk',
    helpline: '*100#',
    headOffice: 'Lahore',
    swiftCode: 'ZONGPK',
    ibanPrefix: 'PKXX',
    foundedYear: 2015,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: false,
    supportsCreditCards: false,
    description: 'Electronic Money Institution offering mobile payment solutions',
    products: ['Digital Wallet', 'Money Transfer', 'Merchant Services'],
    services: ['Payment Processing', 'Bill Payment', 'Top-up Services'],
    keywords: ['emi', 'mobile', 'wallet', 'payment'],
  ),
  // ============================================================================
  // INTERNATIONAL BANKS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'adib',
    officialName: 'Abu Dhabi Islamic Bank',
    shortName: 'ADIB',
    institutionType: InstitutionType.foreignBank,
    category: InstitutionCategory.international,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-03-01',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.adib.ae',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=ae.adib.pk',
    officialEmail: 'pkcustomercare@adib.ae',
    helpline: '+92-21-34320100',
    headOffice: 'ADIB Pakistan House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'ADIBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 1998,
    branchCount: 15,
    atmCount: 50,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: false,
    supportsRoshan: false,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'International Islamic bank providing Islamic banking services',
    products: ['Islamic Deposits', 'Islamic Financing', 'Islamic Cards'],
    services: ['Trade Finance', 'Investment Services', 'Remittance'],
    keywords: ['international', 'islamic', 'islamic bank', 'uae'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: false,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: ['United Arab Emirates'],
  ),
  // ============================================================================
  // ADDITIONAL DIGITAL WALLETS & PAYMENTS
  // ============================================================================
  FinancialInstitution(
    institutionId: 'sada_pay',
    officialName: 'SadaPay',
    shortName: 'SadaPay',
    institutionType: InstitutionType.digitalWallet,
    category: InstitutionCategory.payment,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-03-15',
    lastUpdated: '2024-06-08T00:00:00Z',
    officialWebsite: 'https://www.sadapay.com',
    officialEmail: 'hello@sadapay.com',
    helpline: '+92-300-456-7890',
    headOffice: 'Karachi',
    swiftCode: 'SDAPK',
    ibanPrefix: 'PKXX',
    foundedYear: 2021,
    branchCount: null,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: false,
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Fintech digital wallet offering modern banking services',
    products: ['Digital Wallet', 'Debit Card', 'Money Transfer'],
    services: ['Payment Solutions', 'Bill Payment', 'Card Issuance'],
    keywords: ['fintech', 'digital wallet', 'payment', 'banking'],
  ),
  // ============================================================================
  // PHASE 6 CP5 BATCH 3 - SONERI BANK LIMITED (NEW ADDITION)
  // ============================================================================
  FinancialInstitution(
    institutionId: 'soneri_bank',
    officialName: 'Soneri Bank Limited',
    shortName: 'Soneri',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-05',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.soneribank.com',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.soneribank.mobile',
    officialEmail: 'customercare@soneribank.com',
    helpline: '111-766-374',
    headOffice: 'Soneri Bank House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'SOERBAXX',
    ibanPrefix: 'PKXX',
    foundedYear: 1993,
    branchCount: 380,
    atmCount: 650,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Established commercial bank with comprehensive banking services and dedicated Soneri Islamic window for Shariah-compliant products',
    products: ['Savings Account', 'Current Account', 'Fixed Deposit', 'Recurring Deposit', 'Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Auto Finance', 'Home Finance', 'Personal Loan', 'Business Loan', 'Islamic Murabaha Finance', 'Trade Finance', 'Debit Card', 'Credit Card'],
    services: ['Fund Transfer', 'Domestic Remittance', 'International Remittance', 'Bill Payment', 'Trade Finance', 'Corporate Banking', 'Islamic Remittance', 'Halal Investment Advisory', 'Takaful Services', 'Shariah Compliance'],
    keywords: ['commercial', 'banking', 'finance', 'investment', 'islamic', 'sharia', 'halal'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  // ============================================================================
  // PHASE 6 CP6 - REMAINING SBP-LICENSED INSTITUTIONS (NEW ADDITIONS)
  // ============================================================================
  FinancialInstitution(
    institutionId: 'bank_of_punjab',
    officialName: 'Bank of Punjab Limited',
    shortName: 'BoP',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-10',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.bop.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.bop.mobile',
    officialEmail: 'info@bop.com.pk',
    helpline: '111-247-247',
    headOffice: 'Bank of Punjab Building, Lahore',
    city: 'Lahore',
    province: 'Punjab',
    country: 'Pakistan',
    swiftCode: 'BOPAPKKL',
    ibanPrefix: 'PKXX',
    foundedYear: 1989,
    branchCount: 85,
    atmCount: 200,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Regional commercial bank serving Punjab with comprehensive digital banking and Islamic banking services',
    products: ['Savings Account', 'Current Account', 'Islamic Current Account', 'Islamic Savings Account', 'Islamic Term Deposit', 'Auto Finance', 'Home Finance', 'Personal Loan', 'Business Loan', 'Debit Card', 'Credit Card'],
    services: ['Fund Transfer', 'Domestic Remittance', 'Islamic Remittance', 'Trade Finance', 'Bill Payment', 'Investment Services', 'Islamic Trade Finance', 'Takaful Services'],
    keywords: ['commercial', 'banking', 'punjab', 'finance', 'islamic', 'sharia'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'bank_of_khyber',
    officialName: 'Bank of Khyber Limited',
    shortName: 'BoK',
    institutionType: InstitutionType.commercialBank,
    category: InstitutionCategory.commercial,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-12',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.bok.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.bok.mobile',
    officialEmail: 'info@bok.com.pk',
    helpline: '111-235-235',
    headOffice: 'Bank of Khyber House, Peshawar',
    city: 'Peshawar',
    province: 'Khyber Pakhtunkhwa',
    country: 'Pakistan',
    swiftCode: 'BOKHPKKP',
    ibanPrefix: 'PKXX',
    foundedYear: 1991,
    branchCount: 65,
    atmCount: 150,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Regional commercial bank serving Khyber Pakhtunkhwa with digital banking and Islamic financial services',
    products: ['Savings Account', 'Current Account', 'Islamic Current Account', 'Islamic Savings Account', 'Fixed Deposit', 'Auto Finance', 'Home Finance', 'Personal Loan', 'Business Loan', 'Debit Card', 'Credit Card'],
    services: ['Fund Transfer', 'Domestic Remittance', 'Islamic Remittance', 'Trade Finance', 'Bill Payment', 'Investment Advice', 'Islamic Trade Finance', 'Takaful Services'],
    keywords: ['commercial', 'banking', 'khyber', 'pakhtunkhwa', 'finance', 'islamic'],
    consumerFinanceOffered: true,
    corporateBankingOffered: true,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'first_mfb',
    officialName: 'First Microfinance Bank Limited',
    shortName: 'First MFB',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-14',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.fmfb.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.fmfb.mobile',
    officialEmail: 'info@fmfb.com.pk',
    helpline: '111-334-334',
    headOffice: 'First MFB Building, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'FMFBPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2002,
    branchCount: 320,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Leading microfinance bank serving low-income segments with innovative financing and women empowerment programs',
    products: ['Micro Loans', 'Women Business Loans', 'Agriculture Loans', 'Consumer Loans', 'Islamic Micro Loans', 'Savings Accounts', 'Micro Credit Card'],
    services: ['Microfinance', 'Women Empowerment', 'Agricultural Lending', 'Business Training', 'Islamic Microfinance', 'Government Program Distribution', 'Digital Lending'],
    keywords: ['microfinance', 'women', 'agriculture', 'lending', 'islamic'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'united_mfb',
    officialName: 'United Microfinance Bank Limited',
    shortName: 'United MFB',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-16',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.umbl.com.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.umbl.mobile',
    officialEmail: 'info@umbl.com.pk',
    helpline: '111-446-446',
    headOffice: 'United MFB Center, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'UMBLPKKA',
    ibanPrefix: 'PKXX',
    foundedYear: 2002,
    branchCount: 290,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Progressive microfinance institution providing financial services to underserved populations with focus on entrepreneurship',
    products: ['Microfinance Loans', 'Business Loans', 'Agriculture Loans', 'Education Loans', 'Islamic Microfinance', 'Savings Products', 'Digital Wallet'],
    services: ['Microfinance Services', 'Entrepreneurship Support', 'Agricultural Finance', 'Digital Banking', 'Islamic Microfinance', 'Community Programs', 'Mobile Money'],
    keywords: ['microfinance', 'entrepreneurship', 'banking', 'lending', 'islamic'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: true,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'khushhali_bank',
    officialName: 'Khushhali Bank Limited',
    shortName: 'Khushhali',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-18',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.khushhali.org.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.khushhali.mobile',
    officialEmail: 'info@khushhali.org.pk',
    helpline: '111-542-542',
    headOffice: 'Khushhali Head Office, Islamabad',
    city: 'Islamabad',
    province: 'Federal',
    country: 'Pakistan',
    swiftCode: 'KHUSHPKIS',
    ibanPrefix: 'PKXX',
    foundedYear: 1997,
    branchCount: 220,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Pioneering microfinance bank dedicated to poverty alleviation and financial inclusion with women-focused initiatives',
    products: ['Microfinance Loans', 'Women Empowerment Loans', 'Agriculture Loans', 'Education Financing', 'Islamic Microfinance', 'Savings Accounts', 'Digital Services'],
    services: ['Microfinance', 'Women Empowerment Programs', 'Agricultural Support', 'Financial Literacy', 'Islamic Banking', 'Government Partnerships', 'Digital Inclusion'],
    keywords: ['microfinance', 'women', 'poverty', 'inclusion', 'islamic'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: false,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
  FinancialInstitution(
    institutionId: 'tameer_mfb',
    officialName: 'Tameer Microfinance Bank Limited',
    shortName: 'Tameer',
    institutionType: InstitutionType.microfmanceBank,
    category: InstitutionCategory.microfinance,
    licenseStatus: LicenseStatus.active,
    sbpVerified: true,
    verificationDate: '2024-02-20',
    lastUpdated: '2024-06-27T00:00:00Z',
    officialWebsite: 'https://www.tameer.org.pk',
    officialMobileAppUrl: 'https://play.google.com/store/apps/details?id=com.tameer.mobile',
    officialEmail: 'info@tameer.org.pk',
    helpline: '111-643-643',
    headOffice: 'Tameer House, Karachi',
    city: 'Karachi',
    province: 'Sindh',
    country: 'Pakistan',
    swiftCode: 'TAMEERPK',
    ibanPrefix: 'PKXX',
    foundedYear: 2004,
    branchCount: 200,
    atmCount: null,
    supportsInternetBanking: true,
    supportsMobileBanking: true,
    supportsRaast: true,
    supportsQR: true,
    supportsRoshan: true,
    supportsIslamicBanking: true,
    supportsDebitCards: true,
    supportsCreditCards: false,
    description: 'Social enterprise microfinance institution empowering marginalized communities through accessible financial services',
    products: ['Microfinance Loans', 'Community Loans', 'Skills Development Loans', 'Housing Microfinance', 'Islamic Microfinance', 'Savings Products', 'Mobile Banking'],
    services: ['Microfinance Services', 'Skills Training', 'Community Development', 'Housing Support', 'Islamic Banking', 'Digital Services', 'Social Programs'],
    keywords: ['microfinance', 'community', 'social', 'development', 'islamic'],
    consumerFinanceOffered: true,
    corporateBankingOffered: false,
    smeBankingOffered: true,
    walletSupport: true,
    availableLanguages: ['English', 'Urdu'],
    internationalPresence: [],
  ),
];

/// Repository providing access to SBP-recognized financial institutions.
///
/// This is a read-only interface supporting comprehensive filtering and search
/// across multiple institution types (banks, microfinance, wallets, etc.).
///
/// Implements IFinancialInstitutionRepository with both synchronous helpers
/// (for in-memory efficiency) and async interface methods (for cache integration).
///
/// Currently uses local sample data. In production, this would synchronize
/// with official SBP registries and updated institution databases.
class FinancialInstitutionRepository implements IFinancialInstitutionRepository {
  final ApiCacheService _cache;

  FinancialInstitutionRepository({ApiCacheService? cache})
      : _cache = cache ?? ApiCacheService();

  // ============================================================================
  // SYNCHRONOUS HELPERS - For efficient in-memory operations
  // ============================================================================

  /// Helper: Returns all available financial institutions (synchronous).
  List<FinancialInstitution> _loadAllSync() =>
      List.unmodifiable(_financialInstitutions);

  /// Helper: Returns a single institution by ID (synchronous).
  FinancialInstitution? _getInstitutionSync(String institutionId) {
    try {
      return _financialInstitutions
          .firstWhere((inst) => inst.institutionId == institutionId);
    } catch (_) {
      return null;
    }
  }

  /// Helper: Searches institutions synchronously.
  List<FinancialInstitution> _searchSync(String query) {
    if (query.trim().isEmpty) return _loadAllSync();
    final lower = query.toLowerCase();
    return _financialInstitutions
        .where(
          (inst) =>
              inst.officialName.toLowerCase().contains(lower) ||
              inst.shortName.toLowerCase().contains(lower) ||
              inst.keywords.any((kw) => kw.toLowerCase().contains(lower)) ||
              inst.description.toLowerCase().contains(lower),
        )
        .toList();
  }

  /// Helper: Filters commercial banks synchronously.
  List<FinancialInstitution> _filterCommercialSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.commercialBank)
        .toList();
  }

  /// Helper: Filters Islamic banks synchronously.
  List<FinancialInstitution> _filterIslamicSync() {
    return _financialInstitutions
        .where((inst) => inst.supportsIslamicBanking)
        .toList();
  }

  /// Helper: Filters digital banks synchronously.
  List<FinancialInstitution> _filterDigitalSync() {
    return _financialInstitutions
        .where((inst) =>
            inst.institutionType == InstitutionType.digitalBank ||
            inst.institutionType == InstitutionType.digitalWallet ||
            inst.institutionType == InstitutionType.emi)
        .toList();
  }

  /// Helper: Filters microfinance synchronously.
  List<FinancialInstitution> _filterMicrofinanceSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.microfmanceBank)
        .toList();
  }

  /// Helper: Filters DFIs synchronously.
  List<FinancialInstitution> _filterDFISync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.dfi)
        .toList();
  }

  /// Helper: Filters international banks synchronously.
  List<FinancialInstitution> _filterInternationalSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.foreignBank)
        .toList();
  }

  /// Helper: Filters digital wallets synchronously.
  List<FinancialInstitution> _filterWalletsSync() {
    return _financialInstitutions
        .where((inst) =>
            inst.institutionType == InstitutionType.digitalWallet ||
            inst.institutionType == InstitutionType.emi)
        .toList();
  }

  /// Helper: Filters verified institutions synchronously.
  List<FinancialInstitution> _getVerifiedInstitutionsSync() {
    return _financialInstitutions
        .where((inst) => inst.sbpVerified)
        .toList();
  }

  /// Helper: Sorts alphabetically synchronously.
  List<FinancialInstitution> _sortAlphabeticallySync() {
    final sorted = List<FinancialInstitution>.from(_financialInstitutions);
    sorted.sort((a, b) => a.officialName.compareTo(b.officialName));
    return sorted;
  }

  /// Helper: Sorts by recently updated synchronously.
  List<FinancialInstitution> _sortByRecentlyUpdatedSync() {
    final sorted = List<FinancialInstitution>.from(_financialInstitutions);
    sorted.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    return sorted;
  }

  // ============================================================================
  // ASYNC INTERFACE METHODS - Implementing IFinancialInstitutionRepository
  // ============================================================================

  /// Returns all available financial institutions.
  ///
  /// Checks cache first, then loads from local data. Updates cache on completion.
  @override
  Future<List<FinancialInstitution>> loadInstitutions() async {
    const cacheKey = 'all_institutions';
    
    // Check cache
    final cached = _cache.get(cacheKey, ttl: const Duration(hours: 24));
    if (cached != null) {
      return List<FinancialInstitution>.from(cached as List);
    }

    // Load from local data
    final institutions = _loadAllSync();
    
    // Update cache
    _cache.cache(cacheKey, institutions);
    
    return institutions;
  }

  /// Returns all available financial institutions from cache only.
  ///
  /// Does not trigger any network requests or source loads.
  /// Returns empty list if cache is empty or expired.
  @override
  Future<List<FinancialInstitution>> loadFromCache() async {
    const cacheKey = 'all_institutions';
    final cached = _cache.get(cacheKey, ttl: const Duration(hours: 24));
    return cached != null ? List<FinancialInstitution>.from(cached as List) : [];
  }

  /// Refreshes institutions from the primary source.
  ///
  /// Currently reloads from local data and updates cache.
  /// In production, this would sync with SBP registries or APIs.
  @override
  Future<List<FinancialInstitution>> refreshFromSource() async {
    const cacheKey = 'all_institutions';
    
    // Invalidate existing cache entry
    _cache.invalidate(cacheKey);
    
    // Load fresh data from source (currently local, would be API in production)
    final institutions = _loadAllSync();
    
    // Update cache with fresh data
    _cache.cache(cacheKey, institutions);
    
    return institutions;
  }

  /// Searches institutions by query string.
  ///
  /// Performs case-insensitive search across name, short name, keywords, and description.
  /// Returns all matching institutions sorted by relevance.
  @override
  Future<List<FinancialInstitution>> search(String query) async {
    return _searchSync(query);
  }

  /// Filters institutions by category.
  ///
  /// Matches against InstitutionCategory enum names and display names.
  /// Supports both programmatic names (e.g., 'commercial') and display names (e.g., 'Commercial').
  @override
  Future<List<FinancialInstitution>> filterByCategory(String category) async {
    final lower = category.toLowerCase();
    return _financialInstitutions
        .where((inst) {
          final categoryName = inst.category.name.toLowerCase();
          final categoryDisplay = inst.category.displayName.toLowerCase();
          return categoryName.contains(lower) || categoryDisplay.contains(lower);
        })
        .toList();
  }

  /// Filters commercial banks.
  ///
  /// Returns only commercial banking institutions.
  @override
  Future<List<FinancialInstitution>> filterCommercial() async {
    return _filterCommercialSync();
  }

  /// Filters Islamic banking institutions.
  ///
  /// Returns only institutions offering Islamic/Sharia-compliant services.
  @override
  Future<List<FinancialInstitution>> filterIslamic() async {
    return _filterIslamicSync();
  }

  /// Filters digital banks and platforms.
  ///
  /// Returns digital-first banks, fintech platforms, and online-only institutions.
  @override
  Future<List<FinancialInstitution>> filterDigital() async {
    return _filterDigitalSync();
  }

  /// Filters microfinance institutions.
  ///
  /// Returns microfinance banks and SME-focused lenders.
  @override
  Future<List<FinancialInstitution>> filterMicrofinance() async {
    return _filterMicrofinanceSync();
  }

  /// Filters Development Finance Institutions (DFIs).
  ///
  /// Returns specialized long-term development financing institutions.
  @override
  Future<List<FinancialInstitution>> filterDFI() async {
    return _filterDFISync();
  }

  /// Filters international/foreign banks.
  ///
  /// Returns banks with headquarters outside Pakistan operating locally.
  @override
  Future<List<FinancialInstitution>> filterInternational() async {
    return _filterInternationalSync();
  }

  /// Filters digital wallet providers and EMIs.
  ///
  /// Returns electronic money institutions and digital payment providers.
  @override
  Future<List<FinancialInstitution>> filterWallets() async {
    return _filterWalletsSync();
  }

  /// Retrieves a single institution by ID.
  ///
  /// Returns the institution matching the ID, or null if not found.
  /// Checks cache first before querying source.
  @override
  Future<FinancialInstitution?> getInstitution(String institutionId) async {
    final cacheKey = 'institution_$institutionId';
    
    // Check cache
    final cached = _cache.get(cacheKey, ttl: const Duration(hours: 24));
    if (cached != null) {
      return cached as FinancialInstitution;
    }

    // Load from local data
    final institution = _getInstitutionSync(institutionId);
    
    // Update cache if found
    if (institution != null) {
      _cache.cache(cacheKey, institution);
    }
    
    return institution;
  }

  /// Retrieves only SBP-verified institutions.
  ///
  /// Returns institutions with confirmed SBP verification status.
  @override
  Future<List<FinancialInstitution>> getVerifiedInstitutions() async {
    return _getVerifiedInstitutionsSync();
  }

  /// Sorts institutions alphabetically by official name.
  ///
  /// Returns institutions sorted in ascending order by name.
  @override
  Future<List<FinancialInstitution>> sortAlphabetically() async {
    return _sortAlphabeticallySync();
  }

  /// Sorts institutions by most recently updated.
  ///
  /// Returns institutions sorted by lastUpdated timestamp (newest first).
  @override
  Future<List<FinancialInstitution>> sortByRecentlyUpdated() async {
    return _sortByRecentlyUpdatedSync();
  }

  // ============================================================================
  // LEGACY SYNCHRONOUS METHODS - For backward compatibility with existing code
  // ============================================================================

  /// Returns all available financial institutions (synchronous).
  /// 
  /// DEPRECATED: Use loadInstitutions() instead for new code.
  List<FinancialInstitution> loadInstitutionsSync() =>
      List.unmodifiable(_financialInstitutions);

  /// Returns a single institution by ID, or null if not found (synchronous).
  /// 
  /// DEPRECATED: Use getInstitution() instead for new code.
  FinancialInstitution? getInstitutionSync(String institutionId) {
    try {
      return _financialInstitutions
          .firstWhere((inst) => inst.institutionId == institutionId);
    } catch (_) {
      return null;
    }
  }

  /// Searches institutions by name, short name, or keywords (case-insensitive, synchronous).
  /// 
  /// DEPRECATED: Use search() instead for new code.
  List<FinancialInstitution> searchSync(String query) {
    if (query.trim().isEmpty) return loadInstitutionsSync();
    final lower = query.toLowerCase();
    return _financialInstitutions
        .where(
          (inst) =>
              inst.officialName.toLowerCase().contains(lower) ||
              inst.shortName.toLowerCase().contains(lower) ||
              inst.keywords.any((kw) => kw.toLowerCase().contains(lower)) ||
              inst.description.toLowerCase().contains(lower),
        )
        .toList();
  }

  /// Filters institutions by commercial bank category (synchronous).
  /// 
  /// DEPRECATED: Use filterCommercial() instead for new code.
  List<FinancialInstitution> filterCommercialSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.commercialBank)
        .toList();
  }

  /// Filters institutions by Islamic banking category (synchronous).
  /// 
  /// DEPRECATED: Use filterIslamic() instead for new code.
  List<FinancialInstitution> filterIslamicSync() {
    return _financialInstitutions
        .where((inst) => inst.supportsIslamicBanking)
        .toList();
  }

  /// Filters digital banks and wallet providers (synchronous).
  /// 
  /// DEPRECATED: Use filterDigital() instead for new code.
  List<FinancialInstitution> filterDigitalSync() {
    return _financialInstitutions
        .where((inst) =>
            inst.institutionType == InstitutionType.digitalBank ||
            inst.institutionType == InstitutionType.digitalWallet ||
            inst.institutionType == InstitutionType.emi)
        .toList();
  }

  /// Filters microfinance institutions (synchronous).
  /// 
  /// DEPRECATED: Use filterMicrofinance() instead for new code.
  List<FinancialInstitution> filterMicrofinanceSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.microfmanceBank)
        .toList();
  }

  /// Filters Development Finance Institutions (DFIs, synchronous).
  /// 
  /// DEPRECATED: Use filterDFI() instead for new code.
  List<FinancialInstitution> filterDFISync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.dfi)
        .toList();
  }

  /// Filters foreign banks operating in Pakistan (synchronous).
  /// 
  /// DEPRECATED: Use filterInternational() instead for new code.
  List<FinancialInstitution> filterInternationalSync() {
    return _financialInstitutions
        .where((inst) => inst.institutionType == InstitutionType.foreignBank)
        .toList();
  }

  /// Filters digital wallet providers and EMIs (synchronous).
  /// 
  /// DEPRECATED: Use filterWallets() instead for new code.
  List<FinancialInstitution> filterWalletsSync() {
    return _financialInstitutions
        .where((inst) =>
            inst.institutionType == InstitutionType.digitalWallet ||
            inst.institutionType == InstitutionType.emi)
        .toList();
  }

  /// Returns only SBP-verified institutions (synchronous).
  /// 
  /// DEPRECATED: Use getVerifiedInstitutions() instead for new code.
  List<FinancialInstitution> getVerifiedInstitutionsSync() {
    return _financialInstitutions
        .where((inst) => inst.sbpVerified)
        .toList();
  }

  /// Returns institutions sorted alphabetically by official name (synchronous).
  /// 
  /// DEPRECATED: Use sortAlphabetically() instead for new code.
  List<FinancialInstitution> sortAlphabeticallySync() {
    final sorted = List<FinancialInstitution>.from(_financialInstitutions);
    sorted.sort((a, b) => a.officialName.compareTo(b.officialName));
    return sorted;
  }
}
