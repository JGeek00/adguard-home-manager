// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/domain_options.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class TopItemsModal extends StatefulWidget {
  final String type;
  final String title;
  final bool? isClient;
  final List<Map<String, dynamic>> data;

  const TopItemsModal({
    Key? key,
    required this.type,
    required this.title,
    this.isClient,
    required this.data,
  }) : super(key: key);

  @override
  State<TopItemsModal> createState() => _TopItemsModalState();
}

class _TopItemsModalState extends State<TopItemsModal> {
  bool searchActive = false;
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> screenData = [];

  void search(String value) {
    List<Map<String, dynamic>> newValues = widget.data.where((item) => item.keys.toList()[0].contains(value)).toList();
    setState(() => screenData = newValues);
  }

  @override
  void initState() {
    data = widget.data;
    screenData = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    int total = 0;
    for (var element in data) {
      total = total + int.parse(element.values.toList()[0].toString());
    }
    
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: searchController,
                      onChanged: search,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        hintText: AppLocalizations.of(context)!.search,
                        prefixIcon: const Icon(Icons.search_rounded),
                        contentPadding: const EdgeInsets.only(left: 14, bottom: 9, top: 11),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (screenData.isNotEmpty) Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: screenData.length,
                itemBuilder: (context, index) {
                  String? name;
                  if (widget.isClient != null && widget.isClient == true) {
                    try {
                      name = serversProvider.serverStatus.data!.clients.firstWhere((c) => c.ids.contains(screenData[index].keys.toList()[0])).name;
                    } catch (e) {
                      // ---- //
                    }
                  }
            
                  return DomainOptions(
                    isBlocked: widget.type == 'topBlockedDomains',
                    isClient: widget.type == 'topClients',
                    item: screenData[index].keys.toList()[0],
                    onTap: () {
                      if (widget.type == 'topQueriedDomains' || widget.type == 'topBlockedDomains') {
                        logsProvider.setSearchText(screenData[index].keys.toList()[0]);
                        logsProvider.setSelectedClients(null);
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: 'all', 
                            searchText: screenData[index].keys.toList()[0],
                            clients: null
                          )
                        );
                        appConfigProvider.setSelectedScreen(2);
                        Navigator.pop(context);
                      }
                      else if (widget.type == 'topClients') {
                        logsProvider.setSearchText(null);
                        logsProvider.setSelectedClients([screenData[index].keys.toList()[0]]);
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: 'all', 
                            searchText: null,
                            clients: [screenData[index].keys.toList()[0]]
                          )
                        );
                        appConfigProvider.setSelectedScreen(2);
                        Navigator.pop(context);
                      }
                    },
                    child: CustomListTile(
                      title: screenData[index].keys.toList()[0],
                      trailing: Text(
                        screenData[index].values.toList()[0].toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      ),
                      subtitleWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (name != null) ...[
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                child: Text(
                                  "${doubleFormat((screenData[index].values.toList()[0]/total*100), Platform.localeName)}%",
                                  style: TextStyle(
                                    color: Theme.of(context).listTileTheme.textColor
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: LinearPercentIndicator(
                                  animation: true,
                                  lineHeight: 4,
                                  animationDuration: 500,
                                  curve: Curves.easeOut,
                                  percent: screenData[index].values.toList()[0]/total,
                                  barRadius: const Radius.circular(5),
                                  progressColor: Theme.of(context).colorScheme.primary,
                                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      )
                    ),
                  );
                }
              ),
            ),
            if (screenData.isEmpty) Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context)!.noItemsSearch,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}