import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';

class ServicesModal extends StatefulWidget {
  final List<String> blockedServices;
  final void Function(List<String>) onConfirm;

  const ServicesModal({
    super.key,
    required this.blockedServices,
    required this.onConfirm,
  });

  @override
  State<ServicesModal> createState() => _ServicesModalStateWidget();
}

class _ServicesModalStateWidget extends State<ServicesModal> {
  List<String> blockedServices = [];

  

  @override
  void initState() {
    final filteringProvider = Provider.of<FilteringProvider>(context, listen: false);

    if (filteringProvider.blockedServicesLoadStatus != LoadStatus.loaded) {
      filteringProvider.getBlockedServices();
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
    final filteringProvider = Provider.of<FilteringProvider>(context);

    Widget content() {
      switch (filteringProvider.blockedServicesLoadStatus) {
        case LoadStatus.loading:
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

        case LoadStatus.loaded:
          return SizedBox(
            width: double.minPositive,
            height: MediaQuery.of(context).size.height*0.5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteringProvider.blockedServices!.services.length,
              itemBuilder: (context, index) => CheckboxListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    filteringProvider.blockedServices!.services[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                ),
                value: blockedServices.contains(filteringProvider.blockedServices!.services[index].id), 
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                onChanged: (value) => checkUncheckService(value!, filteringProvider.blockedServices!.services[index].id)
              )
            ),
          );

        case LoadStatus.error:
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