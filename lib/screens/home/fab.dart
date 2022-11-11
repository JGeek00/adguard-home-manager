import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/home/management_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void openManagementBottomSheet() {
      if (width < 700) {
         showModalBottomSheet(
          context: context, 
          isScrollControlled: true,
          builder: (context) => const ManagementModal(),
          backgroundColor: Colors.transparent,
        );
      }
      else {
        showDialog(
          context: context, 
          builder: (context) => const ManagementModal(),
        );
      }
    }

    return serversProvider.serverStatus.loadStatus == 1
      ? FloatingActionButton(
          onPressed: openManagementBottomSheet,
          backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: Icon(
            Icons.shield_rounded,
            color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          ),
        )
      : const SizedBox();
  }
}