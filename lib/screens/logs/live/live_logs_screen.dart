import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adguard_home_manager/screens/logs/details/log_details_screen.dart';
import 'package:adguard_home_manager/screens/logs/live/live_logs_list.dart';

import 'package:adguard_home_manager/models/logs.dart';
import 'package:adguard_home_manager/providers/live_logs_provider.dart';

class LiveLogsScreen extends StatefulWidget {
  const LiveLogsScreen({super.key});

  @override
  State<LiveLogsScreen> createState() => _LiveLogsScreenState();
}

class _LiveLogsScreenState extends State<LiveLogsScreen> {
  Log? _selectedLog;

  @override
  void initState() {
    Provider.of<LiveLogsProvider>(context, listen: false).startFetchLogs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: LiveLogsList(
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
                          twoColumns: true,
                        )
                      : const SizedBox()
                  )
                ],
              ),
            );
          }
          else {
            return LiveLogsList(
              twoColumns: false,
              selectedLog: _selectedLog,
              onLogSelected: (log) => setState(() => _selectedLog = log),
            );
          }
        },
           ),
     );
  }
}