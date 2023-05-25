import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/access_settings/clients_list.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/clients_provider.dart';

class AccessSettings extends StatefulWidget {
  const AccessSettings({Key? key}) : super(key: key);

  @override
  State<AccessSettings> createState() => _AccessSettingsState();
}

class _AccessSettingsState extends State<AccessSettings> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;

  @override
  void initState() {
    Provider.of<ClientsProvider>(context, listen: false).fetchClients(updateLoading: true);
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    Widget body() {
      return TabBarView(
        controller: tabController,
        children: [
          ClientsList(
            type: 'allowed',
            scrollController: scrollController, 
            loadStatus: clientsProvider.loadStatus, 
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.clients!.clientsAllowedBlocked!.allowedClients : [], 
          ),
          ClientsList(
            type: 'disallowed',
            scrollController: scrollController, 
            loadStatus: clientsProvider.loadStatus, 
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.clients!.clientsAllowedBlocked!.disallowedClients : [], 
          ),
          ClientsList(
            type: 'domains',
            scrollController: scrollController, 
            loadStatus: clientsProvider.loadStatus, 
            data: clientsProvider.loadStatus == LoadStatus.loaded
              ? clientsProvider.clients!.clientsAllowedBlocked!.blockedHosts : [], 
          ),
        ]
      );
    }

    PreferredSizeWidget tabBar() {
      return TabBar(
        controller: tabController,
        isScrollable: true,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
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

    if (Platform.isAndroid || Platform.isIOS) {
      return Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: Text(AppLocalizations.of(context)!.accessSettings),
                      pinned: true,
                      floating: true,
                      centerTitle: false,
                      forceElevated: innerBoxIsScrolled,
                      bottom: tabBar()
                    ),
                  ),
                )
              ];
            }), 
            body: body()
          )
        ),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.accessSettings),
          centerTitle: false,
          bottom: tabBar()
        ),
        body: body(),
      );
    }
  }
}