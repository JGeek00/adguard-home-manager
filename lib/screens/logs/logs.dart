// ignore_for_file: use_build_context_synchronously

import 'package:adguard_home_manager/models/logs.dart';
import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/logs/logs_list.dart';
import 'package:adguard_home_manager/screens/logs/log_details_screen.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  Log? _selectedLog;

  @override
  Widget build(BuildContext context) {
   

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: LogsListWidget(
                    twoColumns: true,
                    selectedLog: _selectedLog,
                    onLogSelected: (log) => setState(() => _selectedLog = log),
                  )
                ),
                Expanded(
                  flex: 3,
                  child: _selectedLog != null
                    ? LogDetailsScreen(
                        log: _selectedLog!,
                        dialog: false,
                      )
                    : const SizedBox()
                )
              ],
            ),
          );
        }
        else {
          return LogsListWidget(
            twoColumns: false,
            selectedLog: _selectedLog,
            onLogSelected: (log) => setState(() => _selectedLog = log),
          );
        }
      },
    );
  }
}