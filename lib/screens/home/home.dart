// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/server_status.dart';
import 'package:adguard_home_manager/screens/home/appbar.dart';
import 'package:adguard_home_manager/screens/home/fab.dart';
import 'package:adguard_home_manager/screens/home/top_items.dart';
import 'package:adguard_home_manager/screens/home/chart.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController scrollController = ScrollController();
  late bool isVisible;

  @override
  initState(){
    super.initState();

    isVisible = true;
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );

        case 1:
          return ListView(
            controller: scrollController,
            children: [
              ServerStatus(serverStatus: serversProvider.serverStatus.data!),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),

              HomeChart(
                data: serversProvider.serverStatus.data!.stats.dnsQueries, 
                label: AppLocalizations.of(context)!.dnsQueries, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numDnsQueries, Platform.localeName), 
                secondaryValue: "${doubleFormat(serversProvider.serverStatus.data!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                color: Colors.blue,
              ),
              
              HomeChart(
                data: serversProvider.serverStatus.data!.stats.blockedFiltering, 
                label: AppLocalizations.of(context)!.blockedFilters, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numBlockedFiltering, Platform.localeName), 
                secondaryValue: "${doubleFormat((serversProvider.serverStatus.data!.stats.numBlockedFiltering/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName)}%",
                color: Colors.red,
              ),

              HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedSafebrowsing, 
                label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing, Platform.localeName), 
                secondaryValue: "${doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName)}%",
                color: Colors.green,
              ),

              HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedParental, 
                label: AppLocalizations.of(context)!.blockedAdultWebsites, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedParental, Platform.localeName), 
                secondaryValue: "${doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedParental/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName)}%",
                color: Colors.orange,
              ),

              TopItems(
                label: AppLocalizations.of(context)!.topQueriedDomains, 
                data: serversProvider.serverStatus.data!.stats.topQueriedDomains,
                type: 'topQueriedDomains',
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
                data: serversProvider.serverStatus.data!.stats.topBlockedDomains,
                type: 'topBlockedDomains',
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
                data: serversProvider.serverStatus.data!.stats.topClients,
                type: 'topClients',
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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: const HomeAppBar(),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
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
        child: status()
      ),
      floatingActionButton: appConfigProvider.showingSnackbar
        ? null
        : isVisible 
          ? const HomeFab() 
          : null
        
    );
  }
}