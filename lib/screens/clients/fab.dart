// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ClientsFab extends StatelessWidget {
  final int tab;

  const ClientsFab({
    Key? key,
    required this.tab,
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
      showFlexibleBottomSheet(
        minHeight: 0.6,
        initHeight: 0.6,
        maxHeight: 0.95,
        isCollapsible: true,
        duration: const Duration(milliseconds: 250),
        anchors: [0.95],
        context: context, 
        builder: (ctx, controller, offset) => ClientModal(
          scrollController: controller,
          onConfirm: confirmAddClient
        ),
        bottomSheetColor: Colors.transparent
      );
    }

    return FloatingActionButton(
      onPressed: () => openAddClient(),
      child: const Icon(Icons.add),
    );
  }
}