// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/screens/logs/clients_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/filter_status_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';

class LogsFiltersModal extends StatelessWidget {
  const LogsFiltersModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);

    return LogsFiltersModalWidget(
      logsProvider: logsProvider
    );
  }
}

class LogsFiltersModalWidget extends StatefulWidget {
  final LogsProvider logsProvider;

  const LogsFiltersModalWidget({
    Key? key,
    required this.logsProvider
  }) : super(key: key);

  @override
  State<LogsFiltersModalWidget> createState() => _LogsFiltersModalWidgetState();
}

class _LogsFiltersModalWidgetState extends State<LogsFiltersModalWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.logsProvider.searchText ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<LogsProvider>(context);
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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

    void selectTime() async {
      DateTime now = DateTime.now();
      DateTime? dateValue = await showDatePicker(
        context: context, 
        initialDate: now, 
        firstDate: DateTime(now.year, now.month-1, now.day), 
        lastDate: now
      );
      if (dateValue != null) {
        TimeOfDay? timeValue = await showTimePicker(
          context: context, 
          initialTime: TimeOfDay.now(),
          helpText: AppLocalizations.of(context)!.selectTime,
        );
        if (timeValue != null) {
          DateTime value = DateTime(
            dateValue.year,
            dateValue.month,
            dateValue.day,
            timeValue.hour,
            timeValue.minute,
            dateValue.second
          ).toUtc();

          logsProvider.setLogsOlderThan(value);
        }
      }
    }

    void resetFilters() async {
      setState(() {
        searchController.text = '';
      });

      logsProvider.setLoadStatus(0);

      logsProvider.resetFilters();

      final result = await getLogs(
        server: serversProvider.selectedServer!, 
        count: logsProvider.logsQuantity
      );

      logsProvider.setAppliedFilters(
        AppliedFiters(
          selectedResultStatus: 'all', 
          searchText: null,
          clients: null
        )
      );

      if (result['result'] == 'success') {
        logsProvider.setLogsData(result['data']);
        logsProvider.setLoadStatus(1);
      }
      else {
        appConfigProvider.addLog(result['log']);
        logsProvider.setLoadStatus(2);
      }
    }

    void openSelectFilterStatus() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => FilterStatusModal(
          value: logsProvider.selectedResultStatus,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    void openSelectClients() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => ClientsModal(
          value: logsProvider.selectedClients,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent
      );
    }

    void filterLogs() async {
      Navigator.pop(context);

      logsProvider.setLoadStatus(0);

      logsProvider.setOffset(0);

      final result = await getLogs(
        server: serversProvider.selectedServer!, 
        count: logsProvider.logsQuantity,
        olderThan: logsProvider.logsOlderThan,
        responseStatus: logsProvider.selectedResultStatus,
        search: logsProvider.searchText,
      );

      logsProvider.setAppliedFilters(
        AppliedFiters(
          selectedResultStatus: logsProvider.selectedResultStatus,
          searchText: logsProvider.searchText,
          clients: logsProvider.selectedClients
        )
      );

      if (result['result'] == 'success') {
        logsProvider.setLogsData(result['data']);
        logsProvider.setLoadStatus(1);
      }
      else {
        appConfigProvider.addLog(result['log']);
        logsProvider.setLoadStatus(2);
      }
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 430,
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          )
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: 400 < MediaQuery.of(context).size.height
                  ? const NeverScrollableScrollPhysics() 
                  : null,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) => logsProvider.setSearchText(value),
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
                                  setState(() {
                                    searchController.text = '';
                                  });
                                  logsProvider.setSearchText(null);
                                },
                                icon: const Icon(Icons.clear)
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     onTap: selectTime,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //       child: Row(
                  //         children: [
                  //           const Icon(
                  //             Icons.schedule,
                  //             size: 24,
                  //             color: Colors.grey,
                  //           ),
                  //           const SizedBox(width: 20),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 AppLocalizations.of(context)!.logsOlderThan,
                  //                 style: const TextStyle(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.w500
                  //                 ),
                  //               ),
                  //               const SizedBox(height: 5),
                  //               Text(
                  //                 logsProvider.logsOlderThan != null
                  //                   ? convertTimestampLocalTimezone(logsProvider.logsOlderThan!, 'HH:mm - dd/MM/yyyy')
                  //                   : AppLocalizations.of(context)!.notSelected,
                  //                 style: const TextStyle(
                  //                   fontSize: 14,
                  //                   color: Colors.grey
                  //                 ),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  CustomListTile(
                    title: AppLocalizations.of(context)!.client,
                    subtitle: logsProvider.selectedClients != null
                      ? "${logsProvider.selectedClients!.length} ${AppLocalizations.of(context)!.clientsSelected}"
                      : AppLocalizations.of(context)!.all,
                    onTap: logsProvider.clientsLoadStatus == 1 
                      ? openSelectClients
                      : null,
                    disabled: logsProvider.clientsLoadStatus != 1 ,
                    icon: Icons.smartphone_rounded,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    trailing: logsProvider.clientsLoadStatus == 0 
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                      : logsProvider.clientsLoadStatus == 2 
                        ? const Icon(
                            Icons.error_rounded,
                            color: Colors.red,
                          )
                        : null,
                  ),
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: resetFilters, 
                    child: Text(AppLocalizations.of(context)!.resetFilters)
                  ),
                  TextButton(
                    onPressed: filterLogs, 
                    child: Text(AppLocalizations.of(context)!.apply)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}