const Map<String, List<String>> _defaultBankProductSections = {
  'Current Accounts': ['Everyday current accounts with digital access.'],
  'Savings Accounts': ['Flexible savings options with attractive returns.'],
  'Islamic Accounts': ['Shariah-compliant accounts for ethical banking.'],
  'Roshan Digital Accounts': ['Digital NRV accounts for overseas Pakistanis.'],
  'Credit Cards': ['Reward and cashback credit cards for everyday spending.'],
  'Debit Cards': ['Secure debit cards with tap-to-pay convenience.'],
  'Home Finance': ['Home financing with flexible repayment plans.'],
  'Auto Finance': ['Vehicle financing for new and used cars.'],
  'Personal Finance': ['Personal loans for lifestyle and education goals.'],
  'SME Banking': ['Business banking support for small enterprises.'],
  'Corporate Banking': ['Corporate solutions for large and medium businesses.'],
  'Agriculture Banking': ['Agricultural financing for growers and livestock.'],
};

class BankModel {
  final String id;
  final String name;
  final String fullName;
  final String description;
  final String slogan;
  final String logoAsset;
  final String category;

  final String website;
  final String internetBanking;
  final String mobileApp;
  final String mobileAppAndroidUrl;
  final String mobileAppIosUrl;

  final String helpline;
  final String smsBanking;
  final String whatsappBanking;
  final String customerCare;
  final String email;

  final String branchLocator;
  final String creditCards;
  final String debitCards;
  final String islamicBanking;
  final bool roshanDigitalAccount;
  final String roshanDigitalAccountUrl;
  final String swiftCode;
  final String openAccountUrl;
  final String downloadAppUrl;

  final int establishedYear;
  final String headquarters;
  final int branchCount;
  final int atmCount;
  final Map<String, String> socialMedia;
  final Map<String, List<String>> productSections;
  final List<String> keywords;
  final double rating;

  const BankModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.slogan,
    required this.logoAsset,
    required this.category,
    required this.website,
    required this.internetBanking,
    required this.mobileApp,
    required this.mobileAppAndroidUrl,
    required this.mobileAppIosUrl,
    required this.helpline,
    required this.smsBanking,
    required this.whatsappBanking,
    this.customerCare = '',
    this.email = '',
    required this.branchLocator,
    required this.creditCards,
    required this.debitCards,
    required this.islamicBanking,
    required this.roshanDigitalAccount,
    required this.roshanDigitalAccountUrl,
    required this.swiftCode,
    required this.openAccountUrl,
    required this.downloadAppUrl,
    this.establishedYear = 0,
    this.headquarters = 'Headquarters not available',
    this.branchCount = 0,
    this.atmCount = 0,
    this.socialMedia = const {},
    this.productSections = _defaultBankProductSections,
    this.keywords = const [],
    this.rating = 4.0,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    final productSections = (json['productSections'] as Map<String, dynamic>?)
            ?.map((key, value) => MapEntry(
                  key,
                  List<String>.from(value as List<dynamic>),
                )) ??
        _defaultBankProductSections;

    return BankModel(
      id: json['id'] as String,
      name: json['name'] as String,
      fullName: json['fullName'] as String,
      description: json['description'] as String,
      slogan: json['slogan'] as String,
      logoAsset: json['logoAsset'] as String,
      category: json['category'] as String,
      website: json['website'] as String,
      internetBanking: json['internetBanking'] as String,
      mobileApp: json['mobileApp'] as String,
      mobileAppAndroidUrl: json['mobileAppAndroidUrl'] as String,
      mobileAppIosUrl: json['mobileAppIosUrl'] as String,
      helpline: json['helpline'] as String,
      smsBanking: json['smsBanking'] as String,
      whatsappBanking: json['whatsappBanking'] as String,
      customerCare: json['customerCare'] as String? ?? '',
      email: json['email'] as String? ?? '',
      branchLocator: json['branchLocator'] as String,
      creditCards: json['creditCards'] as String,
      debitCards: json['debitCards'] as String,
      islamicBanking: json['islamicBanking'] as String,
      roshanDigitalAccount: json['roshanDigitalAccount'] as bool,
      roshanDigitalAccountUrl: json['roshanDigitalAccountUrl'] as String,
      swiftCode: json['swiftCode'] as String,
      openAccountUrl: json['openAccountUrl'] as String,
      downloadAppUrl: json['downloadAppUrl'] as String,
      establishedYear: json['establishedYear'] as int? ?? 0,
      headquarters: json['headquarters'] as String? ?? 'Headquarters not available',
      branchCount: json['branchCount'] as int? ?? 0,
      atmCount: json['atmCount'] as int? ?? 0,
      socialMedia: (json['socialMedia'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as String)) ??
          {},
      productSections: productSections,
      keywords: List<String>.from(json['keywords'] as List<dynamic>? ?? const []),
      rating: (json['rating'] as num?)?.toDouble() ?? 4.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fullName': fullName,
      'description': description,
      'slogan': slogan,
      'logoAsset': logoAsset,
      'category': category,
      'website': website,
      'internetBanking': internetBanking,
      'mobileApp': mobileApp,
      'mobileAppAndroidUrl': mobileAppAndroidUrl,
      'mobileAppIosUrl': mobileAppIosUrl,
      'helpline': helpline,
      'smsBanking': smsBanking,
      'whatsappBanking': whatsappBanking,
      'customerCare': customerCare,
      'email': email,
      'branchLocator': branchLocator,
      'creditCards': creditCards,
      'debitCards': debitCards,
      'islamicBanking': islamicBanking,
      'roshanDigitalAccount': roshanDigitalAccount,
      'roshanDigitalAccountUrl': roshanDigitalAccountUrl,
      'swiftCode': swiftCode,
      'openAccountUrl': openAccountUrl,
      'downloadAppUrl': downloadAppUrl,
      'establishedYear': establishedYear,
      'headquarters': headquarters,
      'branchCount': branchCount,
      'atmCount': atmCount,
      'socialMedia': socialMedia,
      'productSections': productSections,
      'keywords': keywords,
      'rating': rating,
    };
  }

  bool matchesSearch(String query) {
    final normalized = query.toLowerCase();
    final fields = [
      name,
      fullName,
      slogan,
      description,
      category,
      swiftCode,
      branchLocator,
      website,
      internetBanking,
      mobileApp,
      helpline,
      smsBanking,
      whatsappBanking,
      customerCare,
      email,
      headquarters,
    ];

    if (fields.any((value) => value.toLowerCase().contains(normalized))) {
      return true;
    }

    if (keywords.any((keyword) => keyword.toLowerCase().contains(normalized))) {
      return true;
    }

    return productSections.values
        .expand((items) => items)
        .any((item) => item.toLowerCase().contains(normalized));
  }
}
