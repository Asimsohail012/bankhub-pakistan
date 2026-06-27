import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for financial calendar service.
abstract class FinancialCalendarService {
  /// Fetches upcoming financial calendar events.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getUpcomingEvents();

  /// Fetches events for a specific category.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getEventsByCategory(
    String category,
  );

  /// Fetches events by importance level.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getEventsByImportance(
    String importance,
  );

  /// Refreshes calendar events from source.
  Future<LiveDataResult<List<FinancialCalendarEvent>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of FinancialCalendarService.
///
/// Currently returns placeholder data. In production, this would
/// connect to financial calendar data providers or economic calendars.
class FinancialCalendarServiceImpl implements FinancialCalendarService {
  static final _placeholderData = [
    FinancialCalendarEvent(
      id: 'event_001',
      name: 'SBP Monetary Policy Decision',
      category: 'Policy',
      scheduledDate: DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      importance: 'High',
      description: 'State Bank of Pakistan announces policy rate decision',
    ),
    FinancialCalendarEvent(
      id: 'event_002',
      name: 'US Federal Reserve Meeting',
      category: 'Global',
      scheduledDate: DateTime.now().add(const Duration(days: 10)).toIso8601String(),
      importance: 'High',
      description: 'Federal Reserve FOMC meeting and interest rate decision',
    ),
    FinancialCalendarEvent(
      id: 'event_003',
      name: 'Quarterly GDP Release',
      category: 'Economic',
      scheduledDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      importance: 'Medium',
      description: 'Quarterly GDP growth figures release',
    ),
    FinancialCalendarEvent(
      id: 'event_004',
      name: 'Inflation Data Release',
      category: 'Economic',
      scheduledDate: DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      importance: 'High',
      description: 'Consumer Price Index and inflation figures',
    ),
    FinancialCalendarEvent(
      id: 'event_005',
      name: 'Stock Exchange Trading',
      category: 'Market',
      scheduledDate: DateTime.now().toIso8601String(),
      importance: 'Low',
      description: 'Regular PSX trading session',
    ),
  ];

  DateTime? _lastUpdated;

  FinancialCalendarServiceImpl();

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>> getUpcomingEvents() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 700));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_financial_calendar',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>>
      getEventsByCategory(String category) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    final filtered = _placeholderData
        .where((event) => event.category == category)
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_financial_calendar',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>>
      getEventsByImportance(String importance) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    final filtered = _placeholderData
        .where((event) => event.importance == importance)
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_financial_calendar',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<FinancialCalendarEvent>>> refresh() =>
      getUpcomingEvents();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'financial_calendar_api';
}
