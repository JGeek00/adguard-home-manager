import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/constants/enums.dart';

class ShowHideTopItemsList extends StatelessWidget {
  final List<HomeTopItems> enabledHomeTopItems;
  final void Function(List<HomeTopItems>) setEnabledHomeTopItems;

  const ShowHideTopItemsList({
    super.key,
    required this.enabledHomeTopItems,
    required this.setEnabledHomeTopItems,
  });

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    void updateValue(HomeTopItems value, bool newStatus) {
      if (newStatus == true) {
        setEnabledHomeTopItems([
          ...enabledHomeTopItems,
          value
        ]);
      }
      else {
        setEnabledHomeTopItems(enabledHomeTopItems.where((e) => e != value).toList());
      }
    }

    return SafeArea(
      top: false,
      bottom: true,
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ), 
            SliverList.list(
              children: [
                const SizedBox(height: 8),
                CustomSwitchListTile(
                  value: enabledHomeTopItems.contains(HomeTopItems.queriedDomains), 
                  onChanged: (v) => updateValue(HomeTopItems.queriedDomains, v),
                  title: AppLocalizations.of(context)!.topQueriedDomains,
                  leadingIcon: Icons.install_desktop_outlined,
                  padding: padding,
                ),
                CustomSwitchListTile(
                  value: enabledHomeTopItems.contains(HomeTopItems.blockedDomains), 
                  onChanged: (v) => updateValue(HomeTopItems.blockedDomains, v),
                  title: AppLocalizations.of(context)!.topBlockedDomains,
                  leadingIcon: Icons.block_rounded,
                  padding: padding,
                ),
                CustomSwitchListTile(
                  value: enabledHomeTopItems.contains(HomeTopItems.recurrentClients), 
                  onChanged: (v) => updateValue(HomeTopItems.recurrentClients, v),
                  title: AppLocalizations.of(context)!.topClients,
                  leadingIcon: Icons.smartphone_rounded,
                  padding: padding,
                ),
                CustomSwitchListTile(
                  value: enabledHomeTopItems.contains(HomeTopItems.topUpstreams), 
                  onChanged: (v) => updateValue(HomeTopItems.topUpstreams, v),
                  title: AppLocalizations.of(context)!.topUpstreams,
                  leadingIcon: Icons.upload_file_rounded,
                  padding: padding,
                ),
                CustomSwitchListTile(
                  value: enabledHomeTopItems.contains(HomeTopItems.avgUpstreamResponseTime), 
                  onChanged: (v) => updateValue(HomeTopItems.avgUpstreamResponseTime, v),
                  title: AppLocalizations.of(context)!.averageUpstreamResponseTime,
                  leadingIcon: Icons.timer_rounded,
                  padding: padding,
                ),
              ]
            )
          ],
        ),
      )
    );
  }
}