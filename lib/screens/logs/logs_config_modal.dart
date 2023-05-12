import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/functions/compare_versions.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class LogsConfigModal extends StatelessWidget {
  final void Function(Map<String, dynamic>) onConfirm;
  final void Function() onClear;
  final bool dialog;
  final String serverVersion;

  const LogsConfigModal({
    Key? key,
    required this.onConfirm,
    required this.onClear,
    required this.dialog,
    required this.serverVersion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return LogsConfigModalWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
      context: context,
      onConfirm: onConfirm,
      onClear: onClear,
      dialog: dialog,
      serverVersion: serverVersion,
    );
  }
}

class LogsConfigModalWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;
  final BuildContext context;
  final void Function(Map<String, dynamic>) onConfirm;
  final void Function() onClear;
  final bool dialog;
  final String serverVersion;

  const LogsConfigModalWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider,
    required this.context,
    required this.onConfirm,
    required this.onClear,
    required this.dialog,
    required this.serverVersion
  }) : super(key: key);

  @override
  State<LogsConfigModalWidget> createState() => _LogsConfigModalWidgetState();
}

class _LogsConfigModalWidgetState extends State<LogsConfigModalWidget> {
  bool generalSwitch = false;
  bool anonymizeClientIp = false;
  String? retentionTime = "";

  List<Map<String, dynamic>> retentionItems = [];

  int loadStatus = 0;

  void loadData() async {
    final result = serverVersionIsAhead(
      currentVersion: widget.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    ) == true 
      ? await getQueryLogInfo(server: widget.serversProvider.selectedServer!)
      : await getQueryLogInfoLegacy(server: widget.serversProvider.selectedServer!);

    if (mounted) {
      if (result['result'] == 'success') {
        setState(() {
          generalSwitch = result['data']['enabled'];
          anonymizeClientIp = result['data']['anonymize_client_ip'];
          retentionTime = result['data']['interval'].toString();
          loadStatus = 1;
        });
      }
      else {
        setState(() => loadStatus = 2);
      }
    }
  }

  @override
  void initState() {
    retentionItems = serverVersionIsAhead(
      currentVersion: widget.serverVersion, 
      referenceVersion: 'v0.107.28',
      referenceVersionBeta: 'v0.108.0-b.33'
    ) == true ? [
      {
        'label': AppLocalizations.of(widget.context)!.hours6,
        'value': 21600000
      },
      {
        'label': AppLocalizations.of(widget.context)!.hours24,
        'value': 86400000
      },
      {
        'label': AppLocalizations.of(widget.context)!.days7,
        'value': 604800000
      },
      {
        'label': AppLocalizations.of(widget.context)!.days30,
        'value': 2592000000
      },
      {
        'label': AppLocalizations.of(widget.context)!.days90,
        'value': 7776000000
      },
    ] : [
      {
        'label': AppLocalizations.of(widget.context)!.hours6,
        'value': 0.25
      },
      {
        'label': AppLocalizations.of(widget.context)!.hours24,
        'value': 1
      },
      {
        'label': AppLocalizations.of(widget.context)!.days7,
        'value': 7
      },
      {
        'label': AppLocalizations.of(widget.context)!.days30,
        'value': 30
      },
      {
        'label': AppLocalizations.of(widget.context)!.days90,
        'value': 90
      },
    ];

    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget generateBody() {
      switch (loadStatus) {
        case 0:
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    AppLocalizations.of(context)!.loadingLogsSettings,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  ),
                )
              ],
            ),
          );

        case 1:
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
                                  Icons.settings,
                                  size: 24,
                                  color: Theme.of(context).listTileTheme.iconColor
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(context)!.logsSettings,
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
                        child: Material(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(28),
                          child: InkWell(
                            onTap: () => setState(() => generalSwitch = !generalSwitch),
                            borderRadius: BorderRadius.circular(28),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.enableLog,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Switch(
                                    value: generalSwitch, 
                                    onChanged: (value) => setState(() => generalSwitch = value),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => setState(() => anonymizeClientIp = !anonymizeClientIp),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.anonymizeClientIp,
                                        style: const TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Switch(
                                        value: anonymizeClientIp, 
                                        onChanged: (value) => setState(() => anonymizeClientIp = value),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: DropdownButtonFormField(
                                items: retentionItems.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
                                  return DropdownMenuItem<String>(
                                    value: item['value'].toString(),
                                    child: Text(item['label']),
                                  );
                                }).toList(),
                                value: retentionTime,
                                onChanged: (value) => setState(() => retentionTime = value),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10)
                                    )
                                  ),
                                  label: Text(AppLocalizations.of(context)!.retentionTime)
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onClear();
                      }, 
                      child: Text(AppLocalizations.of(context)!.clearLogs)
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: Text(AppLocalizations.of(context)!.cancel)
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: retentionTime != ''
                            ? () {
                              Navigator.pop(context);
                              widget.onConfirm({
                                "enabled": generalSwitch,
                                "interval": double.parse(retentionTime!),
                                "anonymize_client_ip": anonymizeClientIp
                              });
                            }
                            : null, 
                          child: Text(
                            AppLocalizations.of(context)!.confirm,
                            style: TextStyle(
                              color: retentionTime != ''
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey
                            ),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (Platform.isIOS) const SizedBox(height: 16)
            ],
          );

        case 2:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocalizations.of(context)!.logSettingsNotLoaded,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                  ),
                ),
              )
            ],
          );

        default:
          return const SizedBox();
      }
    }

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: generateBody()
        ),
      );
    }
    else {
      return Container(
        height: Platform.isIOS ? 436 : 420,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28)
          ),
          color: Theme.of(context).dialogBackgroundColor
        ),
        child: generateBody()
      );
    }
  }
}