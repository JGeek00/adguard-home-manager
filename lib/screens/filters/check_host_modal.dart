// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
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

  Widget? resultWidget;

  void validateDomain(String value) {
    final domainRegex = RegExp(r'^([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
    if (domainRegex.hasMatch(value)) {
      setState(() => domainError = null);
    }
    else {
      setState(() => domainError = AppLocalizations.of(context)!.domainNotValid);
    }
  }

  Widget checking() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Text(AppLocalizations.of(context)!.checkingHost)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void checkHost() async {
      if (mounted) {
        setState(() => resultWidget = checking());

        final result = await checkHostFiltered(server: serversProvider.selectedServer!, host: domainController.text);

        if (result['result'] == 'success') {
          final status = getFilteredStatus(context, appConfigProvider, result['data']['reason'], true);
          if (mounted) {
            setState(() => resultWidget = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  status['icon'],
                  size: 18,
                  color: status['filtered'] == true
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red
                    : appConfigProvider.useThemeColorForStatus
                      ? Theme.of(context).primaryColor
                      : Colors.green,
                ),
                const SizedBox(width: 10),
                Text(
                  status['label'],
                  style: TextStyle(
                    color: status['filtered'] == true
                      ? appConfigProvider.useThemeColorForStatus == true
                        ? Colors.grey
                        : Colors.red
                      : appConfigProvider.useThemeColorForStatus
                        ? Theme.of(context).primaryColor
                        : Colors.green,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ));
          }
        }
        else {
          if (mounted) {
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
        }
      }
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 330,
        width: double.maxFinite,
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
              Expanded(
                child: ListView(
                  physics: 350 < MediaQuery.of(context).size.height
                    ? const NeverScrollableScrollPhysics() 
                    : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Icon(
                        Icons.shield_rounded,
                        size: 24,
                        color: Theme.of(context).listTileTheme.iconColor
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.checkHostFiltered,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    if (resultWidget == null) Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.insertDomain,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 24,
                      right: 24
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)!.close),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: domainController.text != '' && domainError == null
                            ? () => checkHost()
                            : null, 
                          child: Text(
                            AppLocalizations.of(context)!.check,
                            style: TextStyle(
                              color: domainController.text != '' && domainError == null
                                ? Theme.of(context).primaryColor
                                : Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}