// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/add_client_modal.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class ClientsFab extends StatelessWidget {
  const ClientsFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void confirmRemoveDomain(String list, String ip) async {
      Map<String, List<String>> body = {};

      if (list == 'allowed') {
        final List<String> clients = [...serversProvider.clients.data!.clientsAllowedBlocked?.allowedClients ?? [], ip];
        body = {
          "allowed_clients": clients,
          "disallowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.disallowedClients ?? [],
          "blocked_hosts": serversProvider.clients.data!.clientsAllowedBlocked?.blockedHosts ?? [],
        };
      }
      else if (list == 'blocked') {
        final List<String> clients = [...serversProvider.clients.data!.clientsAllowedBlocked?.disallowedClients ?? [], ip];
        body = {
          "allowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.allowedClients ?? [],
          "disallowed_clients": clients,
          "blocked_hosts": serversProvider.clients.data!.clientsAllowedBlocked?.blockedHosts ?? [],
        };
      }

      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);

      final result = await requestAllowedBlockedClientsHosts(serversProvider.selectedServer!, body);

      processModal.close();

      if (result['result'] == 'success') {
        serversProvider.setAllowedDisallowedClientsBlockedDomains(
          ClientsAllowedBlocked(
            allowedClients: body['allowed_clients'] ?? [], 
            disallowedClients: body['disallowed_clients'] ?? [], 
            blockedHosts: body['blocked_hosts'] ?? [], 
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientAddedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientNotRemoved),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openAddClient(String list) {
      showDialog(
        context: context, 
        builder: (ctx) => AddClientModal(
          list: list,
          onConfirm: confirmRemoveDomain
        )
      );
    }

    if (appConfigProvider.selectedClientsTab == 1) {
      return FloatingActionButton(
        onPressed: () => openAddClient('allowed'),
        child: const Icon(Icons.add),
      );
    }
    else if (appConfigProvider.selectedClientsTab == 2) {
      return FloatingActionButton(
        onPressed: () => openAddClient('blocked'),
        child: const Icon(Icons.add),
      );
    }
    else {
      return const SizedBox();
    }
  }
}