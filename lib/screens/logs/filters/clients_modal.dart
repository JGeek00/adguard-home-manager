import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';
import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';

import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class ClientsModal extends StatelessWidget {
  final List<String>? value;
  final bool dialog;

  const ClientsModal({
    super.key,
    required this.value,
    required this.dialog
  });

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    if (dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: _ModalContent(
            selectedClients: logsProvider.selectedClients,
            onClientsSelected: (v) => logsProvider.setSelectedClients(v),
          )
        ),
      );
    }
    else {
      return ListBottomSheet(
        icon: Icons.smartphone_rounded, 
        title: AppLocalizations.of(context)!.clients,
        children: [
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
            itemCount: clientsProvider.clients!.autoClients.length,
            itemBuilder: (context, index) => _ListItem(
              label: clientsProvider.clients!.autoClients[index].ip, 
              checkboxActive: logsProvider.selectedClients.contains(clientsProvider.clients!.autoClients[index].ip),
              onChanged: (isSelected) {
                if (isSelected == true) {
                  logsProvider.setSelectedClients([
                    ...logsProvider.selectedClients,
                    clientsProvider.clients!.autoClients[index].ip
                  ]);
                }
                else {
                  logsProvider.setSelectedClients(
                    logsProvider.selectedClients.where(
                      (item) => item != clientsProvider.clients!.autoClients[index].ip
                    ).toList()
                  );
                }
              }
            )
          )
        ]
      );
    }
  }
}

class _ModalContent extends StatelessWidget {
  final List<String> selectedClients;
  final void Function(List<String>) onClientsSelected;

  const _ModalContent({
    required this.selectedClients,
    required this.onClientsSelected,
  });

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    return Column(
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
                itemCount: clientsProvider.clients!.autoClients.length,
                itemBuilder: (context, index) => _ListItem(
                  label: clientsProvider.clients!.autoClients[index].ip, 
                  checkboxActive: selectedClients.contains(clientsProvider.clients!.autoClients[index].ip),
                  onChanged: (isSelected) {
                    if (isSelected == true) {
                      onClientsSelected([
                        ...selectedClients,
                        clientsProvider.clients!.autoClients[index].ip
                      ]);
                    }
                    else {
                      onClientsSelected(
                        selectedClients.where(
                          (item) => item != clientsProvider.clients!.autoClients[index].ip
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