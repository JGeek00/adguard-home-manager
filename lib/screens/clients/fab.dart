// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client_screen.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ClientsFab extends StatelessWidget {
  final bool isVisible;

  const ClientsFab({
    Key? key,
    required this.isVisible
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void confirmAddClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await postAddClient(server: serversProvider.selectedServer!, data: client.toJson());
      
      processModal.close();

      if (result['result'] == 'success') {
        ClientsData clientsData = serversProvider.clients.data!;
        clientsData.clients.add(client);
        serversProvider.setClientsData(clientsData);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientAddedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddClient() {
      Navigator.push(context, MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ClientScreen(
          onConfirm: confirmAddClient,
        )
      ));
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      bottom: isVisible ?
        appConfigProvider.showingSnackbar
          ? 70 : 20
        : -70,
      right: 20,
      child: FloatingActionButton(
        onPressed: openAddClient,
        child: const Icon(Icons.add),
      )
    );
  }
}