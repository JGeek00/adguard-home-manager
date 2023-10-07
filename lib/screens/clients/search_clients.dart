// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';
import 'package:adguard_home_manager/screens/clients/options_modal.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class SearchClients extends StatefulWidget {
  const SearchClients({Key? key}) : super(key: key);

  @override
  State<SearchClients> createState() => _SearchClientsState();
}

class _SearchClientsState extends State<SearchClients> {
  late ScrollController scrollController;

  final TextEditingController searchController = TextEditingController();

  List<Client> clients = [];
  List<AutoClient> autoClients = [];

  List<Client> clientsScreen = [];
  List<AutoClient> autoClientsScreen = [];

  bool showDivider = true;

  void search(String value) {
    if (value == '') {
      setState(() {
        clientsScreen = [];
        autoClientsScreen = [];
      });
    }
    else {
      setState(() {
        clientsScreen = clients.where((client) => client.name.contains(value) || client.ids.where((e) => e.contains(value)).isNotEmpty).toList();
        autoClientsScreen = autoClients.where((client) => (client.name != null ? client.name!.contains(value) : true) || client.ip.contains(value)).toList();
      });
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels > 0) {
      setState(() => showDivider = false);
    }
    else {
      setState(() => showDivider = true);
    }
  }

  @override
  void initState() {
    final clientsProvider =  Provider.of<ClientsProvider>(context, listen: false);
      
    scrollController = ScrollController()..addListener(scrollListener);

    setState(() {
      clients = clientsProvider.clients!.clients;
      autoClients = clientsProvider.clients!.autoClients;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    final statusProvider = Provider.of<StatusProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void deleteClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.removingClient);
      
      final result = await clientsProvider.deleteClient(client);
    
      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientDeletedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotDeleted, 
          color: Colors.red
        );
      }
    }  

    void confirmEditClient(Client client) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingClient);
      
      final result = await clientsProvider.editClient(client);

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientUpdatedSuccessfully, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.clientNotUpdated, 
          color: Colors.red
        );
      }
    }

    void openClientModal(Client client) {
      openClientFormModal(
        context: context, 
        width: width, 
        onConfirm: confirmEditClient,
        onDelete: deleteClient
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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: TextFormField(
            controller: searchController,
            onChanged: search,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: searchController.text != '' 
              ? () => setState(() {
                  searchController.text = '';
                  autoClientsScreen = autoClients;
                  clientsScreen = clients;
                })
              : null, 
            icon: const Icon(Icons.clear_rounded),
            tooltip: AppLocalizations.of(context)!.clearSearch,
          ),
          const SizedBox(width: 10)
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.maxFinite, 1),
          child: Container(
            width: double.maxFinite,
            height: 1,
            decoration: BoxDecoration(
              color: showDivider == true
                ? Theme.of(context).colorScheme.surfaceVariant
                : Colors.transparent
            ),
          ),
        ),
      ),
      body: clientsScreen.isNotEmpty || autoClientsScreen.isNotEmpty 
        ? ListView(
          controller: scrollController,
            children: [
              if (clientsScreen.isNotEmpty) ...[
                SectionLabel(
                  label: AppLocalizations.of(context)!.added,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: clientsScreen.length,
                  padding: const EdgeInsets.only(bottom: 0),
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: index == 0 
                      ? const EdgeInsets.only(left: 20, right: 20, bottom: 15)
                      : const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    isThreeLine: true,
                    onLongPress: () => openOptionsModal(clientsScreen[index]),
                    onTap: statusProvider.serverStatus != null
                      ? () => openClientModal(clientsScreen[index])
                      : null,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        clientsScreen[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clientsScreen[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), '')),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              size: 19,
                              color: clientsScreen[index].filteringEnabled == true 
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
                              color: clientsScreen[index].safebrowsingEnabled == true 
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
                              color: clientsScreen[index].parentalEnabled == true 
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
                              color: serverVersionIsAhead(
                                currentVersion: statusProvider.serverStatus!.serverVersion, 
                                referenceVersion: 'v0.107.28',
                                referenceVersionBeta: 'v0.108.0-b.33'
                              ) == true 
                                ? clientsScreen[index].safeSearch != null && clientsScreen[index].safeSearch!.enabled == true 
                                  ? appConfigProvider.useThemeColorForStatus == true
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.green
                                  : appConfigProvider.useThemeColorForStatus == true
                                    ? Colors.grey
                                    : Colors.red
                                : clientsScreen[index].safesearchEnabled == true
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
                  )
                )
              ],
              if (autoClientsScreen.isNotEmpty) ...[
                SectionLabel(
                  label: AppLocalizations.of(context)!.activeClients,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                ),
                ListView.builder(                  
                  shrinkWrap: true,
                  primary: false,
                  itemCount: autoClientsScreen.length,
                  padding: const EdgeInsets.only(bottom: 0),
                  itemBuilder: (context, index) => CustomListTile(
                    title: autoClientsScreen[index].name != '' 
                      ? autoClientsScreen[index].name!
                      : autoClientsScreen[index].ip,
                    subtitle: autoClientsScreen[index].name != '' 
                      ? autoClientsScreen[index].ip 
                      : null,
                    trailing: Text(autoClientsScreen[index].source),
                    padding: index == 0
                      ? const EdgeInsets.only(left: 20, right: 20, bottom: 15)
                      : null,
                  )
                )
              ]
            ],
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                searchController.text == ''
                  ? AppLocalizations.of(context)!.inputSearchTerm
                  : AppLocalizations.of(context)!.noClientsSearch,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 22
                ),
              ),
            ),
          )
    );
  }
}