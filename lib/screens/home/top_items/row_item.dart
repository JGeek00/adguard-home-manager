import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/options_menu.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

class RowItem extends StatelessWidget {
  final HomeTopItems type;
  final Color chartColor;
  final String domain;
  final String number;
  final bool clients;
  final bool showColor;
  final String? unit;
  final List<MenuOption> Function(dynamic) options;
  final void Function(dynamic)? onTapEntry;

  const RowItem({
    super.key,
    required this.type,
    required this.chartColor,
    required this.domain,
    required this.number,
    required this.clients,
    required this.showColor,
    required this.options,
    this.onTapEntry,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    String? name;
    if (clients == true) {
      try {
        name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(domain)).name;
      } catch (e) {
        // ---- //
      }
    }

    return Material(
      color: Colors.transparent,
      child: OptionsMenu(
        value: domain,
        options: options,
        onTap: onTapEntry,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    if (showColor == true) Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: chartColor
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            domain,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface
                            ),
                          ),
                          if (name != null) ...[
                            const SizedBox(height: 5),
                            Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                number,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OthersRowItem extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool showColor;

  const OthersRowItem({
    super.key,
    required this.items,
    required this.showColor,
  });

  @override
  Widget build(BuildContext context) {
    if (items.length <= 5) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                if (showColor == true) Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.others,
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            List<int>.from(
              items.sublist(5, items.length).map((e) => e.values.first.toInt())
            ).reduce((a, b) => a + b).toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
    );
  }
}