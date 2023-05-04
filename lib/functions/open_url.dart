import 'dart:io';

import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  if (Platform.isAndroid || Platform.isIOS) {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: const CustomTabsOptions(
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: false,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      )
    );
  }
  else {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}    