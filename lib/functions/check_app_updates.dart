// import 'dart:io';

// import 'package:install_referrer/install_referrer.dart';

// import 'package:adguard_home_manager/functions/compare_versions.dart';
// import 'package:adguard_home_manager/services/external_requests.dart';
// import 'package:adguard_home_manager/models/github_release.dart';

// Future<GitHubRelease?> checkAppUpdates({
//   required String currentBuildNumber,
//   required void Function(GitHubRelease?) setUpdateAvailable,
//   required InstallationAppReferrer? installationSource,
//   required bool isBeta
// }) async {
//   var result = isBeta 
//     ? await ExternalRequests.getReleasesGitHub() 
//     : await ExternalRequests.getReleaseData();

//   if (result.successful == true) {
//     late GitHubRelease gitHubRelease;
//     if (isBeta) {
//       gitHubRelease = (result.content as List<GitHubRelease>).firstWhere((r) => r.prerelease == true);
//     }
//     else {
//       gitHubRelease = result.content as GitHubRelease;
//     }

//     final update = gitHubUpdateExists(
//       currentBuildNumber: currentBuildNumber, 
//       gitHubRelease: gitHubRelease,
//       isBeta: isBeta
//     );

//     if (update == true) {
//       setUpdateAvailable(gitHubRelease);
        
//       if (Platform.isAndroid) {
//         if (installationSource == InstallationAppReferrer.androidManually) {
//           return gitHubRelease;
//         }
//         else {
//           return null;
//         }
//       }
//       else if (Platform.isIOS) {
//         return null;
//       }
//       else {
//         return gitHubRelease;
//       }
//     }
//     else {
//       setUpdateAvailable(null);
//     }
//   }
//   return null;
// }