import '../models/exchange_rate.dart';
import '../services/exchange_rate_service.dart';

class ExchangeRepository {
  final ExchangeRateService _service;

  ExchangeRepository({ExchangeRateService? service}) : _service = service ?? ExchangeRateService();

  Future<List<ExchangeRate>> getExchangeRates() async {
    return _service.fetchExchangeRates();
  }
}
