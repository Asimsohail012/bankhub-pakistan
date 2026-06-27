import 'package:flutter/material.dart';

/// Reusable animation curves and transitions for premium UI.
class AppAnimations {
  /// Smooth easing curve for page transitions
  static const pageTransitionCurve = Curves.easeOut;

  /// Duration for standard animations (e.g., card entrance, button press)
  static const standardDuration = Duration(milliseconds: 300);

  /// Duration for smooth transitions (e.g., page navigation)
  static const transitionDuration = Duration(milliseconds: 400);

  /// Duration for slow animations (e.g., floating action button entrance)
  static const slowDuration = Duration(milliseconds: 500);

  /// Fade and slide transition for widgets entering the screen
  static SlideTransition buildSlideTransition(
    Animation<double> animation,
    Widget child, {
    Offset beginOffset = const Offset(0, 0.1),
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Fade transition for smooth visibility changes
  static FadeTransition buildFadeTransition(
    Animation<double> animation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  /// Scale and fade transition for dialog/bottom sheet entrance
  static ScaleTransition buildScaleTransition(
    Animation<double> animation,
    Widget child, {
    double beginScale = 0.95,
  }) {
    return ScaleTransition(
      scale: Tween<double>(begin: beginScale, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      ),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  /// Build a smooth bounce animation
  static Animation<double> buildBounceAnimation(TickerProvider vsync) {
    final controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );
  }

  /// Page route with custom transition
  static PageRoute<T> buildPageRoute<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return buildSlideTransition(animation, child);
      },
    );
  }
}

/// Extension for easy navigation with premium transitions
extension NavigationExtension on BuildContext {
  Future<T?> pushWithAnimation<T>(Widget page) {
    return Navigator.push<T>(
      this,
      AppAnimations.buildPageRoute(page),
    );
  }

  void popWithAnimation<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }
}
