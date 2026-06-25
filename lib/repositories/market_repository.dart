import '../models/gold_price.dart';
import '../models/financial_indicator.dart';
import '../services/gold_price_service.dart';
import '../services/financial_market_service.dart';

class MarketRepository {
  final GoldPriceService _goldService;
  final FinancialMarketService _marketService;

  MarketRepository({
    GoldPriceService? goldService,
    FinancialMarketService? marketService,
  })  : _goldService = goldService ?? GoldPriceService(),
        _marketService = marketService ?? FinancialMarketService();

  Future<List<GoldPrice>> getGoldPrices() async {
    return _goldService.fetchGoldPrices();
  }

  Future<List<FinancialIndicator>> getMarketIndicators() async {
    return _marketService.fetchMarketIndicators();
  }
}
