// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/screens/logs/log_list_tile.dart';

import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class LogDetailsScreen extends StatelessWidget {
  final Log log;
  final bool dialog;

  const LogDetailsScreen({
    Key? key,
    required this.log,
    required this.dialog
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);

    Filter? getList(int id) {
      try {
        return statusProvider.filteringStatus!.filters.firstWhere((filter) => filter.id == id, orElse: () {
          return statusProvider.filteringStatus!.whitelistFilters.firstWhere((filter) => filter.id == id);
        });
      } catch (_) {
        return null;
      }
    }

    Widget getResult() {
      final filter = getFilteredStatus(context, appConfigProvider, log.reason, true);
      return Text(
        filter['label'],
        style: TextStyle(
          color: filter['color'],
          fontWeight: FontWeight.w500
        ),
      );
    }

    void blockUnblock(String domain, String newStatus) async {
      final ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.savingUserFilters);

      final rules = await statusProvider.blockUnblockDomain(
        domain: domain,
        newStatus: newStatus
      );

      processModal.close();

      if (rules == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.userFilteringRulesNotUpdated, 
          color: Colors.red
        );
      }
    }

    Widget content() {
      return ListView(
        children: [
          SectionLabel(label: AppLocalizations.of(context)!.status),
          LogListTile(
            icon: Icons.shield_rounded, 
            title: AppLocalizations.of(context)!.result, 
            subtitleWidget: getResult(),
            trailing: log.cached == true 
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text(
                    "CACHE",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              : null,
          ),
          if (log.rule != null) LogListTile(
            icon: Icons.block, 
            title: AppLocalizations.of(context)!.blockingRule, 
            subtitle: log.rule
          ),
          LogListTile(
            icon: Icons.schedule, 
            title: AppLocalizations.of(context)!.time,
            subtitle: convertTimestampLocalTimezone(log.time, 'HH:mm:ss')
          ),
          SectionLabel(label: AppLocalizations.of(context)!.request),
          LogListTile(
            icon: Icons.domain_rounded, 
            title: AppLocalizations.of(context)!.domain,
            subtitle: log.question.name
          ),
          LogListTile(
            icon: Icons.category_rounded, 
            title: AppLocalizations.of(context)!.type,
            subtitle: log.question.type
          ),
          LogListTile(
            icon: Icons.class_rounded, 
            title: AppLocalizations.of(context)!.clas,
            subtitle: log.question.questionClass
          ),
          SectionLabel(label: AppLocalizations.of(context)!.response),
          if (log.upstream != null && log.upstream != '') LogListTile(
            icon: Icons.dns_rounded, 
            title: AppLocalizations.of(context)!.dnsServer,
            subtitle: log.upstream
          ),
          LogListTile(
            icon: Icons.timer_rounded, 
            title: AppLocalizations.of(context)!.elapsedTime,
            subtitle: "${double.parse(log.elapsedMs).toStringAsFixed(2)} ms"
          ),
          if (log.status != null) LogListTile(
            icon: Icons.system_update_alt_rounded, 
            title: AppLocalizations.of(context)!.responseCode,
            subtitle: log.status
          ),
          SectionLabel(label: AppLocalizations.of(context)!.client),
          LogListTile(
            icon: Icons.smartphone_rounded, 
            title: AppLocalizations.of(context)!.deviceIp,
            subtitle: log.client
          ),
          if (log.clientInfo != null && log.clientInfo!.name != '') LogListTile(
            icon: Icons.abc_rounded, 
            title: AppLocalizations.of(context)!.deviceName,
            subtitle: log.clientInfo!.name
          ),
          if (log.rules.isNotEmpty) ...[
            SectionLabel(label: AppLocalizations.of(context)!.rules),
            ...log.rules.map((rule) {
              final Filter? list = getList(rule.filterListId);
              if (list != null) {
                return LogListTile(
                  icon: Icons.rule_rounded, 
                  title: rule.text,
                  subtitle: list.name
                );
              }
              else {
                return const SizedBox();
              }
            }).toList()
          ],
          if (log.answer.isNotEmpty) ...[
            SectionLabel(label: AppLocalizations.of(context)!.answers),
            ...log.answer.map((a) => LogListTile(
              icon: Icons.download_rounded, 
              title: a.value,
              subtitle: "TTL: ${a.ttl.toString()}",
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(
                  a.type,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            )).toList()
          ]
        ],
      );
    }

    if (dialog) {
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
                    Row(
                      children: [
                            IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded)
                        ),
                        const SizedBox(width: 16),
                        Text(
                          AppLocalizations.of(context)!.logDetails,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: log.question.name != null
                            ? () => blockUnblock(
                                log.question.name!, 
                                getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true ? 'unblock' : 'block'
                              )
                            : null,
                          icon: Icon(
                            getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                              ? Icons.check_circle_rounded
                              : Icons.block
                          ),
                          tooltip: getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                            ? AppLocalizations.of(context)!.unblockDomain
                            : AppLocalizations.of(context)!.blockDomain,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: content(),
                ),
              )
            ],
          ),
        ),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title:  Text(AppLocalizations.of(context)!.logDetails),
          actions: [
            if (statusProvider.filteringStatus != null) IconButton(
              onPressed: log.question.name != null
                ? () => blockUnblock(
                    log.question.name!, 
                    getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true ? 'unblock' : 'block'
                  )
                : null,
              icon: Icon(
                getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                  ? Icons.check_circle_rounded
                  : Icons.block
              ),
              tooltip: getFilteredStatus(context, appConfigProvider, log.reason, true)['filtered'] == true
                ? AppLocalizations.of(context)!.unblockDomain
                : AppLocalizations.of(context)!.blockDomain,
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: content(),
      );
    }
  }
}