import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/widgets/add_server/add_server_modal.dart';
import 'package:adguard_home_manager/widgets/version_warning_modal.dart';

bool checkDataValid({
  required TextEditingController nameController,
  required TextEditingController ipDomainController,
  required String? ipDomainError,
  required String? pathError,
  required String? portError,
}) {
  if (
    nameController.text != '' &&
    ipDomainController.text != '' &&
    ipDomainError == null &&
    pathError == null && 
    portError == null 
  ) {
    return true;
  }
  else {
    return false;
  }
}


String? validatePort({
  required String? value,
  required BuildContext context
}) {
  if (value != null && value != '') {
    if (int.tryParse(value) != null && int.parse(value) <= 65535) {
      return null;
    }
    else {
      return AppLocalizations.of(context)!.invalidPort;
    }
  }
  else {
    return null;
  }
}

String? validateSubroute({
  required BuildContext context,
  required String? value
}) {
  if (value != null && value != '') {
    RegExp subrouteRegexp = RegExp(r'^\/\b([A-Za-z0-9_\-~/]*)[^\/|\.|\:]$');
    if (subrouteRegexp.hasMatch(value) == true) {
      return null;
    }
    else {
      return AppLocalizations.of(context)!.invalidPath;
    }
  }
  else {
    return null;
  }
}

String? validateAddress({
  required BuildContext context,
  required String? value
}) {
  if (value != null && value != '') {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
    RegExp domain = RegExp(r'^(([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+)$');
    if (ipAddress.hasMatch(value) == true || domain.hasMatch(value) == true) {
      return null;
    }
    else {
      return AppLocalizations.of(context)!.invalidIpDomain;
    }
  }
  else {
    return AppLocalizations.of(context)!.ipDomainNotEmpty;
  }
}

void openServerFormModal({
  required BuildContext context,
  required double width,
  Server? server,
}) {
  showGeneralDialog(
    context: context, 
    barrierColor:  width <= 700 
      ?Colors.transparent 
      : Colors.black54,
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1), 
          end: const Offset(0, 0)
        ).animate(
          CurvedAnimation(
            parent: anim1, 
            curve: Curves.easeInOutCubicEmphasized
          )
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => AddServerModal(
      fullScreen: width <= 700,
      server: server,
      onUnsupportedVersion: (version) => showDialog(
        context: context, 
        builder: (ctx) => VersionWarningModal(
          version: version 
        ),
        barrierDismissible: false
      ),
    ),
  );
}