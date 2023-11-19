// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/services/api_client.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/server.dart';

Future<ApiResponse> clearDnsCache(BuildContext context, Server server) async {
  final serversProvider = Provider.of<ServersProvider>(context, listen: false);

  final ProcessModal processModal = ProcessModal(context: context);
  processModal.open(AppLocalizations.of(context)!.clearingDnsCache);

  final result = await serversProvider.apiClient2!.resetDnsCache();

  processModal.close();
  
  return result;
}