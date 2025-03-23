import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html;
import 'package:markdown/markdown.dart' as md;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/functions/open_url.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

const _minExent = 64.0;
const _maxExent = 240.0;

const _iconMaxBottomPositionExent = 130.0;
const _iconMinBottomPositionExent = 34.0;

const _textMaxBottomPositionExent = 70.0;
const _textMinBottomPositionExent = 16.0;

const _versionTextMaxBottomPositionExent = 30.0;
const _versionTextMinBottomPositionExent = 0.0;

const _textMaxFontSize = 24.0;
const _textMinFontSize = 22.0;

const _iconSafetyMargin = 15.0;

const _iconSize = 45.0;

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _scrollController = ScrollController();
  bool _isScrolled = false;

  String? _htmlChangelog;

  void processChangelog() async {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    if (serversProvider.updateAvailable.data?.changelog == null) return;
    final markdownResult = await compute(md.markdownToHtml, serversProvider.updateAvailable.data!.changelog!);
    final htmlParsedResult = await compute(html.parse, markdownResult);
    setState(() => _htmlChangelog = htmlParsedResult.outerHtml);
  }

  @override
  void initState() {
    final serversProvider = Provider.of<ServersProvider>(context, listen: false);
    _scrollController.addListener(() {
      final newValue = _scrollController.offset > 20;
      if (!(
        serversProvider.updatingServer == false &&
        serversProvider.updateAvailable.data!.canAutoupdate != null && 
        serversProvider.updateAvailable.data!.canAutoupdate == true
      )) return;
      if (_isScrolled == newValue) return;
      setState(() => _isScrolled = newValue);
    });

    processChangelog();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void update() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.requestingUpdate);

      final result = await serversProvider.apiClient2!.requestUpdateServer();

      processModal.close();
      
      if (!context.mounted) return;
      if (result.successful == true) {
        serversProvider.recheckPeriodServerUpdated();
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateSuccessful,
          color: Colors.green,
          labelColor: Colors.white,
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider, 
          label: AppLocalizations.of(context)!.requestStartUpdateFailed,
          color: Colors.red,
          labelColor: Colors.white,
        );
      }
    }  

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _Header(
                    onRefresh: () => serversProvider.checkServerUpdatesAvailable(
                      server: serversProvider.selectedServer!,
                    ),
                    viewPaddingTop: MediaQuery.of(context).viewPadding.top
                  )
                ),
                SliverList.list(
                  children: [
                    const SizedBox(height: 16),
                     if (_htmlChangelog != null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Changelog ${serversProvider.updateAvailable.data!.canAutoupdate == true 
                          ? serversProvider.updateAvailable.data!.newVersion
                          : serversProvider.updateAvailable.data!.currentVersion}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        ),
                      ),
                    ),
                    if (_htmlChangelog != null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Html(
                        data: _htmlChangelog,
                        onLinkTap: (url, context, attributes) => url != null ? openUrl(url) : null,
                      )
                    ),
                    if (_htmlChangelog == null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)!.loadingChangelog,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSurfaceVariant
                            ),
                          )
                        ],
                      )
                    ),
                  ]
                )
              ],
            ),
            if (
              serversProvider.updatingServer == false &&
              serversProvider.updateAvailable.data!.canAutoupdate != null && 
              serversProvider.updateAvailable.data!.canAutoupdate == true
            ) AnimatedPositioned(
              right: 20,
              bottom: _isScrolled ? -70 : 20, 
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              child: FloatingActionButton(
                onPressed: () => update(),
                tooltip: AppLocalizations.of(context)!.updateNow,
                child: const Icon(Icons.download_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends SliverPersistentHeaderDelegate {
  final void Function() onRefresh;
  final double viewPaddingTop;

  const _Header({
    required this.onRefresh,
    required this.viewPaddingTop,
  });
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final serversProvider = Provider.of<ServersProvider>(context);

    final iconMaxBottomPositionExent = _iconMaxBottomPositionExent + viewPaddingTop;
    final iconMinBottomPositionExent = _iconMinBottomPositionExent + viewPaddingTop;
    final textMaxBottomPositionExent = _textMaxBottomPositionExent + viewPaddingTop;
    final textMinBottomPositionExent = _textMinBottomPositionExent + viewPaddingTop;
    final versionTextMaxBottomPositionExent = _versionTextMaxBottomPositionExent + viewPaddingTop;
    final versionTextMinBottomPositionExent = _versionTextMinBottomPositionExent + viewPaddingTop;

    final iconPercentage = shrinkOffset.clamp(0, _maxExent-_minExent-_iconSafetyMargin)/(_maxExent-_minExent-_iconSafetyMargin);
    final textPercentage = shrinkOffset.clamp(0, _maxExent-_minExent)/(_maxExent-_minExent);

    final textFontSize = _textMinFontSize + (_textMaxFontSize-_textMinFontSize)*(1-textPercentage);
    final mainText = _textMinBottomPositionExent + (textMaxBottomPositionExent-textMinBottomPositionExent)*(1-textPercentage);
    final versionText = _versionTextMinBottomPositionExent + (versionTextMaxBottomPositionExent-versionTextMinBottomPositionExent)*(1-textPercentage);

    final iconBottom = _iconMinBottomPositionExent + (iconMaxBottomPositionExent-iconMinBottomPositionExent)*(1-iconPercentage);

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint.withOpacity(0.075),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                bottom: false,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    if (Navigator.of(context).canPop()) Positioned(
                      top: 8,
                      left: 0,
                      child: BackButton(
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 0,
                      child: IconButton(
                        onPressed: onRefresh,
                        icon: const Icon(Icons.refresh_rounded),
                        tooltip: AppLocalizations.of(context)!.refresh,
                      )
                    ),
                    Positioned(
                      bottom: iconBottom,
                      left: (constraints.maxWidth/2)-(_iconSize/2),
                      child: Opacity(
                        opacity: 1-iconPercentage,
                        child: serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                          ? const Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 4)
                              ],
                            )
                          : Icon(
                              serversProvider.updateAvailable.data!.canAutoupdate == true
                                ? Icons.system_update_rounded
                                : Icons.system_security_update_good_rounded,
                              size: _iconSize,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    Positioned(
                      bottom: mainText,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth-100
                        ),
                        child: Text(
                          serversProvider.updateAvailable.loadStatus == LoadStatus.loading
                            ? AppLocalizations.of(context)!.checkingUpdates
                            : serversProvider.updateAvailable.data!.canAutoupdate == true
                              ? AppLocalizations.of(context)!.updateAvailable
                              :  AppLocalizations.of(context)!.serverUpdated,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      )
                    ),
                    Positioned(
                      bottom: versionText,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth-100
                        ),
                        child: Opacity(
                          opacity: 1-iconPercentage,
                          child: Text(
                            serversProvider.updateAvailable.data!.canAutoupdate == true
                              ? "${AppLocalizations.of(context)!.newVersion}: ${serversProvider.updateAvailable.data!.newVersion ?? 'N/A'}"
                              : "${AppLocalizations.of(context)!.installedVersion}: ${serversProvider.updateAvailable.data!.currentVersion}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurfaceVariant
                            ),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  double get maxExtent => _maxExent + viewPaddingTop;
  
  @override
  double get minExtent => _minExent + viewPaddingTop;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}