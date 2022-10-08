import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/screens/connect/fab.dart';
import 'package:adguard_home_manager/screens/connect/appbar.dart';
import 'package:adguard_home_manager/widgets/servers_list/servers_list.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  List<ExpandableController> expandableControllerList = [];

  void expandOrContract(int index) async {
    expandableControllerList[index].expanded = !expandableControllerList[index].expanded;
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    for (var i = 0; i < serversProvider.serversList.length; i++) {
      expandableControllerList.add(ExpandableController());
    }

    return Scaffold(
      appBar: const ConnectAppBar(),
      body: ServersList(
        context: context, 
        controllers: expandableControllerList, 
        onChange: expandOrContract
      ),
      floatingActionButton: const FabConnect(),
    );
  }
}