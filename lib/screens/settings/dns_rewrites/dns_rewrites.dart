// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dns_rewrites/add_dns_rewrite_modal.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/delete_dns_rewrite.dart';

import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

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
  Future fetchData() async {
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
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void deleteDnsRewrite(RewriteRulesData rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.deleting);

      final result = await deleteDnsRewriteRule(server: serversProvider.selectedServer!, data: {
        "domain": rule.domain,
        "answer": rule.answer
      });

      processModal.close();

      if (result['result'] == 'success') {
        List<RewriteRulesData> data = serversProvider.rewriteRules.data!;
        data = data.where((item) => item.domain != rule.domain).toList();
        serversProvider.setRewriteRulesData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleDeleted, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotDeleted, 
          color: Colors.red
        );
      }
    }

    void addDnsRewrite(RewriteRulesData rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingRewrite);

      final result = await addDnsRewriteRule(server: serversProvider.selectedServer!, data: {
        "domain": rule.domain,
        "answer": rule.answer
      });

      processModal.close();

      if (result['result'] == 'success') {
        List<RewriteRulesData> data = serversProvider.rewriteRules.data!;
        data.add(rule);
        serversProvider.setRewriteRulesData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleAdded, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotAdded, 
          color: Colors.red
        );
      }
    }

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
            return RefreshIndicator(
              onRefresh: () async {
                await fetchData();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: serversProvider.rewriteRules.data!.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2)
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSurface
                                ),
                              ),
                              Text(
                                serversProvider.rewriteRules.data![index].domain,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.answer}: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSurface
                                ),
                              ),
                              Text(
                                serversProvider.rewriteRules.data![index].answer,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => {
                          showDialog(
                            context: context, 
                            builder: (context) => DeleteDnsRewrite(
                              onConfirm: () => deleteDnsRewrite(serversProvider.rewriteRules.data![index])
                            )
                          )
                        }, 
                        icon: const Icon(Icons.delete)
                      )
                    ],
                  ),
                )
              ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () => {
          showModalBottomSheet(
            context: context, 
            builder: (context) => AddDnsRewriteModal(
              onConfirm: addDnsRewrite,
            ),
            backgroundColor: Colors.transparent,
            isScrollControlled: true
          )
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
        ),
      ),
    );
  }
}