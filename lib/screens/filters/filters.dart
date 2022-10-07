import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/filters_list.dart';
import 'package:adguard_home_manager/screens/filters/custom_rules_list.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return FiltersWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider
    );
  }
}

class FiltersWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const FiltersWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> with TickerProviderStateMixin {
  late TabController tabController;

  Future fetchFilters() async {
    widget.serversProvider.setFilteringLoadStatus(0, false);

    final result = await getFiltering(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        widget.serversProvider.setFilteringData(result['data']);
        widget.serversProvider.setFilteringLoadStatus(1, true);
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        widget.serversProvider.setFilteringLoadStatus(2, true);
      }
    }
  }

  @override
  void initState() {
    fetchFilters();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() => widget.appConfigProvider.setSelectedFiltersTab(tabController.index));
  }

  List<AutoClient> generateClientsList(List<AutoClient> clients, List<String> ips) {
    return clients.where((client) => ips.contains(client.ip)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    switch (serversProvider.filtering.loadStatus) {
      case 0:
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppBar(
              title: Text(AppLocalizations.of(context)!.filters),
              centerTitle: true,
            ),
            SizedBox(
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
            ),
          ],
        );
      
      case 1:
        return DefaultTabController(
          length: 3, 
          child: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(AppLocalizations.of(context)!.filters),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.verified_user_rounded),
                        text: AppLocalizations.of(context)!.whitelists,
                      ),
                      Tab(
                        icon: const Icon(Icons.gpp_bad_rounded),
                        text: AppLocalizations.of(context)!.blacklists,
                      ),
                      Tab(
                        icon: const Icon(Icons.shield_rounded),
                        text: AppLocalizations.of(context)!.customRules,
                      ),
                    ]
                  )
                )
              ];
            }), 
            body: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromRGBO(220, 220, 220, 1)
                      : const Color.fromRGBO(50, 50, 50, 1)
                  )
                )
              ),
              child: TabBarView(
                controller: tabController,
                children: [
                  RefreshIndicator(
                    onRefresh: fetchFilters,
                    child: FiltersList(
                      data: serversProvider.filtering.data!.whitelistFilters
                    )
                  ),
                  RefreshIndicator(
                    onRefresh: fetchFilters,
                    child: FiltersList(
                      data: serversProvider.filtering.data!.filters
                    )
                  ),
                  RefreshIndicator(
                    onRefresh: fetchFilters,
                    child: CustomRulesList(
                      data: serversProvider.filtering.data!.userRules
                    )
                  ),
                ],
              ),
            )
          )
        );
        
      case 2:
        return Column(
          children: [
            AppBar(
              title: Text(AppLocalizations.of(context)!.filters),
              centerTitle: true,
            ),
            SizedBox(
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
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}