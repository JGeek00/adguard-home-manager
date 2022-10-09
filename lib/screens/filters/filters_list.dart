// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/fab.dart';
import 'package:adguard_home_manager/screens/filters/list_details_modal.dart';
import 'package:adguard_home_manager/screens/filters/add_list_modal.dart';
import 'package:adguard_home_manager/screens/filters/delete_list_modal.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class FiltersList extends StatefulWidget {
  final int loadStatus;
  final ScrollController scrollController;
  final List<Filter> data;
  final void Function() fetchData;
  final String type;

  const FiltersList({
    Key? key,
    required this.loadStatus,
    required this.scrollController,
    required this.data,
    required this.fetchData,
    required this.type,
  }) : super(key: key);

  @override
  State<FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  late bool isVisible;

  @override
  initState(){
    super.initState();

    isVisible = true;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
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

    void enableDisableList(Filter list, bool enabled) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updatingListData);
      
      final result = await updateFilterList(server: serversProvider.selectedServer!, data: {
        "data": {
          "enabled": enabled,
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

        processModal.close();

        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listDataUpdated),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listDataNotUpdated),
            backgroundColor: Colors.red,
          )
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

        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listDataUpdated),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);
        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listDataNotUpdated),
            backgroundColor: Colors.red,
          )
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

        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listDeleted),
            backgroundColor: Colors.green,
          )
        );
      }
      else {
        processModal.close();
        appConfigProvider.addLog(result1['log']);
        appConfigProvider.setShowingSnackbar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.listNotDeleted),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    void openDetailsModal(Filter filter) {
      showFlexibleBottomSheet(
        minHeight: 0.6,
        initHeight: 0.6,
        maxHeight: (filter.enabled == true ? 774 : 755)/MediaQuery.of(context).size.height,
        isCollapsible: true,
        duration: const Duration(milliseconds: 250),
        anchors: [(filter.enabled == true ? 774 : 755)/MediaQuery.of(context).size.height],
        context: context, 
        builder: (ctx, controller, offset) => ListDetailsModal(
          scrollController: controller,
          list: filter, 
          type: widget.type,
          onDelete: (Filter list, String type) {
            showDialog(
              context: context, 
              builder: (context) => DeleteListModal(
                onConfirm: () {
                  Navigator.pop(context);
                  deleteList(list, type);
                },
              )
            );
          }, 
          edit: (type) => {
            showModalBottomSheet(
              context: context, 
              builder: (ctx) => AddListModal(
                list: filter,
                type: type,
                onEdit: confirmEditList
              ),
              isScrollControlled: true,
              backgroundColor: Colors.transparent
            )
          },
          onEnableDisable: enableDisableList,
        ),
        bottomSheetColor: Colors.transparent
      );
    }

    switch (widget.loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingFilters,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      case 1:
        return Stack(
          children: [
            if (widget.data.isNotEmpty) ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) => Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => openDetailsModal(widget.data[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width-130,
                              child: Text(
                                widget.data[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${intFormat(widget.data[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.data[index].enabled == true
                            ? AppLocalizations.of(context)!.enabled
                            : AppLocalizations.of(context)!.disabled,
                          style: TextStyle(
                            color: widget.data[index].enabled == true
                              ? Colors.green
                              : Colors.red,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.data.isEmpty) if (widget.data.isEmpty) SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.type == 'blacklist'
                      ? AppLocalizations.of(context)!.noBlackLists
                      : AppLocalizations.of(context)!.noWhiteLists,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: widget.fetchData, 
                    icon: const Icon(Icons.refresh_rounded), 
                    label: Text(AppLocalizations.of(context)!.refresh),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: FiltersFab(
                type: widget.type
              )
            )
          ],
        );

      case 2:
        return SizedBox(
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
                AppLocalizations.of(context)!.filtersNotLoaded,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      default:
        return const SizedBox();
    }

  }
}