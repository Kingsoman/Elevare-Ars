import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformHelper {
  /// Returns true if running on Web
  static bool get isWeb => kIsWeb;

  /// Returns true if running on Android or iOS (mobile devices)
  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Returns true if running on desktop (Windows, macOS, Linux)
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// Returns true if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Returns true if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;
}
