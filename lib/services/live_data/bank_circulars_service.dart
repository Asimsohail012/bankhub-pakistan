import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for bank circulars service.
abstract class BankCircularsService {
  /// Fetches recent bank circulars and announcements.
  Future<LiveDataResult<List<BankCircular>>> getCirculars();

  /// Fetches circulars by source (e.g., 'SBP', 'Bank Name').
  Future<LiveDataResult<List<BankCircular>>> getCircularsBySource(
    String source,
  );

  /// Searches circulars by keyword.
  Future<LiveDataResult<List<BankCircular>>> searchCirculars(String query);

  /// Refreshes circulars from source.
  Future<LiveDataResult<List<BankCircular>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankCircularsService.
///
/// Currently returns placeholder data. In production, this would
/// connect to SBP or bank websites for regulatory circulars.
class BankCircularsServiceImpl implements BankCircularsService {
  static final _placeholderData = [
    BankCircular(
      id: 'circ_001',
      title: 'Updated KYC Requirements',
      content: 'All banks must update KYC procedures as per new guidelines...',
      source: 'SBP',
      issuedDate: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      effectiveDate: DateTime.now().add(const Duration(days: 10)).toIso8601String(),
    ),
    BankCircular(
      id: 'circ_002',
      title: 'Foreign Remittance Processing Update',
      content: 'New processing timelines for international remittances...',
      source: 'SBP',
      issuedDate: DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      effectiveDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
    ),
    BankCircular(
      id: 'circ_003',
      title: 'Digital Banking Security Standards',
      content: 'Enhanced security requirements for digital banking platforms...',
      source: 'SBP',
      issuedDate: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      effectiveDate: null,
    ),
  ];

  DateTime? _lastUpdated;

  BankCircularsServiceImpl();

  @override
  Future<LiveDataResult<List<BankCircular>>> getCirculars() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 700));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_bank_circulars',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankCircular>>> getCircularsBySource(
    String source,
  ) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    final filtered =
        _placeholderData.where((c) => c.source == source).toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_bank_circulars',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankCircular>>> searchCirculars(
    String query,
  ) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 650));

    final lower = query.toLowerCase();
    final filtered = _placeholderData
        .where(
          (circular) =>
              circular.title.toLowerCase().contains(lower) ||
              circular.content.toLowerCase().contains(lower),
        )
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_bank_circulars',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankCircular>>> refresh() => getCirculars();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'bank_circulars_api';
}
