// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class CheckHostModal extends StatefulWidget {
  const CheckHostModal({Key? key}) : super(key: key);

  @override
  State<CheckHostModal> createState() => _CheckHostModalState();
}

class _CheckHostModalState extends State<CheckHostModal> {
  final TextEditingController domainController = TextEditingController();
  String? domainError;

  bool isChecking = false;

  Widget? resultWidget;

  void validateDomain(String value) {
    final domainRegex = RegExp(r'^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9]))\.([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}\.[a-zA-Z]{2,3})$');
    if (domainRegex.hasMatch(value)) {
      setState(() => domainError = null);
    }
    else {
      setState(() => domainError = AppLocalizations.of(context)!.domainNotValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    void checkHost() async {
      setState(() => isChecking = true);

      final result = await checkHostFiltered(server: serversProvider.selectedServer!, host: domainController.text);

      if (result['result'] == 'success') {
        final status = getFilteredStatus(context, result['data']['reason']);
        setState(() => resultWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status['icon'],
              size: 18,
              color: status['filtered'] == true
                ? Colors.red
                : Colors.green,
            ),
            const SizedBox(width: 10),
            Text(
              status['label'],
              style: TextStyle(
                color: status['filtered'] == true
                ? Colors.red
                : Colors.green,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ));
      }
      else {
        setState(() => resultWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cancel,
              size: 18,
              color: Colors.red,
            ),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.check,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ));
      }

      setState(() => isChecking = false);
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Stack(
        children: [
          AnimatedContainer(
            height: resultWidget != null
              ? 350
              : 310,
            width: double.maxFinite,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
              color: Theme.of(context).dialogBackgroundColor
            ),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Icon(
                      Icons.shield_rounded,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.checkHostFiltered,
                    style: const TextStyle(
                      fontSize: 24
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: domainController,
                      onChanged: validateDomain,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.link_rounded),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10)
                          )
                        ),
                        errorText: domainError,
                        labelText: AppLocalizations.of(context)!.domain,
                      ),
                    ),
                  ),
                  if (resultWidget != null) Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20
                    ),
                    child: resultWidget,
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
                                child: Text(AppLocalizations.of(context)!.close),
                              ),
                              const SizedBox(width: 20),
                              TextButton(
                                onPressed: checkHost, 
                                child: Text(AppLocalizations.of(context)!.check),
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
          ),
          AnimatedOpacity(
            opacity: isChecking == true ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: IgnorePointer(
              ignoring: isChecking == true ? false : true,
              child: Container(
                height: 310,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  color: Colors.black.withOpacity(0.8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context)!.checkingHost,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}