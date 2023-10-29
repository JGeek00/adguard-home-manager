// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/add_button.dart';
import 'package:adguard_home_manager/screens/filters/list_options_menu.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/options_modal.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/models/filtering.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class FiltersTripleColumn extends StatelessWidget {
  final void Function(String) onRemoveCustomRule;
  final void Function(Filter, String) onOpenDetailsModal;
  final List<Widget> actions;

  const FiltersTripleColumn({
    Key? key,
    required this.onRemoveCustomRule,
    required this.onOpenDetailsModal,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;
    
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
      switch (filteringProvider.loadStatus) {
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
                              icon: const Icon(Icons.add_rounded),
                              tooltip: AppLocalizations.of(context)!.addWhitelist,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteringProvider.filtering!.whitelistFilters.length,
                        itemBuilder: (context, index) => ListOptionsMenu(
                          list: filteringProvider.filtering!.whitelistFilters[index],
                          listType: 'whitelist',
                          child: CustomListTile(
                            title: filteringProvider.filtering!.whitelistFilters[index].name,
                            subtitle: "${intFormat(filteringProvider.filtering!.whitelistFilters[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                            trailing: Icon(
                              filteringProvider.filtering!.whitelistFilters[index].enabled == true
                                ? Icons.check_circle_rounded
                                : Icons.cancel,
                              color: filteringProvider.filtering!.whitelistFilters[index].enabled == true
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red
                            ),
                            onTap: () => onOpenDetailsModal(filteringProvider.filtering!.whitelistFilters[index], 'whitelist'),
                          ),
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
                              icon: const Icon(Icons.add_rounded),
                              tooltip: AppLocalizations.of(context)!.addBlacklist,
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteringProvider.filtering!.filters.length,
                        itemBuilder: (context, index) => ListOptionsMenu(
                          list: filteringProvider.filtering!.filters[index],
                          listType: 'blacklist',
                          child: CustomListTile(
                            title: filteringProvider.filtering!.filters[index].name,
                            subtitle: "${intFormat(filteringProvider.filtering!.filters[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                            trailing: Icon(
                              filteringProvider.filtering!.filters[index].enabled == true
                                ? Icons.check_circle_rounded
                                : Icons.cancel,
                              color: filteringProvider.filtering!.filters[index].enabled == true
                                ? appConfigProvider.useThemeColorForStatus == true
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.green
                                : appConfigProvider.useThemeColorForStatus == true
                                  ? Colors.grey
                                  : Colors.red
                            ),
                            onTap: () => onOpenDetailsModal(filteringProvider.filtering!.filters[index], 'blacklist'),
                          ),
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
                              icon: const Icon(Icons.add_rounded),
                              tooltip: AppLocalizations.of(context)!.addCustomRule,
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteringProvider.filtering!.userRules.length,
                        itemBuilder: (context, index) => ContextMenuArea(
                          builder: (context) => [
                            CustomListTile(
                              title: AppLocalizations.of(context)!.copyClipboard,
                              icon: Icons.copy_rounded,
                              onTap: () {
                                copyToClipboard(
                                  value: filteringProvider.filtering!.userRules[index],
                                  successMessage: AppLocalizations.of(context)!.copiedClipboard,
                                );
                                Navigator.pop(context);
                              }
                            ),
                          ],
                          child: CustomListTile(
                            onLongPress: () => showDialog(
                              context: context, 
                              builder: (context) => OptionsModal(
                                options: [
                                  MenuOption(
                                    title: AppLocalizations.of(context)!.copyClipboard,
                                    icon: Icons.copy_rounded,
                                    action: () => copyToClipboard(
                                      value: filteringProvider.filtering!.userRules[index],
                                      successMessage: AppLocalizations.of(context)!.copiedClipboard,
                                    )
                                  )
                                ]
                              )
                            ),
                            title: filteringProvider.filtering!.userRules[index],
                            subtitleWidget: generateSubtitle(filteringProvider.filtering!.userRules[index]),
                            trailing: IconButton(
                              onPressed: () => onRemoveCustomRule(filteringProvider.filtering!.userRules[index]),
                              icon: const Icon(Icons.delete),
                              tooltip: AppLocalizations.of(context)!.delete,
                            ),
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
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context)!.filters),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await filteringProvider.fetchFilters();
              if (result == false) {
                showSnacbkar(
                  appConfigProvider: appConfigProvider,
                  label: AppLocalizations.of(context)!.errorLoadFilters, 
                  color: Colors.red
                );
              }
            }, 
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