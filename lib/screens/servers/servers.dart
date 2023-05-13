import 'dart:io';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/widgets/version_warning_modal.dart';
import 'package:adguard_home_manager/widgets/servers_list/servers_list.dart';
import 'package:adguard_home_manager/widgets/add_server_modal.dart';

import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Servers extends StatefulWidget {
  final double? breakingWidth;

  const Servers({
    Key? key,
    this.breakingWidth
  }) : super(key: key);

  @override
  State<Servers> createState() => _ServersState();
}

class _ServersState extends State<Servers> {
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

    final width = MediaQuery.of(context).size.width;

    for (var i = 0; i < serversProvider.serversList.length; i++) {
      expandableControllerList.add(ExpandableController());
    }

    void openAddServerModal() async {
      await Future.delayed(const Duration(seconds: 0), (() => {
        if (width > 700) {
          showDialog(
            context: context, 
            barrierDismissible: false,
            builder: (context) => AddServerModal(
              window: true,
              onUnsupportedVersion: (version) => showDialog(
                context: context, 
                builder: (ctx) => VersionWarningModal(
                  version: version 
                ),
                barrierDismissible: false
              ),
            ),
          )
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => AddServerModal(
              window: false,
              onUnsupportedVersion: (version) => showDialog(
                context: context, 
                builder: (ctx) => VersionWarningModal(
                  version: version 
                ),
                barrierDismissible: false
              ),
            )
          ))
        }
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.servers),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          ServersList(
            context: context, 
            controllers: expandableControllerList, 
            onChange: expandOrContract,
            scrollController: scrollController,
            breakingWidth: widget.breakingWidth ?? 700,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: isVisible ?
              appConfigProvider.showingSnackbar
                ? 70 : (Platform.isIOS ? 40 : 20)
              : -70,
            right: 20,
            child: FloatingActionButton(
              onPressed: openAddServerModal,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}