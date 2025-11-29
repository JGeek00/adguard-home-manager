import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as flutter_custom_tabs;

void openUrl(String url) async {
  try {
    await flutter_custom_tabs.launchUrl(
      Uri.parse(url),
      customTabsOptions: const flutter_custom_tabs.CustomTabsOptions(
        shareState: flutter_custom_tabs.CustomTabsShareState.browserDefault,
        urlBarHidingEnabled: true,
        showTitle: true,
      ),
      safariVCOptions: const flutter_custom_tabs.SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: flutter_custom_tabs.SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e, stackTrace) {
    try {
      await url_launcher.launchUrl(
        Uri.parse(url),
        mode: url_launcher.LaunchMode.externalApplication,
      );
    } catch (innerError, innerStackTrace) {
      Sentry.captureException(innerError, stackTrace: innerStackTrace);
    }
    Sentry.captureException(e, stackTrace: stackTrace);
  }
}