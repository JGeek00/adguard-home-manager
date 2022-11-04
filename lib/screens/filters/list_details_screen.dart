// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/filter_list_tile.dart';
import 'package:adguard_home_manager/screens/filters/add_list_modal.dart';
import 'package:adguard_home_manager/screens/filters/delete_list_modal.dart';

import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class ListDetailsScreen extends StatefulWidget {
  final Filter list;
  final String type;

  const ListDetailsScreen({
    Key? key,
    required this.list,
    required this.type,
  }) : super(key: key);

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  String name = "";
  bool enabled = true;
  bool fabVisible = true;

  @override
  void initState() {
    name = widget.list.name;
    enabled = widget.list.enabled;

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && fabVisible == true) {
          setState(() => fabVisible = false);
        }
      } 
      else {
        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && fabVisible == false) {
            setState(() => fabVisible = true);
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void enableDisableList(Filter list, bool newStatus) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(
        enabled == true
          ? AppLocalizations.of(context)!.disablingList
          : AppLocalizations.of(context)!.enablingList,
      );
      
      final result = await updateFilterList(server: serversProvider.selectedServer!, data: {
        "data": {
          "enabled": newStatus,
          "name": list.name,
          "url": list.url
        },
        "url": list.url,
        "whitelist": widget.type == 'whitelist' ? true : false
      });

      processModal.close();

      if (result['result'] == 'success') {
        final result2 = await getFiltering(server: serversProvider.selectedServer!);

        if (result2['result'] == 'success') {
          serversProvider.setFilteringData(result2['data']);
          serversProvider.setFilteringLoadStatus(1, true);
        }
        else {
          appConfigProvider.addLog(result2['log']);
          serversProvider.setFilteringLoadStatus(2, true);
        }

        setState(() => enabled = newStatus);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataUpdated, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataNotUpdated, 
          color: Colors.red
        );
      }
    }

    void confirmEditList({required Filter list, required String type}) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingListData);

      final result1 = await updateFilterList(server: serversProvider.selectedServer!, data: {
        "data": {
          "enabled": list.enabled,
          "name": list.name,
          "url": list.url
        },
        "url": list.url,
        "whitelist": type == 'whitelist' ? true : false
      });

      if (result1['result'] == 'success') {
        final result2 = await getFiltering(server: serversProvider.selectedServer!);

        if (result2['result'] == 'success') {
          serversProvider.setFilteringData(result2['data']);
          serversProvider.setFilteringLoadStatus(1, true);
        }
        else {
          appConfigProvider.addLog(result2['log']);
          serversProvider.setFilteringLoadStatus(2, true);
        }

        processModal.close();

        setState(() => name = list.name);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataUpdated, 
          color: Colors.green
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataNotUpdated, 
          color: Colors.red
        );
      }
    }

    void deleteList(Filter list, String type) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.deletingList);

      final result1 = await deleteFilterList(server: serversProvider.selectedServer!, data: {
        "url": list.url,
        "whitelist": type == 'whitelist' ? true : false
      });

      if (result1['result'] == 'success') {
        final result2 = await getFiltering(server: serversProvider.selectedServer!);

        if (result2['result'] == 'success') {
          serversProvider.setFilteringData(result2['data']);
          serversProvider.setFilteringLoadStatus(1, true);
        }
        else {
          appConfigProvider.addLog(result2['log']);
          serversProvider.setFilteringLoadStatus(2, true);
        }

        processModal.close();

        Navigator.pop(context); // Closes the screen

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDeleted, 
          color: Colors.green
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listNotDeleted, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.listDetails),
        actions: [
          IconButton(
            onPressed: () => {
              showModalBottomSheet(
                context: context, 
                builder: (ctx) => AddListModal(
                  list: widget.list,
                  type: widget.type,
                  onEdit: confirmEditList
                ),
                isScrollControlled: true,
                backgroundColor: Colors.transparent
              )
            }, 
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) => DeleteListModal(
                  onConfirm: () => deleteList(widget.list, widget.type),
                )
              );
            }, 
            icon: const Icon(Icons.delete),
            tooltip: AppLocalizations.of(context)!.delete,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              FilterListTile(
                icon: Icons.shield_rounded, 
                title: AppLocalizations.of(context)!.currentStatus, 
                subtitle: enabled == true
                  ? AppLocalizations.of(context)!.enabled
                  : AppLocalizations.of(context)!.disabled,
                color: enabled == true
                  ? appConfigProvider.useThemeColorForStatus == true
                    ? Theme.of(context).primaryColor
                    : Colors.green
                  :  appConfigProvider.useThemeColorForStatus == true
                    ? Colors.grey
                    : Colors.red,
                bold: true,
              ),
              FilterListTile(
                icon: Icons.badge_rounded, 
                title: AppLocalizations.of(context)!.name, 
                subtitle: name
              ),
              FilterListTile(
                icon: Icons.link_rounded, 
                title: "URL", 
                subtitle: widget.list.url
              ),
              FilterListTile(
                icon: Icons.list_rounded, 
                title: AppLocalizations.of(context)!.rules, 
                subtitle: widget.list.rulesCount.toString()
              ),
              FilterListTile(
                icon: Icons.shield_rounded, 
                title: AppLocalizations.of(context)!.listType, 
                subtitle: widget.type == 'whitelist'
                  ? AppLocalizations.of(context)!.whitelist
                  : AppLocalizations.of(context)!.blacklist, 
              ),
              if (widget.list.lastUpdated != null) FilterListTile(
                icon: Icons.schedule_rounded, 
                title: AppLocalizations.of(context)!.latestUpdate, 
                subtitle: formatTimestampUTC(widget.list.lastUpdated!, 'dd-MM-yyyy HH:mm'), 
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: fabVisible ?
              appConfigProvider.showingSnackbar
                ? 70 : 20
              : -70,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => enableDisableList(widget.list, !enabled),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                enabled == true
                  ? Icons.gpp_bad_rounded
                  : Icons.verified_user_rounded,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          )
        ],
      ),
    );
  }
}