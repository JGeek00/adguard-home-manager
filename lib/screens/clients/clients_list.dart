import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/active_client_tile.dart';

import 'package:adguard_home_manager/widgets/tab_content_list.dart';

import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class ClientsList extends StatelessWidget {
  final ScrollController scrollController;
  final LoadStatus loadStatus;
  final List<AutoClient> data;
  final Future Function() fetchClients;
  final void Function(AutoClient) onClientSelected;
  final AutoClient? selectedClient;
  final bool splitView;
  final bool sliver;

  const ClientsList({
    Key? key,
    required this.scrollController,
    required this.loadStatus,
    required this.data,
    required this.fetchClients,
    required this.onClientSelected,
    this.selectedClient,
    required this.splitView,
    required this.sliver
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabContentList(
      listPadding: splitView == true 
        ? const EdgeInsets.only(top: 8)
        : null,
      noSliver: !sliver,
      loadingGenerator: () =>  SizedBox(
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          ],
        ),
      ), 
      itemsCount: data.length, 
      contentWidget: (index) => ActiveClientTile(
        client: data[index], 
        onTap: onClientSelected,
        splitView: splitView,
        selectedClient: selectedClient,
      ),
      noData: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.noClientsList,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
      ), 
      errorGenerator: () => SizedBox(
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          ],
        ),
      ), 
      loadStatus: loadStatus, 
      onRefresh: fetchClients
    );
  }
}