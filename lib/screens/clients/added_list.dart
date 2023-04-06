// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client_screen.dart';
import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/fab.dart';
import 'package:adguard_home_manager/screens/clients/options_modal.dart';
import 'package:adguard_home_manager/widgets/tab_content_list.dart';

import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AddedList extends StatefulWidget {
  final ScrollController scrollController;
  final LoadStatus loadStatus;
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
      Navigator.push(context, MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => ClientScreen(
          onConfirm: confirmEditClient,
          onDelete: deleteClient,
          client: client,
        )
      ));
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

    return Stack(
      children: [
        CustomTabContentList(
          loadingGenerator: () => SizedBox(
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          ), 
          itemsCount: widget.data.length,
          contentWidget: (index) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            isThreeLine: true,
            onLongPress: () => openOptionsModal(widget.data[index]),
            onTap: () => openClientModal(widget.data[index]),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.data[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''),
                  style: TextStyle(
                    color: Theme.of(context).listTileTheme.textColor
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 19,
                      color: widget.data[index].filteringEnabled == true 
                        ? appConfigProvider.useThemeColorForStatus == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.green
                        : appConfigProvider.useThemeColorForStatus == true
                          ? Colors.grey
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.vpn_lock_rounded,
                      size: 18,
                      color: widget.data[index].safebrowsingEnabled == true 
                        ? appConfigProvider.useThemeColorForStatus == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.green
                        : appConfigProvider.useThemeColorForStatus == true
                          ? Colors.grey
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.block,
                      size: 18,
                      color: widget.data[index].parentalEnabled == true 
                        ? appConfigProvider.useThemeColorForStatus == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.green
                        : appConfigProvider.useThemeColorForStatus == true
                          ? Colors.grey
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.search_rounded,
                      size: 19,
                      color: widget.data[index].safesearchEnabled == true 
                        ? appConfigProvider.useThemeColorForStatus == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.green
                        : appConfigProvider.useThemeColorForStatus == true
                          ? Colors.grey
                          : Colors.red,
                    )
                  ],
                )
              ],
            ),
          ), 
          noData: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.noClientsList,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          errorGenerator: () => SizedBox(
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          ), 
          loadStatus: widget.loadStatus, 
          onRefresh: widget.fetchClients
        ),
        ClientsFab(
          isVisible: isVisible,
        )
      ],
    );
  }
}