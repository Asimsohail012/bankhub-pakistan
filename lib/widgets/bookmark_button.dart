import 'package:flutter/material.dart';
import '../services/user_preferences_service.dart';

/// Button widget for toggling bookmarks with animation.
class BookmarkButton extends StatefulWidget {
  final String itemId;
  final String itemType; // 'bank', 'news', 'circular', 'job', 'calculator'
  final VoidCallback? onChanged;
  final double size;
  final Color? color;
  final bool showLabel;

  const BookmarkButton({
    super.key,
    required this.itemId,
    required this.itemType,
    this.onChanged,
    this.size = 24,
    this.color,
    this.showLabel = false,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final UserPreferencesService _preferencesService;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _preferencesService = userPreferencesService;
    _updateBookmarkStatus();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateBookmarkStatus() {
    setState(() {
      _isBookmarked = _getIsBookmarked();
    });
  }

  bool _getIsBookmarked() {
    switch (widget.itemType) {
      case 'bank':
        return _preferencesService.isBookmarkedBank(widget.itemId);
      case 'news':
        return _preferencesService.isBookmarkedNews(widget.itemId);
      case 'circular':
        return _preferencesService.isBookmarkedCircular(widget.itemId);
      case 'job':
        return _preferencesService.isBookmarkedJob(widget.itemId);
      case 'calculator':
        return _preferencesService.isBookmarkedCalculator(widget.itemId);
      default:
        return false;
    }
  }

  void _toggleBookmark() {
    switch (widget.itemType) {
      case 'bank':
        _preferencesService.toggleBookmarkBank(widget.itemId);
        break;
      case 'news':
        _preferencesService.toggleBookmarkNews(widget.itemId);
        break;
      case 'circular':
        _preferencesService.toggleBookmarkCircular(widget.itemId);
        break;
      case 'job':
        _preferencesService.toggleBookmarkJob(widget.itemId);
        break;
      case 'calculator':
        _preferencesService.toggleBookmarkCalculator(widget.itemId);
        break;
    }

    _updateBookmarkStatus();
    widget.onChanged?.call();

    // Animate the button
    if (_isBookmarked) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBookmark,
      child: widget.showLabel
          ? Chip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 1, end: 1.2).animate(
                      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
                    ),
                    child: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: widget.size,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(_isBookmarked ? 'Bookmarked' : 'Bookmark'),
                ],
              ),
            )
          : ScaleTransition(
              scale: Tween<double>(begin: 1, end: 1.2).animate(
                CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
              ),
              child: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                size: widget.size,
                color: widget.color ?? Colors.grey,
              ),
            ),
    );
  }
}
