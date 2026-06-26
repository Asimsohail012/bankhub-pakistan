import 'bank_category.dart';
import 'bank_product.dart';

/// Immutable data-layer model for a bank operating in Pakistan.
///
/// Distinct from [lib/models/bank_model.dart] which is used by the UI layer.
class PakBankModel {
  final String id;
  final String name;
  final String shortName;
  final BankCategory category;
  final String description;
  final String website;
  final String helpline;
  final String headOffice;
  final String swiftCode;
  final int establishedYear;
  final bool mobileBanking;
  final bool internetBanking;
  final double rating;
  final bool favorite;
  final List<BankProduct> products;

  const PakBankModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.category,
    required this.description,
    required this.website,
    required this.helpline,
    required this.headOffice,
    required this.swiftCode,
    required this.establishedYear,
    required this.mobileBanking,
    required this.internetBanking,
    this.rating = 0.0,
    this.favorite = false,
    this.products = const [],
  });

  PakBankModel copyWith({
    String? id,
    String? name,
    String? shortName,
    BankCategory? category,
    String? description,
    String? website,
    String? helpline,
    String? headOffice,
    String? swiftCode,
    int? establishedYear,
    bool? mobileBanking,
    bool? internetBanking,
    double? rating,
    bool? favorite,
    List<BankProduct>? products,
  }) {
    return PakBankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      category: category ?? this.category,
      description: description ?? this.description,
      website: website ?? this.website,
      helpline: helpline ?? this.helpline,
      headOffice: headOffice ?? this.headOffice,
      swiftCode: swiftCode ?? this.swiftCode,
      establishedYear: establishedYear ?? this.establishedYear,
      mobileBanking: mobileBanking ?? this.mobileBanking,
      internetBanking: internetBanking ?? this.internetBanking,
      rating: rating ?? this.rating,
      favorite: favorite ?? this.favorite,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
      'category': category.toJson(),
      'description': description,
      'website': website,
      'helpline': helpline,
      'headOffice': headOffice,
      'swiftCode': swiftCode,
      'establishedYear': establishedYear,
      'mobileBanking': mobileBanking,
      'internetBanking': internetBanking,
      'rating': rating,
      'favorite': favorite,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }

  factory PakBankModel.fromJson(Map<String, dynamic> json) {
    final productList = (json['products'] as List<dynamic>?)
            ?.map((p) => BankProduct.fromJson(p as String))
            .toList() ??
        const [];

    return PakBankModel(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      category: BankCategory.fromJson(json['category'] as String),
      description: json['description'] as String,
      website: json['website'] as String,
      helpline: json['helpline'] as String,
      headOffice: json['headOffice'] as String,
      swiftCode: json['swiftCode'] as String,
      establishedYear: json['establishedYear'] as int,
      mobileBanking: json['mobileBanking'] as bool,
      internetBanking: json['internetBanking'] as bool,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      favorite: json['favorite'] as bool? ?? false,
      products: productList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PakBankModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PakBankModel(id: $id, name: $name)';
}
