// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dns_rewrites/add_dns_rewrite_modal.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/delete_dns_rewrite.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/rewrite_rules_provider.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class DnsRewritesScreen extends StatefulWidget {
  const DnsRewritesScreen({Key? key}) : super(key: key);

  @override
  State<DnsRewritesScreen> createState() => _DnsRewritesScreenState();
}

class _DnsRewritesScreenState extends State<DnsRewritesScreen> {
  @override
  void initState() {
    Provider.of<RewriteRulesProvider>(context, listen: false).fetchRules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rewriteRulesProvider = Provider.of<RewriteRulesProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void deleteDnsRewrite(RewriteRules rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.deleting);

      final result = await rewriteRulesProvider.deleteDnsRewrite(rule);

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleDeleted, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotDeleted, 
          color: Colors.red
        );
      }
    }

    void addDnsRewrite(RewriteRules rule) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.addingRewrite);

      final result = await rewriteRulesProvider.addDnsRewrite(rule);

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleAdded, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotAdded, 
          color: Colors.red
        );
      }
    }

    Widget generateBody() {
      switch (rewriteRulesProvider.loadStatus) {
        case LoadStatus.loading:
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              ],
            ),
          );
        
        case LoadStatus.loaded:
          if (rewriteRulesProvider.rewriteRules!.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                final result = await rewriteRulesProvider.fetchRules();
                if (result == false) {
                  showSnacbkar(
                    appConfigProvider: appConfigProvider,
                    label: AppLocalizations.of(context)!.rewriteRulesNotLoaded, 
                    color: Colors.red
                  );
                }
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: rewriteRulesProvider.rewriteRules!.length,
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
                                rewriteRulesProvider.rewriteRules![index].domain,
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
                                rewriteRulesProvider.rewriteRules![index].answer,
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
                              onConfirm: () => deleteDnsRewrite(rewriteRulesProvider.rewriteRules![index])
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
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }

        case LoadStatus.error:
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
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
        centerTitle: false,
      ),
      body: generateBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
            showDialog(
              context: context, 
              builder: (context) => AddDnsRewriteModal(
                onConfirm: addDnsRewrite,
                dialog: true,
              ),
            )
          }
          else {
            showModalBottomSheet(
              context: context, 
              builder: (context) => AddDnsRewriteModal(
                onConfirm: addDnsRewrite,
                dialog: false,
              ),
              backgroundColor: Colors.transparent,
              isScrollControlled: true
            )
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}