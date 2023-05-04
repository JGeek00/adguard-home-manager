import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/widgets/line_chart.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

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
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    bool isEmpty = true;
    for (int item in data) {
      if (item > 0) {
        isEmpty = false;
        break;
      }
    }

    if (!(appConfigProvider.hideZeroValues == true && isEmpty == true)) {
      return Column(
        children: [
          Padding(
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
                      Flexible(
                        child: Text(
                          label, 
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
    else {
      return const SizedBox();
    }
  }
}