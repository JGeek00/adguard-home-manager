import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Bridge to Android's per-app language preference, a no-op elsewhere: iOS
/// offers no API to write it, and desktop has no such concept.
class PlatformLocaleService {
  static const MethodChannel _channel = MethodChannel(
    'com.jgeek00.adguard_home_manager/locale'
  );

  static bool get _isSupported => Platform.isAndroid;

  /// BCP 47 tag stored by the system, or null when no per-app locale is set.
  static Future<String?> getApplicationLocale() async {
    if (!_isSupported) return null;
    try {
      final String? tag = await _channel.invokeMethod('getApplicationLocale');
      return (tag == null || tag.isEmpty) ? null : tag;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Passing null clears the system entry.
  static Future<void> setApplicationLocale(String? tag) async {
    if (!_isSupported) return;
    try {
      await _channel.invokeMethod('setApplicationLocale', {'tag': tag});
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }
}
