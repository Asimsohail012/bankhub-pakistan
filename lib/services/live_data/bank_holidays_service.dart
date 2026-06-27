import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for bank holidays service.
abstract class BankHolidaysService {
  /// Fetches bank holidays for the current year.
  Future<LiveDataResult<List<BankHoliday>>> getHolidays();

  /// Fetches holidays for a specific year.
  Future<LiveDataResult<List<BankHoliday>>> getHolidaysForYear(int year);

  /// Checks if a specific date is a bank holiday.
  Future<LiveDataResult<bool>> isHoliday(DateTime date);

  /// Refreshes holiday data from source.
  Future<LiveDataResult<List<BankHoliday>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankHolidaysService.
///
/// Currently returns placeholder data. In production, this would
/// connect to SBP or banking association holiday calendars.
class BankHolidaysServiceImpl implements BankHolidaysService {
  static final _placeholderData = [
    BankHoliday(
      date: '2024-08-14',
      name: 'Independence Day',
      description: 'Pakistan Independence Day',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-09-23',
      name: 'Iqbal Day',
      description: 'Allama Iqbal Day',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-12-25',
      name: 'Quaid-e-Azam Day',
      description: 'Birthday of Muhammad Ali Jinnah',
      isNational: true,
    ),
    BankHoliday(
      date: '2024-12-31',
      name: 'Bank Closing',
      description: 'Year-end bank closing',
      isNational: false,
    ),
  ];

  DateTime? _lastUpdated;

  BankHolidaysServiceImpl();

  @override
  Future<LiveDataResult<List<BankHoliday>>> getHolidays() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_bank_holidays',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankHoliday>>> getHolidaysForYear(
    int year,
  ) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 500));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_bank_holidays',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<bool>> isHoliday(DateTime date) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 400));

    final dateStr = date.toIso8601String().split('T')[0];
    final isHoliday =
        _placeholderData.any((holiday) => holiday.date == dateStr);

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: isHoliday,
      source: 'placeholder_bank_holidays',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankHoliday>>> refresh() => getHolidays();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'bank_holidays_api';
}
