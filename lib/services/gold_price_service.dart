import '../models/gold_price.dart';
import '../data/gold_data.dart';
import 'api_client.dart';

class GoldPriceService {
  final ApiClient _apiClient;

  GoldPriceService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<GoldPrice>> fetchGoldPrices() async {
    const cacheKey = 'gold_prices';
    final uri = Uri.parse('https://api.example.com/gold-prices');

    final result = await _apiClient.fetchListWithCache<GoldPrice>(
      cacheKey,
      uri,
      (json) => GoldPrice.fromJson(json),
      fallback: preciousMetals,
    );

    return result.data;
  }
}
