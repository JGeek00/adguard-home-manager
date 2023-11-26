// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items/row_item.dart';
import 'package:adguard_home_manager/screens/top_items/top_items_modal.dart';
import 'package:adguard_home_manager/screens/top_items/top_items.dart';
import 'package:adguard_home_manager/widgets/custom_pie_chart.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class TopItems extends StatefulWidget {
  final HomeTopItems type;
  final String label;
  final List<Map<String, dynamic>> data;
  final bool withChart;
  final bool withProgressBar;
  final String Function(dynamic) buildValue;
  final List<MenuOption> menuOptions;
  final void Function(dynamic)? onTapEntry;

  const TopItems({
    super.key,
    required this.type,
    required this.label,
    required this.data,
    required this.withChart,
    required this.withProgressBar,
    required this.buildValue,
    required this.menuOptions,
    this.onTapEntry,
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
    final width = MediaQuery.of(context).size.width;

    final withChart = widget.type != HomeTopItems.avgUpstreamResponseTime;

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
          if (widget.data.isEmpty) noItems,
          if (widget.data.isNotEmpty && width > 700) Padding(
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
                        data: widget.data, 
                        clients: widget.type == HomeTopItems.recurrentClients, 
                        type: widget.type, 
                        showChart: withChart == true ?  _showChart : false,
                        buildValue: widget.buildValue,
                        menuOptions: widget.menuOptions,
                        onTapEntry: widget.onTapEntry,
                      ),
                      if (withChart == true) OthersRowItem(
                        items: widget.data,
                        showColor: true,
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
          if (widget.data.isNotEmpty && width <= 700) Builder(
            builder: (context) {
              if (widget.withChart == true) {
                return Column(
                  children: [
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(0),
                      elevation: 0,
                      expansionCallback: (_, isExpanded) => setState(() => _showChart = isExpanded),
                      animationDuration: const Duration(milliseconds: 250),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: width <= 700
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.label,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.onSurface
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: CustomPieChart(
                                    data: chartData(),
                                    colors: colors
                                  )
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          isExpanded: _showChart
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _ItemsList(
                        colors: colors, 
                        data: widget.data, 
                        clients: widget.type == HomeTopItems.recurrentClients,
                        type: widget.type, 
                        showChart: _showChart,
                        buildValue: widget.buildValue,
                        menuOptions: widget.menuOptions,
                        onTapEntry: widget.onTapEntry,
                      ),
                    ),
                    if (widget.withChart == true) OthersRowItem(
                      items: widget.data,
                      showColor: _showChart,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }
              else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: width <= 700
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _ItemsList(
                        colors: colors, 
                        data: widget.data, 
                        clients: widget.type == HomeTopItems.recurrentClients,
                        type: widget.type, 
                        showChart: false,
                        buildValue: widget.buildValue,
                        menuOptions: widget.menuOptions,
                        onTapEntry: widget.onTapEntry,
                      ),
                    ),
                    if (widget.withChart == true) OthersRowItem(
                      items: widget.data,
                      showColor: false,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }
            },
          ),
          
          if (widget.data.length > 5) ...[            
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
                            data: widget.data,
                            withProgressBar: widget.withProgressBar,
                            buildValue: widget.buildValue,
                            options: widget.menuOptions,
                            onTapEntry: widget.onTapEntry,
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
                              data: widget.data,
                              withProgressBar: widget.withProgressBar,
                              buildValue: widget.buildValue,
                              menuOptions: widget.menuOptions,
                              onTapEntry: widget.onTapEntry,
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
  final String Function(dynamic) buildValue;
  final List<MenuOption> menuOptions;
  final void Function(dynamic)? onTapEntry;
    
  const _ItemsList({
    required this.colors,
    required this.data,
    required this.clients,
    required this.type,
    required this.showChart,
    required this.buildValue,
    required this.menuOptions,
    this.onTapEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.sublist(
        0, data.length > 5 ? 5 : data.length
      ).asMap().entries.map((e) => RowItem(
        clients: clients ?? false,
        domain: e.value.keys.toList()[0],
        number: buildValue(e.value.values.toList()[0]),
        type: type,
        chartColor: colors[e.key],
        showColor: showChart,
        options: menuOptions,
        onTapEntry: onTapEntry,
      )).toList() 
    );
  }
}