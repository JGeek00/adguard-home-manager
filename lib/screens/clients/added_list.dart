// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class AddedList extends StatelessWidget {
  final List<Client> data;
  final Future Function() fetchClients;

  const AddedList({
    Key? key,
    required this.data,
    required this.fetchClients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);


    if (data.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            isThreeLine: true,
            onTap: () => {},
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(data[index].name),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[index].ids.toString().replaceAll(RegExp(r'^\[|\]$'), '')),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 19,
                      color: data[index].filteringEnabled == true 
                        ? Colors.green
                        : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.vpn_lock_rounded,
                      size: 18,
                      color: data[index].safebrowsingEnabled == true 
                        ? Colors.green
                        : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.block,
                      size: 18,
                      color: data[index].parentalEnabled == true 
                        ? Colors.green
                        : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.search_rounded,
                      size: 19,
                      color: data[index].safesearchEnabled == true 
                        ? Colors.green
                        : Colors.red,
                    )
                  ],
                )
              ],
            ),
          )
        ),
      );
    }
    else {
      return SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.noClientsList,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: fetchClients, 
              icon: const Icon(Icons.refresh_rounded), 
              label: Text(AppLocalizations.of(context)!.refresh),
            )
          ],
        ),
      );
    }
  }
}