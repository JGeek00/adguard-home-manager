import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

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
  List<String> selectedClients = [];

  @override
  void initState() {
    setState(() => selectedClients = widget.value ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: _ModalContent(
            selectedClients: selectedClients,
            onClientsSelected: (v) => setState(() => selectedClients = v),
          )
        ),
      );
    }
    else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height-50
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28) 
            ),
            color: Theme.of(context).dialogBackgroundColor
          ),
          child: _ModalContent(
            selectedClients: selectedClients,
            onClientsSelected: (v) => setState(() => selectedClients = v),
          )
        ),
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

    void apply() async {
      logsProvider.setSelectedClients(
        selectedClients.isNotEmpty ? selectedClients : null
      );

      Navigator.pop(context);
    }

    void selectAll() {
      onClientsSelected(
        clientsProvider.clients!.autoClients.map((item) => item.ip).toList()
      );
    }

    void unselectAll() {
      onClientsSelected([]);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 16,
              ),
              child: Icon(
                Icons.smartphone_rounded,
                size: 24,
                color: Theme.of(context).listTileTheme.iconColor
              ),
            ),
            Text(
              AppLocalizations.of(context)!.clients,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        Flexible(
          child: ListView.builder(
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
          )
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: selectedClients.length == clientsProvider.clients!.autoClients.length
                  ? () => unselectAll()
                  : () => selectAll(), 
                child: Text(
                  selectedClients.length == clientsProvider.clients!.autoClients.length
                    ? AppLocalizations.of(context)!.unselectAll
                    : AppLocalizations.of(context)!.selectAll
                )
              ),
              TextButton(
                onPressed: apply, 
                child: Text(AppLocalizations.of(context)!.apply)
              )
            ],
          ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!checkboxActive),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 8,
            right: 12,
            bottom: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
              ),
              Checkbox(
                value: checkboxActive, 
                onChanged: (v) => onChanged(!checkboxActive),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}