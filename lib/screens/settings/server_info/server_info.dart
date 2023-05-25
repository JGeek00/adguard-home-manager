import 'package:adguard_home_manager/constants/enums.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/server_info/dns_addresses_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
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
  ServerInfo serverInfo = ServerInfo(loadStatus: LoadStatus.loading);

  void fetchServerInfo() async {
    final result = await Provider.of<ServersProvider>(context, listen: false).apiClient!.getServerInfo();
    if (mounted) {
      if (result['result'] == 'success') {
        setState(() {
          serverInfo.loadStatus = LoadStatus.loaded;
          serverInfo.data = result['data'];
        });
      }
      else {
        setState(() => serverInfo.loadStatus = LoadStatus.loaded);
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
        case LoadStatus.loading:
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
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              ],
            ),
          );

        case LoadStatus.loaded:
          return ListView(
            children: [
              CustomListTile(
                title: AppLocalizations.of(context)!.dnsAddresses,
                subtitle: AppLocalizations.of(context)!.seeDnsAddresses,
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
                title: AppLocalizations.of(context)!.dnsPort,
                subtitle: serverInfo.data!.dnsPort.toString(),
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.httpPort,
                subtitle: serverInfo.data!.httpPort.toString(),
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.protectionEnabled,
                subtitle: serverInfo.data!.protectionEnabled == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.dhcpAvailable,
                subtitle: serverInfo.data!.dhcpAvailable == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.serverRunning,
                subtitle: serverInfo.data!.running == true 
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.serverVersion,
                subtitle: serverInfo.data!.version,
              ),
              CustomListTile(
                title: AppLocalizations.of(context)!.serverLanguage,
                subtitle: serverInfo.data!.language,
              ),
            ]
          );

        case LoadStatus.error:
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        centerTitle: false,
      ),
      body: generateBody()
    );
  }
}