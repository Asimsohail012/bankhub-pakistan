class FinancialIndicator {
  final String label;
  final String value;
  final String trend;

  const FinancialIndicator({
    required this.label,
    required this.value,
    required this.trend,
  });

  factory FinancialIndicator.fromJson(Map<String, dynamic> json) {
    return FinancialIndicator(
      label: json['label'] as String,
      value: json['value'] as String,
      trend: json['trend'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'trend': trend,
    };
  }
}
