import 'dart:io';

import 'package:flutter/services.dart';

/// Bridge to Android's ACCESS_LOCAL_NETWORK runtime permission (Local Network
/// Protection, enforced on Android 17+ for apps targeting SDK 37).
/// No-op on other platforms and for non-LAN hosts.
class LocalNetworkPermission {
  static const MethodChannel _channel = MethodChannel(
    'com.jgeek00.adguard_home_manager/local_network'
  );

  static bool get _isSupported => Platform.isAndroid;

  /// True for hosts that can only live on the LAN, so users connecting to
  /// remote servers are never shown the system dialog.
  static bool isLocalHost(String host) {
    var h = host.trim().toLowerCase();
    if (h.isEmpty) return false;
    if (h.startsWith('[') && h.endsWith(']')) {
      h = h.substring(1, h.length - 1);
    }
    if (h == 'localhost' ||
        h.endsWith('.local') ||
        h.endsWith('.lan') ||
        h.endsWith('.home') ||
        h.endsWith('.internal')) {
      return true;
    }
    final address = InternetAddress.tryParse(h);
    if (address == null) {
      // Single-label names (e.g. "adguardhome") resolve via local DNS/mDNS.
      return !h.contains('.');
    }
    if (address.isLoopback || address.isLinkLocal) return true;
    final bytes = address.rawAddress;
    if (address.type == InternetAddressType.IPv4) {
      return bytes[0] == 10 ||
          (bytes[0] == 172 && bytes[1] >= 16 && bytes[1] <= 31) ||
          (bytes[0] == 192 && bytes[1] == 168) ||
          (bytes[0] == 169 && bytes[1] == 254);
    }
    // IPv6 ULA fc00::/7.
    return (bytes[0] & 0xfe) == 0xfc;
  }

  /// Shows the system dialog when needed. Never throws and never blocks the
  /// connection attempt: denied/unavailable resolves to true so the socket is
  /// still attempted (remote hosts don't need the permission, and failures
  /// surface through the usual socket-error path).
  static Future<bool> ensureGranted(String host) async {
    if (!_isSupported || !isLocalHost(host)) return true;
    try {
      final bool? granted = await _channel.invokeMethod('request');
      return granted ?? true;
    } catch (_) {
      // ponytail: fail open, the socket error surfaces through the existing path
      return true;
    }
  }
}
