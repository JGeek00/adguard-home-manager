import 'dart:io';

import 'package:adguard_home_manager/screens/filters/add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class FiltersTripleColumn extends StatelessWidget {
  final void Function(String) onRemoveCustomRule;
  final void Function(Filter, String) onOpenDetailsModal;
  final List<Widget> actions;
  final Future Function() refreshData;

  const FiltersTripleColumn({
    Key? key,
    required this.onRemoveCustomRule,
    required this.onOpenDetailsModal,
    required this.actions,
    required this.refreshData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    bool checkIfComment(String value) {
      final regex = RegExp(r'^(!|#).*$');
      if (regex.hasMatch(value)) {
        return true;
      }
      else {
        return false;
      }
    }

    Widget? generateSubtitle(String rule) {
      final allowRegex = RegExp(r'^@@.*$');
      final blockRegex = RegExp(r'^\|\|.*$');
      final commentRegex = RegExp(r'^(#|!).*$');

      if (allowRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.allowed,
          style: const TextStyle(
            color: Colors.green
          ),
        );
      }
      else if (blockRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.blocked,
          style: const TextStyle(
            color: Colors.red
          ),
        );
      }
      else if (commentRegex.hasMatch(rule)) {
        return Text(
          AppLocalizations.of(context)!.comment,
          style: const TextStyle(
            color: Colors.grey
          ),
        );
      }
      else {
        return null;
      }
    }

    Widget content() {
      switch (serversProvider.filtering.loadStatus) {
        case LoadStatus.loading:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.loadingFilters,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                ],
              ),
            ],
          );

        case LoadStatus.loaded:
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.whitelists,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          AddFiltersButton(
                            type: 'whitelist', 
                            widget: (fn) => IconButton(
                              onPressed: fn, 
                              icon: const Icon(Icons.add_rounded)
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: serversProvider.filtering.data!.whitelistFilters.length,
                        itemBuilder: (context, index) => CustomListTile(
                          title: serversProvider.filtering.data!.whitelistFilters[index].name,
                          subtitle: "${intFormat(serversProvider.filtering.data!.whitelistFilters[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                          trailing: Icon(
                            serversProvider.filtering.data!.whitelistFilters[index].enabled == true
                              ? Icons.check_circle_rounded
                              : Icons.cancel,
                            color: serversProvider.filtering.data!.whitelistFilters[index].enabled == true
                              ? appConfigProvider.useThemeColorForStatus == true
                                ? Theme.of(context).colorScheme.primary
                                : Colors.green
                              : appConfigProvider.useThemeColorForStatus == true
                                ? Colors.grey
                                : Colors.red
                          ),
                          onTap: () => onOpenDetailsModal(serversProvider.filtering.data!.whitelistFilters[index], 'whitelist'),
                        ), 
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.blacklists,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          AddFiltersButton(
                            type: 'blacklist', 
                            widget: (fn) => IconButton(
                              onPressed: fn, 
                              icon: const Icon(Icons.add_rounded)
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: serversProvider.filtering.data!.filters.length,
                        itemBuilder: (context, index) => CustomListTile(
                          title: serversProvider.filtering.data!.filters[index].name,
                          subtitle: "${intFormat(serversProvider.filtering.data!.filters[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                          trailing: Icon(
                            serversProvider.filtering.data!.filters[index].enabled == true
                              ? Icons.check_circle_rounded
                              : Icons.cancel,
                            color: serversProvider.filtering.data!.filters[index].enabled == true
                              ? appConfigProvider.useThemeColorForStatus == true
                                ? Theme.of(context).colorScheme.primary
                                : Colors.green
                              : appConfigProvider.useThemeColorForStatus == true
                                ? Colors.grey
                                : Colors.red
                          ),
                          onTap: () => onOpenDetailsModal(serversProvider.filtering.data!.filters[index], 'blacklist'),
                        ), 
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.customRules,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          AddFiltersButton(
                            type: '', 
                            widget: (fn) => IconButton(
                              onPressed: fn, 
                              icon: const Icon(Icons.add_rounded)
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: serversProvider.filtering.data!.userRules.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            serversProvider.filtering.data!.userRules[index],
                            style: TextStyle(
                              color: checkIfComment(serversProvider.filtering.data!.userRules[index]) == true
                                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                                : Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: generateSubtitle(serversProvider.filtering.data!.userRules[index]),
                          trailing: IconButton(
                            onPressed: () => onRemoveCustomRule(serversProvider.filtering.data!.userRules[index]),
                            icon: const Icon(Icons.delete)
                          ),
                        ),  
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
          
        case LoadStatus.error:
          return SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.filtersNotLoaded,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filters),
        actions: [
          IconButton(
            onPressed: refreshData, 
            icon: const Icon(Icons.refresh_rounded),
            tooltip: AppLocalizations.of(context)!.refresh,
          ),
          ...actions
        ],
      ),
      body: content(),
    );
  }
}