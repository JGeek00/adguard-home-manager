// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_domain_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class BlockedAllowedList extends StatelessWidget {
  final String type;
  final List<String> data;

  const BlockedAllowedList({
    Key? key,
    required this.type,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    void confirmRemoveDomain(String domain) async {
      Map<String, List<String>> body = {};

      if (type == 'allowed') {
        body = {
          "allowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.allowedClients.where((client) => client != domain).toList() ?? [],
          "disallowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.disallowedClients ?? [],
          "blocked_hosts": serversProvider.clients.data!.clientsAllowedBlocked?.blockedHosts ?? [],
        };
      }
      else if (type == 'blocked') {
        body = {
          "allowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.allowedClients ?? [],
          "disallowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.disallowedClients.where((client) => client != domain).toList() ?? [],
          "blocked_hosts": serversProvider.clients.data!.clientsAllowedBlocked?.blockedHosts ?? [],
        };
      }

      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.removingClient);

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

    if (data.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        itemCount: data.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(data[index]),
          trailing: IconButton(
            onPressed: () => {
              showDialog(
                context: context, 
                builder: (context) => RemoveDomainModal(
                  onConfirm: () => confirmRemoveDomain(data[index]),
                )
              )
            }, 
            icon: const Icon(Icons.delete_rounded)
          ),
        )
      );
    }
    else {
      return SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noClientsList,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.grey
            ),
          ),
        ),
      );
    }
  }
}