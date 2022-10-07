// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/fab.dart';
import 'package:adguard_home_manager/screens/clients/client_modal.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AddedList extends StatelessWidget {
  final List<Client> data;
  final Future Function() fetchClients;

  const AddedList({
    Key? key,
    required this.data,
    required this.fetchClients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void confirmEditClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await postUpdateClient(server: serversProvider.selectedServer!, data: {
        'name': client.name,
        'data': client.toJson()
      });

      processModal.close();

      if (result['result'] == 'success') {
        ClientsData clientsData = serversProvider.clients.data!;
        clientsData.clients = clientsData.clients.map((e) {
          if (e.name == client.name) {
            return client;
          }
          else {
            return e;
          }
        }).toList();
        serversProvider.setClientsData(clientsData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientUpdatedSuccessfully),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientNotUpdated),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openClientModal(Client client) {
      showModalBottomSheet(
        context: context, 
        builder: (ctx) => ClientModal(
          client: client,
          onConfirm: confirmEditClient
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    return Stack(
      children: [
        if (data.isNotEmpty) RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemCount: data.length,
            itemBuilder: (context, index) => ListTile(
              isThreeLine: true,
              onTap: () => openClientModal(data[index]),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(data[index].name),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), '')),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list_rounded,
                        size: 19,
                        color: data[index].filteringEnabled == true 
                          ? Colors.green
                          : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.vpn_lock_rounded,
                        size: 18,
                        color: data[index].safebrowsingEnabled == true 
                          ? Colors.green
                          : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.block,
                        size: 18,
                        color: data[index].parentalEnabled == true 
                          ? Colors.green
                          : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.search_rounded,
                        size: 19,
                        color: data[index].safesearchEnabled == true 
                          ? Colors.green
                          : Colors.red,
                      )
                    ],
                  )
                ],
              ),
            )
          ),
        ),
        if (data.isEmpty) SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.noClientsList,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: fetchClients, 
                icon: const Icon(Icons.refresh_rounded), 
                label: Text(AppLocalizations.of(context)!.refresh),
              )
            ],
          ),
        ),
        const Positioned(
          bottom: 20,
          right: 20,
          child: ClientsFab(),
        ),
      ],
    );
  }
}