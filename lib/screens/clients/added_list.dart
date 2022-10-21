// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/fab.dart';
import 'package:adguard_home_manager/screens/clients/options_modal.dart';
import 'package:adguard_home_manager/screens/clients/client_modal.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AddedList extends StatefulWidget {
  final ScrollController scrollController;
  final int loadStatus;
  final List<Client> data;
  final Future Function() fetchClients;

  const AddedList({
    Key? key,
    required this.scrollController,
    required this.loadStatus,
    required this.data,
    required this.fetchClients
  }) : super(key: key);

  @override
  State<AddedList> createState() => _AddedListState();
}

class _AddedListState extends State<AddedList> {
  late bool isVisible;

  @override
  initState(){
    super.initState();

    isVisible = true;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

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

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientUpdatedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotUpdated, 
          color: Colors.red
        );
      }
    }

    void deleteClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.removingClient);
      
      final result = await postDeleteClient(server: serversProvider.selectedServer!, name: client.name);
    
      processModal.close();

      if (result['result'] == 'success') {
        ClientsData clientsData = serversProvider.clients.data!;
        clientsData.clients = clientsData.clients.where((c) => c.name != client.name).toList();
        serversProvider.setClientsData(clientsData);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientDeletedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotDeleted, 
          color: Colors.red
        );
      }
    }

    void openClientModal(Client client) {
      ScaffoldMessenger.of(context).clearSnackBars();
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
          client: client,
          onConfirm: confirmEditClient,
          onDelete: deleteClient,
        ),
        bottomSheetColor: Colors.transparent
      );
    }

    void openDeleteModal(Client client) {
      showModal(
        context: context, 
        builder: (ctx) => RemoveClientModal(
          onConfirm: () => deleteClient(client)
        )
      );
    }

    void openOptionsModal(Client client) {
      showModal(
        context: context, 
        builder: (ctx) => OptionsModal(
          onDelete: () => openDeleteModal(client),
          onEdit: () => openClientModal(client),
        )
      );
    }

    switch (widget.loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      case 1:
        return Stack(
          children: [
            if (widget.data.isNotEmpty) ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) => ListTile(
                isThreeLine: true,
                onLongPress: () => openOptionsModal(widget.data[index]),
                onTap: () => openClientModal(widget.data[index]),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.data[index].name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), '')),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_rounded,
                          size: 19,
                          color: widget.data[index].filteringEnabled == true 
                            ? Colors.green
                            : Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.vpn_lock_rounded,
                          size: 18,
                          color: widget.data[index].safebrowsingEnabled == true 
                            ? Colors.green
                            : Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.block,
                          size: 18,
                          color: widget.data[index].parentalEnabled == true 
                            ? Colors.green
                            : Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.search_rounded,
                          size: 19,
                          color: widget.data[index].safesearchEnabled == true 
                            ? Colors.green
                            : Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
            if (widget.data.isEmpty) SizedBox(
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
                    onPressed: widget.fetchClients, 
                    icon: const Icon(Icons.refresh_rounded), 
                    label: Text(AppLocalizations.of(context)!.refresh),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: const ClientsFab(tab: 1),
            )
          ],
        );
      
      case 2:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.errorLoadServerStatus,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      default:
        return const SizedBox();
    }

  }
}