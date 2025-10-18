// NEW SHIMMER WRAPPER

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Simple shimmer widget wrapper using the shimmer package
/// Automatically adapts to dark/light theme
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape,
  });

  /// Create a circular shimmer (for avatars)
  const ShimmerLoading.circular({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = null,
      shape = const CircleBorder();

  /// Create a rectangular shimmer with rounded corners
  ShimmerLoading.rectangular({
    super.key,
    required this.width,
    required this.height,
    double borderRadiusValue = 8,
  }) : borderRadius = BorderRadius.circular(borderRadiusValue),
       shape = null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      // Base color (the shimmer background)
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,

      // Highlight color (the shimmer wave)
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,

      // Animation direction
      direction: ShimmerDirection.ltr,

      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
        ),
      ),
    );
  }
}
