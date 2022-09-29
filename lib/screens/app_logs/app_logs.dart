// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:adguard_home_manager/screens/app_logs/app_log_details_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';

class AppLogs extends StatelessWidget {
  const AppLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void copyLogsClipboard() async {
      List<Map<String, String>> logsString = appConfigProvider.logs.map((log) => log.toMap()).toList();
      await Clipboard.setData(
        ClipboardData(text: jsonEncode(logsString))
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logs copied to the clipboard"),
          backgroundColor: Colors.black,
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Logs"),
        actions: [
          IconButton(
            onPressed: appConfigProvider.logs.isNotEmpty
              ? copyLogsClipboard
              : null, 
            icon: const Icon(Icons.share),
            tooltip: "Copy logs to clipboard",
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: appConfigProvider.logs.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemCount: appConfigProvider.logs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(appConfigProvider.logs[index].message),
            subtitle: Text(appConfigProvider.logs[index].dateTime.toString()),
            trailing: Text(appConfigProvider.logs[index].type),
            onTap: () => {
              showDialog(
                context: context, 
                builder: (context) => AppLogDetailsModal(
                  log: appConfigProvider.logs[index]
                )
              )
            },
          )
        )
      : const Center(
          child: Text(
            "No saved logs",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
        )
    );
  }
}