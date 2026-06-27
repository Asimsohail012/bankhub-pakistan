import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for KIBOR (Karachi Interbank Offered Rate) service.
abstract class KiborService {
  /// Fetches current KIBOR rates for various tenors.
  Future<LiveDataResult<List<KiborData>>> getKiborRates();

  /// Fetches KIBOR rate for a specific tenor.
  Future<LiveDataResult<KiborData>> getKiborForTenor(String tenor);

  /// Refreshes KIBOR data from source.
  Future<LiveDataResult<List<KiborData>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of KiborService.
///
/// Currently returns placeholder data. In production, this would
/// connect to SBP or banking data providers for live KIBOR rates.
class KiborServiceImpl implements KiborService {
  static final _placeholderData = [
    KiborData(
      rate: 19.75,
      tenor: '1D',
      change: 0.05,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    KiborData(
      rate: 20.50,
      tenor: '1W',
      change: -0.10,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    KiborData(
      rate: 21.25,
      tenor: '1M',
      change: 0.15,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    KiborData(
      rate: 21.75,
      tenor: '3M',
      change: 0.00,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    KiborData(
      rate: 22.00,
      tenor: '6M',
      change: -0.25,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    KiborData(
      rate: 22.50,
      tenor: '12M',
      change: 0.35,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
  ];

  DateTime? _lastUpdated;

  KiborServiceImpl();

  @override
  Future<LiveDataResult<List<KiborData>>> getKiborRates() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 700));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_kibor',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<KiborData>> getKiborForTenor(String tenor) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final data = _placeholderData.firstWhere((k) => k.tenor == tenor);
      _lastUpdated = DateTime.now();
      return LiveDataResult.success(
        data: data,
        source: 'placeholder_kibor',
        lastUpdated: _lastUpdated!.toIso8601String(),
      );
    } catch (_) {
      return LiveDataResult.error(
        message: 'KIBOR rate not found for tenor: $tenor',
        source: 'kibor_api',
      );
    }
  }

  @override
  Future<LiveDataResult<List<KiborData>>> refresh() => getKiborRates();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'kibor_api';
}
