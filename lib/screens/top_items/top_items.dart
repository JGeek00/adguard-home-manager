// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items_options_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/functions/copy_clipboard.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/functions/block_unblock_domain.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class TopItemsScreen extends StatefulWidget {
  final String type;
  final String title;
  final bool? isClient;
  final List<Map<String, dynamic>> data;

  const TopItemsScreen({
    Key? key,
    required this.type,
    required this.title,
    this.isClient,
    required this.data,
  }) : super(key: key);

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
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    int total = 0;
    for (var element in data) {
      total = total + int.parse(element.values.toList()[0].toString());
    }

    bool? getIsBlocked() {
      if (widget.type == 'topBlockedDomains') {
        return true;
      }
      else if (widget.type == 'topQueriedDomains') {
        return false;
      }
      else {
        return null;
      }
    }

    void changeBlockStatus(String status, String domain) async {
      final result = await blockUnblock(context, domain, status);
      showSnacbkar(
        context: context, 
        appConfigProvider: appConfigProvider, 
        label: result['message'], 
        color: result['success'] == true ? Colors.green : Colors.red
      );
    }

    void openOptionsModal(String domain) {
      showDialog(
        context: context, 
        builder: (context) => TopItemsOptionsModal(
          isBlocked: getIsBlocked(),
          changeStatus: (String status) => changeBlockStatus(status, domain),
          copyToClipboard: () => copyToClipboard(
            context: context, 
            value: domain, 
            successMessage: AppLocalizations.of(context)!.domainCopiedClipboard
          )
        )
      );
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
          final result = await getServerStatus(serversProvider.selectedServer!);
          if (result['result'] == 'success') {
            serversProvider.setServerStatusData(result['data']);
          }
          else {
            appConfigProvider.addLog(result['log']);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.serverStatusNotRefreshed),
                backgroundColor: Colors.red,
              )
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
                    name = serversProvider.serverStatus.data!.clients.firstWhere((c) => c.ids.contains(screenData[index].keys.toList()[0])).name;
                  } catch (e) {
                    // ---- //
                  }
                }

                return CustomListTile(
                  onTap: widget.type == 'topQueriedDomains' || widget.type == 'topBlockedDomains'
                    ? () {
                        logsProvider.setSearchText(screenData[index].keys.toList()[0]);
                        logsProvider.setAppliedFilters(
                          AppliedFiters(
                            selectedResultStatus: 'all', 
                            searchText: screenData[index].keys.toList()[0]
                          )
                        );
                        Navigator.pop(context);
                        appConfigProvider.setSelectedScreen(2);
                      }
                    : null,
                  onLongPress: widget.type == 'topQueriedDomains' || widget.type == 'topBlockedDomains'
                    ? () => openOptionsModal(screenData[index].keys.toList()[0])
                    : null,
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
                );
              }
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context)!.noItemsSearch,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey
                  ),
                ),
              ),
            )
      ),
    );
  }
}