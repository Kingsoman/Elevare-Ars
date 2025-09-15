import 'package:flutter/widgets.dart';

/// A utility class that defines responsive breakpoints and helpers
/// for checking the current screen size category.
///
/// This makes it easy to build adaptive layouts that change
/// based on the available screen width.
class ResponsiveHelper {
  /// 🔹 Breakpoint for very large desktop screens (≥ 1600px)
  static const double desktopXL = 1600;

  /// 🔹 Breakpoint for normal desktop screens (≥ 1200px)
  static const double desktop = 1200;

  /// 🔹 Breakpoint for small desktop / large tablet (≥ 1000px)
  static const double smallDesktop = 1000;

  /// 🔹 Breakpoint for tablet (≥ 610px)
  static const double tablet = 610;

  /// ✅ Returns `true` if screen is Mobile (< 610px)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= tablet;

  /// ✅ Returns `true` if screen is Tablet (610px – 999px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tablet && width < smallDesktop;
  }

  /// ✅ Returns `true` if screen is Small Desktop (1000px – 1199px)
  static bool isSmallDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= smallDesktop && width < desktop;
  }

  /// ✅ Returns `true` if screen is Desktop (1200px – 1599px)
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= desktop && width < desktopXL;
  }

  /// ✅ Returns `true` if screen is Extra Large Desktop (≥ 1600px)
  static bool isDesktopXL(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopXL;
}
