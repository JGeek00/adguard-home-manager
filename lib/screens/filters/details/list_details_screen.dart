// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/details/add_list_modal.dart';
import 'package:adguard_home_manager/screens/filters/modals/delete_list_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/functions/format_time.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class ListDetailsScreen extends StatefulWidget {
  final int listId;
  final String type;
  final bool dialog;

  const ListDetailsScreen({
    Key? key,
    required this.listId,
    required this.type,
    required this.dialog
  }) : super(key: key);

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  bool fabVisible = true;

  @override
  void initState() {
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
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    Filter? list;
    try {
      list = filteringProvider.filtering != null
        ? widget.type == 'whitelist'
          ? filteringProvider.filtering!.whitelistFilters.firstWhere((l) => l.id == widget.listId)
          : filteringProvider.filtering!.filters.firstWhere((l) => l.id == widget.listId)
        : null;
    } catch (e) {
      // ------- //
    }

    void updateList({
      required FilteringListActions action,
      required Filter filterList,
    }) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(
        action == FilteringListActions.edit
          ? AppLocalizations.of(context)!.savingList
          : action == FilteringListActions.disable 
            ? AppLocalizations.of(context)!.disablingList
            : AppLocalizations.of(context)!.enablingList,
      );
      final result = await filteringProvider.updateList(
        list: filterList, 
        type: widget.type, 
        action: action
      );
      processModal.close();
      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.listDataNotUpdated, 
          color: Colors.red
        );
      }
    }

    List<Widget> content() {
      return [
        CustomListTile(
          icon: Icons.shield_rounded, 
          title: AppLocalizations.of(context)!.currentStatus, 
          subtitleWidget: Text(
            list!.enabled == true
              ? AppLocalizations.of(context)!.enabled
              : AppLocalizations.of(context)!.disabled,
            style: TextStyle(
              color: list.enabled == true
                ? appConfigProvider.useThemeColorForStatus == true
                  ? Theme.of(context).colorScheme.primary
                  : Colors.green
                :  appConfigProvider.useThemeColorForStatus == true
                  ? Colors.grey
                  : Colors.red,
              fontWeight: FontWeight.w500
            ),
          ),
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
        ),
        CustomListTile(
          icon: Icons.badge_rounded, 
          title: AppLocalizations.of(context)!.name, 
          subtitle: list.name,
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
        ),
        CustomListTile(
          icon: Icons.link_rounded, 
          title: "URL", 
          subtitle: list.url,
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
          trailing: IconButton(
            onPressed: () => openUrl(list!.url), 
            icon: const Icon(Icons.open_in_browser_rounded),
            tooltip: AppLocalizations.of(context)!.openListUrl,
          ),
        ),
        CustomListTile(
          icon: Icons.list_rounded, 
          title: AppLocalizations.of(context)!.rules, 
          subtitle: list.rulesCount.toString(),
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
        ),
        CustomListTile(
          icon: Icons.shield_rounded, 
          title: AppLocalizations.of(context)!.listType, 
          subtitle: widget.type == 'whitelist'
            ? AppLocalizations.of(context)!.whitelist
            : AppLocalizations.of(context)!.blacklist,
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
        ),
        if (list.lastUpdated != null) CustomListTile(
          icon: Icons.schedule_rounded, 
          title: AppLocalizations.of(context)!.latestUpdate, 
          subtitle: convertTimestampLocalTimezone(list.lastUpdated!, 'dd-MM-yyyy HH:mm'), 
          padding: widget.dialog == true
            ? const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8
              )
            : null,
        ),
        if (widget.dialog == true) Container(height: 16)
      ];
    }

    List<Widget> actions() {
      return [
        IconButton(
          onPressed: () => {
            if (width > 700 || !(Platform.isAndroid || Platform.isIOS)) {
              showDialog(
                context: context, 
                builder: (ctx) => AddListModal(
                  list: list,
                  type: widget.type,
                  onEdit: ({required Filter list, required String type}) async => updateList(
                    action: FilteringListActions.edit,
                    filterList: list
                  ),
                  dialog: true,
                ),
              )
            }
            else {
              showModalBottomSheet(
                context: context, 
                useRootNavigator: true,
                builder: (ctx) => AddListModal(
                  list: list,
                  type: widget.type,
                  onEdit: ({required Filter list, required String type}) async => updateList(
                    action: FilteringListActions.edit,
                    filterList: list
                  ),
                  dialog: false,
                ),
                isScrollControlled: true,
                backgroundColor: Colors.transparent
              )
            }
          }, 
          icon: const Icon(Icons.edit),
          tooltip: AppLocalizations.of(context)!.edit,
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context, 
              builder: (c) => DeleteListModal(
                onConfirm: () async {
                  ProcessModal processModal = ProcessModal();
                  processModal.open(AppLocalizations.of(context)!.deletingList);
                  final result = await filteringProvider.deleteList(
                    listUrl: list!.url, 
                    type: widget.type,
                  );
                  processModal.close();
                  if (result == true) {
                    showSnacbkar(
                      appConfigProvider: appConfigProvider,
                      label: AppLocalizations.of(context)!.listDeleted, 
                      color: Colors.green
                    );
                    Navigator.pop(context);
                  }
                  else {
                    showSnacbkar(
                      appConfigProvider: appConfigProvider,
                      label: AppLocalizations.of(context)!.listNotDeleted, 
                      color: Colors.red
                    );
                  }
                }
              )
            );
          }, 
          icon: const Icon(Icons.delete),
          tooltip: AppLocalizations.of(context)!.delete,
        ),
        const SizedBox(width: 10),
      ];
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.listDetails,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        )
                      ],
                    ),
                    if (list != null) Row(
                      children: [
                        IconButton(
                          onPressed: () =>  updateList(
                            action: list!.enabled == true
                              ? FilteringListActions.disable
                              : FilteringListActions.enable,
                            filterList: list
                          ),
                          icon: Icon(
                            list.enabled == true
                              ? Icons.gpp_bad_rounded
                              : Icons.verified_user_rounded,
                          ),
                          tooltip: list.enabled == true
                            ? AppLocalizations.of(context)!.disableList
                            : AppLocalizations.of(context)!.enableList,
                        ),
                        ...actions()
                      ],
                    )
                  ],
                ),
              ),
              Flexible(
                child: list != null
                  ?  SingleChildScrollView(
                      child: Wrap(
                        children: content(),
                      ),
                    )
                  : Center(
                      child: Text(
                        AppLocalizations.of(context)!.listNotAvailable,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
              )
            ],
          ),
        )
      );
    }
    else {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(AppLocalizations.of(context)!.listDetails),
            actions: list != null ? actions() : null,
          ),
          body: Stack(
            children: [
              if (list != null) ListView(
                children: content(),
              ),
              if (list == null) Center(
                child: Text(
                  AppLocalizations.of(context)!.listNotAvailable,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              if (list != null) AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                bottom: fabVisible ?
                  appConfigProvider.showingSnackbar
                    ? 70 : (Platform.isIOS ? 40 : 20)
                  : -70,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => updateList(
                    action: list!.enabled == true
                      ? FilteringListActions.disable
                      : FilteringListActions.enable,
                    filterList: list
                  ),
                  child: Icon(
                    list.enabled == true
                      ? Icons.gpp_bad_rounded
                      : Icons.verified_user_rounded,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}