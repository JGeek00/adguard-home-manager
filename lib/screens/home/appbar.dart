import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/servers/servers.dart';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/routes/router_globals.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class HomeAppBar extends StatelessWidget {
  final bool innerBoxScrolled;

  const HomeAppBar({
    Key? key,
    required this.innerBoxScrolled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final statusProvider = Provider.of<StatusProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    final Server? server =  serversProvider.selectedServer;

    void navigateServers() {
      Future.delayed(const Duration(milliseconds: 0), (() {
        rootNavigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const Servers())
        );
      }));
    }

    return SliverAppBar.large(
      pinned: true,
      floating: true,
      centerTitle: false,
      forceElevated: innerBoxScrolled,
      surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      leading: Stack(
        children: [
          Center(
            child: Icon(
              serversProvider.selectedServer != null && statusProvider.serverStatus != null
                ? statusProvider.serverStatus!.generalEnabled == true 
                  ? Icons.gpp_good_rounded
                  : Icons.gpp_bad_rounded
                : Icons.shield,
              size: 30,
              color: serversProvider.selectedServer != null && statusProvider.serverStatus != null
                ? statusProvider.serverStatus!.generalEnabled == true 
                  ? appConfigProvider.useThemeColorForStatus
                    ? Theme.of(context).colorScheme.primary
                    : Colors.green
                  : appConfigProvider.useThemeColorForStatus == true
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
                    : Colors.red
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
            ),
          ),
          if (statusProvider.remainingTime > 0) Positioned(
            bottom: 15,
            right: 15,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.surface
                  ),
                  child: Icon(
                    Icons.timer_rounded,
                    size: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (serversProvider.selectedServer != null) ...[
            Text(
              server!.name,
              style: !appConfigProvider.hideServerAddress ? const TextStyle(
                fontSize: 20
              ) : null,
            ),
            if (!appConfigProvider.hideServerAddress) ...[
              const SizedBox(height: 5),
              Text(
                "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).listTileTheme.textColor
                ),
              )
            ]
          ],
          if (serversProvider.selectedServer == null) Text(
            AppLocalizations.of(context)!.noServerSelected,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: navigateServers,
              child: Row(
                children: [
                  const Icon(Icons.storage_rounded),
                  const SizedBox(width: 10),
                  Text(AppLocalizations.of(context)!.servers)
                ],
              ),
            ),
            if (serversProvider.selectedServer != null && statusProvider.loadStatus == LoadStatus.loaded) PopupMenuItem(
              onTap: () => openUrl("${server!.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}"),
              child: Row(
                children: [
                  const Icon(Icons.web_rounded),
                  const SizedBox(width: 10),
                  Text(AppLocalizations.of(context)!.webAdminPanel)
                ],
              ),
            )
          ]
        )
      ],
    );
  }
}