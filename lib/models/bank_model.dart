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

  final String branchLocator;
  final String creditCards;
  final String debitCards;
  final String islamicBanking;
  final bool roshanDigitalAccount;
  final String roshanDigitalAccountUrl;
  final String swiftCode;

  final String openAccountUrl;
  final String downloadAppUrl;

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
    required this.branchLocator,
    required this.creditCards,
    required this.debitCards,
    required this.islamicBanking,
    required this.roshanDigitalAccount,
    required this.roshanDigitalAccountUrl,
    required this.swiftCode,
    required this.openAccountUrl,
    required this.downloadAppUrl,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
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
      branchLocator: json['branchLocator'] as String,
      creditCards: json['creditCards'] as String,
      debitCards: json['debitCards'] as String,
      islamicBanking: json['islamicBanking'] as String,
      roshanDigitalAccount: json['roshanDigitalAccount'] as bool,
      roshanDigitalAccountUrl: json['roshanDigitalAccountUrl'] as String,
      swiftCode: json['swiftCode'] as String,
      openAccountUrl: json['openAccountUrl'] as String,
      downloadAppUrl: json['downloadAppUrl'] as String,
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
      'branchLocator': branchLocator,
      'creditCards': creditCards,
      'debitCards': debitCards,
      'islamicBanking': islamicBanking,
      'roshanDigitalAccount': roshanDigitalAccount,
      'roshanDigitalAccountUrl': roshanDigitalAccountUrl,
      'swiftCode': swiftCode,
      'openAccountUrl': openAccountUrl,
      'downloadAppUrl': downloadAppUrl,
    };
  }
}
