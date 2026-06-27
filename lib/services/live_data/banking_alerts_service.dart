import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for banking alerts service.
abstract class BankingAlertsService {
  /// Fetches all active banking alerts.
  Future<LiveDataResult<List<BankingAlert>>> getAlerts();

  /// Fetches unread alerts only.
  Future<LiveDataResult<List<BankingAlert>>> getUnreadAlerts();

  /// Fetches alerts for a specific bank.
  Future<LiveDataResult<List<BankingAlert>>> getAlertsByBank(String bankName);

  /// Fetches alerts by severity level.
  Future<LiveDataResult<List<BankingAlert>>> getAlertsBySeverity(String severity);

  /// Searches alerts by keyword.
  Future<LiveDataResult<List<BankingAlert>>> searchAlerts(String query);

  /// Marks an alert as read.
  Future<LiveDataResult<bool>> markAsRead(String alertId);

  /// Dismisses an alert.
  Future<LiveDataResult<bool>> dismissAlert(String alertId);

  /// Refreshes alerts from source.
  Future<LiveDataResult<List<BankingAlert>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankingAlertsService.
///
/// Currently returns placeholder data. In production, this would
/// connect to bank notification systems or alert aggregators.
class BankingAlertsServiceImpl implements BankingAlertsService {
  static final _placeholderData = [
    BankingAlert(
      id: 'alert_001',
      title: 'System Maintenance',
      message: 'HBL Online Banking will be under maintenance on Sunday 2-4 AM',
      type: 'Maintenance',
      severity: 'Medium',
      sourceBank: 'HBL',
      issuedDate: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      expiryDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      read: false,
      action: null,
    ),
    BankingAlert(
      id: 'alert_002',
      title: 'New Regulatory Change',
      message: 'SBP has announced new withholding tax rates for financial transactions',
      type: 'Important',
      severity: 'High',
      sourceBank: 'SBP',
      issuedDate: DateTime.now().subtract(const Duration(hours: 6)).toIso8601String(),
      expiryDate: null,
      read: false,
      action: 'https://www.sbp.org.pk/announcements',
    ),
    BankingAlert(
      id: 'alert_003',
      title: 'Security Update',
      message: 'New security features available in your Bank Alfalah mobile app',
      type: 'Info',
      severity: 'Low',
      sourceBank: 'Bank Alfalah',
      issuedDate: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      expiryDate: null,
      read: true,
      action: 'https://play.google.com/store/apps/details?id=com.bankalfalah',
    ),
    BankingAlert(
      id: 'alert_004',
      title: 'Interest Rate Change',
      message: 'UBL has revised savings account interest rates effective from 1st July',
      type: 'Warning',
      severity: 'Medium',
      sourceBank: 'UBL',
      issuedDate: DateTime.now().subtract(const Duration(hours: 12)).toIso8601String(),
      expiryDate: null,
      read: false,
      action: null,
    ),
    BankingAlert(
      id: 'alert_005',
      title: 'Fraud Alert',
      message: 'Be cautious of unsolicited calls requesting personal information',
      type: 'Warning',
      severity: 'Critical',
      sourceBank: 'System',
      issuedDate: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      expiryDate: null,
      read: false,
      action: null,
    ),
  ];

  DateTime? _lastUpdated;
  final Set<String> _readAlerts = {};
  final Set<String> _dismissedAlerts = {};

  BankingAlertsServiceImpl();

  @override
  Future<LiveDataResult<List<BankingAlert>>> getAlerts() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    _lastUpdated = DateTime.now();
    final filtered = _placeholderData
        .where((alert) => !_dismissedAlerts.contains(alert.id))
        .toList();
    
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingAlert>>> getUnreadAlerts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    final filtered = _placeholderData
        .where(
          (alert) =>
              !_dismissedAlerts.contains(alert.id) &&
              !_readAlerts.contains(alert.id),
        )
        .toList();

    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingAlert>>> getAlertsByBank(
    String bankName,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    final filtered = _placeholderData
        .where(
          (alert) =>
              alert.sourceBank.toLowerCase() == bankName.toLowerCase() &&
              !_dismissedAlerts.contains(alert.id),
        )
        .toList();

    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingAlert>>> getAlertsBySeverity(
    String severity,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    final filtered = _placeholderData
        .where(
          (alert) =>
              alert.severity.toLowerCase() == severity.toLowerCase() &&
              !_dismissedAlerts.contains(alert.id),
        )
        .toList();

    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingAlert>>> searchAlerts(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final lower = query.toLowerCase();
    final filtered = _placeholderData
        .where(
          (alert) =>
              (alert.title.toLowerCase().contains(lower) ||
                  alert.message.toLowerCase().contains(lower) ||
                  alert.sourceBank.toLowerCase().contains(lower)) &&
              !_dismissedAlerts.contains(alert.id),
        )
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<bool>> markAsRead(String alertId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    _readAlerts.add(alertId);
    _lastUpdated = DateTime.now();

    return LiveDataResult.success(
      data: true,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<bool>> dismissAlert(String alertId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    _dismissedAlerts.add(alertId);
    _lastUpdated = DateTime.now();

    return LiveDataResult.success(
      data: true,
      source: 'placeholder_banking_alerts',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankingAlert>>> refresh() => getAlerts();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'banking_alerts_api';
}
