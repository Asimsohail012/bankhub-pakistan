import '../models/exchange_rate.dart';

const List<ExchangeRate> liveExchangeRates = [
  ExchangeRate(
    currency: 'US Dollar',
    code: 'USD',
    buyRate: 309.85,
    sellRate: 311.20,
    change: '+0.22%',
  ),
  ExchangeRate(
    currency: 'British Pound',
    code: 'GBP',
    buyRate: 385.90,
    sellRate: 388.40,
    change: '+0.18%',
  ),
  ExchangeRate(
    currency: 'Euro',
    code: 'EUR',
    buyRate: 334.40,
    sellRate: 336.00,
    change: '+0.14%',
  ),
  ExchangeRate(
    currency: 'Saudi Riyal',
    code: 'SAR',
    buyRate: 82.90,
    sellRate: 83.25,
    change: '+0.08%',
  ),
  ExchangeRate(
    currency: 'UAE Dirham',
    code: 'AED',
    buyRate: 84.55,
    sellRate: 84.90,
    change: '+0.10%',
  ),
];
