import 'live_data_result.dart';
import 'models.dart';

/// Abstract interface for bank jobs service.
abstract class BankJobsService {
  /// Fetches latest job postings from banks.
  Future<LiveDataResult<List<BankJob>>> getLatestJobs();

  /// Fetches jobs for a specific bank.
  Future<LiveDataResult<List<BankJob>>> getJobsByBank(String bankName);

  /// Searches jobs by keyword, location, or job type.
  Future<LiveDataResult<List<BankJob>>> searchJobs(String query);

  /// Refreshes jobs from source.
  Future<LiveDataResult<List<BankJob>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();
}

/// Concrete implementation of BankJobsService.
///
/// Currently returns placeholder data. In production, this would
/// connect to banking job portals or career websites.
class BankJobsServiceImpl implements BankJobsService {
  static final _placeholderData = [
    BankJob(
      id: 'job_001',
      title: 'Senior Mobile App Developer',
      bank: 'HBL',
      location: 'Karachi',
      jobType: 'Full-time',
      postedDate: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      deadline: DateTime.now().add(const Duration(days: 14)).toIso8601String(),
    ),
    BankJob(
      id: 'job_002',
      title: 'Financial Analyst',
      bank: 'Meezan Bank',
      location: 'Lahore',
      jobType: 'Full-time',
      postedDate: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      deadline: DateTime.now().add(const Duration(days: 21)).toIso8601String(),
    ),
    BankJob(
      id: 'job_003',
      title: 'Customer Service Executive',
      bank: 'Bank Alfalah',
      location: 'Islamabad',
      jobType: 'Full-time',
      postedDate: DateTime.now().toIso8601String(),
      deadline: null,
    ),
  ];

  DateTime? _lastUpdated;

  BankJobsServiceImpl();

  @override
  Future<LiveDataResult<List<BankJob>>> getLatestJobs() async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 700));

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: _placeholderData,
      source: 'placeholder_bank_jobs',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankJob>>> getJobsByBank(String bankName) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 600));

    final filtered = _placeholderData
        .where((job) => job.bank.toLowerCase() == bankName.toLowerCase())
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_bank_jobs',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankJob>>> searchJobs(String query) async {
    // Simulate network delay with timeout placeholder
    await Future.delayed(const Duration(milliseconds: 650));

    final lower = query.toLowerCase();
    final filtered = _placeholderData
        .where(
          (job) =>
              job.title.toLowerCase().contains(lower) ||
              job.bank.toLowerCase().contains(lower) ||
              job.location.toLowerCase().contains(lower) ||
              job.jobType.toLowerCase().contains(lower),
        )
        .toList();

    _lastUpdated = DateTime.now();
    return LiveDataResult.success(
      data: filtered,
      source: 'placeholder_bank_jobs',
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<BankJob>>> refresh() => getLatestJobs();

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => 'bank_jobs_api';
}
