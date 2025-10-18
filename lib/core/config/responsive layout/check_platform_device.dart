import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

class PlatformHelper {
  /// Returns true if running on Web
  static bool get isWeb => kIsWeb;

  /// Returns true if running on Android
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns true if running on iOS
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns true if running on mobile (Android or iOS)
  static bool get isMobile => isAndroid || isIOS;

  /// Returns true if running on macOS
  static bool get isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns true if running on Windows
  static bool get isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns true if running on Linux
  static bool get isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Returns true if running on desktop (Windows, macOS, Linux)
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Returns true if running in an Apple browser (Safari on iOS/macOS Web)
  static bool get isAppleBrowser =>
      kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
}
