import 'package:flutter/material.dart';

import 'package:adguard_home_manager/widgets/line_chart.dart';

class HomeChart extends StatelessWidget {
  final List<int> data;
  final String label;
  final String primaryValue;
  final String secondaryValue;
  final Color color;

  const HomeChart({
    Key? key,
    required this.data,
    required this.label,
    required this.primaryValue,
    required this.secondaryValue,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    for (int item in data) {
      if (item > 0) {
        isEmpty = false;
        break;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: !isEmpty ? 10 : 15
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label, 
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
                !isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          primaryValue,
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          secondaryValue,
                          style: TextStyle(
                            fontSize: 12,
                            color: color
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          primaryValue,
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "($secondaryValue)",
                          style: TextStyle(
                            fontSize: 12,
                            color: color
                          ),
                        )
                      ],
                    )
              ],
            ),
          ),
          if (!isEmpty) SizedBox(
            width: double.maxFinite,
            height: 150,
            child: CustomLineChart(
              data: data, 
              color: color,
            )
          ),
        ],
      ),
    );
  }
}