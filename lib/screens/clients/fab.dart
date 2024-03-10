// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ClientsFab extends StatelessWidget {
  const ClientsFab({super.key});

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void confirmAddClient(Client client) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await clientsProvider.addClient(client);
      
      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientAddedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotAdded, 
          color: Colors.red
        );
      }
    }

    void openAddClient() {
      openClientFormModal(
        context: context, 
        width: width, 
        onConfirm: confirmAddClient
      );
    }

    if (statusProvider.serverStatus != null) {
      return FloatingActionButton(
        onPressed: openAddClient,
        child: const Icon(Icons.add),
      );
    }
    else {
      return const SizedBox();
    }
  }
}