import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for gold price service.
abstract class GoldPriceService {
  /// Fetches current gold prices in various units.
  Future<LiveDataResult<GoldPriceData>> getGoldPrices();

  /// Refreshes gold price data from source.
  Future<LiveDataResult<GoldPriceData>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of GoldPriceService.
///
/// Currently returns placeholder data. In production, this would
/// connect to live gold price data providers or APIs.
class GoldPriceServiceImpl implements GoldPriceService {
  static final _placeholderData = GoldPriceData(
    pricePerGram: 7850,
    pricePerTola: 91620,
    pricePerOunce: 244125,
    dailyChange: 125,
    lastUpdated: DateTime.now().toIso8601String(),
  );

  DateTime? _lastUpdated;

  GoldPriceServiceImpl();

  @override
  Future<LiveDataResult<GoldPriceData>> getGoldPrices() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_gold_prices',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<GoldPriceData>> refresh() => getGoldPrices();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'gold_price_api';
}
