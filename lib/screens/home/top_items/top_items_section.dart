// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/top_items/row_item.dart';
import 'package:adguard_home_manager/screens/home/top_items/top_items_screen.dart';
import 'package:adguard_home_manager/widgets/custom_pie_chart.dart';

import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class TopItemsSection extends StatelessWidget {
  final HomeTopItems type;
  final String label;
  final List<Map<String, dynamic>> data;
  final bool withChart;
  final bool withProgressBar;
  final String Function(dynamic) buildValue;
  final List<MenuOption> Function(dynamic) menuOptions;
  final void Function(dynamic)? onTapEntry;

  const TopItemsSection({
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
  Widget build(BuildContext context) {
    final colors = [
      Colors.red, 
      Colors.green, 
      Colors.blue, 
      Colors.orange,
      Colors.teal, 
      Colors.grey
    ];

    final width = MediaQuery.of(context).size.width;

    final withChart = type != HomeTopItems.avgUpstreamResponseTime;

    Map<String, double> ringData() {
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

    List<Map<String, dynamic>> lineData() {
      List<Map<String, dynamic>> values = [];
      data.sublist(0, data.length > 5 ? 5 : data.length).forEach((element) {
        values.add({
          "label": element.keys.first,
          "value": element.values.first.toDouble()
        });
      });
      if (data.length > 5) {
        final int rest = List<int>.from(
          data.sublist(5, data.length).map((e) => e.values.first.toInt())
        ).reduce((a, b) => a + b);
        values.add({
          "label": AppLocalizations.of(context)!.others,
          "value": rest.toDouble()
        });
      }
      return values;
    }

    final lineChartData = lineData();
    final total = lineChartData.map((e) => e["value"]).reduce((a, b) => a + b);

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
                        data: ringData(),
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
                          label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      _ItemsList(
                        colors: colors, 
                        data: data, 
                        clients: type == HomeTopItems.recurrentClients, 
                        type: type, 
                        showChart: withChart,
                        buildValue: buildValue,
                        menuOptions: menuOptions,
                        onTapEntry: onTapEntry,
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
          if (data.isNotEmpty && width <= 700) ...[
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            const SizedBox(height: 8),
            if (withChart == true) Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 20,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Row(
                      children: lineChartData.asMap().entries.map((e) => Tooltip(
                        message:'${e.value["label"]} (${doubleFormat((e.value["value"]/total)*100, Platform.localeName)}%)',
                        child: Container(
                          width: constraints.maxWidth*(e.value["value"]/total),
                          decoration: BoxDecoration(
                            color: colors[e.key]
                          ),
                        ),
                      )).toList()
                    )
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _ItemsList(
                colors: colors, 
                data: data, 
                clients: type == HomeTopItems.recurrentClients,
                type: type, 
                showChart: withChart,
                buildValue: buildValue,
                menuOptions: menuOptions,
                onTapEntry: onTapEntry,
              ),
            ),
            OthersRowItem(
              items: data,
              showColor: withChart,
            ),
          ],
          
          if (data.length > 5) ...[            
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {
                      showGeneralDialog(
                        context: context, 
                        barrierColor: !(width > 700 || !(Platform.isAndroid | Platform.isIOS))
                          ?Colors.transparent 
                          : Colors.black54,
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 1), 
                              end: const Offset(0, 0)
                            ).animate(
                              CurvedAnimation(
                                parent: anim1, 
                                curve: Curves.easeInOutCubicEmphasized
                              )
                            ),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) => TopItemsScreen(
                          type: type,
                          title: label,
                          isClient: type == HomeTopItems.recurrentClients, 
                          data: data,
                          withProgressBar: withProgressBar,
                          buildValue: buildValue,
                          options: menuOptions,
                          onTapEntry: onTapEntry,
                          isFullscreen: !(width > 700 || !(Platform.isAndroid | Platform.isIOS)),
                        )
                      )
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
  final List<MenuOption> Function(dynamic) menuOptions;
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