import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/widgets/servers_list/servers_list.dart';
import 'package:adguard_home_manager/widgets/add_server_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';

class Servers extends StatefulWidget {
  const Servers({Key? key}) : super(key: key);

  @override
  State<Servers> createState() => _ServersState();
}

class _ServersState extends State<Servers> {
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

    void openAddServerModal() async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        Navigator.push(context, MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => const AddServerModal()
        ))
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.servers),
      ),
      body: ServersList(
        context: context, 
        controllers: expandableControllerList, 
        onChange: expandOrContract
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddServerModal,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}