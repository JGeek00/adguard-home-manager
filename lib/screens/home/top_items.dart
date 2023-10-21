// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_pie_chart.dart';
import 'package:adguard_home_manager/widgets/domain_options.dart';
import 'package:adguard_home_manager/screens/top_items/top_items_modal.dart';
import 'package:adguard_home_manager/screens/top_items/top_items.dart';

import 'package:adguard_home_manager/models/applied_filters.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/providers/logs_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class TopItems extends StatefulWidget {
  final String type;
  final String label;
  final List<Map<String, dynamic>> data;
  final bool? clients;

  const TopItems({
    Key? key,
    required this.type,
    required this.label,
    required this.data,
    this.clients
  }) : super(key: key);

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
        case 'topQueriedDomains':
          return statusProvider.serverStatus!.stats.topQueriedDomains;
          
        case 'topBlockedDomains':
          return statusProvider.serverStatus!.stats.topBlockedDomains;

        case 'topClients':
          return statusProvider.serverStatus!.stats.topClients;

        default:
          return [];
      }
    }

    Map<String, double> chartData() {
      Map<String, double> values = {};
      widget.data.sublist(0, widget.data.length > 5 ? 5 : widget.data.length).forEach((element) {
        values = {
          ...values,
          element.keys.first: element.values.first.toDouble()
        };
      });
      if (widget.data.length > 5) {
        final int rest = List<int>.from(
          widget.data.sublist(5, widget.data.length).map((e) => e.values.first.toInt())
        ).reduce((a, b) => a + b);
        values = {
          ...values,
          AppLocalizations.of(context)!.others: rest.toDouble()
        };
      }
      return values;
    }

    final List<Widget> itemsList = widget.data.sublist(
        0, 
        widget.data.length > 5 ? 5 : widget.data.length
      ).asMap().entries.map((e) => RowItem(
        clients: widget.clients ?? false,
        domain: e.value.keys.toList()[0],
        number: e.value.values.toList()[0].toString(),
        type: widget.type,
        chartColor: _showChart ? colors[e.key] : null,
      )).toList();

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

    final Widget chart = CustomPieChart(
      data: chartData(), 
      colors: colors
    );

    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: width <= 700
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                if (width <= 700) TextButton(
                  onPressed: () => setState(() => _showChart = !_showChart), 
                  child: Text(
                    _showChart 
                      ? AppLocalizations.of(context)!.hideChart
                      : AppLocalizations.of(context)!.showChart
                  ) 
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          if (widget.data.isEmpty) noItems,
          if (widget.data.isNotEmpty && width > 700) SizedBox(
            height: 240,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: chart,
                  )
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ...itemsList,
                      OthersRowItem(items: widget.data)
                    ]
                  ),
                )
              ],
            ),
          ),
          if (widget.data.isNotEmpty && width <= 700) ...[
            if (_showChart) ...[
              chart,
              const SizedBox(height: 16),
            ],
            ...itemsList,
            if (_showChart) OthersRowItem(items: widget.data)
          ],
          
          if (widget.data.length > 5) ...[
            const SizedBox(height: 20),
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
                            isClient: widget.clients,
                            data: generateData(),
                          )
                        )
                      }
                      else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TopItemsScreen(
                              type: widget.type,
                              title: widget.label,
                              isClient: widget.clients,
                              data: generateData(),
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

class RowItem extends StatelessWidget {
  final String type;
  final Color? chartColor;
  final String domain;
  final String number;
  final bool clients;

  const RowItem({
    Key? key,
    required this.type,
    this.chartColor,
    required this.domain,
    required this.number,
    required this.clients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final logsProvider = Provider.of<LogsProvider>(context);

    String? name;
    if (clients == true) {
      try {
        name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(domain)).name;
      } catch (e) {
        // ---- //
      }
    }

    return Material(
      color: Colors.transparent,
      child: DomainOptions(
        item: domain,
        isClient: type == 'topClients',
        isBlocked: type == 'topBlockedDomains',
        onTap: () {
          if (type == 'topQueriedDomains' || type == 'topBlockedDomains') {
            logsProvider.setSearchText(domain);
            logsProvider.setSelectedClients(null);
            logsProvider.setAppliedFilters(
              AppliedFiters(
                selectedResultStatus: 'all', 
                searchText: domain,
                clients: null
              )
            );
            appConfigProvider.setSelectedScreen(2);
          }
          else if (type == 'topClients') {
            logsProvider.setSearchText(null);
            logsProvider.setSelectedClients([domain]);
            logsProvider.setAppliedFilters(
              AppliedFiters(
                selectedResultStatus: 'all', 
                searchText: null,
                clients: [domain]
              )
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    if (chartColor != null) Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: chartColor
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            domain,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                          if (name != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                number,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OthersRowItem extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const OthersRowItem({
    Key? key,
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (items.length <= 5) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.others,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            List<int>.from(
              items.sublist(5, items.length).map((e) => e.values.first.toInt())
            ).reduce((a, b) => a + b).toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
    );
  }
}