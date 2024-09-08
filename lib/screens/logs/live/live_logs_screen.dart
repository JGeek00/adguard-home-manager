import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/logs/details/log_details_screen.dart';
import 'package:adguard_home_manager/screens/logs/log_tile.dart';

import 'package:adguard_home_manager/providers/live_logs_provider.dart';

class LiveLogsScreen extends StatefulWidget {
  const LiveLogsScreen({super.key});

  @override
  State<LiveLogsScreen> createState() => _LiveLogsScreenState();
}

class _LiveLogsScreenState extends State<LiveLogsScreen> {
  @override
  void initState() {
    Provider.of<LiveLogsProvider>(context, listen: false).startFetchLogs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final liveLogsProvider = Provider.of<LiveLogsProvider>(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar.large(
              title: Text(AppLocalizations.of(context)!.liveLogs),
            )
          )
        ],
        body: SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                if (liveLogsProvider.logs.isEmpty) SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.hereWillAppearRealtimeLogs,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 24
                        ),
                      ),
                    ),
                  ),
                ),
                if (liveLogsProvider.logs.isNotEmpty) SliverList.builder(
                  itemCount: liveLogsProvider.logs.length,
                  itemBuilder: (context, index) => LogTile(
                    log: liveLogsProvider.logs[index], 
                    length: liveLogsProvider.logs.length, 
                    index: index, 
                    onLogTap: (log) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogDetailsScreen(
                            log: log,
                            dialog: false,
                          )
                        )
                      );
                    },
                    twoColumns: false
                  ),
                )
              ],
            ),
          ) 
        )
      ),
    );
  }
}