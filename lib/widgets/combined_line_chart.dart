import 'package:adguard_home_manager/screens/home/combined_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';


class CustomCombinedLineChart extends StatelessWidget {
  final CombinedChartData inputData;

  const CustomCombinedLineChart({
    Key? key,
    required this.inputData,
  }) : super(key: key);

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
          tooltipBgColor: selectedTheme == ThemeMode.light
            ? const Color.fromRGBO(220, 220, 220, 0.9)
            : const Color.fromRGBO(35, 35, 35, 0.9),
          getTooltipItems: (items) => items.asMap().entries.map((item) => LineTooltipItem(
            "${data['lines'][item.key]['label']}: ${item.value.y.toInt().toString()}", 
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: data['lines'][item.key]['color']
            )
          )).toList()
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