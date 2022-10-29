import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DownloadModal extends StatefulWidget {
  final String url;
  final String version;
  final void Function(String) onFinish;

  const DownloadModal({
    Key? key,
    required this.url,
    required this.version,
    required this.onFinish,
  }) : super(key: key);

  @override
  State<DownloadModal> createState() => _DownloadModalState();
}

class _DownloadModalState extends State<DownloadModal> {
  int progress = 0;
  String? status;
  late StreamSubscription progressStream;

  void removeOldInstallers()  {
    final downloads = Directory('/storage/emulated/0/Download').listSync();
    final installers = downloads.where((file) => file.path.contains('adguard-home-manager'));
    for (FileSystemEntity installer in installers) {
      if (installer.existsSync()) {
        installer.deleteSync();
      }
    }
  }

  @override
  void initState() {
    removeOldInstallers();

    FlDownloader.initialize();
    progressStream = FlDownloader.progressStream.listen((event) {
      if (event.status == DownloadStatus.successful) {
        setState(() => progress = event.progress); 
        Navigator.pop(context);
        widget.onFinish(event.filePath!);
      }
      else if (event.status == DownloadStatus.running) {
        print(event.progress);
        setState(() {
          progress = event.progress;
          status = null;
        });
      }
      else if (event.status == DownloadStatus.paused) {
        setState(() => status == "Paused");
      }
      else if (event.status == DownloadStatus.pending) {
        setState(() => status == "Pending");
      }
      else if (event.status == DownloadStatus.failed) {
        setState(() => status == "Failed");
      }
      else if (event.status == DownloadStatus.canceling) {
        setState(() => status == "Canceling");
      }
    });

    FlDownloader.download(widget.url, fileName: 'adguard-home-manager_v${widget.version}.apk');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    progressStream.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${AppLocalizations.of(context)!.downloadingUpdate}..."),
      titlePadding: const EdgeInsets.only(
        left: 24, right: 24, top: 24, bottom: 10,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearPercentIndicator(
            animation: true,
            lineHeight: 4,
            animationDuration: 500,
            curve: Curves.easeOut,
            percent: progress/100,
            animateFromLastPercent: true,
            barRadius: const Radius.circular(5),
            progressColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  status != null
                    ? status!
                    : "$progress% ${AppLocalizations.of(context)!.completed}"),
              )
            ],
          )
        ],
      ),
    );
  }
}