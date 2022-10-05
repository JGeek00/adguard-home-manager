import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlockClientModal extends StatefulWidget {
  final void Function(String) onConfirm;

  const BlockClientModal({
    Key? key,
    required this.onConfirm
  }) : super(key: key);

  @override
  State<BlockClientModal> createState() => _BlockClientModalState();
}

class _BlockClientModalState extends State<BlockClientModal> {
  TextEditingController ipController = TextEditingController();
  String? ipError;

  void validateIp(String value) {
    RegExp ipAddress = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)(\.(?!$)|$)){4}$');
    if (ipAddress.hasMatch(value) == true) {
      setState(() => ipError = null);
    }
    else {
      setState(() => ipError = AppLocalizations.of(context)!.ipNotValid);
    }
  }

  bool checkValidValues() {
    if (
      ipController.text != '' &&
      ipError == null
    ) {
      return true;
    }
    else {
      return false;
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 322,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          )
        ),
        child: Column(
          children: [
            const Icon(
              Icons.block,
              size: 26,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.blockClient,
              style: const TextStyle(
                fontSize: 24
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: ipController,
              onChanged: validateIp,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.link_rounded),
                errorText: ipError,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                labelText: AppLocalizations.of(context)!.ipAddress,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)!.cancel)
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: checkValidValues() == true
                            ? () {
                                Navigator.pop(context);
                                widget.onConfirm(ipController.text);
                              }
                            : null, 
                          child: Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                              color: checkValidValues() == true
                                ? Theme.of(context).primaryColor
                                : Colors.grey
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}