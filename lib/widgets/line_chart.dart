import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class CustomLineChart extends StatelessWidget {
  final List<int> data;
  final Color color;
  final List<DateTime> dates;
  final bool daysInterval;
  final BuildContext context;

  const CustomLineChart({
    Key? key,
    required this.data,
    required this.color,
    required this.dates,
    required this.daysInterval,
    required this.context
  }) : super(key: key);

  String chartDate(DateTime date) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    String getMonth(int month) {
      final List<String> months = [
        AppLocalizations.of(context)!.january,
        AppLocalizations.of(context)!.february,
        AppLocalizations.of(context)!.march,
        AppLocalizations.of(context)!.april,
        AppLocalizations.of(context)!.may,
        AppLocalizations.of(context)!.june,
        AppLocalizations.of(context)!.july,
        AppLocalizations.of(context)!.august,
        AppLocalizations.of(context)!.september,
        AppLocalizations.of(context)!.october,
        AppLocalizations.of(context)!.november,
        AppLocalizations.of(context)!.december,
      ];

      return months[month-1];
    }
  
    if (daysInterval == true) {
      return "${date.day} ${getMonth(date.month).substring(0, 3)}";
    }
    else {
      return "${date.day} ${getMonth(date.month).substring(0, 3)} ${twoDigits(date.hour)}:00";
    }
  }

  LineChartData mainData(Map<String, dynamic> data, ThemeMode selectedTheme) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: data['data'],
          color: color,
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          preventCurveOverShooting: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: color.withOpacity(0.2)
          ),
        ),
        LineChartBarData(
          spots: data['data'],
          color: Colors.transparent,
          barWidth: 0,
        ),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: selectedTheme == ThemeMode.light
            ? const Color.fromRGBO(220, 220, 220, 0.9)
            : const Color.fromRGBO(35, 35, 35, 0.9),
          getTooltipItems: (items) => [
            LineTooltipItem(
              chartDate(dates[items[0].x.toInt()]), 
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface
              )
            ),
            LineTooltipItem(
              items[0].y.toInt().toString(), 
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color
              )
            ),
          ]
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    Map<String, dynamic> formatData(List<int> data) {
      final List<FlSpot> formattedData = [];

      int xPosition = 0;
      int topPoint = 0;
      for (int i = 0; i < data.length; i++) {
        if (data[i] > topPoint) {
          topPoint = data[i];
        }
        formattedData.add(
          FlSpot(
            xPosition.toDouble(), 
            data[i].toDouble()
          )
        );
        xPosition++;
      }

      return {
        'data': formattedData,
        'topPoint': topPoint
      };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: LineChart(
        mainData(formatData(data), appConfigProvider.selectedTheme)
      ),
    );
  }
}