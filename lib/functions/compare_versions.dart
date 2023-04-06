bool compareVersions({
  required String currentVersion, 
  required String newVersion
}) {
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
}

bool compareBetaVersions({
  required String currentVersion, 
  required String newVersion
}) {
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
}