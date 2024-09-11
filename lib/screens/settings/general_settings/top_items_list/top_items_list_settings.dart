import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/general_settings/top_items_list/show_hide_top_items_list.dart';
import 'package:adguard_home_manager/screens/settings/general_settings/top_items_list/reorderable_top_items_home.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class TopItemsListSettings extends StatefulWidget {
  const TopItemsListSettings({super.key});

  @override
  State<TopItemsListSettings> createState() => _TopItemsListSettingsState();
}

class _TopItemsListSettingsState extends State<TopItemsListSettings> with TickerProviderStateMixin {
  late TabController _tabController;

  List<HomeTopItems> persistHomeTopItemsList = [];

  @override
  void initState() {
    final appConfigProvider = Provider.of<AppConfigProvider>(context, listen: false);
    persistHomeTopItemsList = appConfigProvider.homeTopItemsOrder;

    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void saveSettings() async {
      final result = await appConfigProvider.setHomeTopItemsOrder(persistHomeTopItemsList);
      if (!context.mounted) return;
      if (result == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsSaved, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.settingsNotSaved, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                floating: true,
                centerTitle: false,
                forceElevated: innerBoxIsScrolled,
                surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
                title: Text(AppLocalizations.of(context)!.topItemsOrder),
                actions: [
                  IconButton(
                    onPressed: !listEquals(appConfigProvider.homeTopItemsOrder, persistHomeTopItemsList)
                      ? () => saveSettings()
                      : null, 
                    icon: const Icon(Icons.save_rounded),
                    tooltip: AppLocalizations.of(context)!.save,
                  ),
                  const SizedBox(width: 8)
                ],
                bottom: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.reorder_rounded),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.reorder)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.remove_red_eye_rounded),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.showHide)
                        ],
                      ),
                    ),
                  ]
                )
              ),
            )
          ], 
          body: TabBarView(
            controller: _tabController,
            children: [
              ReorderableTopItemsHome(
                persistHomeTopItems: persistHomeTopItemsList,
                setPersistHomeTopItems: (v) => setState(() => persistHomeTopItemsList = v),
              ),
              ShowHideTopItemsList(
                enabledHomeTopItems: persistHomeTopItemsList,
                setEnabledHomeTopItems: (v) => setState(() => persistHomeTopItemsList = v),
              )
            ]
          )
        ),
      ),
    );
  }
}