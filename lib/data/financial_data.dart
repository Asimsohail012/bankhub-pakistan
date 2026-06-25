import '../models/financial_indicator.dart';

const List<FinancialIndicator> financialIndicators = [
  FinancialIndicator(
    label: 'KIBOR (3M)',
    value: '20.50%',
    trend: '+15bps',
  ),
  FinancialIndicator(
    label: 'Policy Rate',
    value: '22.75%',
    trend: '+25bps',
  ),
  FinancialIndicator(
    label: 'Inflation',
    value: '27.1%',
    trend: '+0.4%',
  ),
  FinancialIndicator(
    label: 'KSE-100',
    value: '62,850.45',
    trend: '+1.3%',
  ),
];
