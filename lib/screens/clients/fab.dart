// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client_screen.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/functions/maps_fns.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ClientsFab extends StatelessWidget {
  const ClientsFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void confirmAddClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await postAddClient(
        server: serversProvider.selectedServer!, 
        data: serverVersionIsAhead(
          currentVersion: statusProvider.serverStatus!.serverVersion, 
          referenceVersion: 'v0.107.28',
          referenceVersionBeta: 'v0.108.0-b.33'
        ) == false
          ? removePropFromMap(client.toJson(), 'safesearch_enabled')
          : removePropFromMap(client.toJson(), 'safe_search')
      );
      
      processModal.close();

      if (result['result'] == 'success') {
        Clients clientsData = clientsProvider.clients!;
        clientsData.clients.add(client);
        clientsProvider.setClientsData(clientsData);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientAddedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddClient() {
      if (width > 900 || !(Platform.isAndroid | Platform.isIOS)) {
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (BuildContext context) => ClientScreen(
            onConfirm: confirmAddClient,
            serverVersion: statusProvider.serverStatus!.serverVersion,
            dialog: true,
          )
        );
      }
      else {
        Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => ClientScreen(
            onConfirm: confirmAddClient,
            serverVersion: statusProvider.serverStatus!.serverVersion,
            dialog: false,
          )
        ));
      }
    }

    return FloatingActionButton(
      onPressed: openAddClient,
      child: const Icon(Icons.add),
    );
  }
}