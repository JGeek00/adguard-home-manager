import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class DnsRewrites extends StatelessWidget {
  const DnsRewrites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return DnsRewritesWidget(
      serversProvider: serversProvider,
      appConfigProvider: appConfigProvider,
    );
  }
}

class DnsRewritesWidget extends StatefulWidget {
  final ServersProvider serversProvider;
  final AppConfigProvider appConfigProvider;

  const DnsRewritesWidget({
    Key? key,
    required this.serversProvider,
    required this.appConfigProvider
  }) : super(key: key);

  @override
  State<DnsRewritesWidget> createState() => _DnsRewritesWidgetState();
}

class _DnsRewritesWidgetState extends State<DnsRewritesWidget> {
  void fetchData() async {
    widget.serversProvider.setRewriteRulesLoadStatus(0, false);

    final result = await getDnsRewriteRules(server: widget.serversProvider.selectedServer!);

    if (result['result'] == 'success') {
      widget.serversProvider.setRewriteRulesData(result['data']);
      widget.serversProvider.setRewriteRulesLoadStatus(1, true);
    }
    else {
      widget.appConfigProvider.addLog(result['log']);
      widget.serversProvider.setRewriteRulesLoadStatus(2, true);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);

    Widget generateBody() {
      switch (serversProvider.rewriteRules.loadStatus) {
        case 0:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.loadingRewriteRules,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
        
        case 1:
          if (serversProvider.rewriteRules.data!.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: serversProvider.rewriteRules.data!.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200
                    )
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.domain}: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              serversProvider.rewriteRules.data![index].domain,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.answer}: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              serversProvider.rewriteRules.data![index].answer,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => {}, 
                      icon: const Icon(Icons.delete)
                    )
                  ],
                ),
              )
            );
          }
          else {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noRewriteRules,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              ),
            );
          }

        case 2:
          return SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.rewriteRulesNotLoaded,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );

        default:
          return const SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsRewrites),
      ),
      body: generateBody(),
    );
  }
}