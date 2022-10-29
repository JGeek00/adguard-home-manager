import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

import 'package:adguard_home_manager/screens/connect/fab.dart';
import 'package:adguard_home_manager/screens/connect/appbar.dart';
import 'package:adguard_home_manager/widgets/servers_list/servers_list.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  List<ExpandableController> expandableControllerList = [];

  late bool isVisible;
  final ScrollController scrollController = ScrollController();

  void expandOrContract(int index) async {
    expandableControllerList[index].expanded = !expandableControllerList[index].expanded;
  }

  @override
  void initState() {
    super.initState();

    isVisible = true;
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    for (var i = 0; i < serversProvider.serversList.length; i++) {
      expandableControllerList.add(ExpandableController());
    }

    return Scaffold(
      appBar: const ConnectAppBar(),
      body: Stack(
        children: [
          ServersList(
            context: context, 
            controllers: expandableControllerList, 
            onChange: expandOrContract,
            scrollController: scrollController,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: isVisible ?
              appConfigProvider.showingSnackbar
                ? 70 : 20
              : -70,
            right: 20,
            child: const FabConnect()
          )
        ],
      ),
    );
  }
}