import 'package:flutter_web_browser/flutter_web_browser.dart';

void openUrl(String url) {
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