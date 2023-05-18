import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/servers/servers.dart';

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
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final Server? server =  serversProvider.selectedServer;

    void navigateServers() {
      Future.delayed(const Duration(milliseconds: 0), (() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Servers())
        );
      }));
    }

    return SliverAppBar.large(
      pinned: true,
      floating: true,
      centerTitle: false,
      forceElevated: innerBoxScrolled,
      leading: Icon(
        serversProvider.selectedServer != null && serversProvider.serverStatus.data != null
          ? serversProvider.serverStatus.data!.generalEnabled == true 
            ? Icons.gpp_good_rounded
            : Icons.gpp_bad_rounded
          : Icons.shield,
        size: 30,
        color: serversProvider.selectedServer != null && serversProvider.serverStatus.data != null
          ? serversProvider.serverStatus.data!.generalEnabled == true 
            ? appConfigProvider.useThemeColorForStatus
              ? Theme.of(context).colorScheme.primary
              : Colors.green
            : appConfigProvider.useThemeColorForStatus == true
              ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
              : Colors.red
          : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (serversProvider.selectedServer != null) ...[
            Text(
              server!.name,
              style: const TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).listTileTheme.textColor
              ),
            )
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
            if (serversProvider.selectedServer != null && serversProvider.serverStatus.loadStatus == 1) PopupMenuItem(
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