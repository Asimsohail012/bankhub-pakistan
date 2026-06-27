import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for exchange rate service.
abstract class ExchangeRateService {
  /// Fetches current exchange rates for major currency pairs.
  Future<LiveDataResult<List<ExchangeRateData>>> getExchangeRates();

  /// Refreshes exchange rate data from source.
  Future<LiveDataResult<List<ExchangeRateData>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of ExchangeRateService.
///
/// Currently returns placeholder data. In production, this would
/// connect to live exchange rate APIs or data providers.
class ExchangeRateServiceImpl implements ExchangeRateService {
  static final _placeholderData = [
    ExchangeRateData(
      currency: 'USD/PKR',
      rate: 279.50,
      change: 0.25,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    ExchangeRateData(
      currency: 'EUR/PKR',
      rate: 305.75,
      change: -0.15,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    ExchangeRateData(
      currency: 'GBP/PKR',
      rate: 352.25,
      change: 0.50,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
    ExchangeRateData(
      currency: 'SAR/PKR',
      rate: 74.50,
      change: 0.10,
      lastUpdated: DateTime.now().toIso8601String(),
    ),
  ];

  DateTime? _lastUpdated;

  ExchangeRateServiceImpl();

  @override
  Future<LiveDataResult<List<ExchangeRateData>>> getExchangeRates() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_exchange_rates',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<ExchangeRateData>>> refresh() =>
      getExchangeRates();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'exchange_rate_api';
}
