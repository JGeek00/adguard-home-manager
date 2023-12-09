// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dhcp/delete_static_lease_modal.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/add_static_lease_modal.dart';

import 'package:adguard_home_manager/providers/dhcp_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpLeases extends StatelessWidget {
  final List<Lease> items;
  final bool staticLeases;

  const DhcpLeases({
    super.key,
    required this.items,
    required this.staticLeases,
  });

  @override
  Widget build(BuildContext context) {
    final dhcpProvider = Provider.of<DhcpProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    void deleteLease(Lease lease) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.deleting);

      final result = await dhcpProvider.deleteLease(lease);

      processModal.close();

      if (result == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseDeleted, 
          color: Colors.green
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseNotDeleted, 
          color: Colors.red
        );
      }
    }

    void createLease(Lease lease) async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.creating);

      final result = await dhcpProvider.createLease(lease);

      processModal.close();

      if (result.successful == true) {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseCreated, 
          color: Colors.green
        );
      }
      else if (result.successful == false && result.content == "already_exists") {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseExists, 
          color: Colors.red
        );
      }
      else if (result.successful == false && result.content == "server_not_configured") {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.serverNotConfigured, 
          color: Colors.red
        );
      }
      else {
        showSnacbkar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseNotCreated, 
          color: Colors.red
        );
      }
    }

    void openAddStaticLease() {
      if (width > 900 || !(Platform.isAndroid || Platform.isIOS)) {
        showDialog(
          context: context, 
          builder: (context) => AddStaticLeaseModal(
            onConfirm: createLease,
            dialog: true,
          ),
        );
      }
      else {
        showModalBottomSheet(
          context: context, 
          useRootNavigator: true,
          builder: (context) => AddStaticLeaseModal(
            onConfirm: createLease,
            dialog: false,
          ),
          backgroundColor: Colors.transparent,
          isScrollControlled: true
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
        title: Text(
          staticLeases == true
            ? AppLocalizations.of(context)!.dhcpStatic
            : AppLocalizations.of(context)!.dhcpLeases,
        ),
      ),
      body: items.isNotEmpty
        ? SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                isThreeLine: true,
                title: Text(items[index].ip),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[index].mac),
                    Text(items[index].hostname),
                  ],
                ),
                trailing: staticLeases == true
                  ? IconButton(
                      onPressed: () {
                        showModal(
                          context: context,
                          builder: (context) => DeleteStaticLeaseModal(
                            onConfirm: () => deleteLease(items[index])
                          )
                        );
                      }, 
                      icon: const Icon(Icons.delete)
                    )
                  : null,
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                staticLeases == true
                  ? AppLocalizations.of(context)!.noDhcpStaticLeases
                  : AppLocalizations.of(context)!.noLeases,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 22
                ),
              ),
            ),
          ),
      floatingActionButton: staticLeases == true
        ? FloatingActionButton(
            onPressed: openAddStaticLease,
            child: const Icon(Icons.add),
          )
        : null,
    );
  }
}