import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dhcp/dhcp_interface_item.dart';
import 'package:adguard_home_manager/widgets/list_bottom_sheet.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class SelectInterfaceModal extends StatelessWidget {
  final List<NetworkInterface> interfaces;
  final void Function(NetworkInterface) onSelect;
  final bool dialog;

  const SelectInterfaceModal({
    super.key,
    required this.interfaces,
    required this.onSelect,
    required this.dialog
  });

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
      return ListBottomSheet(
        icon: Icons.settings_ethernet_rounded, 
        title: AppLocalizations.of(context)!.selectInterface,
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: interfaces.length,
            itemBuilder: (context, index) => DhcpInterfaceItem(
              networkInterface: interfaces[index], 
              onSelect: onSelect
            )
          ),
        ]
      );
    }
  }
}