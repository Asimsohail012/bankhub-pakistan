class GoldPrice {
  final String metal;
  final String karat;
  final String pricePer10g;
  final String change;

  const GoldPrice({
    required this.metal,
    required this.karat,
    required this.pricePer10g,
    required this.change,
  });

  factory GoldPrice.fromJson(Map<String, dynamic> json) {
    final typeValue = json['type'] ?? json['karat'];
    final priceValue = json['price'] ?? json['pricePer10g'];
    return GoldPrice(
      metal: json['metal'] as String,
      karat: typeValue as String,
      pricePer10g: priceValue.toString(),
      change: json['change'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metal': metal,
      'type': karat,
      'price': pricePer10g,
      'change': change,
    };
  }
}
