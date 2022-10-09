import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/filter_list_tile.dart';

import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class ListDetailsModal extends StatelessWidget {
  final ScrollController scrollController;
  final Filter list;
  final String type;
  final void Function(Filter, String) onDelete;
  final void Function(String) edit;
  final void Function(Filter, bool) onEnableDisable;

  const ListDetailsModal({
    Key? key,
    required this.scrollController,
    required this.list,
    required this.type,
    required this.onDelete,
    required this.edit,
    required this.onEnableDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28)
        ),
        color: Theme.of(context).dialogBackgroundColor
      ),
      child: Column(
        children: [
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: ListView(
                controller: scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Icon(
                        type == 'whitelist'
                          ? Icons.verified_user_rounded
                          : Icons.gpp_bad_rounded,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.listDetails,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onEnableDisable(list, !list.enabled);
                        }, 
                        label: Text(
                          list.enabled == true
                            ? AppLocalizations.of(context)!.disable
                            : AppLocalizations.of(context)!.enable
                        ),
                        icon: Icon(
                          list.enabled == true
                            ? Icons.gpp_bad_rounded
                            : Icons.verified_user_rounded
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  FilterListTile(
                    icon: Icons.shield_rounded, 
                    title: AppLocalizations.of(context)!.currentStatus, 
                    subtitle: list.enabled == true
                      ? AppLocalizations.of(context)!.enabled
                      : AppLocalizations.of(context)!.disabled,
                    color: list.enabled == true
                      ? Colors.green
                      : Colors.red,
                    bold: true,
                  ),
                  FilterListTile(
                    icon: Icons.badge_rounded, 
                    title: AppLocalizations.of(context)!.name, 
                    subtitle: list.name
                  ),
                  FilterListTile(
                    icon: Icons.link_rounded, 
                    title: "URL", 
                    subtitle: list.url
                  ),
                  FilterListTile(
                    icon: Icons.list_rounded, 
                    title: AppLocalizations.of(context)!.rules, 
                    subtitle: list.rulesCount.toString()
                  ),
                  FilterListTile(
                    icon: Icons.shield_rounded, 
                    title: AppLocalizations.of(context)!.listType, 
                    subtitle: type == 'whitelist'
                      ? AppLocalizations.of(context)!.whitelist
                      : AppLocalizations.of(context)!.blacklist, 
                  ),
                  if (list.lastUpdated != null) FilterListTile(
                    icon: Icons.schedule_rounded, 
                    title: AppLocalizations.of(context)!.latestUpdate, 
                    subtitle: formatTimestampUTC(list.lastUpdated!, 'dd-MM-yyyy HH:mm'), 
                  ),
                ],
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        edit(type);
                      }, 
                      icon: const Icon(Icons.edit)
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        onDelete(list, type);
                      }, 
                      icon: const Icon(Icons.delete)
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.close)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}