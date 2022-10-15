import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/dhcp.dart';

class AddStaticLeaseModal extends StatefulWidget {
  final void Function(Lease) onConfirm;

  const AddStaticLeaseModal({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AddStaticLeaseModal> createState() => _AddStaticLeaseModalState();
}

class _AddStaticLeaseModalState extends State<AddStaticLeaseModal> {
  final TextEditingController macController = TextEditingController();
  String? macError;
  final TextEditingController ipController = TextEditingController();
  String? ipError;
  final TextEditingController hostNameController = TextEditingController();
  String? hostNameError;

  bool validData = false;

  void validateMac(String value) {
    final RegExp macRegex = RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
    if (macRegex.hasMatch(value)) {
      setState(() => macError = null);
    }
    else {
      setState(() => macError = AppLocalizations.of(context)!.macAddressNotValid);
    }
    validateData();
  }

  void validateIp(String value) {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => ipError = null);
    }
    else {
      setState(() => ipError = AppLocalizations.of(context)!.ipNotValid);
    }
    validateData();
  }

  void validateData() {
    if (
      macController.text != '' &&
      macError == null && 
      ipController.text != '' && 
      ipError == null &&
      hostNameController.text != '' && 
      hostNameError == null
    ) {
      setState(() => validData = true);
    }
    else {
      setState(() => validData = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).viewInsets.bottom > 0
          ? MediaQuery.of(context).size.height-MediaQuery.of(context).viewInsets.bottom-25
          : 550,
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          )
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).size.height-425
                : MediaQuery.of(context).size.height-400,
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 28),
                    child: Icon(
                      Icons.add,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.addStaticLease,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextFormField(
                      controller: macController,
                      onChanged: validateMac,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.smartphone_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: macError,
                        labelText: AppLocalizations.of(context)!.macAddress,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextFormField(
                      controller: ipController,
                      onChanged: validateIp,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.link_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: ipError,
                        labelText: AppLocalizations.of(context)!.ipAddress,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: TextFormField(
                      controller: hostNameController,
                      onChanged: (value) {
                        if (value != '') {
                          setState(() => hostNameError = null);
                        }
                        else {
                          setState(() => hostNameError = AppLocalizations.of(context)!.hostNameError);
                        }
                        validateData();
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.badge_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: hostNameError,
                        labelText: AppLocalizations.of(context)!.hostName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: validData == true
                            ? () {
                              Navigator.pop(context);
                              widget.onConfirm(
                                Lease(
                                  mac: macController.text, 
                                  hostname: hostNameController.text, 
                                  ip: ipController.text
                                )
                              );
                            }
                            : null,
                          child: Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                              color: validData == true
                                ? Theme.of(context).primaryColor
                                : Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}