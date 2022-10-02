import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/log_list_tile.dart';

import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/models/logs.dart';

class LogDetailsModal extends StatelessWidget {
  final Log log;
  final void Function(Log, String) blockUnblock;

  const LogDetailsModal({
    Key? key,
    required this.log,
    required this.blockUnblock
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getResult() {
      final filter = getFilteredStatus(context, log.reason);
      return Text(
        filter['label'],
        style: TextStyle(
          color: filter['color'],
          fontWeight: FontWeight.w500
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          )
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 24,
                bottom: 20,
              ),
              child: Icon(
                Icons.list_rounded,
                size: 26,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.logDetails,
              style: const TextStyle(
                fontSize: 24
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  LogListTile(
                    icon: Icons.shield_rounded, 
                    title: AppLocalizations.of(context)!.result, 
                    subtitleWidget: getResult(),
                    trailing: log.cached == true 
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text(
                            "CACHE",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
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
                    subtitle: formatTimestampUTCFromAPI(log.time, 'HH:mm:ss')
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.request,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.response,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  if (log.upstream != '') LogListTile(
                    icon: Icons.dns_rounded, 
                    title: AppLocalizations.of(context)!.dnsServer,
                    subtitle: log.upstream
                  ),
                  LogListTile(
                    icon: Icons.timer_rounded, 
                    title: AppLocalizations.of(context)!.elapsedTime,
                    subtitle: "${double.parse(log.elapsedMs).toStringAsFixed(2)} ms"
                  ),
                  LogListTile(
                    icon: Icons.system_update_alt_rounded, 
                    title: AppLocalizations.of(context)!.responseCode,
                    subtitle: log.status
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.client,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  LogListTile(
                    icon: Icons.smartphone_rounded, 
                    title: AppLocalizations.of(context)!.deviceIp,
                    subtitle: log.client
                  ),
                  if (log.clientInfo.name != '') LogListTile(
                    icon: Icons.abc_rounded, 
                    title: AppLocalizations.of(context)!.deviceName,
                    subtitle: log.clientInfo.name
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      blockUnblock(log, getFilteredStatus(context, log.reason)['filtered'] == true ? 'unblock' : 'block');
                      Navigator.pop(context);
                    },
                    child: Text(
                      getFilteredStatus(context, log.reason)['filtered'] == true
                        ? AppLocalizations.of(context)!.unblockDomain
                        : AppLocalizations.of(context)!.blockDomain
                      )
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.close)
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