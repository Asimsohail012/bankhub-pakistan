import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Premium animated search bar with voice input support.
class PremiumSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onVoicePressed;
  final String hintText;
  final bool showVoiceButton;

  const PremiumSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onVoicePressed,
    this.hintText = 'Search banks, IBAN, cards...',
    this.showVoiceButton = true,
  });

  @override
  State<PremiumSearchBar> createState() => _PremiumSearchBarState();
}

class _PremiumSearchBarState extends State<PremiumSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _focusController;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
    if (_focusNode.hasFocus) {
      _focusController.forward();
    } else {
      _focusController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _focusController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withValues(
                  alpha: 0.08 + (_focusController.value * 0.12),
                ),
                blurRadius: 12 + (_focusController.value * 8),
                offset: Offset(0, 2 + (_focusController.value * 2)),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showVoiceButton)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onVoicePressed,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.mic_none_rounded,
                            color: _isFocused
                                ? AppColors.secondary
                                : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  if (widget.controller.text.isNotEmpty)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.controller.clear();
                          widget.onChanged?.call('');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.close_rounded,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
              ),
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }
}
