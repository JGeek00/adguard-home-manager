import 'package:sentry_flutter/sentry_flutter.dart';

bool compareVersions({
  required String currentVersion, 
  required String newVersion
}) {
  try {
    final currentSplit = currentVersion.split('.').map((e) => int.parse(e)).toList();
    final newSplit = newVersion.split('.').map((e) => int.parse(e)).toList();

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
  } catch (e) {
    Sentry.captureException(e, hint: Hint.withMap({
      "fn": "compareVersions",
      "currentVersion": currentVersion,
      "newVersion": newVersion,
    }));
    return false;
  }
}

bool compareBetaVersions({
  required String currentVersion, 
  required String newVersion
}) {
  try {
    final currentSplit = currentVersion.split('-')[0].split('.').map((e) => int.parse(e)).toList();
    final newSplit = newVersion.split('-')[0].split('.').map((e) => int.parse(e)).toList();

    final currentBeta = int.parse(currentVersion.split('-')[1].replaceAll('b.', ''));
    final newBeta = int.parse(newVersion.split('-')[1].replaceAll('b.', ''));
    
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
  } catch (e) {
    Sentry.captureException(e, hint: Hint.withMap({
      "fn": "compareBetaVersions",
      "currentVersion": currentVersion,
      "newVersion": newVersion,
    }));
    return false;
  }
}

bool serverVersionIsAhead({
  required String currentVersion, 
  required String referenceVersion, 
  String? referenceVersionBeta
}) {
  try {
    final current = currentVersion.replaceAll('v', '');
    final reference = referenceVersion.replaceAll('v', '');
    final referenceBeta = referenceVersionBeta?.replaceAll('v', '');

    if (current.contains('b')) {
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
    else {
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
    Sentry.captureException(e, hint: Hint.withMap({
      "fn": "serverVersionIsAhead",
      "currentVersion": currentVersion,
      "referenceVersion": referenceVersion,
      "referenceVersionBeta": referenceVersionBeta ?? ""
    }));
    return false;
  }
}