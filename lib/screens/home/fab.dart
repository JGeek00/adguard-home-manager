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
          child: Icon(
            Icons.shield_rounded,
            color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        )
      : const SizedBox();
  }
}