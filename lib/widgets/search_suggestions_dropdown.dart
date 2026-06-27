import 'package:flutter/material.dart';
import '../models/search_suggestion.dart';

/// Widget that displays search suggestions in a dropdown list.
class SearchSuggestionsDropdown extends StatelessWidget {
  final List<SearchSuggestion> suggestions;
  final Function(SearchSuggestion) onSuggestionSelected;
  final bool isLoading;

  const SearchSuggestionsDropdown({
    super.key,
    required this.suggestions,
    required this.onSuggestionSelected,
    this.isLoading = false,
  });

  IconData _getIconData(String? icon) {
    switch (icon) {
      case 'history':
        return Icons.history;
      case 'trending_up':
        return Icons.trending_up;
      case 'account_balance':
        return Icons.account_balance;
      case 'newspaper':
        return Icons.newspaper;
      case 'work':
        return Icons.work;
      default:
        return Icons.search;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (suggestions.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'No suggestions found',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: suggestions.length,
          separatorBuilder: (_, _) => Divider(height: 1, color: Colors.grey.shade200),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              leading: Icon(
                _getIconData(suggestion.icon),
                size: 18,
                color: Colors.grey.shade600,
              ),
              title: Text(suggestion.text),
              subtitle: suggestion.subtitle != null
                  ? Text(
                      suggestion.subtitle!,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    )
                  : null,
              trailing: Icon(
                Icons.arrow_outward,
                size: 16,
                color: Colors.grey.shade400,
              ),
              onTap: () => onSuggestionSelected(suggestion),
            );
          },
        ),
      ),
    );
  }
}
