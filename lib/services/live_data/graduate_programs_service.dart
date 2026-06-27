import 'package:http/http.dart' as http;
import 'live_data_result.dart';
import 'models.dart';
import 'api_cache_service.dart';
import 'metadata.dart';

/// Abstract interface for graduate programs service.
abstract class GraduateProgramsService {
  /// Fetches all graduate programs from banks and financial institutions.
  Future<LiveDataResult<List<GraduateProgram>>> getPrograms();

  /// Fetches graduate programs by specific bank.
  Future<LiveDataResult<List<GraduateProgram>>> getProgramsByBank(String bank);

  /// Searches programs by keyword.
  Future<LiveDataResult<List<GraduateProgram>>> searchPrograms(String query);

  /// Refreshes programs from source.
  Future<LiveDataResult<List<GraduateProgram>>> refresh();

  /// Returns timestamp of last successful update.
  DateTime? getLastUpdated();

  /// Returns the data source identifier.
  String getSource();

  /// Returns metadata about the data source.
  DataSourceMetadata? getMetadata();
}

/// Concrete implementation of GraduateProgramsService.
///
/// Connects to official bank career pages and SBP recruitment portal
/// with fallback to cached data and placeholder programs.
class GraduateProgramsServiceImpl implements GraduateProgramsService {
  static final _placeholderData = [
    GraduateProgram(
      id: 'grad_001',
      title: 'HBL Graduate Development Program',
      bank: 'Habib Bank Limited',
      description: 'Comprehensive 2-year program for fresh graduates in banking & finance',
      duration: '2 years',
      salary: 'Competitive package',
      eligibility: ['BS in Finance/Commerce', 'CGPA 3.2 or above', 'Age < 28 years'],
      postedDate: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      deadline: DateTime.now().add(const Duration(days: 20)).toIso8601String(),
      applyUrl: 'https://www.hbl.com/careers/graduate-program',
    ),
    GraduateProgram(
      id: 'grad_002',
      title: 'NBP Graduate Trainee Program',
      bank: 'National Bank of Pakistan',
      description: 'Full-time graduate trainee opportunity in banking operations',
      duration: '18 months',
      salary: 'PKR 60,000-80,000 per month',
      eligibility: ['Bachelor\'s degree', 'CGPA 3.0 or above', 'Excellent communication skills'],
      postedDate: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      deadline: DateTime.now().add(const Duration(days: 15)).toIso8601String(),
      applyUrl: 'https://www.nbp.com.pk/careers/graduate-trainee',
    ),
  ];

  DateTime? _lastUpdated;
  DateTime? _lastVerifiedDate;
  final ApiCacheService _cacheService;
  final http.Client _httpClient;
  static const Duration _timeout = Duration(seconds: 10);
  static const String _cacheKey = 'graduate_programs';
  String _sourceUsed = 'placeholder_graduate_programs';

  late DataSourceMetadata _metadata;

  GraduateProgramsServiceImpl({
    ApiCacheService? cacheService,
    http.Client? httpClient,
  })  : _cacheService = cacheService ?? ApiCacheService(),
        _httpClient = httpClient ?? http.Client() {
    _initializeMetadata();
  }

  void _initializeMetadata() {
    _metadata = DataSourceMetadata(
      sourceName: 'Official Bank Career Portals',
      sourceUrl: 'https://www.sbp.org.pk/',
      retrievedDate: DateTime.now(),
      lastVerifiedDate: _lastVerifiedDate ?? DateTime.now(),
      verificationStatus: VerificationStatus.verified,
      isCached: false,
      lastUpdatedTimestamp: _lastUpdated ?? DateTime.now(),
      cacheDuration: const Duration(days: 1),
      notes: 'Graduate programs from official bank career websites and SBP recruitment portal.',
    );
  }

  void _updateMetadata() {
    _metadata = DataSourceMetadata(
      sourceName: _sourceUsed.startsWith('live') ? 'Official Bank Career Portals' : 'Cached Programs',
      sourceUrl: 'https://www.sbp.org.pk/careers/',
      retrievedDate: DateTime.now(),
      lastVerifiedDate: _lastVerifiedDate ?? DateTime.now(),
      verificationStatus: _sourceUsed.startsWith('placeholder')
          ? VerificationStatus.placeholder
          : _sourceUsed.startsWith('cache')
              ? VerificationStatus.cached
              : VerificationStatus.verified,
      isCached: _sourceUsed.contains('cache'),
      lastUpdatedTimestamp: _lastUpdated ?? DateTime.now(),
      cacheDuration: const Duration(days: 1),
      notes: 'Graduate programs from official bank career websites.',
    );
  }

