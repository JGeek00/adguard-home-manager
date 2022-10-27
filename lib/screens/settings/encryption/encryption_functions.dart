import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

String? validateDomain(BuildContext context, String domain) {
  RegExp regExp = RegExp(r'^([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
  if (regExp.hasMatch(domain)) {
    return null;
  }
  else {
    return AppLocalizations.of(context)!.domainNotValid;
  }
}

String? validatePort(BuildContext context, String value) {
  if (int.tryParse(value) != null && int.parse(value) <= 65535) {
    return null;
  }
  else {
    return AppLocalizations.of(context)!.invalidPort;
  } 
}

String? validateCertificate(BuildContext context, String cert) {
  final regExp = RegExp(r'(-{3,}(\bBEGIN CERTIFICATE\b))|(-{3,}-{3,}(\END CERTIFICATE\b)-{3,})', multiLine: true);
  if (regExp.hasMatch(cert.replaceAll('\n', ''))) {
    return null;
  }
  else {
    return AppLocalizations.of(context)!.invalidCertificate;
  }
}

String? validatePrivateKey(BuildContext context, String cert) {
  final regExp = RegExp(r'(-{3,}(\bBEGIN\b).*(PRIVATE KEY\b))|(-{3,}-{3,}(\bEND\b).*(PRIVATE KEY\b)-{3,})', multiLine: true);
  if (regExp.hasMatch(cert.replaceAll('\n', ''))) {
    return null;
  }
  else {
    return AppLocalizations.of(context)!.invalidPrivateKey;
  }
}

String? validatePath(BuildContext context, String cert) {
  final regExp = RegExp(r'^(\/{0,1}(?!\/))[A-Za-z0-9\/\-_]+(\.([a-zA-Z]+))?$');
  if (regExp.hasMatch(cert)) {
    return null;
  }
  else {
    return AppLocalizations.of(context)!.invalidPath;
  }
}

Widget generateStatus(BuildContext context, AppConfigProvider appConfigProvider, bool localValidation, int dataValidApi) {
  if (localValidation == true) {
    if (dataValidApi == 0) {
      return const SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        )
      );
    }
    else if (dataValidApi == 1) {
      return Icon(
        Icons.check_circle_rounded,
        color: appConfigProvider.useThemeColorForStatus == true
          ? Theme.of(context).primaryColor
          : Colors.green,
      );
    }
    else if (dataValidApi == 2) {
      return Icon(
        Icons.cancel_rounded,
        color: appConfigProvider.useThemeColorForStatus == true
          ? Theme.of(context).listTileTheme.iconColor
          : Colors.red,
      );
    }
    else {
      return const SizedBox();
    }
  }
  else {
    return const Icon(
      Icons.error_rounded,
      color: Colors.grey,
    );
  }
}

String generateStatusString(BuildContext context, bool localValidation, int dataValidApi) {
  if (localValidation == true) {
    if (dataValidApi == 0) {
      return AppLocalizations.of(context)!.validatingData;
    }
    else if (dataValidApi == 1) {
      return AppLocalizations.of(context)!.dataValid;
    }
    else if (dataValidApi == 2) {
      return AppLocalizations.of(context)!.dataNotValid;
    }
    else {
      return "";
    }
  }
  else {
    return AppLocalizations.of(context)!.dataNotValid;
  }
}