import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  // This property defines the maximum width for screens >= 600px.
  final double maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 700, // Default max width for larger screens
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Define the breakpoint where the container should switch from full width
    const double breakpoint = 600;
    final double constrainedWidth = size.width < breakpoint
        ? size
              .width // Use full available width if less than 600px
        : maxWidth; // Use the specified maxWidth if 600px or wider

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          // Apply the calculated constraint
          constraints: BoxConstraints(maxWidth: constrainedWidth),

          // The child is placed directly without extra Padding,
          // relying on the child itself to handle internal padding.
          child: child,
        ),
      ),
    );
  }
}
