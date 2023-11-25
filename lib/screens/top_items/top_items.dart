// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/domain_options.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class TopItemsScreen extends StatefulWidget {
  final HomeTopItems type;
  final String title;
  final bool? isClient;
  final List<Map<String, dynamic>> data;
  final bool withProgressBar;
  final String? unit;

  const TopItemsScreen({
    super.key,
    required this.type,
    required this.title,
    this.isClient,
    required this.data,
    required this.withProgressBar,
    this.unit,
  });

  @override
  State<TopItemsScreen> createState() => _TopItemsScreenState();
}

class _TopItemsScreenState extends State<TopItemsScreen> {
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
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    double total = 0;
    for (var element in data) {
      total = total + double.parse(element.values.toList()[0].toString());
    }
    
    return Scaffold(
      appBar: AppBar(
        title: searchActive == true
          ? Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: TextFormField(
                controller: searchController,
                onChanged: search,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18
                ),
                autofocus: true,
              ),
          )
          : Text(widget.title),
        leading: searchActive == true ?
          IconButton(
            onPressed: () => setState(() {
              searchActive = false;
              searchController.text = '';
              screenData = data;
            }), 
            icon: const Icon(Icons.arrow_back),
            tooltip: AppLocalizations.of(context)!.exitSearch,
          ) : null,
        actions: [
          if (searchActive == false) IconButton(
            onPressed: () => setState(() => searchActive = true), 
            icon: const Icon(Icons.search),
            tooltip: AppLocalizations.of(context)!.search,
          ),
          if (searchActive == true) IconButton(
            onPressed: () => setState(() {
              searchController.text = '';
              screenData = data;
            }), 
            icon: const Icon(Icons.clear_rounded),
            tooltip: AppLocalizations.of(context)!.clearSearch,
          ),
          const SizedBox(width: 10)
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.maxFinite, 1),
          child: Container(
            width: double.maxFinite,
            height: 1,
            decoration: BoxDecoration(
              color: searchActive == true
                ? Colors.grey.withOpacity(0.5)
                : Colors.transparent
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final result = await statusProvider.getServerStatus();
          if (mounted && result == false) {
            showSnacbkar(
              appConfigProvider: appConfigProvider, 
              label: AppLocalizations.of(context)!.serverStatusNotRefreshed, 
              color: Colors.red
            );
          }
        },
        child: screenData.isNotEmpty
          ? ListView.builder(
              itemCount: screenData.length,
              itemBuilder: (context, index) {
                String? name;
                if (widget.isClient != null && widget.isClient == true) {
                  try {
                    name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(screenData[index].keys.toList()[0])).name;
                  } catch (e) {
                    // ---- //
                  }
                }

                return DomainOptions(
                  item: screenData[index].keys.toList()[0],
                  isBlocked: widget.type == HomeTopItems.blockedDomains,
                  isDomain: widget.type == HomeTopItems.queriedDomains || widget.type == HomeTopItems.blockedDomains,
                  onTap: () {
                    if (widget.type == HomeTopItems.queriedDomains || widget.type == HomeTopItems.blockedDomains) {
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
                    else if (widget.type == HomeTopItems.recurrentClients) {
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
                      screenData[index].values.toList()[0].runtimeType == double
                        ? "${screenData[index].values.toList()[0].toStringAsFixed(2)}${widget.unit != null ? ' ${widget.unit}' : ''}"
                        : "${screenData[index].values.toList()[0].toString()}${widget.unit != null ? ' ${widget.unit}' : ''}",
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
                        if (widget.withProgressBar == true) Row(
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
            )
          : Center(
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
      ),
    );
  }
}