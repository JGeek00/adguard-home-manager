import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/clients.dart';

class ClientsList extends StatelessWidget {
  final int loadStatus;
  final List<AutoClient> data;
  final Future Function() fetchClients;

  const ClientsList({
    Key? key,
    required this.loadStatus,
    required this.data,
    required this.fetchClients
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingStatus,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      case 1:
        if (data.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemCount: data.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                data[index].name != '' 
                  ? data[index].name!
                  : data[index].ip
              ),
              subtitle: data[index].name != ''
                ? Text(
                    data[index].ip
                  )
                : null,
              trailing: Text(data[index].source),
            )
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
                  label: Text(AppLocalizations.of(context)!.refresh)
                )
              ],
            ),
          );
        }

      case 2:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.errorLoadServerStatus,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
        
      default:
        return const SizedBox();
    }
  }
}