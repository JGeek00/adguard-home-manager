import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';
import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class _ClientLog {
  final String ip;
  final String? name;

  const _ClientLog({
    required this.ip,
    required this.name
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
        ip: e.ip, 
        name: name
      );
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);

    void onSearch(String value) {
      final filtered = clientsProvider.clients!.autoClients.map((e) {
        String? name;
        try {
          name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(e.ip)).name;
        } catch (e) {
          // ---- //
        }
        return _ClientLog(
          ip: e.ip, 
          name: name
        );
      }).where(
        (c) => c.ip.contains(value.toLowerCase()) || (c.name != null && c.name!.toLowerCase().contains(value.toLowerCase()))
      ).toList();
      setState(() => _filteredClients = filtered);
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
                      onSearch: onSearch
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
                    CustomCheckboxListTile(
                      padding: const EdgeInsets.only(
                        left: 24,
                        top: 8,
                        right: 12,
                        bottom: 8
                      ),
                      value: logsProvider.selectedClients.length == clientsProvider.clients!.autoClients.length, 
                      onChanged: (v) {
                        if (v == true) {
                          logsProvider.setSelectedClients(clientsProvider.clients!.autoClients.map((e) => e.ip).toList());
                        }
                        else {
                          logsProvider.setSelectedClients([]);
                        }
                      }, 
                      title: AppLocalizations.of(context)!.selectAll
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: _filteredClients.length,
                      itemBuilder: (context, index) => _ListItem(
                        label: _filteredClients[index].ip, 
                        checkboxActive: logsProvider.selectedClients.contains(_filteredClients[index].ip),
                        onChanged: (isSelected) {
                          if (isSelected == true) {
                            logsProvider.setSelectedClients([
                              ...logsProvider.selectedClients,
                              _filteredClients[index].ip
                            ]);
                          }
                          else {
                            logsProvider.setSelectedClients(
                              logsProvider.selectedClients.where(
                                (item) => item != _filteredClients[index].ip
                              ).toList()
                            );
                          }
                        }
                      )
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
              onSearch: onSearch
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
            CustomCheckboxListTile(
              padding: const EdgeInsets.only(
                left: 24,
                top: 8,
                right: 12,
                bottom: 8
              ),
              value: logsProvider.selectedClients.length == clientsProvider.clients!.autoClients.length, 
              onChanged: (v) {
                if (v == true) {
                  logsProvider.setSelectedClients(clientsProvider.clients!.autoClients.map((e) => e.ip).toList());
                }
                else {
                  logsProvider.setSelectedClients([]);
                }
              }, 
              title: AppLocalizations.of(context)!.selectAll
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: _filteredClients.length,
              itemBuilder: (context, index) => _ListItem(
                label: _filteredClients[index].ip, 
                checkboxActive: logsProvider.selectedClients.contains(_filteredClients[index].ip),
                onChanged: (isSelected) {
                  if (isSelected == true) {
                    logsProvider.setSelectedClients([
                      ...logsProvider.selectedClients,
                      _filteredClients[index].ip
                    ]);
                  }
                  else {
                    logsProvider.setSelectedClients(
                      logsProvider.selectedClients.where(
                        (item) => item != _filteredClients[index].ip
                      ).toList()
                    );
                  }
                }
              )
            )
          ]
        ),
      );
    }
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
  final String label;
  final bool checkboxActive;
  final void Function(bool) onChanged;

  const _ListItem({
    required this.label,
    required this.checkboxActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    String? name;
    try {
      name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(label)).name;
    } catch (e) {
      // ---- //
    }

    return CustomCheckboxListTile(
      value: checkboxActive, 
      onChanged: (v) => onChanged(v),
      title: label,
      subtitle: name,
      padding: const EdgeInsets.only(
        left: 24,
        top: 8,
        right: 12,
        bottom: 8
      ),
    );
  }
}