// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/remove_client_modal.dart';
import 'package:adguard_home_manager/screens/clients/fab.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class BlockedList extends StatefulWidget {
  final ScrollController scrollController;
  final int loadStatus;
  final List<String> data;
  final Future Function() fetchClients;

  const BlockedList({
    Key? key,
    required this.scrollController,
    required this.loadStatus,
    required this.data,
    required this.fetchClients
  }) : super(key: key);

  @override
  State<BlockedList> createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {
  late bool isVisible;

  @override
  initState(){
    super.initState();

    isVisible = true;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void confirmRemoveDomain(String domain) async {
      Map<String, List<String>> body = {
        "allowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.allowedClients ?? [],
        "disallowed_clients": serversProvider.clients.data!.clientsAllowedBlocked?.disallowedClients.where((client) => client != domain).toList() ?? [],
        "blocked_hosts": serversProvider.clients.data!.clientsAllowedBlocked?.blockedHosts ?? [],
      };

      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.removingClient);

      final result = await requestAllowedBlockedClientsHosts(serversProvider.selectedServer!, body);

      processModal.close();

      if (result['result'] == 'success') {
        serversProvider.setAllowedDisallowedClientsBlockedDomains(
          ClientsAllowedBlocked(
            allowedClients: body['allowed_clients'] ?? [], 
            disallowedClients: body['disallowed_clients'] ?? [], 
            blockedHosts: body['blocked_hosts'] ?? [], 
          )
        );
      }
      else if (result['result'] == 'error' && result['message'] == 'client_another_list') {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientAnotherList),
            backgroundColor: Colors.red,
          )
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.clientNotRemoved),
            backgroundColor: Colors.red,
          )
        );
      }
    }

    switch (widget.loadStatus) {
      case 0:
         return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingStatus,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );

      case 1: 
        return Stack(
          children: [
            if (widget.data.isNotEmpty) ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(widget.data[index]),
                trailing: IconButton(
                  onPressed: () => {
                    showDialog(
                      context: context, 
                      builder: (context) => RemoveClientModal(
                        onConfirm: () => confirmRemoveDomain(widget.data[index]),
                      )
                    )
                  }, 
                  icon: const Icon(Icons.delete_rounded)
                ),
              )
            ),
            if (widget.data.isEmpty) SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.noBlockedClients,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: widget.fetchClients, 
                    icon: const Icon(Icons.refresh_rounded), 
                    label: Text(AppLocalizations.of(context)!.refresh),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: const ClientsFab(tab: 2),
            )
          ]
        );

      case 2: 
        return SizedBox(
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
                AppLocalizations.of(context)!.errorLoadServerStatus,
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
}