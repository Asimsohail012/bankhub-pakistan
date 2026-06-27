import '../models/financial_institution.dart';

/// Abstract repository interface for universal financial institution access.
/// 
/// Defines read-only methods for comprehensive institution management including
/// filtering, searching, sorting, and caching operations. Implementations must
/// support graceful fallback to cached data and maintain data consistency.
abstract interface class IFinancialInstitutionRepository {
  /// Loads all available financial institutions.
  ///
  /// Returns all institutions from the current data source (cache or live).
  /// Should handle missing data gracefully by returning empty list or cached data.
  Future<List<FinancialInstitution>> loadInstitutions();

  /// Loads institutions from cache only.
  ///
  /// Returns cached institutions without triggering network requests.
  /// Useful for offline-first operations or when cache hits are preferred.
  Future<List<FinancialInstitution>> loadFromCache();

  /// Refreshes institutions from the primary source.
  ///
  /// Triggers synchronization with configured data source (API, SBP registry, etc).
  /// Updates cache and returns fresh data. Implements retry logic and error recovery.
  Future<List<FinancialInstitution>> refreshFromSource();

  /// Searches institutions by query string.
  ///
  /// Performs case-insensitive search across name, short name, keywords, and description.
  /// Returns all matching institutions sorted by relevance.
  Future<List<FinancialInstitution>> search(String query);

  /// Filters institutions by category.
  ///
  /// Returns institutions matching the specified category (commercial, islamic, etc).
  Future<List<FinancialInstitution>> filterByCategory(String category);

  /// Filters commercial banks.
  ///
  /// Returns only commercial banking institutions.
  Future<List<FinancialInstitution>> filterCommercial();

  /// Filters Islamic banking institutions.
  ///
  /// Returns only institutions offering Islamic/Sharia-compliant services.
  Future<List<FinancialInstitution>> filterIslamic();

  /// Filters digital banks and platforms.
  ///
  /// Returns digital-first banks, fintech platforms, and online-only institutions.
  Future<List<FinancialInstitution>> filterDigital();

  /// Filters microfinance institutions.
  ///
  /// Returns microfinance banks and SME-focused lenders.
  Future<List<FinancialInstitution>> filterMicrofinance();

  /// Filters Development Finance Institutions (DFIs).
  ///
  /// Returns specialized long-term development financing institutions.
  Future<List<FinancialInstitution>> filterDFI();

  /// Filters international/foreign banks.
  ///
  /// Returns banks with headquarters outside Pakistan operating locally.
  Future<List<FinancialInstitution>> filterInternational();

  /// Filters digital wallet providers and EMIs.
  ///
  /// Returns electronic money institutions and digital payment providers.
  Future<List<FinancialInstitution>> filterWallets();

  /// Retrieves a single institution by ID.
  ///
  /// Returns the institution matching the ID, or null if not found.
  /// Should check cache first before querying source.
  Future<FinancialInstitution?> getInstitution(String institutionId);

  /// Retrieves only SBP-verified institutions.
  ///
  /// Returns institutions with confirmed SBP verification status.
  Future<List<FinancialInstitution>> getVerifiedInstitutions();

  /// Sorts institutions alphabetically by official name.
  ///
  /// Returns institutions sorted in ascending order by name.
  Future<List<FinancialInstitution>> sortAlphabetically();

  /// Sorts institutions by most recently updated.
  ///
  /// Returns institutions sorted by lastUpdated timestamp (newest first).
  Future<List<FinancialInstitution>> sortByRecentlyUpdated();
}
