// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

Future<bool> clearDnsCache(BuildContext context, Server server) async {
  final ProcessModal processModal = ProcessModal(context: context);
  processModal.open(AppLocalizations.of(context)!.clearingDnsCache);

  final result = await resetDnsCache(server: server);

  processModal.close();
  
  if (result['result'] == 'success') {
    return true;
  }
  else {
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    appConfigProvider.addLog(result['log']);
    return false;
  }
}