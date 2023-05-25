import 'dart:io';
import 'dart:math';

import 'package:store_checker/store_checker.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

Future<GitHubRelease?> checkAppUpdates({
  required String appVersion,
  required void Function(GitHubRelease?) setUpdateAvailable,
  required Source installationSource
}) async {
  final result = await checkAppUpdatesGitHub();

  if (result['result'] == 'success') {
    final update = gitHubUpdateExists(appVersion, result['body']);

    if (update == true) {
      final release = appVersion.contains('beta')
        ? result['body'].firstWhere((release) => release.prerelease == true)
        : result['body'].firstWhere((release) => release.prerelease == false);

      setUpdateAvailable(release);
        
      if (Platform.isAndroid) {
        if (
          installationSource == Source.IS_INSTALLED_FROM_LOCAL_SOURCE ||
          installationSource == Source.IS_INSTALLED_FROM_PLAY_PACKAGE_INSTALLER ||
          installationSource == Source.UNKNOWN
        ) {
          return release;
        }
        else {
          return null;
        }
      }
      else if (Platform.isIOS) {
        return null;
      }
      else {
        return release;
      }
    }
    else {
      setUpdateAvailable(null);
    }
  }
  return null;
}