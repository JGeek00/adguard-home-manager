// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class TopItemsScreen extends StatelessWidget {
  final String type;
  final String title;
  final bool? isClient;

  const TopItemsScreen({
    Key? key,
    required this.type,
    required this.title,
    this.isClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    List<Map<String, dynamic>> data = [];
    switch (type) {
      case 'topQueriedDomains':
        data = serversProvider.serverStatus.data!.stats.topQueriedDomains;
        break;
        
      case 'topBlockedDomains':
        data = serversProvider.serverStatus.data!.stats.topBlockedDomains;
        break;

      case 'topClients':
        data = serversProvider.serverStatus.data!.stats.topClients;
        break;

      default:
        break;
    }

    int total = 0;
    for (var element in data) {
      total = total + int.parse(element.values.toList()[0].toString());
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            String? name;
            if (isClient != null && isClient == true) {
              try {
                name = serversProvider.serverStatus.data!.clients.firstWhere((c) => c.ids.contains(data[index].keys.toList()[0])).name;
              } catch (e) {
                // ---- //
              }
            }

            return CustomListTile(
              title: data[index].keys.toList()[0],
              trailing: Text(data[index].values.toList()[0].toString()),
              subtitleWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (name != null) ...[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                  Text(
                    "${doubleFormat((data[index].values.toList()[0]/total*100), Platform.localeName)}%",
                    style: TextStyle(
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                  ),
                ],
              )
            );
          }
        ),
      ),
    );
  }
}