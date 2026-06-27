/// Represents a bank comparison result for history and bookmarking.
class BankComparison {
  final String id; // Unique ID for the comparison
  final List<String> bankIds; // IDs of compared banks
  final DateTime createdAt;
  final String? name; // Optional user-given name for the comparison
  final Map<String, dynamic> comparisonData; // Cached comparison results

  const BankComparison({
    required this.id,
    required this.bankIds,
    required this.createdAt,
    this.name,
    this.comparisonData = const {},
  });

  BankComparison copyWith({
    String? id,
    List<String>? bankIds,
    DateTime? createdAt,
    String? name,
    Map<String, dynamic>? comparisonData,
  }) =>
      BankComparison(
        id: id ?? this.id,
        bankIds: bankIds ?? this.bankIds,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        comparisonData: comparisonData ?? this.comparisonData,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankComparison &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
