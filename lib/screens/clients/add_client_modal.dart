import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddClientModal extends StatefulWidget {
  final String list;
  final void Function(String, String) onConfirm;

  const AddClientModal({
    Key? key,
    required this.list,
    required this.onConfirm
  }) : super(key: key);

  @override
  State<AddClientModal> createState() => _AddClientModalState();
}

class _AddClientModalState extends State<AddClientModal> {
  String list = '';

  TextEditingController ipController = TextEditingController();
  String? ipError;

  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

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
      (list == 'allowed' ||
      list == 'blocked') &&
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
    return AlertDialog(
      title: Column(
        children: [
          const Icon(
            Icons.add,
            size: 26,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.addClient,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                      ),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                      ),
                  onTap: () => setState(() => list = 'allowed'),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                      ),
                      border: Border.all(
                        color: Theme.of(context).primaryColor
                      ),
                      color: list == 'allowed'  
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.05)
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.allowed,
                      style: TextStyle(
                        color: list == 'allowed'  
                          ? Colors.white
                          : null
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                ),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  ),
                  onTap: () => setState(() => list = 'blocked'),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                      ),
                      border: Border.all(
                        color: Theme.of(context).primaryColor
                      ),
                      color: list == 'blocked'  
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.05)
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.blocked,
                      style: TextStyle(
                        color: list == 'blocked'  
                          ? Colors.white
                          : null
                      ),
                    ),
                  ),
                ),
              )
            ],
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
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: checkValidValues() == true
            ? () {
                Navigator.pop(context);
                widget.onConfirm(list, ipController.text);
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
    );
  }
}