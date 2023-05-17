import 'dart:io';

import 'package:adguard_home_manager/models/github_release.dart';

String? getAppUpdateDownloadLink(GitHubRelease gitHubRelease) {
  if (Platform.isAndroid) {
    return gitHubRelease.assets.firstWhere((item) => item.browserDownloadUrl.contains('apk')).browserDownloadUrl;
  }
  else if (Platform.isMacOS) {
    return gitHubRelease.assets.firstWhere((item) => item.browserDownloadUrl.contains('macOS')).browserDownloadUrl;  // macOS package is a zip
  }
  else if (Platform.isWindows) {
    return gitHubRelease.assets.firstWhere((item) => item.browserDownloadUrl.contains('exe')).browserDownloadUrl;
  }
  else if (Platform.isLinux) {
    return gitHubRelease.assets.firstWhere((item) => item.browserDownloadUrl.contains('deb')).browserDownloadUrl;
  }
  else {
    return null;
  }
}