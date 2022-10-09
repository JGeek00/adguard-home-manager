import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/custom_list_tile.dart';
import 'package:adguard_home_manager/screens/settings/dns_addresses_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/models/server_info.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServerInformation extends StatelessWidget {
  const ServerInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ServerInformationWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}

class ServerInformationWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const ServerInformationWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<ServerInformationWidget> createState() => _ServerInformationWidgetState();
}

class _ServerInformationWidgetState extends State<ServerInformationWidget> {
  ServerInfo serverInfo = ServerInfo(loadStatus: 0);

  void fetchServerInfo() async {
    final result = await getServerInfo(server: widget.serversProvider.selectedServer!);
    if (mounted) {
      if (result['result'] == 'success') {
        setState(() {
          serverInfo.loadStatus = 1;
          serverInfo.data = result['data'];
        });
      }
      else {
        widget.appConfigProvider.addLog(result['log']);
        setState(() => serverInfo.loadStatus = 2);
      }
    }
  }

  @override
  void initState() {
    fetchServerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget generateBody() {
      switch (serverInfo.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.loadingServerInfo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          );

        case 1:
          return ListView(
            children: [
              CustomListTile(
                label: AppLocalizations.of(context)!.dnsAddresses,
                description: AppLocalizations.of(context)!.seeDnsAddresses,
                onTap: () {
                  showModal(
                    context: context, 
                    builder: (context) => DnsAddressesModal(
                      dnsAddresses: serverInfo.data!.dnsAddresses
                    )
                  );
                },
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.dnsPort,
                description: serverInfo.data!.dnsPort.toString(),
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.httpPort,
                description: serverInfo.data!.httpPort.toString(),
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.protectionEnabled,
                description: serverInfo.data!.protectionEnabled == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.dhcpAvailable,
                description: serverInfo.data!.dhcpAvailable == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.serverRunning,
                description: serverInfo.data!.running == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.serverVersion,
                description: serverInfo.data!.version,
              ),
              CustomListTile(
                label: AppLocalizations.of(context)!.serverLanguage,
                description: serverInfo.data!.language,
              ),
            ]
          );

        case 2:
          return SizedBox(
            width: double.maxFinite,
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
                  AppLocalizations.of(context)!.serverInfoNotLoaded,
                  textAlign: TextAlign.center,
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


    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.serverInformation),
      ),
      body: generateBody()
    );
  }
}