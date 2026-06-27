/// Advanced filter options for searching and filtering banks.
class BankFilter {
  final List<String>? provinces; // e.g., ['Punjab', 'Sindh']
  final List<String>? cities;
  final List<String>? bankTypes; // e.g., ['Government', 'Private', 'Islamic']
  final List<String>? specializations; // e.g., ['SME Banking', 'Corporate', 'Consumer']
  final bool? hasInternetBanking;
  final bool? hasMobileApp;
  final bool? hasIslamicBanking;
  final bool? hasRoshanDigital;
  final bool? hasWhatsAppBanking;
  final bool? hasSmsBanking;
  final int? minBranches;
  final int? maxBranches;
  final double? minRating;
  final bool? sbpVerifiedOnly;
  final bool? digitalBanksOnly;

  const BankFilter({
    this.provinces,
    this.cities,
    this.bankTypes,
    this.specializations,
    this.hasInternetBanking,
    this.hasMobileApp,
    this.hasIslamicBanking,
    this.hasRoshanDigital,
    this.hasWhatsAppBanking,
    this.hasSmsBanking,
    this.minBranches,
    this.maxBranches,
    this.minRating,
    this.sbpVerifiedOnly = false,
    this.digitalBanksOnly = false,
  });

  bool get isEmpty =>
      provinces == null &&
      cities == null &&
      bankTypes == null &&
      specializations == null &&
      hasInternetBanking == null &&
      hasMobileApp == null &&
      hasIslamicBanking == null &&
      hasRoshanDigital == null &&
      hasWhatsAppBanking == null &&
      hasSmsBanking == null &&
      minBranches == null &&
      maxBranches == null &&
      minRating == null &&
      sbpVerifiedOnly == false &&
      digitalBanksOnly == false;

  BankFilter copyWith({
    List<String>? provinces,
    List<String>? cities,
    List<String>? bankTypes,
    List<String>? specializations,
    bool? hasInternetBanking,
    bool? hasMobileApp,
    bool? hasIslamicBanking,
    bool? hasRoshanDigital,
    bool? hasWhatsAppBanking,
    bool? hasSmsBanking,
    int? minBranches,
    int? maxBranches,
    double? minRating,
    bool? sbpVerifiedOnly,
    bool? digitalBanksOnly,
  }) =>
      BankFilter(
        provinces: provinces ?? this.provinces,
        cities: cities ?? this.cities,
        bankTypes: bankTypes ?? this.bankTypes,
        specializations: specializations ?? this.specializations,
        hasInternetBanking: hasInternetBanking ?? this.hasInternetBanking,
        hasMobileApp: hasMobileApp ?? this.hasMobileApp,
        hasIslamicBanking: hasIslamicBanking ?? this.hasIslamicBanking,
        hasRoshanDigital: hasRoshanDigital ?? this.hasRoshanDigital,
        hasWhatsAppBanking: hasWhatsAppBanking ?? this.hasWhatsAppBanking,
        hasSmsBanking: hasSmsBanking ?? this.hasSmsBanking,
        minBranches: minBranches ?? this.minBranches,
        maxBranches: maxBranches ?? this.maxBranches,
        minRating: minRating ?? this.minRating,
        sbpVerifiedOnly: sbpVerifiedOnly ?? this.sbpVerifiedOnly,
        digitalBanksOnly: digitalBanksOnly ?? this.digitalBanksOnly,
      );
}
