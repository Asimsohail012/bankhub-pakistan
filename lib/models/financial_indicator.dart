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

  static List<FinancialIndicator> fromApiJson(Map<String, dynamic> json) {
    return [
      FinancialIndicator(
        label: 'KIBOR',
        value: json['kibor'] as String,
        trend: json['kiborTrend'] as String? ?? '',
      ),
      FinancialIndicator(
        label: 'Policy Rate',
        value: json['policyRate'] as String,
        trend: json['policyRateTrend'] as String? ?? '',
      ),
      FinancialIndicator(
        label: 'Inflation',
        value: json['inflation'] as String,
        trend: json['inflationTrend'] as String? ?? '',
      ),
      if (json.containsKey('kse100'))
        FinancialIndicator(
          label: 'KSE-100',
          value: json['kse100'] as String,
          trend: json['kse100Trend'] as String? ?? '',
        ),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'trend': trend,
    };
  }
}
