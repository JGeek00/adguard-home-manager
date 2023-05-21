// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/server_status.dart';
import 'package:adguard_home_manager/screens/home/combined_chart.dart';
import 'package:adguard_home_manager/screens/home/appbar.dart';
import 'package:adguard_home_manager/screens/home/fab.dart';
import 'package:adguard_home_manager/screens/home/top_items.dart';
import 'package:adguard_home_manager/screens/home/chart.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
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

    final width = MediaQuery.of(context).size.width;

    Widget loading() {
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
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          ],
        ),
      );
    }

    Widget loadError() {
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
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          ],
        ),
      );
    }

    List<Widget> listItems() {
      return [
        ServerStatus(serverStatus: serversProvider.serverStatus.data!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            thickness: 1,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 16),
              
        if (appConfigProvider.combinedChartHome == false) Wrap(
          children: [
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: serversProvider.serverStatus.data!.stats.dnsQueries, 
                label: AppLocalizations.of(context)!.dnsQueries, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numDnsQueries, Platform.localeName), 
                secondaryValue: "${doubleFormat(serversProvider.serverStatus.data!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                color: Colors.blue,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: serversProvider.serverStatus.data!.stats.blockedFiltering, 
                label: AppLocalizations.of(context)!.blockedFilters, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numBlockedFiltering, Platform.localeName), 
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numBlockedFiltering/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.red,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedSafebrowsing, 
                label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing, Platform.localeName), 
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.green,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: serversProvider.serverStatus.data!.stats.replacedParental, 
                label: AppLocalizations.of(context)!.blockedAdultWebsites, 
                primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedParental, Platform.localeName), 
                secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedParental/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.orange,
              ),
            ),             
          ],
        ),

        if (appConfigProvider.combinedChartHome == true) const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CombinedHomeChart(),
        ),
               
        if (width <= 700) ...[
          TopItems(
            label: AppLocalizations.of(context)!.topQueriedDomains, 
            data: serversProvider.serverStatus.data!.stats.topQueriedDomains,
            type: 'topQueriedDomains',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
                
          const SizedBox(height: 16),
            
          TopItems(
            label: AppLocalizations.of(context)!.topBlockedDomains, 
            data: serversProvider.serverStatus.data!.stats.topBlockedDomains,
            type: 'topBlockedDomains',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 16),
               
          TopItems(
            label: AppLocalizations.of(context)!.topClients, 
            data: serversProvider.serverStatus.data!.stats.topClients,
            type: 'topClients',
            clients: true,
          ),
        ],
        if (width > 700) Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ConstrainedBox(
                    constraints: const  BoxConstraints(
                      maxWidth: 500
                    ),
                    child: TopItems(
                      label: AppLocalizations.of(context)!.topQueriedDomains, 
                      data: serversProvider.serverStatus.data!.stats.topQueriedDomains,
                      type: 'topQueriedDomains',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500
                    ),
                    child: TopItems(
                      label: AppLocalizations.of(context)!.topBlockedDomains, 
                      data: serversProvider.serverStatus.data!.stats.topBlockedDomains,
                      type: 'topBlockedDomains',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500
                    ),
                    child: TopItems(
                      label: AppLocalizations.of(context)!.topClients, 
                      data: serversProvider.serverStatus.data!.stats.topClients,
                      type: 'topClients',
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ];
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: HomeAppBar(innerBoxScrolled: innerBoxIsScrolled,)
                )
              ], 
              body: SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (context) => RefreshIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    onRefresh: () async {
                      final result = await getServerStatus(serversProvider.selectedServer!);
                      if (result['result'] == 'success') {
                        serversProvider.setServerStatusData(result['data']);
                      }
                      else {
                        appConfigProvider.addLog(result['log']);
                        showSnacbkar(
                          appConfigProvider: appConfigProvider, 
                          label: AppLocalizations.of(context)!.serverStatusNotRefreshed, 
                          color: Colors.red
                        );
                      }
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        if (serversProvider.serverStatus.loadStatus == 0) SliverFillRemaining(
                          child: loading(),
                        ),
                        if (serversProvider.serverStatus.loadStatus == 1) SliverList.list(
                          children: listItems()
                        ),
                        if (serversProvider.serverStatus.loadStatus == 2) SliverFillRemaining(
                          child: loadError(),
                        ),
                      ],
                    )
                  ),
                )
              )
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible == true ?
                appConfigProvider.showingSnackbar
                  ? 70 
                  : 20
                : -70,
              right: 20,
              child: const HomeFab() 
            ),
          ],
        ),
      ),
    );
  }
}