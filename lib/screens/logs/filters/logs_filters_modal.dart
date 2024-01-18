// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/filters/clients_modal.dart';
import 'package:adguard_home_manager/screens/logs/filters/filter_status_modal.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class LogsFiltersModal extends StatefulWidget {
  final bool dialog;

  const LogsFiltersModal({
    super.key,
    required this.dialog
  });

  @override
  State<LogsFiltersModal> createState() => _LogsFiltersModalState();
}

class _LogsFiltersModalState extends State<LogsFiltersModal> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = Provider.of<LogsProvider>(context, listen: false).searchText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dialog == true) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500
            ),
            child: _FiltersList(
              searchController: searchController, 
              onClearSearch: () => setState(() => searchController.text = "")
            )
          )
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            )
          ),
          child: SafeArea(
            child: _FiltersList(
              searchController: searchController, 
              onClearSearch: () => setState(() => searchController.text = "")
            ),
          )
        ),
      );
    }
  }
}

class _FiltersList extends StatelessWidget {
  final TextEditingController searchController;
  final void Function() onClearSearch;

  const _FiltersList({
    Key? key,
    required this.searchController,
    required this.onClearSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);
    final clientsProvider = Provider.of<ClientsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    final Map<String, String> translatedString = {
      "all": AppLocalizations.of(context)!.all, 
      "filtered": AppLocalizations.of(context)!.filtered, 
      "processed": AppLocalizations.of(context)!.processedRow, 
      "whitelisted": AppLocalizations.of(context)!.processedWhitelistRow, 
      "blocked": AppLocalizations.of(context)!.blocked, 
      "blocked_safebrowsing": AppLocalizations.of(context)!.blockedSafeBrowsingRow, 
      "blocked_parental": AppLocalizations.of(context)!.blockedParentalRow, 
      "safe_search": AppLocalizations.of(context)!.blockedSafeSearchRow, 
    };

    void openSelectFilterStatus() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (context) => FilterStatusModal(
            value: logsProvider.selectedResultStatus,
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => FilterStatusModal(
            value: logsProvider.selectedResultStatus,
            dialog: false,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent
        );
      }
    }

    void openSelectClients() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context,
          builder: (context) => ClientsModal(
            value: logsProvider.selectedClients,
            dialog: true,
          ),
          barrierDismissible: false
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => ClientsModal(
            value: logsProvider.selectedClients,
            dialog: false,
          ),
          isScrollControlled: true,
          backgroundColor: Colors.transparent
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 16,
                          ),
                          child: Icon(
                            Icons.filter_list_rounded,
                            size: 24,
                            color: Theme.of(context).listTileTheme.iconColor
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.filters,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onChanged: logsProvider.setSearchText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10)
                              )
                            ),
                            labelText: AppLocalizations.of(context)!.search,
                            suffixIcon: IconButton(
                              onPressed: () {
                                onClearSearch();
                                logsProvider.setSearchText(null);
                              },
                              icon: const Icon(Icons.clear)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(height: 16),
                CustomListTile(
                  title: AppLocalizations.of(context)!.client,
                  subtitle: logsProvider.selectedClients != null
                    ? "${logsProvider.selectedClients!.length} ${AppLocalizations.of(context)!.clientsSelected}"
                    : AppLocalizations.of(context)!.all,
                  onTap: clientsProvider.loadStatus == LoadStatus.loaded 
                    ? openSelectClients
                    : null,
                  disabled: clientsProvider.loadStatus != LoadStatus.loaded,
                  icon: Icons.smartphone_rounded,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  trailing: clientsProvider.loadStatus == LoadStatus.loading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                    : clientsProvider.loadStatus == LoadStatus.error
                      ? const Icon(
                          Icons.error_rounded,
                          color: Colors.red,
                        )
                      : null,
                ),
                SectionLabel(
                  label: AppLocalizations.of(context)!.quickFilters,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterChip(
                      selected: logsProvider.selectedResultStatus == "all",
                      label: Text(AppLocalizations.of(context)!.all), 
                      onSelected: (_) => logsProvider.setSelectedResultStatus(value: "all")
                    ),
                    FilterChip(
                      selected: logsProvider.selectedResultStatus == "processed" ||
                        logsProvider.selectedResultStatus == "whitelisted",
                      label: Text(AppLocalizations.of(context)!.allowed), 
                      onSelected: (_) => logsProvider.setSelectedResultStatus(value: "processed")
                    ),
                    FilterChip(
                      selected: logsProvider.selectedResultStatus == "blocked" || 
                        logsProvider.selectedResultStatus == "blocked_safebrowsing" ||
                        logsProvider.selectedResultStatus == "blocked_parental" ||
                        logsProvider.selectedResultStatus == "safe_search",
                      label: Text(AppLocalizations.of(context)!.blocked), 
                      onSelected: (_) => logsProvider.setSelectedResultStatus(value: "blocked")
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(8)),
                CustomListTile(
                  title: AppLocalizations.of(context)!.responseStatus,
                  subtitle: "${translatedString[logsProvider.selectedResultStatus]}",
                  onTap: openSelectFilterStatus,
                  icon: Icons.shield_rounded,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  searchController.text = "";
                  logsProvider.requestResetFilters();
                }, 
                child: Text(AppLocalizations.of(context)!.resetFilters)
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  logsProvider.filterLogs();
                },
                child: Text(AppLocalizations.of(context)!.apply)
              ),
            ],
          ),
        ),
        if (Platform.isIOS) const SizedBox(height: 16)
      ],
    );
  }
}