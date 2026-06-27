import 'package:flutter/material.dart';
import '../models/bank_comparison.dart';
import 'user_preferences_service.dart';

/// Service for managing bank comparison history and bookmarks.
class ComparisonService extends ChangeNotifier {
  final List<BankComparison> _comparisonHistory = [];
  final UserPreferencesService _userPreferencesService;

  List<BankComparison> get comparisonHistory => _comparisonHistory;

  ComparisonService({required this._userPreferencesService});

  /// Create and store a new comparison.
  BankComparison createComparison(List<String> bankIds, {String? name}) {
    final comparison = BankComparison(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      bankIds: bankIds,
      createdAt: DateTime.now(),
      name: name,
    );

    _comparisonHistory.insert(0, comparison);

    // Track frequently compared banks
    for (final bankId in bankIds) {
      _userPreferencesService.addFrequentlyCompared(bankId);
    }

    notifyListeners();
    return comparison;
  }

  /// Get comparison by ID.
  BankComparison? getComparison(String id) {
    try {
      return _comparisonHistory.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Update comparison name.
  void updateComparisonName(String id, String newName) {
    final index = _comparisonHistory.indexWhere((c) => c.id == id);
    if (index != -1) {
      final comparison = _comparisonHistory[index];
      _comparisonHistory[index] = comparison.copyWith(name: newName);
      notifyListeners();
    }
  }

  /// Delete comparison by ID.
  void deleteComparison(String id) {
    _comparisonHistory.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  /// Delete all comparisons.
  void clearHistory() {
    _comparisonHistory.clear();
    notifyListeners();
  }

  /// Get recently compared banks.
  List<String> getRecentlyComparedBanks({int limit = 5}) {
    final banks = <String>[];
    for (final comparison in _comparisonHistory.take(limit)) {
      for (final bankId in comparison.bankIds) {
        if (!banks.contains(bankId)) {
          banks.add(bankId);
        }
      }
    }
    return banks;
  }

  /// Get frequently compared banks (from preferences).
  List<String> getFrequentlyComparedBanks({int limit = 5}) {
    return _userPreferencesService.preferences.frequentlyCompared.take(limit).toList();
  }

  /// Save comparison data cache.
  void updateComparisonData(String id, Map<String, dynamic> data) {
    final index = _comparisonHistory.indexWhere((c) => c.id == id);
    if (index != -1) {
      final comparison = _comparisonHistory[index];
      _comparisonHistory[index] = comparison.copyWith(comparisonData: data);
      notifyListeners();
    }
  }

  /// Get total comparison count.
  int get totalComparisons => _comparisonHistory.length;
}

/// Singleton instance
ComparisonService? _comparisonInstance;

/// Get singleton instance
ComparisonService getComparisonService() {
  _comparisonInstance ??= ComparisonService(
    userPreferencesService: userPreferencesService,
  );
  return _comparisonInstance!;
}
