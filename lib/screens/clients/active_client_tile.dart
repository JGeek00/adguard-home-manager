import 'package:flutter/material.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/options_modal.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/models/clients.dart';

class ActiveClientTile extends StatelessWidget {
  final AutoClient client;
  final void Function(AutoClient) onTap;
  final bool splitView;
  final AutoClient? selectedClient;

  const ActiveClientTile({
    Key? key,
    required this.client,
    required this.onTap,
    required this.splitView,
    this.selectedClient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (splitView == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ContextMenuArea(
          builder: (context) => [
            CustomListTile(
              title: AppLocalizations.of(context)!.copyClipboard,
              icon: Icons.copy_rounded,
              onTap: () {
                copyToClipboard(
                  context: context, 
                  value: client.name != '' 
                    ? client.name!
                    : client.ip,
                  successMessage: AppLocalizations.of(context)!.copiedClipboard,
                );
                Navigator.pop(context);
              },
            )
          ],
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => onTap(client),
              onLongPress: () => showDialog(
                context: context, 
                builder: (context) => OptionsModal(
                  options: [
                    MenuOption(
                      title: AppLocalizations.of(context)!.copyClipboard,
                      icon: Icons.copy_rounded,
                      action: () {
                        copyToClipboard(
                          context: context, 
                          value: client.name != '' 
                            ? client.name!
                            : client.ip,
                          successMessage: AppLocalizations.of(context)!.copiedClipboard,
                        );
                        Navigator.pop(context);
                      },
                    )
                  ]
                ),
              ),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: client == selectedClient 
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  client.name != '' 
                                    ? client.name!
                                    : client.ip,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                if (client.name != '') Text(client.ip)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      client.source,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      );
    }
    else {
      return ContextMenuArea(
        builder: (context) => [
          CustomListTile(
            title: AppLocalizations.of(context)!.copyClipboard,
            icon: Icons.copy_rounded,
            onTap: () {
              copyToClipboard(
                context: context, 
                value: client.name != '' 
                  ? client.name!
                  : client.ip,
                successMessage: AppLocalizations.of(context)!.copiedClipboard,
              );
              Navigator.pop(context);
            },
          )
        ],
        child: CustomListTile(
          title: client.name != '' 
            ? client.name!
            : client.ip,
          subtitle: client.name != '' 
            ? client.ip 
            : null,
          trailing: Text(
            client.source,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          onTap: () => onTap(client),
        ),
      );
    }
  }
}