import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CustomPieChart extends StatelessWidget {
  final Map<String, double> data;
  final List<Color> colors;

  const CustomPieChart({
    Key? key,
    required this.data,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: data,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 3,
      colorList: colors,
      initialAngleInDegree: 270,
      chartType: ChartType.ring,
      ringStrokeWidth: 12,
      legendOptions: const LegendOptions(
        showLegends: false
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: false,
      ),
    );
  }
}