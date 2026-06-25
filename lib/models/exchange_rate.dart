class ExchangeRate {
  final String currency;
  final String code;
  final double buyRate;
  final double sellRate;
  final String change;

  const ExchangeRate({
    required this.currency,
    required this.code,
    required this.buyRate,
    required this.sellRate,
    required this.change,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      currency: json['currency'] as String,
      code: json['code'] as String,
      buyRate: (json['buyRate'] as num).toDouble(),
      sellRate: (json['sellRate'] as num).toDouble(),
      change: json['change'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'code': code,
      'buyRate': buyRate,
      'sellRate': sellRate,
      'change': change,
    };
  }
}
