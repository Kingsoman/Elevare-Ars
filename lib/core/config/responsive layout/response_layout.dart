import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? leftColumn;
  final Widget centerColumn;
  final Widget? rightColumn;

  const ResponsiveLayout({
    super.key,
    this.leftColumn,
    required this.centerColumn,
    this.rightColumn,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // Large Desktop (> 1600px): Centered, 3-column layout with max width
        if (maxWidth > 1600) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1600),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (leftColumn != null) Flexible(flex: 3, child: leftColumn!),
                  const SizedBox(width: 24),
                  Flexible(flex: 6, child: centerColumn),
                  const SizedBox(width: 24),
                  if (rightColumn != null)
                    Flexible(flex: 3, child: rightColumn!),
                ],
              ),
            ),
          );
        }
        // Desktop (1200px - 1600px): Standard 3-column layout
        else if (maxWidth > 1200) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leftColumn != null) Flexible(flex: 3, child: leftColumn!),
              const SizedBox(width: 16),
              Flexible(flex: 6, child: centerColumn),
              const SizedBox(width: 16),
              if (rightColumn != null) Flexible(flex: 3, child: rightColumn!),
            ],
          );
        }
        // Small Desktop (1000px - 1200px): 2-column layout (center + right)
        // Note: The leftColumn is hidden on this screen size to save space
        else if (maxWidth > 1000) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(flex: 7, child: centerColumn),
              const SizedBox(width: 16),
              if (rightColumn != null) Flexible(flex: 3, child: rightColumn!),
            ],
          );
        }
        // Tablet (600px - 1000px): Single-column layout
        else if (maxWidth > 600) {
          return Column(
            children: [
              if (leftColumn != null) leftColumn!,
              const SizedBox(height: 12),
              centerColumn,
              const SizedBox(height: 12),
              if (rightColumn != null) rightColumn!,
            ],
          );
        }
        // Mobile (< 600px): Single-column layout
        else {
          return Column(
            children: [
              if (leftColumn != null) leftColumn!,
              const SizedBox(height: 12),
              centerColumn,
              const SizedBox(height: 12),
              if (rightColumn != null) rightColumn!,
            ],
          );
        }
      },
    );
  }
}
