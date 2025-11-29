import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';
import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class _ClientLog {
  final String? name;
  final List<String> ids;

  const _ClientLog({
    required this.name,
    required this.ids,
  });
}

class ClientsModal extends StatefulWidget {
  final List<String>? value;
  final bool dialog;

  const ClientsModal({
    super.key,
    required this.value,
    required this.dialog
  });

  @override
  State<ClientsModal> createState() => _ClientsModalState();
}

class _ClientsModalState extends State<ClientsModal> {
  List<_ClientLog> _filteredClients = [];
  final _searchController = TextEditingController();
  int _selectedList = 0;

  @override
  void initState() {
    final clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);
    _filteredClients = clientsProvider.clients!.autoClients.map((e) {
      String? name;
      try {
        name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(e.ip)).name;
      } catch (e) {
        // ---- //
      }
      return _ClientLog(
        name: name,
        ids: [e.ip]
      );
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);

    void onSearch({required String value, int? selectedList}) {
      if ((selectedList ?? _selectedList) == 1) {
        final filtered = clientsProvider.clients!.clients.map((e) {
          String? name;
          try {
            name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(e.ids[0])).name;
          } catch (e) {
            // ---- //
          }
          return _ClientLog(
            name: name,
            ids: e.ids
          );
        }).toList();
        setState(() => _filteredClients = filtered);
      }
      else {
        final filtered = clientsProvider.clients!.autoClients.map((e) {
          String? name;
          try {
            name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(e.ip)).name;
          } catch (e) {
            // ---- //
          }
          return _ClientLog(
            name: name,
            ids: [e.ip]
          );
        }).toList();
        setState(() => _filteredClients = filtered);
      }
    }

    void onListChange(int list) {
      onSearch(value: _searchController.text, selectedList: list);
    }

    void searchAddedClient(_ClientLog client) {
      logsProvider.setSearchText(client.ids[0]);
      logsProvider.filterLogs();
      Navigator.of(context).pop();
      Navigator.pop(context);
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CloseButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      AppLocalizations.of(context)!.clients,
                      style: const TextStyle(
                        fontSize: 22
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: [
                    _SearchField(
                      controller: _searchController, 
                      onClear: () => setState(() => _searchController.text = ""), 
                      onSearch: (v) => onSearch(value: v)
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_rounded,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Text(AppLocalizations.of(context)!.selectClientsFiltersInfo)
                            )
                          ],
                        ),
                      ),
                    ),
                    _Content(
                      selectedList: _selectedList, 
                      filteredClients: _filteredClients, 
                      onListChange: (v) {
                        onListChange(v);
                        setState(() => _selectedList = v);
                      }, 
                      searchAddedClient: searchAddedClient
                    ),
                  ],
                )
              ),
              if (Platform.isIOS) const SizedBox(height: 16)
            ],
          )
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ListBottomSheet(
          icon: Icons.smartphone_rounded, 
          title: AppLocalizations.of(context)!.clients,
          children: [
            _SearchField(
              controller: _searchController, 
              onClear: () => setState(() => _searchController.text = ""), 
              onSearch: (v) => onSearch(value: v)
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(AppLocalizations.of(context)!.selectClientsFiltersInfo)
                    ),
                  ],
                ),
              ),
            ),
            _Content(
              selectedList: _selectedList, 
              filteredClients: _filteredClients, 
              onListChange: (v) {
                onListChange(v);
                setState(() => _selectedList = v);
              }, 
              searchAddedClient: searchAddedClient
            ),
          ]
        ),
      );
    }
  }
}

class _Content extends StatelessWidget {
  final int selectedList;
  final List<_ClientLog> filteredClients;
  final void Function(int) onListChange;
  final void Function(_ClientLog) searchAddedClient;

  const _Content({
    required this.selectedList,
    required this.filteredClients,
    required this.onListChange,   
    required this.searchAddedClient,
  });

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SegmentedButtonSlide(
            entries: [
              SegmentedButtonSlideEntry(icon: Icons.devices, label: AppLocalizations.of(context)!.activeClients),
              SegmentedButtonSlideEntry(icon: Icons.add_rounded, label: AppLocalizations.of(context)!.added),
            ], 
            selectedEntry: selectedList, 
            onChange: onListChange,
            colors: SegmentedButtonSlideColors(
              barColor: Theme.of(context).colorScheme.primary.withOpacity(0.2), 
              backgroundSelectedColor: Theme.of(context).colorScheme.primary, 
            ),
            selectedTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w700
            ),
            unselectedTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            hoverTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: filteredClients.length,
          itemBuilder: (context, index) => _ListItem(
            title: selectedList == 0 ? filteredClients[index].ids[0] : filteredClients[index].name ?? "", 
            subtitle: selectedList == 0 ? filteredClients[index].name : filteredClients[index].ids.join(", "),
            checkboxActive: filteredClients[index].ids.any((id) => logsProvider.selectedClients.contains(id)),
            isAddedClient: selectedList == 1,
            onSearchAddedClient: () => searchAddedClient(filteredClients[index]),
            onChanged: (isSelected) {
              if (isSelected == true) {
                logsProvider.setSelectedClients([
                  ...logsProvider.selectedClients,
                  filteredClients[index].ids[0]
                ]);
              }
              else {
                logsProvider.setSelectedClients(
                  logsProvider.selectedClients.where(
                    (item) => !filteredClients[index].ids.contains(item)
                  ).toList()
                );
              }
            }
          )
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;
  final void Function() onClear;

  const _SearchField({
    required this.controller,
    required this.onClear,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextFormField(
          controller: controller,
          onChanged: onSearch,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            prefixIcon: const Icon(Icons.search_rounded),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            suffixIcon: controller.text != ""
              ? IconButton(
                  onPressed: onClear, 
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 20,
                  ),
                  tooltip: AppLocalizations.of(context)!.clearSearch,
                )
              : null
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool checkboxActive;
  final void Function(bool) onChanged;
  final bool isAddedClient;
  final void Function()? onSearchAddedClient;

  const _ListItem({
    required this.title,
    this.subtitle,
    required this.checkboxActive,
    required this.onChanged,
    required this.isAddedClient,
    required this.onSearchAddedClient,
  });

  @override
  Widget build(BuildContext context) {
    if (isAddedClient == true) {
      return CustomListTile(
        title: title,
        subtitle: subtitle,
        trailing: TextButton(
          onPressed: onSearchAddedClient, 
          child: Text(AppLocalizations.of(context)!.select)
        ),
      );
    }
    else {
      return CustomCheckboxListTile(
        value: checkboxActive, 
        onChanged: (v) => onChanged(v),
        title: title,
        subtitle: subtitle,
        padding: const EdgeInsets.only(
          left: 24,
          top: 8,
          right: 12,
          bottom: 8
        ),
      );
    }
  }
}