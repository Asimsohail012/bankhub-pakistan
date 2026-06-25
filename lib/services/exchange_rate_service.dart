import '../models/exchange_rate.dart';
import '../data/exchange_rate_data.dart';
import 'api_client.dart';

class ExchangeRateService {
  final ApiClient _apiClient;

  ExchangeRateService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<ExchangeRate>> fetchExchangeRates() async {
    const cacheKey = 'exchange_rates';
    final uri = Uri.parse('https://api.example.com/exchange-rates');

    final result = await _apiClient.fetchListWithCache<ExchangeRate>(
      cacheKey,
      uri,
      (json) => ExchangeRate.fromJson(json),
      fallback: liveExchangeRates,
    );

    return result.data ?? [];
  }
}
