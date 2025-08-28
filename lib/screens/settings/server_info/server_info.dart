import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/server_info/dns_addresses_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/models/server_info.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class ServerInformation extends StatefulWidget {
  const ServerInformation({super.key});

  @override
  State<ServerInformation> createState() => _ServerInformationState();
}

class _ServerInformationState extends State<ServerInformation> {
  ServerInfo serverInfo = ServerInfo(loadStatus: LoadStatus.loading);

  void fetchServerInfo() async {
    final result = await Provider.of<ServersProvider>(context, listen: false).apiClient2!.getServerInfo();
    if (!mounted) return;
    if (result.successful == true) {
      setState(() {
        serverInfo.data = result.content as ServerInfoData;
        serverInfo.loadStatus = LoadStatus.loaded;
      });
    }
    else {
      setState(() => serverInfo.loadStatus = LoadStatus.error);
    }
  }

  @override
  void initState() {
    fetchServerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.serverInformation),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
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
                        if (width > 700) {
                          showDialog(
                            context: context, 
                            builder: (context) => DnsAddressesModal(
                              dnsAddresses: serverInfo.data!.dnsAddresses,
                              isDialog: true,
                            )
                          );
                        }
                        else {
                          showModalBottomSheet(
                            context: context, 
                            builder: (context) => DnsAddressesModal(
                              dnsAddresses: serverInfo.data!.dnsAddresses,
                              isDialog: false,
                            ),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            useSafeArea: true
                          );
                        }
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
                    if (serverInfo.data!.language != "") CustomListTile(
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
          },
        ),
      )
    );
  }
}