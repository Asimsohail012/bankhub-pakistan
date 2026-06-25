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
    return GoldPrice(
      metal: json['metal'] as String,
      karat: json['karat'] as String,
      pricePer10g: json['pricePer10g'] as String,
      change: json['change'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metal': metal,
      'karat': karat,
      'pricePer10g': pricePer10g,
      'change': change,
    };
  }
}
