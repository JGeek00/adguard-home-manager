import 'package:flutter/material.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AddedClientTile extends StatelessWidget {
  final Client client;
  final void Function(Client) onTap;
  final void Function(Client) onLongPress;
  final void Function(Client)? onEdit;
  final void Function(Client) onDelete;
  final Client? selectedClient;
  final bool? splitView;

  const AddedClientTile({
    super.key,
    required this.client,
    required this.onTap,
    required this.onLongPress,
    this.onEdit,
    required this.onDelete,
    this.selectedClient,
    required this.splitView,
  });

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    if (splitView == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(28),
          child: ContextMenuArea(
            builder: (context) => [
              if (onEdit != null) CustomListTile(
                title: AppLocalizations.of(context)!.edit,
                icon: Icons.edit_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onEdit!(client);
                }
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.delete,
                icon: Icons.delete_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onDelete(client);
                }
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.copyClipboard,
                icon: Icons.copy_rounded,
                onTap: () {
                  copyToClipboard(
                    value: client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''), 
                    successMessage: AppLocalizations.of(context)!.copiedClipboard,
                  );
                  Navigator.pop(context);
                }
              ),
            ],
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => onTap(client),
              onLongPress: () => onLongPress(client),
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
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.filter_list_rounded,
                                      size: 19,
                                      color: client.filteringEnabled == true 
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
                                      color: client.safebrowsingEnabled == true 
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
                                      color: client.parentalEnabled == true 
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
                                      color: client.safeSearch != null && client.safeSearch!.enabled == true 
                                        ? appConfigProvider.useThemeColorForStatus == true
                                          ? Theme.of(context).colorScheme.primary
                                          : Colors.green
                                        : appConfigProvider.useThemeColorForStatus == true
                                          ? Colors.grey
                                          : Colors.red
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
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
          if (onEdit != null) CustomListTile(
            title: AppLocalizations.of(context)!.seeDetails,
            icon: Icons.file_open_rounded,
            onTap: () {
              Navigator.pop(context);
              onEdit!(client);
            }
          ),
          CustomListTile(
            title: AppLocalizations.of(context)!.copyClipboard,
            icon: Icons.copy_rounded,
            onTap: () {
              copyToClipboard(
                value: client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''), 
                successMessage: AppLocalizations.of(context)!.copiedClipboard,
              );
              Navigator.pop(context);
            }
          ),
        ],
        child: CustomListTile(
          onLongPress: () => onLongPress(client),
          onTap: () => onTap(client),
          title: client.name,
          subtitleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.ids.toString().replaceAll(RegExp(r'^\[|\]$'), ''),
                style: TextStyle(
                  color: Theme.of(context).listTileTheme.textColor
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    size: 19,
                    color: client.filteringEnabled == true 
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
                    color: client.safebrowsingEnabled == true 
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
                    color: client.parentalEnabled == true 
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
                    color: client.safeSearch != null && client.safeSearch!.enabled == true 
                      ? appConfigProvider.useThemeColorForStatus == true
                        ? Theme.of(context).colorScheme.primary
                        : Colors.green
                      : appConfigProvider.useThemeColorForStatus == true
                        ? Colors.grey
                        : Colors.red
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}