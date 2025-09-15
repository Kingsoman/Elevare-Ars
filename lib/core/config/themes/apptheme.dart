import 'package:flutter/material.dart';

/// A professional and consistent app theme for both light and dark modes.
///
/// This theme is built upon Material 3's dynamic color system using
/// `ColorScheme.fromSeed`. It establishes a single seed color and then
/// overrides specific theme properties to create a unique, modern, and
/// cohesive visual identity.
///
/// It provides:
///   - Harmonious color schemes for light and dark modes.
///   - Consistent typography using the 'Poppins' font from Google Fonts.
///   - Pre-styled themes for most common widgets (Buttons, Cards, Inputs, etc.).
///   - A flat, modern aesthetic with subtle borders instead of large shadows.
class AppTheme {
  // 1. Define the single seed color that will be used to generate
  //    the entire color palette for both light and dark themes.
  //    A vibrant, professional blue is chosen for its versatility.
  static const Color _seedColor = Color.fromARGB(255, 92, 92, 92);

  // --- Light Theme Definition ---
  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    seedColor: _seedColor,
    // Override specific colors of the generated scheme for a custom look.
    colorOverrides: const ColorScheme.light().copyWith(
      surface: const Color(0xFFF8F9FA), // Main background color (from image)
      onSurface: const Color(0xFF1A1C1E), // Main text color
      surfaceContainer: Colors.white, // For cards, dialogs, sheets (from image)
      onSurfaceVariant: const Color(0xFF43474E), // For secondary text and icons
      outlineVariant: const Color(
        0xFFE0E0E0,
      ), // For subtle borders and dividers
      error: const Color(0xFFDC2626), // Error color for validation, etc.
      onError: Colors.white, // Text/icon color on top of the error color
    ),
  );

  // --- Dark Theme Definition ---
  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    seedColor: _seedColor,
    // Override specific colors of the generated scheme for a custom look.
    colorOverrides: const ColorScheme.dark().copyWith(
      surface: const Color(0xFF121212), // Main background color (from image)
      onSurface: const Color(0xFFE2E2E6), // Main text color (avoids pure white)
      surfaceContainer: const Color(
        0xFF1E2126,
      ), // For cards, dialogs, sheets (from image)
      onSurfaceVariant: const Color(0xFF9CA3AF), // For secondary text and icons
      outlineVariant: const Color(
        0xFF32363B,
      ), // For subtle borders and dividers
      error: const Color(0xFFF87171), // A lighter red for dark mode
      onError: const Color(0xFF450A0A), // High-contrast text on error color
    ),
  );

  /// A private helper method to construct the [ThemeData].
  ///
  /// This centralizes all the widget theme definitions to ensure that
  /// both light and dark themes share the same typography, shapes, and styles.
  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color seedColor,
    required ColorScheme colorOverrides,
  }) {
    // 1. Generate the base ColorScheme from the seed color.
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        ).copyWith(
          // 2. Apply the custom color overrides.
          surface: colorOverrides.surface,
          onSurface: colorOverrides.onSurface,
          surfaceContainer: colorOverrides.surfaceContainer,
          onSurfaceVariant: colorOverrides.onSurfaceVariant,
          outlineVariant: colorOverrides.outlineVariant,
          error: colorOverrides.error,
          onError: colorOverrides.onError,
        );

    // 3. Define the base theme and typography.
    final baseTheme = ThemeData(brightness: brightness);
    final textTheme = baseTheme.textTheme.apply(
      fontFamily: 'Poppins',
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    // 4. Return the configured ThemeData.
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),

      // --- Component Themes ---

      // ✅ Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),

      // ✅ AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),

      // ✅ Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const CircleBorder(),
      ),

      // ✅ Input Fields Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // ✅ Navigation Themes
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        selectedIconTheme: IconThemeData(color: colorScheme.onPrimaryContainer),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      ),

      // ✅ Dialog & Sheet Themes
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: textTheme.titleLarge,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        modalBackgroundColor: colorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        textStyle: textTheme.bodyMedium,
      ),

      // ✅ Other Component Themes
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        thickness: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        side: BorderSide.none,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colorScheme.primary.withValues(alpha: 0.5)
              : null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colorScheme.primary
              : null;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.outline, width: 1.5),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),
    );
  }
}
