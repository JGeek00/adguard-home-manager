import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/top_items/top_items.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
class TopItems extends StatelessWidget {
  final String type;
  final String label;
  final List<Map<String, dynamic>> data;
  final bool? clients;

  const TopItems({
    Key? key,
    required this.type,
    required this.label,
    required this.data,
    this.clients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    Widget rowItem(Map<String, dynamic> item) {
      String? name;
      if (clients != null && clients == true) {
        try {
          name = serversProvider.serverStatus.data!.clients.firstWhere((c) => c.ids.contains(item.keys.toList()[0])).name;
        } catch (e) {
          // ---- //
        }
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.keys.toList()[0],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  if (name != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).listTileTheme.iconColor
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Text(item.values.toList()[0].toString())
          ],
        ),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 20),
          if (data.isEmpty) Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 10
            ),
            child: Text(
              AppLocalizations.of(context)!.noItems,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
            ),
          ),
          if (data.isNotEmpty) rowItem(data[0]),
          if (data.length >= 2) rowItem(data[1]),
          if (data.length >= 3) rowItem(data[2]),
          if (data.length >= 4) rowItem(data[3]),
          if (data.length >= 5) rowItem(data[4]),
          if (data.length > 5) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TopItemsScreen(
                          type: type,
                          title: label,
                          isClient: clients,
                        )
                      )
                    ),
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