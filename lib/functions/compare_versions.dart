import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:adguard_home_manager/models/github_release.dart';

bool compareVersions({
  required String currentVersion, 
  required String newVersion
}) {
  if (currentVersion == "") return false;
  try {
    if (currentVersion.contains('a')) {   // alpha
      return true;
    }
    else if (currentVersion.contains('b')) {    // beta
      final current = currentVersion.replaceAll('v', '');
      final newV = currentVersion.replaceAll('v', '');

      final currentSplit = current.split('-')[0].split('.').map((e) => int.parse(e)).toList();
      final newSplit = newV.split('-')[0].split('.').map((e) => int.parse(e)).toList();

      final currentBeta = int.parse(current.split('-')[1].replaceAll('b.', ''));
      final newBeta = int.parse(newV.split('-')[1].replaceAll('b.', ''));
      
      if (newSplit[0] > currentSplit[0]) {
        return true;
      }
      else if (newSplit[1] > currentSplit[1]) {
        return true;
      }
      else if (newSplit[2] > currentSplit[2]) {
        return true;
      }
      else if (newBeta > currentBeta) {
        return true;
      }
      else {
        return false;
      }
    }
    else {    // stable
      final current = currentVersion.replaceAll('v', '');
      final newV = currentVersion.replaceAll('v', '');
      
      final currentSplit = current.split('.').map((e) => int.parse(e)).toList();
      final newSplit = newV.split('.').map((e) => int.parse(e)).toList();

      if (newSplit[0] > currentSplit[0]) {
        return true;
      }
      else if (newSplit[1] > currentSplit[1]) {
        return true;
      }
      else if (newSplit[2] > currentSplit[2]) {
        return true;
      }   
      else {
        return false;
      }
    }
  } catch (e) {
    Sentry.captureException(e);
    Sentry.captureMessage("compareVersions error", params: [
      {
        "fn": "compareVersions",
        "currentVersion": currentVersion,
        "newVersion": newVersion,
      }.toString()
    ]);
    return false;
  }
}

bool serverVersionIsAhead({
  required String currentVersion, 
  required String referenceVersion, 
  String? referenceVersionBeta
}) {
  if (currentVersion == "") return false;
  try {
    final current = currentVersion.replaceAll('v', '');
    final reference = referenceVersion.replaceAll('v', '');
    final referenceBeta = referenceVersionBeta?.replaceAll('v', '');

    if (currentVersion.contains('a')) {   // alpha
      return true;
    }
    else if (current.contains('b')) {   // beta
      if (referenceBeta != null) {
        final currentSplit = current.split('-')[0].split('.').map((e) => int.parse(e)).toList();
        final newSplit = referenceBeta.split('-')[0].split('.').map((e) => int.parse(e)).toList();

        final currentBeta = int.parse(current.split('-')[1].replaceAll('b.', ''));
        final newBeta = int.parse(referenceBeta.split('-')[1].replaceAll('b.', ''));
        
        if (newSplit[0] == currentSplit[0] && newSplit[1] == currentSplit[1] && newSplit[2] == currentSplit[2] && newBeta == currentBeta) {
          return true;
        }
        else if (newSplit[0] < currentSplit[0]) {
          return true;
        }
        else if (newSplit[1] < currentSplit[1]) {
          return true;
        }
        else if (newSplit[2] < currentSplit[2]) {
          return true;
        }
        else if (newBeta < currentBeta) {
          return true;
        }
        else {
          return false;
        }
      }
      else {
        return false;
      }
    }
    else {    // stable
      final currentSplit = current.split('.').map((e) => int.parse(e)).toList();
      final newSplit = reference.split('.').map((e) => int.parse(e)).toList();

      if (newSplit[0] == currentSplit[0] && newSplit[1] == currentSplit[1] && newSplit[2] == currentSplit[2]) {
        return true;
      }
      else if (newSplit[0] < currentSplit[0]) {
        return true;
      }
      else if (newSplit[1] < currentSplit[1]) {
        return true;
      }
      else if (newSplit[2] < currentSplit[2]) {
        return true;
      }   
      else {
        return false;
      }
    }
  } catch (e) {
    Sentry.captureException(e);
    Sentry.captureMessage("serverVersionIsAhead error", params: [
      {
        "fn": "serverVersionIsAhead",
        "currentVersion": currentVersion,
        "referenceVersion": referenceVersion,
        "referenceVersionBeta": referenceVersionBeta ?? ""
      }.toString()
    ]);
    return false;
  }
}

bool gitHubUpdateExists({
  required String currentBuildNumber, 
  required List<GitHubRelease> gitHubReleases,
  required bool isBeta
}) {
  final release = isBeta == true
    ? gitHubReleases.firstWhere((release) => release.prerelease == true)
    : gitHubReleases.firstWhere((release) => release.prerelease == false);
  
  final versionNumberRegex = RegExp(r'\(\d+\)');
  final releaseNumberExtracted = versionNumberRegex.allMatches(release.tagName).first.group(0);

  if (releaseNumberExtracted != null) {
    final releaseNumber = releaseNumberExtracted.replaceAll(RegExp(r'\(|\)'), '');
    try {
      final newReleaseParsed = int.parse(releaseNumber);
      final currentReleaseParsed = int.parse(currentBuildNumber);
      if (newReleaseParsed > currentReleaseParsed) {
        return true;
      }
      else {
        return false;
      }
    } catch (e) {
      Sentry.captureMessage("Invalid release number. Current release: $currentBuildNumber. New release: $releaseNumber");
      return false;
    }
  }
  else {
    Sentry.captureMessage("Invalid release number. Tagname: ${release.tagName}");
    return false;
  }
}