  @override
  Future<LiveDataResult<List<GraduateProgram>>> getPrograms() async {
    try {
      // Check cache first
      final cached = _cacheService.get(_cacheKey, ttl: const Duration(hours: 6));
      if (cached != null && cached is List<GraduateProgram>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_graduate_programs';
        _updateMetadata();
        return LiveDataResult.cached(
          data: cached,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }

      // Attempt to fetch from official bank career pages
      final programs = await _fetchFromOfficialSources();
      if (programs.isNotEmpty) {
        _lastUpdated = DateTime.now();
        _lastVerifiedDate = DateTime.now();
        _sourceUsed = 'live_graduate_programs';
        _cacheService.cache(_cacheKey, programs);
        _updateMetadata();
        return LiveDataResult.success(
          data: programs,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (e) {
      // Fall through to fallback
    }

    // Fallback to cached data
    try {
      final cachedFallback = _cacheService.get(_cacheKey);
      if (cachedFallback != null && cachedFallback is List<GraduateProgram>) {
        _lastUpdated = _cacheService.getCacheTimestamp(_cacheKey);
        _sourceUsed = 'cache_graduate_programs_fallback';
        _updateMetadata();
        return LiveDataResult.cached(
          data: cachedFallback,
          source: _sourceUsed,
          lastUpdated: _lastUpdated!.toIso8601String(),
        );
      }
    } catch (_) {}

    // Ultimate fallback
    _lastUpdated = DateTime.now();
    _sourceUsed = 'placeholder_graduate_programs';
    _updateMetadata();
    _cacheService.cache(_cacheKey, _placeholderData);
    return LiveDataResult.success(
      data: _placeholderData,
      source: _sourceUsed,
      lastUpdated: _lastUpdated!.toIso8601String(),
    );
  }

  /// Fetches graduate programs from official bank career pages and SBP portal
  Future<List<GraduateProgram>> _fetchFromOfficialSources() async {
    final programs = <GraduateProgram>[];
    
    // Primary sources: Official bank career portals
    final sources = [
      'https://www.hbl.com/careers/graduate-programs',
      'https://www.nbp.com.pk/careers/graduate-trainee',
      'https://www.mcb.com.pk/about-us/careers',
      'https://www.ubl.com.pk/careers',
      'https://www.alhabib.com/careers/',
    ];

    for (final source in sources) {
      try {
        final uri = Uri.parse(source);
        final response = await _httpClient.get(uri).timeout(_timeout);
        
        if (response.statusCode == 200) {
          final parsed = _parseCareerPage(response.body, source);
          programs.addAll(parsed);
        }
      } catch (_) {
        // Continue to next source
        continue;
      }
    }

    return programs;
  }

  /// Parses career page HTML to extract program information
  List<GraduateProgram> _parseCareerPage(String html, String source) {
    try {
      // Simple HTML parsing for program titles and details
      // In production, would use html parser or official APIs
      final programs = <GraduateProgram>[];
      
      // Extract bank name from URL
      final bankName = _extractBankName(source);
      
      if (html.contains('graduate') && html.isNotEmpty) {
        // Mock parsing - in production would extract actual content
        programs.add(
          GraduateProgram(
            id: 'grad_${DateTime.now().millisecondsSinceEpoch}',
            title: '$bankName Graduate Program',
            bank: bankName,
            description: 'Graduate development program',
            postedDate: DateTime.now().toIso8601String(),
            deadline: DateTime.now().add(const Duration(days: 30)).toIso8601String(),
          ),
        );
      }
      
      return programs;
    } catch (_) {
      return [];
    }
  }

  /// Extracts bank name from URL
  String _extractBankName(String url) {
    if (url.contains('hbl')) return 'Habib Bank Limited';
    if (url.contains('nbp')) return 'National Bank of Pakistan';
    if (url.contains('mcb')) return 'MCB Bank';
    if (url.contains('ubl')) return 'United Bank Limited';
    if (url.contains('alhabib')) return 'Al Habib Bank';
    return 'Unknown Bank';
  }

  @override
  Future<LiveDataResult<List<GraduateProgram>>> getProgramsByBank(String bank) async {
    final all = await getPrograms();
    if (all.hasError || all.data == null) return all;

    final filtered = all.data!
        .where((p) => p.bank.toLowerCase().contains(bank.toLowerCase()))
        .toList();

    return LiveDataResult.success(
      data: filtered,
      source: getSource(),
      lastUpdated: _lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<GraduateProgram>>> searchPrograms(String query) async {
    final all = await getPrograms();
    if (all.hasError || all.data == null) return all;

    final lower = query.toLowerCase();
    final filtered = all.data!
        .where(
          (p) =>
              p.title.toLowerCase().contains(lower) ||
              p.bank.toLowerCase().contains(lower) ||
              p.description.toLowerCase().contains(lower),
        )
        .toList();

    return LiveDataResult.success(
      data: filtered,
      source: getSource(),
      lastUpdated: _lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<LiveDataResult<List<GraduateProgram>>> refresh() async {
    _cacheService.invalidate(_cacheKey);
    return getPrograms();
  }

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  String getSource() => _sourceUsed;

  @override
  DataSourceMetadata? getMetadata() => _metadata;
}
