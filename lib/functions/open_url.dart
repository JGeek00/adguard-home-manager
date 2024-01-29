import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void openUrl(String url) async {
  try {
    await launchUrl(
      Uri.parse(url),      
      customTabsOptions: const CustomTabsOptions(
        shareState: CustomTabsShareState.browserDefault,
        urlBarHidingEnabled: true,
        showTitle: true,
      ),                    
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,        
      ),
    );
  } catch (e, stackTrace) {
    Sentry.captureException(e, stackTrace: stackTrace);
  }
}    