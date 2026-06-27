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
    lastUpdated: '2024-06-01T00:00:00Z',
    officialWebsite: 'https://www.hbl.com',
    officialEmail: 'support@hbl.com',
    helpline: '111-111-425',
    headOffice: 'HBL Tower, I.I. Chundrigar Road, Karachi',
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
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Leading commercial bank with comprehensive digital banking services',
    products: ['Current Account', 'Savings Account', 'Debit Card', 'Credit Card', 'Loans'],
    services: ['Foreign Remittance', 'Trade Finance', 'Investment Advisory'],
    keywords: ['banking', 'credit', 'savings', 'digital'],
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
    lastUpdated: '2024-06-03T00:00:00Z',
    officialWebsite: 'https://www.meezanbank.com',
    officialEmail: 'support@meezanbank.com',
    helpline: '111-331-331',
    headOffice: 'Meezan House, Karachi',
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
    lastUpdated: '2024-06-04T00:00:00Z',
    officialWebsite: 'https://www.bankalfalah.com',
    officialEmail: 'support@bankalfalah.com',
    helpline: '111-225-225',
    headOffice: 'Karachi',
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
    supportsIslamicBanking: false,
    supportsDebitCards: true,
    supportsCreditCards: true,
    description: 'Progressive commercial bank with focus on retail banking',
    products: ['Checking Account', 'Savings Account', 'Debit Card', 'Personal Loan'],
    services: ['Bill Payment', 'Remittance', 'Investment'],
    keywords: ['banking', 'savings', 'personal finance'],
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
    lastUpdated: '2024-06-05T00:00:00Z',
    officialWebsite: 'https://www.mobilinkbank.com',
    officialEmail: 'support@mobilinkbank.com',
    helpline: '111-877-877',
    headOffice: 'Karachi',
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
