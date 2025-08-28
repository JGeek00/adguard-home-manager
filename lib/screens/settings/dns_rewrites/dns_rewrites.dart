// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/screens/settings/dns_rewrites/delete_dns_rewrite.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/dns_rewrite_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/rewrite_rules_provider.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';

class DnsRewritesScreen extends StatefulWidget {
  const DnsRewritesScreen({super.key});

  @override
  State<DnsRewritesScreen> createState() => _DnsRewritesScreenState();
}

class _DnsRewritesScreenState extends State<DnsRewritesScreen> {
  late bool isVisible;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<RewriteRulesProvider>(context, listen: false).fetchRules();
    super.initState();

    isVisible = true;
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rewriteRulesProvider = Provider.of<RewriteRulesProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void deleteDnsRewrite(RewriteRules rule) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.deleting);

      final result = await rewriteRulesProvider.deleteDnsRewrite(rule);

      processModal.close();

      if (result == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleDeleted, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotDeleted, 
          color: Colors.red
        );
      }
    }

    void addDnsRewrite(RewriteRules rule, _) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.addingRewrite);

      final result = await rewriteRulesProvider.addDnsRewrite(rule);

      processModal.close();

      if (result == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleAdded, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotAdded, 
          color: Colors.red
        );
      }
    }

    void updateRewriteRule(RewriteRules newRule, RewriteRules? previousRule) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updatingRule);

      final result = await rewriteRulesProvider.editDnsRewrite(newRule, previousRule!);

      processModal.close();

      if (result == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.dnsRewriteRuleNotUpdated, 
          color: Colors.red
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dnsRewrites),
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Builder(
              builder: (context) {
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
                            textAlign: TextAlign.center,
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
                            showSnackbar(
                              appConfigProvider: appConfigProvider,
                              label: AppLocalizations.of(context)!.rewriteRulesNotLoaded, 
                              color: Colors.red
                            );
                          }
                        },
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.only(top: 0),
                          itemCount: rewriteRulesProvider.rewriteRules!.length,
                          itemBuilder: (context, index) => Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: InkWell(
                              onTap: () => {
                                if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
                                  showDialog(
                                    context: context, 
                                    builder: (context) => DnsRewriteModal(
                                      onConfirm: updateRewriteRule,
                                      dialog: true,
                                      rule: rewriteRulesProvider.rewriteRules![index],
                                      onDelete: (rule) => showDialog(
                                        context: context, 
                                        builder: (context) => DeleteDnsRewrite(
                                          onConfirm: () => deleteDnsRewrite(rule)
                                        )
                                      ),
                                    ),
                                  )
                                }
                                else {
                                  showModalBottomSheet(
                                    context: context, 
                                    useRootNavigator: true,
                                    builder: (context) => DnsRewriteModal(
                                      onConfirm: updateRewriteRule,
                                      dialog: false,
                                      rule: rewriteRulesProvider.rewriteRules![index],
                                      onDelete: (rule) => showDialog(
                                        context: context, 
                                        builder: (context) => DeleteDnsRewrite(
                                          onConfirm: () => deleteDnsRewrite(rule)
                                        )
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                  )
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16, top: 16, bottom: 16, right: 8
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
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    )
                                  ],
                                ),
                              ),
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
                            textAlign: TextAlign.center,
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
              },
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                  : -70,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => {
                    if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
                      showDialog(
                        context: context, 
                        builder: (context) => DnsRewriteModal(
                          onConfirm: addDnsRewrite,
                          dialog: true,
                          onDelete: (rule) => showDialog(
                            context: context, 
                            builder: (context) => DeleteDnsRewrite(
                              onConfirm: () => deleteDnsRewrite(rule)
                            )
                          ),
                        ),
                      )
                    }
                    else {
                      showModalBottomSheet(
                        context: context, 
                        useRootNavigator: true,
                        builder: (context) => DnsRewriteModal(
                          onConfirm: addDnsRewrite,
                          dialog: false,
                          onDelete: (rule) => showDialog(
                            context: context, 
                            builder: (context) => DeleteDnsRewrite(
                              onConfirm: () => deleteDnsRewrite(rule)
                            )
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true
                      )
                    }
                  },
                  child: const Icon(Icons.add),
                ),
            )
          ],
        ),
      ),
    );
  }
}