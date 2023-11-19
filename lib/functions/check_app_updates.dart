import 'dart:io';

import 'package:store_checker/store_checker.dart';

import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/services/external_requests.dart';
import 'package:adguard_home_manager/models/github_release.dart';

Future<GitHubRelease?> checkAppUpdates({
  required String currentBuildNumber,
  required void Function(GitHubRelease?) setUpdateAvailable,
  required Source installationSource,
  required bool isBeta
}) async {
  var result = isBeta 
    ? await ExternalRequests.getReleasesGitHub() 
    : await ExternalRequests.getLatestReleaseGitHub();

  if (result.successful == true) {
    late GitHubRelease gitHubRelease;
    if (isBeta) {
      gitHubRelease = (result.content as List<GitHubRelease>).firstWhere((r) => r.prerelease == true);
    }
    else {
      gitHubRelease = result.content as GitHubRelease;
    }

    final update = gitHubUpdateExists(
      currentBuildNumber: currentBuildNumber, 
      gitHubRelease: gitHubRelease,
      isBeta: isBeta
    );

    if (update == true) {
      setUpdateAvailable(gitHubRelease);
        
      if (Platform.isAndroid) {
        if (
          installationSource == Source.IS_INSTALLED_FROM_LOCAL_SOURCE ||
          installationSource == Source.IS_INSTALLED_FROM_PLAY_PACKAGE_INSTALLER ||
          installationSource == Source.UNKNOWN
        ) {
          return gitHubRelease;
        }
        else {
          return null;
        }
      }
      else if (Platform.isIOS) {
        return null;
      }
      else {
        return gitHubRelease;
      }
    }
    else {
      setUpdateAvailable(null);
    }
  }
  return null;
}