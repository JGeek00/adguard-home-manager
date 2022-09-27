import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/server.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    final Server server = serversProvider.selectedServer!;

    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  serversProvider.serverStatus.data != null
                    ? serversProvider.serverStatus.data!.generalEnabled == true 
                      ? Icons.gpp_good_rounded
                      : Icons.gpp_bad_rounded
                    : Icons.shield,
                  size: 30,
                  color: serversProvider.serverStatus.data != null
                    ? serversProvider.serverStatus.data!.generalEnabled == true 
                      ? Colors.green
                      : Colors.red
                    : Colors.grey,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      server.name,
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${server.connectionMethod}://${server.domain}${server.path ?? ""}${server.port != null ? ':${server.port}' : ""}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(140, 140, 140, 1)
                      ),
                    )
                  ],
                ),
              ],
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                
              ]
            )
          ],
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}