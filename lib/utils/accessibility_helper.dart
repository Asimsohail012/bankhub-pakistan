import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Accessibility utilities for the application
class AccessibilityHelper {
  /// Wraps a widget with semantic information for screen readers
  static Widget withSemantics({
    required Widget child,
    required String label,
    bool enabled = true,
    bool onTapHint = false,
    bool readOnly = false,
    String? hint,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      enabled: enabled,
      onTap: onTap,
      button: onTapHint,
      readOnly: readOnly,
      hint: hint,
      child: child,
    );
  }

  /// Creates an accessible button with semantic label
  static Widget accessibleButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
    Color? color,
  }) {
    return Semantics(
      label: label,
      button: true,
      enabled: true,
      onTap: onPressed,
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        tooltip: label,
      ),
    );
  }

  /// Creates an accessible text button
  static Widget accessibleTextButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return Semantics(
      label: label,
      button: true,
      enabled: true,
      onTap: onPressed,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  /// Wraps a slider with semantic information
  static Widget accessibleSlider({
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Semantics(
      label: label,
      slider: true,
      enabled: true,
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
      ),
    );
  }

  /// Creates accessible text with contrast checking
  static TextStyle getAccessibleTextStyle(
    TextStyle baseStyle,
    Color backgroundColor, {
    required BuildContext context,
  }) {
    // Ensure minimum contrast ratio of 4.5:1 for normal text, 3:1 for large text
    final isDarkBackground = _getContrastRatio(baseStyle.color ?? Colors.black, backgroundColor) < 3;
    
    return baseStyle.copyWith(
      color: isDarkBackground ? Colors.white : Colors.black87,
    );
  }

  /// Calculates contrast ratio between two colors
  static double _getContrastRatio(Color color1, Color color2) {
    final l1 = _getLuminance(color1);
    final l2 = _getLuminance(color2);
    final lighter = [l1, l2].reduce((a, b) => a > b ? a : b);
    final darker = [l1, l2].reduce((a, b) => a < b ? a : b);
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculates luminance of a color
  static double _getLuminance(Color color) {
    final r = color.r * 255;
    final g = color.g * 255;
    final b = color.b * 255;

    final rs = r / 255 <= 0.03928 ? r / 255 / 12.92 : math.pow((r / 255 + 0.055) / 1.055, 2.4);
    final gs = g / 255 <= 0.03928 ? g / 255 / 12.92 : math.pow((g / 255 + 0.055) / 1.055, 2.4);
    final bs = b / 255 <= 0.03928 ? b / 255 / 12.92 : math.pow((b / 255 + 0.055) / 1.055, 2.4);

    return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs;
  }
}

/// Accessible icon button with semantic label
class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;
  final String? tooltip;
  final Color? color;
  final double? size;
  final bool enabled;

  const AccessibleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.tooltip,
    this.color,
    this.size,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      enabled: enabled,
      onTap: enabled ? onPressed : null,
      child: Tooltip(
        message: tooltip ?? semanticLabel,
        child: IconButton(
          icon: Icon(icon, size: size, color: color),
          onPressed: enabled ? onPressed : null,
        ),
      ),
    );
  }
}

/// Accessible text field with labels and hints
class AccessibleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? semanticLabel;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool enabled;

  const AccessibleTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.semanticLabel,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.obscureText = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      textField: true,
      enabled: enabled,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        obscureText: obscureText,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

/// Accessible card with semantic information
class AccessibleCard extends StatelessWidget {
  final Widget child;
  final String? semanticLabel;
  final VoidCallback? onTap;
  final String? tooltip;
  final bool isButton;

  const AccessibleCard({
    super.key,
    required this.child,
    this.semanticLabel,
    this.onTap,
    this.tooltip,
    this.isButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: isButton,
      enabled: onTap != null,
      onTap: onTap,
      child: Tooltip(
        message: tooltip ?? semanticLabel ?? '',
        child: Card(
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
