import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/constants/services.dart';

class ServicesModal extends StatefulWidget {
  final List<String> blockedServices;
  final void Function(List<String>) onConfirm;

  const ServicesModal({
    Key? key,
    required this.blockedServices,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<ServicesModal> createState() => _ServicesModalState();
}

class _ServicesModalState extends State<ServicesModal> {
  List<String> blockedServices = [];

  @override
  void initState() {
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
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 20
      ),
      title: Column(
        children: [
          const Icon(Icons.public),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.services)
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        height: MediaQuery.of(context).size.height*0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: (context, index) => CheckboxListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                services[index]['label']!,
                style: const TextStyle(
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
            value: blockedServices.contains(services[index]['id']), 
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            onChanged: (value) => checkUncheckService(value!, services[index]['id']!)
          )
        ),
      ),
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
                ? Theme.of(context).primaryColor
                : Colors.grey
            ),
          )
        ),
      ],
    );
  }
}