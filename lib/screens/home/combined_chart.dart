import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/combined_line_chart.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class CombinedChartData {
  final CombinedChartItem totalQueries;
  final CombinedChartItem? blockedFilters;
  final CombinedChartItem? replacedSafeBrowsing;
  final CombinedChartItem? replacedParental;

  const CombinedChartData({
    required this.totalQueries,
    this.blockedFilters,
    this.replacedSafeBrowsing,
    this.replacedParental
  });
}

class CombinedChartItem {
  final String label;
  final Color color;
  final List<int> data;

  const CombinedChartItem({
    required this.label,
    required this.color,
    required this.data
  });
}

class CombinedHomeChart extends StatelessWidget {
  const CombinedHomeChart({Key? key}) : super(key: key);

  List<int>? removeZero(List<int> list) {
    final removed = list.where((i) => i > 0);
    if (removed.isNotEmpty) {
      return list;
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    if (statusProvider.serverStatus != null) {
      final data = CombinedChartData(
        totalQueries: CombinedChartItem(
          label: AppLocalizations.of(context)!.dnsQueries, 
          color: Colors.blue, 
          data: statusProvider.serverStatus!.stats.dnsQueries
        ),
        blockedFilters: appConfigProvider.hideZeroValues == true
          ? removeZero(statusProvider.serverStatus!.stats.blockedFiltering) != null
            ? CombinedChartItem(
                label: AppLocalizations.of(context)!.blockedFilters, 
                color: Colors.red,
                data: statusProvider.serverStatus!.stats.blockedFiltering
              ) 
            : null
          : CombinedChartItem(
              label: AppLocalizations.of(context)!.blockedFilters, 
              color: Colors.red,
              data: statusProvider.serverStatus!.stats.blockedFiltering
            ) ,
        replacedSafeBrowsing: appConfigProvider.hideZeroValues == true
          ? removeZero(statusProvider.serverStatus!.stats.replacedSafebrowsing) != null
            ? CombinedChartItem(
                label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
                color: Colors.green,
                data: statusProvider.serverStatus!.stats.replacedSafebrowsing
              ) 
            : null
          : CombinedChartItem(
              label: AppLocalizations.of(context)!.malwarePhisingBlocked, 
              color: Colors.green,
              data: statusProvider.serverStatus!.stats.replacedSafebrowsing
            ) ,
        replacedParental: appConfigProvider.hideZeroValues == true
          ?  removeZero(statusProvider.serverStatus!.stats.replacedParental) != null
            ? CombinedChartItem(
                label: AppLocalizations.of(context)!.blockedAdultWebsites, 
                color: Colors.orange,
                data: statusProvider.serverStatus!.stats.replacedParental
              ) 
            : null
          : CombinedChartItem(
              label: AppLocalizations.of(context)!.blockedAdultWebsites, 
              color: Colors.orange,
              data: statusProvider.serverStatus!.stats.replacedParental
            ) ,
      );

      Widget legend({
        required String label,
        required Color color,
        required String primaryValue,
        String? secondaryValue
      }) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                label, 
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  primaryValue,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                if (secondaryValue != null) Text(
                  secondaryValue,
                  style: TextStyle(
                    fontSize: 10,
                    color: color
                  ),
                )
              ],
            )
          ],
        );
      }

      if (width > 700) {
        return Column(
          children: [
            Text(
              AppLocalizations.of(context)!.statistics,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 300,
                    width: double.maxFinite,
                    child: CustomCombinedLineChart(
                      inputData: data,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        legend(
                          label: data.totalQueries.label, 
                          color: data.totalQueries.color, 
                          primaryValue: intFormat(statusProvider.serverStatus!.stats.numDnsQueries, Platform.localeName), 
                          secondaryValue: "${doubleFormat(statusProvider.serverStatus!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                        ),
                        const SizedBox(height: 16),
                        if (data.blockedFilters != null) legend(
                          label: data.blockedFilters!.label, 
                          color: data.blockedFilters!.color, 
                          primaryValue: intFormat(statusProvider.serverStatus!.stats.numBlockedFiltering, Platform.localeName), 
                          secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numBlockedFiltering/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                        ),
                        const SizedBox(height: 16),
                        if (data.replacedSafeBrowsing != null) legend(
                          label: data.replacedSafeBrowsing!.label, 
                          color: data.replacedSafeBrowsing!.color, 
                          primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedSafebrowsing, Platform.localeName), 
                          secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedSafebrowsing/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                        ),
                        const SizedBox(height: 16),
                        if (data.replacedParental != null) legend(
                          label: data.replacedParental!.label, 
                          color: data.replacedParental!.color, 
                          primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedParental, Platform.localeName), 
                          secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedParental/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
            const SizedBox(height: 16)
          ],
        );
      }
      else {
        return Column(
          children: [
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.statistics,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  width: double.maxFinite,
                  child: CustomCombinedLineChart(
                    inputData: data,
                  ),
                ),
                const SizedBox(height: 16),
                legend(
                  label: data.totalQueries.label, 
                  color: data.totalQueries.color, 
                  primaryValue: intFormat(statusProvider.serverStatus!.stats.numDnsQueries, Platform.localeName), 
                  secondaryValue: "${doubleFormat(statusProvider.serverStatus!.stats.avgProcessingTime*1000, Platform.localeName)} ms",
                ),
                const SizedBox(height: 16),
                if (data.blockedFilters != null) legend(
                  label: data.blockedFilters!.label, 
                  color: data.blockedFilters!.color, 
                  primaryValue: intFormat(statusProvider.serverStatus!.stats.numBlockedFiltering, Platform.localeName), 
                  secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numBlockedFiltering/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                ),
                const SizedBox(height: 16),
                if (data.replacedSafeBrowsing != null) legend(
                  label: data.replacedSafeBrowsing!.label, 
                  color: data.replacedSafeBrowsing!.color, 
                  primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedSafebrowsing, Platform.localeName), 
                  secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedSafebrowsing/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                ),
                const SizedBox(height: 16),
                if (data.replacedParental != null) legend(
                  label: data.replacedParental!.label, 
                  color: data.replacedParental!.color, 
                  primaryValue: intFormat(statusProvider.serverStatus!.stats.numReplacedParental, Platform.localeName), 
                  secondaryValue: "${statusProvider.serverStatus!.stats.numDnsQueries > 0 ? doubleFormat((statusProvider.serverStatus!.stats.numReplacedParental/statusProvider.serverStatus!.stats.numDnsQueries)*100, Platform.localeName) : 0}%",
                ),
                const SizedBox(height: 16),
              ],
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
            const SizedBox(height: 16)
          ],
        );
      }
    }
    else {
      return const SizedBox();
    }
  }
}