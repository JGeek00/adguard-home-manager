// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/server_status.dart';
import 'package:adguard_home_manager/screens/home/top_items.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    Widget status() {
      switch (serversProvider.serverStatus.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingStatus,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          );

        case 1:
          return ListView(
            children: [
              ServerStatus(serverStatus: serversProvider.serverStatus.data!),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),

              TopItems(
                label: AppLocalizations.of(context)!.topQueriedDomains, 
                data: serversProvider.serverStatus.data!.stats.topQueriedDomains
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),

              TopItems(
                label: AppLocalizations.of(context)!.topBlockedDomains, 
                data: serversProvider.serverStatus.data!.stats.topBlockedDomains
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),

              TopItems(
                label: AppLocalizations.of(context)!.topClients, 
                data: serversProvider.serverStatus.data!.stats.topClients
              ),

              const SizedBox(height: 70) // To avoid content under fab
            ],
          );
        
        case 2:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
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
                  AppLocalizations.of(context)!.errorLoadServerStatus,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        final result = await getServerStatus(serversProvider.selectedServer!);
        if (result['result'] == 'success') {
          serversProvider.setServerStatusData(result['data']);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.serverStatusNotRefreshed),
              backgroundColor: Colors.red,
            )
          );
        }
      },
      child: status()
    );
  }
}