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

  static const double desktopXL = 1600;
  static const double desktop = 1200;
  static const double smallDesktop = 1000;
  static const double tablet = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        if (maxWidth > desktopXL) {
          return _threeColumn(centered: true);
        } else if (maxWidth > desktop) {
          return _threeColumn(centered: true);
        } else if (maxWidth > smallDesktop) {
          return _twoColumn();
        } else if (maxWidth > 890) {
          return _twoColumn(); // tablet large
        } else if (maxWidth > 610) {
          return _centerWithMargins(); // 👈 special case
        } else {
          return _singleColumn();
        }
      },
    );
  }

  Widget _threeColumn({required bool centered}) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Left column → fixed width (220px)
        if (leftColumn != null) SizedBox(width: 260, child: leftColumn!),

        const SizedBox(width: 24),

        // 🔹 Center column → takes remaining space
        Expanded(child: centerColumn),

        const SizedBox(width: 24),

        // 🔹 Right column → you can also fix it or keep flexible
        if (rightColumn != null)
          SizedBox(width: 300, child: rightColumn!), // example: fixed 300px
      ],
    );

    return centered
        ? Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: row,
            ),
          )
        : row;
  }

  Widget _centerWithMargins() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700), // adjust to taste
        child: centerColumn,
      ),
    );
  }

  Widget _twoColumn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 7, child: centerColumn),
        const SizedBox(width: 16),
        if (rightColumn != null) Flexible(flex: 3, child: rightColumn!),
      ],
    );
  }

  Widget _singleColumn() {
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
}
