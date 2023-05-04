// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class BlockedServicesScreen extends StatelessWidget {
  final bool dialog;

  const BlockedServicesScreen({
    Key? key,
    required this.dialog
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return BlockedServicesScreenWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
      dialog: dialog,
    );
  }
}

class BlockedServicesScreenWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final bool dialog;

  const BlockedServicesScreenWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.dialog
  }) : super(key: key);

  @override
  State<BlockedServicesScreenWidget> createState() => _BlockedServicesScreenStateWidget();
}

class _BlockedServicesScreenStateWidget extends State<BlockedServicesScreenWidget> {
  List<String> values = [];

  Future loadBlockedServices() async {
    final result = await getBlockedServices(server: widget.serversProvider.selectedServer!);
    if (result['result'] == 'success') {
      widget.serversProvider.setBlockedServicesListLoadStatus(1, true);
      widget.serversProvider.setBlockedServiceListData(result['data']);
    }
    else {
      widget.serversProvider.setBlockedServicesListLoadStatus(2, true);
      widget.appConfigProvider.addLog(result['log']);
    }
  }

  @override
  void initState() {
    if (widget.serversProvider.blockedServicesList.loadStatus != 1) {
      loadBlockedServices();
    }

    values = widget.serversProvider.filtering.data!.blockedServices; 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void updateValues(bool value, BlockedService item) {
      if (value == true) {
        setState(() {
          values = values.where((v) => v != item.id).toList();
        });
      }
      else {
        setState(() {
          values.add(item.id);
        });
      }
    }

    void updateBlockedServices() async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.updating);

      final result = await setBlockedServices(server: serversProvider.selectedServer!, data: values);

      processModal.close();

      if (result['result'] == 'success') {
        serversProvider.setBlockedServices(values);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.blockedServicesUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.blockedServicesNotUpdated, 
          color: Colors.red
        );
      }
    }

    Widget body() {
      switch (serversProvider.blockedServicesList.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingBlockedServicesList,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );

        case 1:
          return ListView.builder(
            itemCount: serversProvider.blockedServicesList.services!.length,
            itemBuilder: (context, index) => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => updateValues(
                  values.contains(serversProvider.blockedServicesList.services![index].id), 
                  serversProvider.blockedServicesList.services![index]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    bottom: 6,
                    right: 12,
                    left: 24
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        serversProvider.blockedServicesList.services![index].name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Checkbox(
                        value: values.contains(serversProvider.blockedServicesList.services![index].id), 
                        onChanged: (value) => updateValues(
                          value!, 
                          serversProvider.blockedServicesList.services![index]
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
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
                  AppLocalizations.of(context)!.blockedServicesListNotLoaded,
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

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(         
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.blockedServices,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: updateBlockedServices, 
                      icon: const Icon(
                        Icons.save_rounded
                      ),
                      tooltip: AppLocalizations.of(context)!.save,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: body()
              ),
            ],
          )
        ),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.blockedServices),
          actions: [
            IconButton(
              onPressed: updateBlockedServices, 
              icon: const Icon(
                Icons.save_rounded
              ),
              tooltip: AppLocalizations.of(context)!.save,
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: RefreshIndicator(
          onRefresh: loadBlockedServices,
          child: body()
        ),
      );
    }
  }
}