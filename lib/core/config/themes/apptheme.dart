import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A professional and consistent app theme for both light and dark modes.
///
/// This theme uses Material 3's `ColorScheme.fromSeed` to generate vibrant
/// and harmonious color schemes, then overrides specific colors with a
/// custom-defined professional palette. It also integrates Google Fonts
/// for a clean and modern typography.
class AppTheme {
  // 1. Define a single seed color for the entire app.
  //    Material 3's algorithm will derive all other colors from this.
  //    A deep blue is used for a professional and versatile look.
  static const Color _seedColor = Color(0xFF0052D4);

  // --- Light Theme ---
  static final ThemeData lightTheme = _buildTheme(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color(0xFFF9FAFB), // Background
          onSurface: const Color(0xFF111827), // Primary Text
          surfaceContainer: const Color(0xFFFFFFFF), // Surface (cards, sheets)
          onSurfaceVariant: const Color(0xFF6B7280), // Secondary Text
          error: const Color(0xFFDC2626),
          onError: Colors.white,
        ),
    brightness: Brightness.light,
  );

  // --- Dark Theme ---
  static final ThemeData darkTheme = _buildTheme(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ).copyWith(
          surface: const Color(0xFF121212), // Background
          onSurface: const Color(0xFFF3F4F6), // Primary Text
          surfaceContainer: const Color(0xFF1F2937), // Surface (cards, dialogs)
          onSurfaceVariant: const Color(0xFF9CA3AF), // Secondary Text
          error: const Color(0xFFEF4444),
          onError: Colors.black, // Better contrast on the bright red
        ),
    brightness: Brightness.dark,
  );

  /// A private helper method to build the theme data.
  ///
  /// This centralizes the theme configuration, ensuring consistency
  /// between the light and dark themes.
  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    // Use the base theme provided by the brightness.
    final baseTheme = ThemeData(brightness: brightness);

    // Create a text theme using Google Fonts for a modern feel.
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme.copyWith(
        // Customizing specific text styles for consistency.
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),

      // ✅ Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer, // A slightly elevated color
        elevation: 0, // Flatter look for this design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),

      // ✅ AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0, // A flatter, more modern look
        surfaceTintColor: Colors.transparent, // Prevents tinting on scroll
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
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
        fillColor: colorScheme.surfaceContainer, // Adjusted to match card
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant, // Using the specified color
        ),
      ),

      // ✅ Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // ✅ Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        indicatorColor: colorScheme.primary,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // ✅ Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: textTheme.titleLarge,
      ),

      // ✅ Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        modalBackgroundColor: colorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),

      // ✅ Slider, Switch, Checkbox, Radio Themes
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withAlpha(0x3d),
        thumbColor: colorScheme.primary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withAlpha(0x80);
          }
          return null;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return colorScheme.outline;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.outline, width: 1.5),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),

      // ✅ Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: colorScheme.surfaceContainerHighest,
      ),

      // ✅ Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        labelStyle: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
        ),
        side: BorderSide.none,
      ),

      // ✅ Tooltip Theme
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
