// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items/row_item.dart';
import 'package:adguard_home_manager/screens/home/top_items/top_item_expansion_panel.dart';
import 'package:adguard_home_manager/screens/top_items/top_items_modal.dart';
import 'package:adguard_home_manager/screens/top_items/top_items.dart';
import 'package:adguard_home_manager/widgets/custom_pie_chart.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class TopItems extends StatefulWidget {
  final HomeTopItems type;
  final String label;

  const TopItems({
    super.key,
    required this.type,
    required this.label,
  });

  @override
  State<TopItems> createState() => _TopItemsState();
}

class _TopItemsState extends State<TopItems> {
  bool _showChart = true;

  final colors = [
    Colors.red, 
    Colors.green, 
    Colors.blue, 
    Colors.orange,
    Colors.teal, 
    Colors.grey
  ];

  @override
  void initState() {
    _showChart = Provider.of<AppConfigProvider>(context, listen: false).showTopItemsChart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    final width = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> generateData() {
      switch (widget.type) {
        case HomeTopItems.queriedDomains:
          return statusProvider.serverStatus!.stats.topQueriedDomains;
          
        case HomeTopItems.blockedDomains:
          return statusProvider.serverStatus!.stats.topBlockedDomains;

        case HomeTopItems.recurrentClients:
          return statusProvider.serverStatus!.stats.topClients;

        case HomeTopItems.topUpstreams:
          return statusProvider.serverStatus!.stats.topUpstreamResponses ?? [];

        case HomeTopItems.avgUpstreamResponseTime:
          return statusProvider.serverStatus!.stats.topUpstreamsAvgTime ?? [];

        default:
          return [];
      }
    }

    final data = generateData();

    final withChart = widget.type != HomeTopItems.avgUpstreamResponseTime;

    Map<String, double> chartData() {
      Map<String, double> values = {};
      data.sublist(0, data.length > 5 ? 5 : data.length).forEach((element) {
        values = {
          ...values,
          element.keys.first: element.values.first.toDouble()
        };
      });
      if (data.length > 5) {
        final int rest = List<int>.from(
          data.sublist(5, data.length).map((e) => e.values.first.toInt())
        ).reduce((a, b) => a + b);
        values = {
          ...values,
          AppLocalizations.of(context)!.others: rest.toDouble()
        };
      }
      return values;
    }

    final Widget noItems = Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        top: 10
      ),
      child: Text(
        AppLocalizations.of(context)!.noItems,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );

    return SizedBox(
      child: Column(
        children: [
          if (data.isEmpty) noItems,
          if (data.isNotEmpty && width > 700) Padding(
            padding: EdgeInsets.only(bottom: withChart == false ? 16 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (withChart == true) Expanded(
                  flex: 1,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 250
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomPieChart(
                        data: chartData(), 
                        colors: colors
                      )
                    ),
                  )
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 16
                        ),
                        child: Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      _ItemsList(
                        colors: colors, 
                        data: data, 
                        clients: widget.type == HomeTopItems.recurrentClients, 
                        type: widget.type, 
                        showChart: withChart == true ?  _showChart : false,
                        unit: widget.type == HomeTopItems.avgUpstreamResponseTime ? 'ms' : null,
                      ),
                      if (withChart == true) OthersRowItem(
                        items: data,
                        showColor: true,
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
          if (data.isNotEmpty && width <= 700) TopItemExpansionPanel(
            type: widget.type, 
            label: widget.label, 
            data: data, 
            chartData: chartData(),
            withChart: withChart
          ),
          
          if (data.length > 5) ...[            
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {
                      if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => TopItemsModal(
                            type: widget.type,
                            title: widget.label,
                            isClient: widget.type == HomeTopItems.recurrentClients, 
                            data: generateData(),
                            withProgressBar: widget.type != HomeTopItems.avgUpstreamResponseTime,
                            unit: widget.type == HomeTopItems.avgUpstreamResponseTime ? 'ms' : null,
                          )
                        )
                      }
                      else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TopItemsScreen(
                              type: widget.type,
                              title: widget.label,
                              isClient: widget.type == HomeTopItems.recurrentClients, 
                              data: generateData(),
                              withProgressBar: widget.type != HomeTopItems.avgUpstreamResponseTime,
                              unit: widget.type == HomeTopItems.avgUpstreamResponseTime ? 'ms' : null,
                            )
                          )
                        )
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.viewMore),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ]
        ],
      ),
    );
  }
}

class _ItemsList extends StatelessWidget {
  final List<Color> colors;
  final List<Map<String, dynamic>> data;
  final bool? clients;
  final HomeTopItems type;
  final bool showChart;
  final String? unit;
    
  const _ItemsList({
    required this.colors,
    required this.data,
    required this.clients,
    required this.type,
    required this.showChart,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.sublist(
        0, data.length > 5 ? 5 : data.length
      ).asMap().entries.map((e) => RowItem(
        clients: clients ?? false,
        domain: e.value.keys.toList()[0],
        number: e.value.values.toList()[0].runtimeType == double
          ? "${e.value.values.toList()[0].toStringAsFixed(2)}${unit != null ? ' $unit' : ''}"
          : "${e.value.values.toList()[0].toString()}${unit != null ? ' $unit' : ''}",
        type: type,
        chartColor: colors[e.key],
        showColor: showChart,
      )).toList() 
    );
  }
}