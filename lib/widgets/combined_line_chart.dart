import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/home/combined_chart.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';


class CustomCombinedLineChart extends StatelessWidget {
  final CombinedChartData inputData;
  final List<DateTime> dates;
  final BuildContext context;
  final bool daysInterval;

  const CustomCombinedLineChart({
    Key? key,
    required this.inputData,
    required this.context,
    required this.dates,
    required this.daysInterval
  }) : super(key: key);

  LineChartData mainData(Map<String, dynamic> data, ThemeMode selectedTheme) {
    String chartDate(DateTime date) {
      String twoDigits(int number) => number.toString().padLeft(2, '0');

      String shortMonth(String month) => month.length > 3 ? month.substring(0, 3) : month;

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
        return "${date.day} ${shortMonth(getMonth(date.month))}";
      }
      else {
        return "${date.day} ${shortMonth(getMonth(date.month))} ${twoDigits(date.hour)}:00";
      }
    }

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
      lineBarsData: List<LineChartBarData>.from(
        data["lines"].map((item) => LineChartBarData(
          spots: item['data'],
          color: item['color'],
          isCurved: true,
          barWidth: 2,
          isStrokeCapRound: true,
          preventCurveOverShooting: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: item['color'].withOpacity(0.2)
          ),
        ))
      ),
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          tooltipBgColor: selectedTheme == ThemeMode.light
            ? const Color.fromRGBO(220, 220, 220, 0.9)
            : const Color.fromRGBO(35, 35, 35, 0.9),
          getTooltipItems: (items) {
            return [
              LineTooltipItem(
                chartDate(dates[items[0].x.toInt()]), 
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface
                )
              ),
              ...items.sublist(0, items.length-1).asMap().entries.map((item) => LineTooltipItem(
                "${data['lines'][item.key]['label']}: ${item.value.y.toInt().toString()}", 
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: data['lines'][item.key]['color']
                )
              ))
            ];
          }
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    Map<String, dynamic> formatData(CombinedChartData unformattedData) {
      int topPoint = 0;
      
      List<FlSpot> dataLine(List<int> data) {
        final List<FlSpot> formattedData = [];

        int xPosition = 0;
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

        return formattedData;
      }

      List<FlSpot> datesLine(int number) {
        final List<FlSpot> formattedData = [];

        for (int i = 0; i < number; i++) {
          formattedData.add(
            FlSpot(
              i.toDouble(),
              0
            )
          );
        }

        return formattedData;
      }

      List<Map<String, dynamic>> toDraw = [];
      toDraw.add({
        "data": dataLine(unformattedData.totalQueries.data),
        "color": unformattedData.totalQueries.color,
        "label": unformattedData.totalQueries.label
      });
      if (unformattedData.blockedFilters != null) {
        toDraw.add({
          "data": dataLine(unformattedData.blockedFilters!.data),
          "color": unformattedData.blockedFilters!.color,
          "label": unformattedData.blockedFilters!.label
        });
      }
      if (unformattedData.replacedSafeBrowsing != null) {
        toDraw.add({
          "data": dataLine(unformattedData.replacedSafeBrowsing!.data),
          "color": unformattedData.replacedSafeBrowsing!.color,
          "label": unformattedData.replacedSafeBrowsing!.label
        });
      }
      if (unformattedData.replacedParental != null) {
        toDraw.add({
          "data": dataLine(unformattedData.replacedParental!.data),
          "color": unformattedData.replacedParental!.color,
          "label": unformattedData.replacedParental!.label
        });
      }
      toDraw.add({
        "data": datesLine(dates.length),
        "color": Colors.transparent,
      });

      return {
        'lines': toDraw,
        'topPoint': topPoint
      };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: LineChart(
        mainData(formatData(inputData), appConfigProvider.selectedTheme)
      ),
    );
  }
}