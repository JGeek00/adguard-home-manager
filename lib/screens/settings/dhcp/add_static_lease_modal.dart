import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/models/dhcp.dart';

class AddStaticLeaseModal extends StatelessWidget {
  final void Function(Lease) onConfirm;
  final bool dialog;

  const AddStaticLeaseModal({
    super.key,
    required this.onConfirm,
    required this.dialog
  });

  @override
  Widget build(BuildContext context) {
    if (dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: _Content(onConfirm: onConfirm)
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            )
          ),
          child: SafeArea(
            child: _Content(onConfirm: onConfirm)
          )
        ),
      );
    }
  }
}

class _Content extends StatefulWidget {
  final void Function(Lease) onConfirm;

  const _Content({
    required this.onConfirm
  });

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final TextEditingController macController = TextEditingController();
  String? macError;
  final TextEditingController ipController = TextEditingController();
  String? ipError;
  final TextEditingController hostNameController = TextEditingController();
  String? hostNameError;

  bool validData = false;

  void validateMac(String value) {
    if (Regexps.macAddress.hasMatch(value)) {
      setState(() => macError = null);
    }
    else {
      setState(() => macError = AppLocalizations.of(context)!.macAddressNotValid);
    }
    validateData();
  }

  void validateIp(String value) {
    if (Regexps.ipv4Address.hasMatch(value) == true) {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Icon(
                                Icons.add,
                                size: 24,
                                color: Theme.of(context).listTileTheme.iconColor
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.addStaticLease,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 12 
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 12
                  ),
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
        ),
        Padding(
          padding: const EdgeInsets.all(24),
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
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}