import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/custom_pie_chart.dart';
import 'package:adguard_home_manager/screens/home/top_items/row_item.dart';

import 'package:adguard_home_manager/constants/enums.dart';

class TopItemExpansionPanel extends StatefulWidget {
  final HomeTopItems type;
  final String label;
  final List<Map<String, dynamic>> data;
  final Map<String, double> chartData;
  final bool withChart;

  const TopItemExpansionPanel({
    super.key, 
    required this.type,
    required this.label,
    required this.data,
    required this.chartData,
    required this.withChart
  });

  @override
  State<TopItemExpansionPanel> createState() => _TopItemExpansionPanelState();
}

class _TopItemExpansionPanelState extends State<TopItemExpansionPanel> {
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                          data: widget.chartData,
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
              unit: widget.type == HomeTopItems.avgUpstreamResponseTime ? 'ms' : null,
            ),
          ),
          if (widget.type != HomeTopItems.avgUpstreamResponseTime) OthersRowItem(
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
              unit: widget.type == HomeTopItems.avgUpstreamResponseTime ? 'ms' : null,
            ),
          ),
          if (widget.type != HomeTopItems.avgUpstreamResponseTime) OthersRowItem(
            items: widget.data,
            showColor: false,
          ),
          const SizedBox(height: 16),
        ],
      );
    }
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