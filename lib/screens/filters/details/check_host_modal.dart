// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/constants/regexps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/get_filtered_status.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class CheckHostModal extends StatelessWidget {
  final bool dialog;

  const CheckHostModal({
    super.key,
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
          child: const _Content()
        ),
      );
    }
    else {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            color: Theme.of(context).dialogBackgroundColor
          ),
          child: const SafeArea(
            child: _Content()
          )
        ),
      );
    }
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController domainController = TextEditingController();
  String? domainError;

  Widget? resultWidget;

  void validateDomain(String value) {
    if (Regexps.domain.hasMatch(value)) {
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
      setState(() => resultWidget = checking());

      final result = await serversProvider.apiClient2!.checkHostFiltered(host: domainController.text);
      if (!mounted) return;

      if (result.successful == true) {
        final status = getFilteredStatus(context, appConfigProvider, result.content['reason'], true);
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
                    ? Theme.of(context).colorScheme.primary
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
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green,
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ));
        }
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
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
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
                      ],
                    ),
                  ],
                ),
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
                  padding: const EdgeInsets.all(24),
                  child: resultWidget,
                ),
                if (resultWidget == null) Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.insertDomain,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                          ? Theme.of(context).colorScheme.primary
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
    );
  }
}