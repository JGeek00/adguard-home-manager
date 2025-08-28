import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/line_chart.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class HomeChart extends StatefulWidget {
  final List<int> data;
  final String label;
  final String primaryValue;
  final String secondaryValue;
  final Color color;
  final int hoursInterval;
  final void Function() onTapTitle;
  final bool isDesktop;

  const HomeChart({
    super.key,
    required this.data,
    required this.label,
    required this.primaryValue,
    required this.secondaryValue,
    required this.color,
    required this.hoursInterval,
    required this.onTapTitle,
    required this.isDesktop,
  });

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final bool isEmpty = widget.data.every((i) => i == 0);

    if (!(appConfigProvider.hideZeroValues == true && isEmpty == true)) {
      List<DateTime> dateTimes = [];
      DateTime currentDate = DateTime.now().subtract(Duration(hours: widget.hoursInterval*widget.data.length));
      for (var i = 0; i < widget.data.length; i++) {
        currentDate = currentDate.add(Duration(hours: widget.hoursInterval));
        dateTimes.add(currentDate);
      }
      
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: !isEmpty ? 10 : 15
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: isEmpty
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isHover = true),
                          onExit: (_) => setState(() => _isHover = false),
                          child: GestureDetector(
                            onTapDown: (_) => setState(() => _isHover = true),
                            onTapUp: (_) => setState(() => _isHover = false),
                            onTap: !isEmpty ? () => widget.onTapTitle () : null,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.label, 
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: _isHover && !isEmpty
                                        ? Theme.of(context).colorScheme.onSurfaceVariant
                                        : Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                if (!isEmpty) ...[
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20,
                                    color: _isHover && !isEmpty
                                      ? Theme.of(context).colorScheme.onSurfaceVariant
                                      : Theme.of(context).colorScheme.onSurface,
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (!isEmpty) Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.primaryValue,
                            style: TextStyle(
                              color: widget.color,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            widget.secondaryValue,
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.color
                            ),
                          )
                        ],
                      ),
                      if (isEmpty && !widget.isDesktop) Column(
                        children: [
                          Icon(
                            Icons.show_chart_rounded,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 16,
                          ),
                          Text(
                            AppLocalizations.of(context)!.noData,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    data: widget.data, 
                    color: widget.color,
                    dates: dateTimes,
                    daysInterval: widget.hoursInterval == 24,
                    context: context,
                  )
                ),
                if (isEmpty && widget.isDesktop) SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 30,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.noDataChart,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }
    else {
      return const SizedBox();
    }
  }
}