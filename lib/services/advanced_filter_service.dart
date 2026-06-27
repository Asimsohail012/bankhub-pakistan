import '../models/bank_filter.dart';
import '../data/repositories/financial_institution_repository.dart';
import '../data/repositories/i_financial_institution_repository.dart';

/// Service for applying advanced filters to institutions.
class AdvancedFilterService {
  final IFinancialInstitutionRepository _repository;

  AdvancedFilterService({
    required this._repository,
  });

  /// Apply advanced filters to institutions.
  /// Returns filtered list based on BankFilter criteria.
  Future<List<dynamic>> applyFilters(BankFilter filter) async {
    if (filter.isEmpty) {
      return await _repository.loadInstitutions();
    }

    try {
      var institutions = await _repository.loadInstitutions() as List<dynamic>;

      // Filter by SBP verified
      if (filter.sbpVerifiedOnly == true) {
        institutions = institutions
            .where((i) => (i as dynamic).sbpVerified == true)
            .toList();
      }

      // Filter by bank types
      if (filter.bankTypes != null && filter.bankTypes!.isNotEmpty) {
        institutions = institutions
            .where((i) =>
                filter.bankTypes!.contains((i as dynamic).institutionType))
            .toList();
      }

      // Filter by specializations
      if (filter.specializations != null && filter.specializations!.isNotEmpty) {
        // Note: This requires institution data to have specialization field
        // For now, we'll skip this as it may not be in the current model
      }

      // Filter by capabilities (digital banking, internet banking, etc.)
      if (filter.hasInternetBanking == true) {
        institutions = institutions
            .where((i) => (i as dynamic).supportsInternetBanking == true)
            .toList();
      }

      if (filter.hasMobileApp == true) {
        // Requires mobile app field in model
        // institutions = institutions
        //     .where((i) => (i as dynamic).hasMobileApp == true)
        //     .toList();
      }

      if (filter.hasIslamicBanking == true) {
        institutions = institutions
            .where((i) => (i as dynamic).supportsIslamicBanking == true)
            .toList();
      }

      if (filter.hasRoshanDigital == true) {
        institutions = institutions
            .where((i) => (i as dynamic).supportsRoshanDigital == true)
            .toList();
      }

      // Filter by branch count
      if (filter.minBranches != null) {
        institutions = institutions
            .where((i) =>
                (i as dynamic).branchCount != null &&
                (i as dynamic).branchCount! >= filter.minBranches!)
            .toList();
      }

      if (filter.maxBranches != null) {
        institutions = institutions
            .where((i) =>
                (i as dynamic).branchCount != null &&
                (i as dynamic).branchCount! <= filter.maxBranches!)
            .toList();
      }

      // Filter by rating
      if (filter.minRating != null) {
        institutions = institutions
            .where((i) =>
                (i as dynamic).rating != null &&
                (i as dynamic).rating! >= filter.minRating!)
            .toList();
      }

      return institutions;
    } catch (e) {
      return [];
    }
  }

  /// Get filter options for UI dropdowns.
  Future<Map<String, List<String>>> getFilterOptions() async {
    try {
      return {
        'provinces': [
          'Punjab',
          'Sindh',
          'Khyber Pakhtunkhwa',
          'Balochistan',
          'Gilgit-Baltistan',
          'AJK',
          'Islamabad'
        ],
        'bankTypes': [
          'Commercial Bank',
          'Islamic Bank',
          'Microfinance Bank',
          'Digital Bank',
          'DFI',
          'Digital Wallet',
          'Foreign Bank'
        ],
        'specializations': [
          'Consumer Banking',
          'SME Banking',
          'Corporate Banking',
          'Agriculture Banking',
          'Women Banking',
          'Priority Banking',
          'Premium Banking',
          'Overseas Pakistanis'
        ],
      };
    } catch (e) {
      return {};
    }
  }

  /// Get popular/suggested filters.
  List<BankFilter> getSuggestedFilters() {
    return [
      BankFilter(
        bankTypes: ['Islamic Bank'],
        hasIslamicBanking: true,
      ),
      BankFilter(
        digitalBanksOnly: true,
      ),
      BankFilter(
        hasInternetBanking: true,
        hasMobileApp: true,
      ),
      BankFilter(
        sbpVerifiedOnly: true,
      ),
      BankFilter(
        hasRoshanDigital: true,
      ),
    ];
  }
}

/// Singleton instance
AdvancedFilterService? _filterInstance;

/// Get singleton instance
AdvancedFilterService getAdvancedFilterService() {
  _filterInstance ??= AdvancedFilterService(
    repository: FinancialInstitutionRepository(),
  );
  return _filterInstance!;
}
