// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/servers_list/servers_list_item.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServersList extends StatelessWidget {
  final BuildContext context;
  final List<ExpandableController> controllers;
  final Function(int) onChange;
  final ScrollController scrollController;

  const ServersList({
    Key? key,
    required this.context,
    required this.controllers,
    required this.onChange,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    
    if (serversProvider.serversList.isNotEmpty) {
      return ListView.builder(
        controller: scrollController,
        itemCount: serversProvider.serversList.length,
        itemBuilder: (context, index) => ServersListItem(
          expandableController: controllers[index], 
          server: serversProvider.serversList[index], 
          index: index, 
          onChange: onChange
        )
      );
    }
    else {
      return SizedBox(
        height: double.maxFinite,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noSavedConnections,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
  }
}