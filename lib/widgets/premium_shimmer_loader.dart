import 'package:flutter/material.dart';

/// Premium shimmer loading animation widget.
/// 
/// Provides smooth, professional loading placeholders with gradient shimmer effect.
class PremiumShimmerLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final EdgeInsets? margin;

  const PremiumShimmerLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.margin,
  });

  @override
  State<PremiumShimmerLoader> createState() => _PremiumShimmerLoaderState();
}

class _PremiumShimmerLoaderState extends State<PremiumShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation.value * 400, 0),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: const Alignment(-1, 0),
                        end: const Alignment(1, 0),
                        colors: [
                          Colors.white.withValues(alpha: 0),
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ).createShader(bounds);
                    },
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium shimmer grid loader for dashboard cards.
class PremiumShimmerGrid extends StatelessWidget {
  final int crossAxisCount;
  final double spacing;
  final int itemCount;

  const PremiumShimmerGrid({
    super.key,
    this.crossAxisCount = 2,
    this.spacing = 12,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: 1.0,
      children: List.generate(
        itemCount,
        (index) => PremiumShimmerLoader(
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

/// Shimmer loader for list items.
class PremiumShimmerListItem extends StatelessWidget {
  final double height;
  final EdgeInsets? padding;

  const PremiumShimmerListItem({
    super.key,
    this.height = 80,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: PremiumShimmerLoader(
        width: double.infinity,
        height: height,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
