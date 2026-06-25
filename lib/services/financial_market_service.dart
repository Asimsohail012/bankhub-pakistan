import '../models/financial_indicator.dart';
import '../data/financial_data.dart';
import 'api_client.dart';

class FinancialMarketService {
  final ApiClient _apiClient;

  FinancialMarketService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<List<FinancialIndicator>> fetchMarketIndicators() async {
    const cacheKey = 'market_indicators';
    final uri = Uri.parse('https://api.example.com/financial-indicators');

    final result = await _apiClient.fetchObjectWithCache<List<FinancialIndicator>>(
      cacheKey,
      uri,
      (json) => FinancialIndicator.fromApiJson(json),
      fallback: financialIndicators,
    );

    return result.data ?? [];
  }
}
