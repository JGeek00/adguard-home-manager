// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/live/live_logs_screen.dart';
import 'package:adguard_home_manager/screens/logs/filters/logs_filters_modal.dart';

import 'package:adguard_home_manager/config/globals.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/live_logs_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

final GlobalKey _searchButtonKey = GlobalKey();

class LogsListAppBar extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final bool showDivider;

  const LogsListAppBar({
    super.key,
    required this.innerBoxIsScrolled,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void openFilersModal() {
      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => const LogsFiltersModal(
            dialog: true,
          ),
          barrierDismissible: false
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => const LogsFiltersModal(
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true
        );
      }
    }

    void showSearchDialog() {
      showDialog(
        context: context, 
        builder: (context) => _Search(
          searchButtonRenderBox: _searchButtonKey.currentContext?.findRenderObject() as RenderBox?,
          onSearch: (v) {
            logsProvider.setAppliedFilters(
              AppliedFiters(
                selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                searchText: v != "" ? v : null, 
                clients: logsProvider.appliedFilters.clients
              )
            );
            logsProvider.filterLogs();
          },
        ),
      );
    }

    void openLiveLogsScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProxyProvider<ServersProvider, LiveLogsProvider>(
                create: (context) => LiveLogsProvider(), 
                update: (context, servers, logs) => logs!..update(servers),
              ),
            ],
            child: const LiveLogsScreen()
          )
        )
      );
    }

    final Map<String, String> translatedString = {
      "all": AppLocalizations.of(context)!.all, 
      "filtered": AppLocalizations.of(context)!.filtered, 
      "processed": AppLocalizations.of(context)!.processedRow, 
      "whitelisted": AppLocalizations.of(context)!.processedWhitelistRow, 
      "blocked": AppLocalizations.of(context)!.blocked, 
      "blocked_safebrowsing": AppLocalizations.of(context)!.blockedSafeBrowsingRow, 
      "blocked_parental": AppLocalizations.of(context)!.blockedParentalRow, 
      "safe_search": AppLocalizations.of(context)!.safeSearch, 
    };

    return SliverAppBar.large(
      pinned: true,
      floating: true,
      centerTitle: false,
      forceElevated: innerBoxIsScrolled,
      surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      title: Text(AppLocalizations.of(context)!.logs),
      actions: [
        if (!(Platform.isAndroid || Platform.isIOS)) IconButton(
          onPressed: () => logsProvider.fetchLogs(inOffset: 0), 
          icon: const Icon(Icons.refresh_rounded),
          tooltip: AppLocalizations.of(context)!.refresh,
        ),
        if (logsProvider.loadStatus == LoadStatus.loaded) IconButton(
          key: _searchButtonKey,
          onPressed: showSearchDialog,
          icon: const Icon(Icons.search_rounded),
          tooltip: AppLocalizations.of(context)!.search,
        ),
        if (logsProvider.loadStatus == LoadStatus.loaded) PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: openFilersModal,
              child: Row(
                children: [
                  const Icon(Icons.filter_list_rounded),
                  const SizedBox(width: 10),
                  Text(AppLocalizations.of(context)!.filters)
                ],
              )
            ),
            PopupMenuItem(
              onTap: openLiveLogsScreen,
              child: Row(
                children: [
                  const Icon(Icons.stream_rounded),
                  const SizedBox(width: 10),
                  Text(AppLocalizations.of(context)!.liveLogs)
                ],
              )
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
      bottom: logsProvider.appliedFilters.searchText != null || logsProvider.appliedFilters.selectedResultStatus != 'all' || logsProvider.appliedFilters.clients.isNotEmpty
        ? PreferredSize(
            preferredSize: const Size(double.maxFinite, 70),
            child: Container(
              height: 50,
              width: double.maxFinite,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: showDivider == true
                      ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
                      : Colors.transparent,
                  )
                )
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (logsProvider.appliedFilters.searchText != null) ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.search_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            logsProvider.appliedFilters.searchText!,
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                            searchText: null,
                            clients: logsProvider.appliedFilters.clients
                          )
                        );
                        logsProvider.setSearchText(null);
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          searchText: ''
                        );
                      },
                    ),
                  ],
                  if (logsProvider.appliedFilters.selectedResultStatus != 'all') ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.shield_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            translatedString[logsProvider.appliedFilters.selectedResultStatus]!,
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: 'all', 
                            searchText: logsProvider.appliedFilters.searchText,
                            clients: logsProvider.appliedFilters.clients
                          )
                        );
                        logsProvider.setSelectedResultStatus(value: 'all');
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          responseStatus: 'all'
                        );
                      },
                    ),
                  ],
                  if (logsProvider.appliedFilters.clients.isNotEmpty) ...[
                    const SizedBox(width: 15),
                    Chip(
                      avatar: const Icon(
                        Icons.smartphone_rounded,
                      ),
                      label: Row(
                        children: [
                          Text(
                            logsProvider.appliedFilters.clients.length == 1
                              ? logsProvider.appliedFilters.clients[0]
                              : "${logsProvider.appliedFilters.clients.length} ${AppLocalizations.of(context)!.clients}",
                          ),
                        ],
                      ),
                      deleteIcon: const Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onDeleted: () {
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: logsProvider.appliedFilters.selectedResultStatus, 
                            searchText: logsProvider.appliedFilters.searchText,
                            clients: []
                          )
                        );
                        logsProvider.setSelectedClients(null);
                        logsProvider.fetchLogs(
                          inOffset: 0,
                          responseStatus: logsProvider.appliedFilters.selectedResultStatus
                        );
                      },
                    ),
                  ],
                  const SizedBox(width: 15),
                ],
              ),
            )
          )
      : null,
    );
  }
}

class _Search extends StatefulWidget {
  final void Function(String) onSearch;
  final RenderBox? searchButtonRenderBox;

  const _Search({
    required this.onSearch,
    required this.searchButtonRenderBox,
  });

  @override
  State<_Search> createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    final logsProvider = Provider.of<LogsProvider>(context, listen: false);
    _searchController.text = logsProvider.appliedFilters.searchText ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    final position = widget.searchButtonRenderBox?.localToGlobal(Offset.zero);
    final topPadding = MediaQuery.of(globalNavigatorKey.currentContext!).viewPadding.top;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth - 32  > 500 ? 500 : constraints.maxWidth - 32;
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: position != null ? position.dy - topPadding : topPadding,
                  child: SizedBox(
                    width: width,
                    child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (v) {
                              if (v == "") {
                                logsProvider.setSearchText(null);
                                return;
                              }
                              logsProvider.setSearchText(v);
                            },
                            onFieldSubmitted: (v) {
                              widget.onSearch(v);
                              Navigator.pop(context);
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              prefixIcon: const Icon(Icons.search_rounded),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.2),
                              suffixIcon: _searchController.text != ""
                                ? IconButton(
                                    onPressed: () {
                                      _searchController.text = "";
                                      logsProvider.setSearchText(null);
                                    }, 
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      size: 20,
                                    ),
                                    tooltip: AppLocalizations.of(context)!.clearSearch,
                                  )
                                : null,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}