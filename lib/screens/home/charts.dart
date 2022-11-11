import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/screens/home/chart.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class HomeCharts extends StatelessWidget {
  const HomeCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    
    final width = MediaQuery.of(context).size.width;

    if (width < 700) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      );
    }
    else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: width/2,
                child: HomeChart(
                  data: serversProvider.serverStatus.data!.stats.dnsQueries, 
                  label: AppLocalizations.of(context)!.dnsQueries, 
                  primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numDnsQueries, Platform.localeName), 
                  secondaryValue: "${doubleFormat(serversProvider.serverStatus.data!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: width/2,
                child: HomeChart(
                  data: serversProvider.serverStatus.data!.stats.blockedFiltering, 
                  label: AppLocalizations.of(context)!.blockedFilters, 
                  primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numBlockedFiltering, Platform.localeName), 
                  secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numBlockedFiltering/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: width/2,
                child: HomeChart(
                  data: serversProvider.serverStatus.data!.stats.replacedSafebrowsing, 
                  label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                  primaryValue: intFormat(serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing, Platform.localeName), 
                  secondaryValue: "${serversProvider.serverStatus.data!.stats.numDnsQueries > 0 ? doubleFormat((serversProvider.serverStatus.data!.stats.numReplacedSafebrowsing/serversProvider.serverStatus.data!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: width/2,
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
        ],
      );
    }
  }
}