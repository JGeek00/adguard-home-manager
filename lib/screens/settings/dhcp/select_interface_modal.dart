import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_interface_item.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class SelectInterfaceModal extends StatelessWidget {
  final List<NetworkInterface> interfaces;
  final void Function(NetworkInterface) onSelect;
  final bool dialog;

  const SelectInterfaceModal({
    Key? key,
    required this.interfaces,
    required this.onSelect,
    required this.dialog
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.settings_ethernet_rounded,
                              size: 24,
                              color: Theme.of(context).listTileTheme.iconColor
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.selectInterface,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onSurface
                              ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: interfaces.length,
                  itemBuilder: (context, index) => DhcpInterfaceItem(
                    networkInterface: interfaces[index], 
                    onSelect: onSelect
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text(AppLocalizations.of(context)!.cancel)
                    )
                  ],
                ),
              ),
              if (Platform.isIOS) const SizedBox(height: 16)
            ],
          ),
        ),
      );
    }
    else {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 1,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.settings_ethernet_rounded,
                          size: 24,
                          color: Theme.of(context).listTileTheme.iconColor
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.selectInterface,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: interfaces.length,
                      itemBuilder: (context, index) => DhcpInterfaceItem(
                        networkInterface: interfaces[index], 
                        onSelect: onSelect
                      )
                    )
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            );
          },
        ),
      );
    }
  }
}