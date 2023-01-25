import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/home/management_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    void openManagementBottomSheet() {
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => const ManagementModal(),
        backgroundColor: Colors.transparent,
      );
    }

    return serversProvider.serverStatus.loadStatus == 1
      ? FloatingActionButton(
          onPressed: openManagementBottomSheet,
          child: const Icon(Icons.shield_rounded),
        )
      : const SizedBox();
  }
}