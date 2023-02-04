import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/services/http_requests.dart';

class ServicesModal extends StatelessWidget {
  final List<String> blockedServices;
  final void Function(List<String>) onConfirm;

  const ServicesModal({
    Key? key,
    required this.blockedServices,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return ServicesModalWidget(
      blockedServices: blockedServices, 
      onConfirm: onConfirm,
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}

class ServicesModalWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final List<String> blockedServices;
  final void Function(List<String>) onConfirm;

  const ServicesModalWidget({
    Key? key,
    required this.blockedServices,
    required this.onConfirm,
    required this.serversProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<ServicesModalWidget> createState() => _ServicesModalStateWidget();
}

class _ServicesModalStateWidget extends State<ServicesModalWidget> {
  List<String> blockedServices = [];

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

    blockedServices = widget.blockedServices;
    super.initState();
  }

  void checkUncheckService(bool value, String service) {
    if (value == true) {
      setState(() {
        blockedServices.add(service);
      });
    }
    else if (value == false) {
      setState(() {
        blockedServices = blockedServices.where((s) => s != service).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    Widget content() {
      switch (serversProvider.blockedServicesList.loadStatus) {
        case 0:
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.loadingBlockedServicesList,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                ],
              ),
            ),
          );

        case 1:
          return SizedBox(
            width: double.minPositive,
            height: MediaQuery.of(context).size.height*0.5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: serversProvider.blockedServicesList.services!.length,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    serversProvider.blockedServicesList.services![index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ),
                value: blockedServices.contains(serversProvider.blockedServicesList.services![index].id), 
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                onChanged: (value) => checkUncheckService(value!, serversProvider.blockedServicesList.services![index].id)
              )
            ),
          );

        case 2:
          return Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 26,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.blockedServicesListNotLoaded,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  )
                ],
              ),
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16
      ),
      title: Column(
        children: [
          Icon(
            Icons.public,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.services,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
      ),
      content: content(),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: blockedServices.isNotEmpty
            ? () {
                widget.onConfirm(blockedServices);
                Navigator.pop(context);
              }
            : null, 
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: TextStyle(
              color: blockedServices.isNotEmpty 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
            ),
          )
        ),
      ],
    );
  }
}