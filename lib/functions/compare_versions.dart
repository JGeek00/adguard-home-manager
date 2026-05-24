import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:adguard_home_manager/models/github_release.dart';

class _ParsedVersion {
  final List<int> numbers;
  final String suffix;

  const _ParsedVersion({
    required this.numbers,
    required this.suffix,
  });

  bool get isAlpha => RegExp(r'(^|[-.])a(lpha)?([-.]|\d|$)').hasMatch(suffix);
  bool get isBeta => RegExp(r'(^|[-.])b(eta)?([-.]|\d|$)').hasMatch(suffix);
}

_ParsedVersion? _parseVersion(String version) {
  final match = RegExp(r'v?(\d+)\.(\d+)\.(\d+)(?:[-+]([0-9A-Za-z][0-9A-Za-z.-]*))?').firstMatch(version);

  if (match == null) return null;

  return _ParsedVersion(
    numbers: [
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    ],
    suffix: match.group(4)?.toLowerCase() ?? '',
  );
}

int _compareVersionNumbers(_ParsedVersion current, _ParsedVersion reference) {
  for (var i = 0; i < current.numbers.length; i++) {
    if (current.numbers[i] > reference.numbers[i]) return 1;
    if (current.numbers[i] < reference.numbers[i]) return -1;
  }

  return 0;
}

bool compareVersions({
  required String currentVersion, 
  required String newVersion
}) {
  if (currentVersion == "") return false;
  try {
    final current = _parseVersion(currentVersion);
    final newV = _parseVersion(newVersion);

    if (current == null || newV == null) return false;

    if (current.isAlpha) {   // alpha
      return true;
    }

    return _compareVersionNumbers(newV, current) > 0;
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
    final current = _parseVersion(currentVersion);
    final reference = _parseVersion(referenceVersion);
    final referenceBeta = referenceVersionBeta != null ? _parseVersion(referenceVersionBeta) : null;

    if (current == null || reference == null) return false;

    if (current.isAlpha) {   // alpha
      return true;
    }
    else if (current.isBeta) {   // beta
      if (referenceBeta != null) {
        return _compareVersionNumbers(current, referenceBeta) >= 0;
      }
      else {
        return false;
      }
    }
    else {    // stable
      return _compareVersionNumbers(current, reference) >= 0;
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
  required GitHubRelease gitHubRelease,
  required bool isBeta
}) {
  final versionNumberRegex = RegExp(r'\(\d+\)');
  final releaseNumberExtractedMatches = versionNumberRegex.allMatches(gitHubRelease.tagName);

  if (releaseNumberExtractedMatches.isNotEmpty) {
    final releaseNumberExtracted = releaseNumberExtractedMatches.first.group(0);

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
      Sentry.captureMessage("Invalid release number. Tagname: ${gitHubRelease.tagName}");
      return false;
    }
  }
  else {
    Sentry.captureMessage("No matches. ${gitHubRelease.tagName}");
    return false;
  }
}
