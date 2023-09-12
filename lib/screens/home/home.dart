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
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';

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
    Provider.of<StatusProvider>(context, listen: false).getServerStatus();

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
    final statusProvider = Provider.of<StatusProvider>(context);
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
        ServerStatusWidget(serverStatus: statusProvider.serverStatus!),
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
                data: statusProvider.serverStatus!.stats.dnsQueries, 
                label: AppLocalizations.of(context)!.dnsQueries, 
                primaryValue: intFormat(statusProvider.serverStatus!.stats.numDnsQueries, Platform.localeName), 
                secondaryValue: "${doubleFormat(statusProvider.serverStatus!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                color: Colors.blue,
                hoursInterval: statusProvider.serverStatus!.stats.timeUnits == "days" ? 24 : 1,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: statusProvider.serverStatus!.stats.blockedFiltering, 
                label: AppLocalizations.of(context)!.blockedFilters, 
                primaryValue: intFormat(statusProvider.serverStatus!.stats.numBlockedFiltering, Platform.localeName), 
                secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numBlockedFiltering/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.red,
                hoursInterval: statusProvider.serverStatus!.stats.timeUnits == "days" ? 24 : 1,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: statusProvider.serverStatus!.stats.replacedSafebrowsing, 
                label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedSafebrowsing, Platform.localeName), 
                secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedSafebrowsing/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.green,
                hoursInterval: statusProvider.serverStatus!.stats.timeUnits == "days" ? 24 : 1,
              ),
            ),
            FractionallySizedBox(
              widthFactor: width > 700 ? 0.5 : 1,
              child: HomeChart(
                data: statusProvider.serverStatus!.stats.replacedParental, 
                label: AppLocalizations.of(context)!.blockedAdultWebsites, 
                primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedParental, Platform.localeName), 
                secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedParental/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                color: Colors.orange,
                hoursInterval: statusProvider.serverStatus!.stats.timeUnits == "days" ? 24 : 1,
              ),
            ),             
          ],
        ),

        if (appConfigProvider.combinedChartHome == true) const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CombinedHomeChart(),
        ),
               
        if (width <= 700) ...appConfigProvider.homeTopItemsOrder.asMap().entries.map((item) {
          Widget list() {
            switch (item.value) {
              case HomeTopItems.queriedDomains:
                return TopItems(
                  label: AppLocalizations.of(context)!.topQueriedDomains, 
                  data: statusProvider.serverStatus!.stats.topQueriedDomains,
                  type: 'topQueriedDomains',
                );
                 
              case HomeTopItems.blockedDomains:
                return TopItems(
                  label: AppLocalizations.of(context)!.topBlockedDomains, 
                  data: statusProvider.serverStatus!.stats.topBlockedDomains,
                  type: 'topBlockedDomains',
                );
                      
              case HomeTopItems.recurrentClients:
                return TopItems(
                  label: AppLocalizations.of(context)!.topClients, 
                  data: statusProvider.serverStatus!.stats.topClients,
                  type: 'topClients',
                  clients: true,
                );
                    
              default:
                return const SizedBox();
            }
          }
              
          return Column(
            children: [
              list(),
              if (item.key < appConfigProvider.homeTopItemsOrder.length - 1) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
                const SizedBox(height: 16),
              ]
            ],
          );
        }),
        if (width > 700) Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: appConfigProvider.homeTopItemsOrder.map((item) {
                switch (item) {
                  case HomeTopItems.queriedDomains:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ConstrainedBox(
                        constraints: const  BoxConstraints(
                          maxWidth: 500
                        ),
                        child: TopItems(
                          label: AppLocalizations.of(context)!.topQueriedDomains, 
                          data: statusProvider.serverStatus!.stats.topQueriedDomains,
                          type: 'topQueriedDomains',
                        ),
                      ),
                    );

                  case HomeTopItems.blockedDomains:
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 500
                        ),
                        child: TopItems(
                          label: AppLocalizations.of(context)!.topBlockedDomains, 
                          data: statusProvider.serverStatus!.stats.topBlockedDomains,
                          type: 'topBlockedDomains',
                        ),
                      ),
                    );

                  case HomeTopItems.recurrentClients: 
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 500
                        ),
                        child: TopItems(
                          label: AppLocalizations.of(context)!.topClients, 
                          data: statusProvider.serverStatus!.stats.topClients,
                          type: 'topClients',
                        ),
                      ),
                    );
                   
                  default:
                    return const SizedBox();
                }
              }).toList(),
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
                    displacement: 95,
                    onRefresh: () async {
                      final result = await statusProvider.getServerStatus();
                      if (result == false) {
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
                        if (statusProvider.loadStatus == LoadStatus.loading) SliverFillRemaining(
                          child: loading(),
                        ),
                        if (statusProvider.loadStatus == LoadStatus.loaded) SliverList.list(
                          children: listItems()
                        ),
                        if (statusProvider.loadStatus == LoadStatus.error) SliverFillRemaining(
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