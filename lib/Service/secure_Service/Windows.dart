import 'package:flutter/services.dart';

class ScreenshotBlocker {
  static const _channel = MethodChannel('screenshot_blocker');

  static Future<void> blockScreenshots() async {
    try {
      await _channel.invokeMethod('blockScreenshots');
    } catch (e) {
      print("Error: $e");
    }
  }
}
