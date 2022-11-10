// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/server_status.dart';
import 'package:adguard_home_manager/screens/home/fab.dart';
import 'package:adguard_home_manager/screens/home/top_items.dart';
import 'package:adguard_home_manager/screens/home/chart.dart';
import 'package:adguard_home_manager/screens/servers/servers.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/server.dart';
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

    final Server? server =  serversProvider.selectedServer;

    void navigateServers() {
      Future.delayed(const Duration(milliseconds: 0), (() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Servers())
        );
      }));
    }

    void openWebAdminPanel() {
      FlutterWebBrowser.openWebPage(
        url: "${server!.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
        customTabsOptions: const CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: false,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        )
      );
    } 

    Widget status() {
      switch (serversProvider.serverStatus.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height-255,
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
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(top: 0),
            children: [
              ServerStatus(serverStatus: serversProvider.serverStatus.data!),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numBlockedFiltering/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.red,
              ),

              HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedSafebrowsing, 
                label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing, Platform.localeName), 
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.green,
              ),

              HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedParental, 
                label: AppLocalizations.of(context)!.blockedAdultWebsites, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedParental, Platform.localeName), 
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedParental/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.orange,
              ),

              TopItems(
                label: AppLocalizations.of(context)!.topQueriedDomains, 
                data: serversProvider.serverStatus.data!.stats.topQueriedDomains,
                type: 'topQueriedDomains',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 20),

              TopItems(
                label: AppLocalizations.of(context)!.topBlockedDomains, 
                data: serversProvider.serverStatus.data!.stats.topBlockedDomains,
                type: 'topBlockedDomains',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 20),

              TopItems(
                label: AppLocalizations.of(context)!.topClients, 
                data: serversProvider.serverStatus.data!.stats.topClients,
                type: 'topClients',
                clients: true,
              ),
            ],
          );
        
        case 2:
          return SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height-255,
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

    return Material(
      child: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar.large(
                leading: Icon(
                  serversProvider.selectedServer != null && serversProvider.serverStatus.data != null
                    ? serversProvider.serverStatus.data!.generalEnabled == true 
                      ? Icons.gpp_good_rounded
                      : Icons.gpp_bad_rounded
                    : Icons.shield,
                  size: 30,
                  color: serversProvider.selectedServer != null && serversProvider.serverStatus.data != null
                    ? serversProvider.serverStatus.data!.generalEnabled == true 
                      ? appConfigProvider.useThemeColorForStatus
                        ? Theme.of(context).primaryColor
                        : Colors.green
                      : appConfigProvider.useThemeColorForStatus == true
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                        : Colors.red
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (serversProvider.selectedServer != null) ...[
                      Text(
                        server!.name,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).listTileTheme.textColor
                        ),
                      )
                    ],
                    if (serversProvider.selectedServer == null) Text(
                      AppLocalizations.of(context)!.noServerSelected,
                    ),
                  ],
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: navigateServers,
                        child: Row(
                          children: [
                            const Icon(Icons.storage_rounded),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.servers)
                          ],
                        ),
                      ),
                      if (serversProvider.selectedServer != null && serversProvider.serverStatus.loadStatus == 1) PopupMenuItem(
                        onTap: openWebAdminPanel,
                        child: Row(
                          children: [
                            const Icon(Icons.web_rounded),
                            const SizedBox(width: 10),
                            Text(AppLocalizations.of(context)!.webAdminPanel)
                          ],
                        ),
                      )
                    ]
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  child: RefreshIndicator(
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
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: isVisible ?
              appConfigProvider.showingSnackbar
                ? 70 : 20
              : -70,
            right: 20,
            child: const HomeFab() 
          )
        ],
      ),
    );
  }
}