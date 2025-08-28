import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/access_settings/clients_list.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';

class AccessSettings extends StatefulWidget {
  const AccessSettings({super.key});

  @override
  State<AccessSettings> createState() => _AccessSettingsState();
}

class _AccessSettingsState extends State<AccessSettings> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    Provider.of<ClientsProvider>(context, listen: false).fetchClients(updateLoading: true);
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (Platform.isAndroid || Platform.isIOS) {
      return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    bottom: false,
                    sliver: SliverAppBar(
                      title: Text(AppLocalizations.of(context)!.accessSettings),
                      pinned: true,
                      floating: true,
                      centerTitle: false,
                      forceElevated: innerBoxIsScrolled,
                      surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
                      bottom: _Tabs(tabController: _tabController)
                    ),
                  ),
                )
              ];
            }), 
            body: _TabsView(
              tabController: _tabController, 
              scrollController: _scrollController
            )
          )
        ),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.accessSettings),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size(double.maxFinite, 50), 
            child: _Tabs(tabController: _tabController)
          )
        ),
        body: _TabsView(
          tabController: _tabController, 
          scrollController: _scrollController
        )
      );
    }
  }
}

class _Tabs extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const _Tabs({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
      tabAlignment: TabAlignment.start,
      tabs: [
        Tab(
          child: Row(
            children: [
              const Icon(Icons.check),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.allowedClients)
            ],
          ),
        ),
        Tab(
          child: Row(
            children: [
              const Icon(Icons.block),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.disallowedClients)
            ],
          ),
        ),
        Tab(
          child: Row(
            children: [
              const Icon(Icons.link_rounded),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.disallowedDomains)
            ],
          ),
        ),
      ]
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TabsView extends StatelessWidget {
  final TabController tabController;
  final ScrollController scrollController;

  const _TabsView({
    required this.tabController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    return TabBarView(
      controller: tabController,
      children: [
        ClientsList(
          type: AccessSettingsList.allowed,
          scrollController: scrollController, 
          loadStatus: clientsProvider.loadStatus, 
          data: clientsProvider.loadStatus == LoadStatus.loaded
            ? clientsProvider.clients!.clientsAllowedBlocked!.allowedClients : [], 
        ),
        ClientsList(
          type: AccessSettingsList.disallowed,
          scrollController: scrollController, 
          loadStatus: clientsProvider.loadStatus, 
          data: clientsProvider.loadStatus == LoadStatus.loaded
            ? clientsProvider.clients!.clientsAllowedBlocked!.disallowedClients : [], 
        ),
        ClientsList(
          type: AccessSettingsList.domains,
          scrollController: scrollController, 
          loadStatus: clientsProvider.loadStatus, 
          data: clientsProvider.loadStatus == LoadStatus.loaded
            ? clientsProvider.clients!.clientsAllowedBlocked!.blockedHosts : [], 
        ),
      ]
    );
  }
}