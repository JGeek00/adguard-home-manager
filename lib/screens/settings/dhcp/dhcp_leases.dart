// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/dhcp/delete_static_lease_modal.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/add_static_lease_modal.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/services/http_requests.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/models/dhcp.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';

class DhcpLeases extends StatefulWidget {
  final List<Lease> items;
  final bool staticLeases;

  const DhcpLeases({
    Key? key,
    required this.items,
    required this.staticLeases,
  }) : super(key: key);

  @override
  State<DhcpLeases> createState() => _DhcpLeasesState();
}

class _DhcpLeasesState extends State<DhcpLeases> {
  late bool isVisible;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
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
    final serversProvider = Provider.of<ServersProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void deleteLease(Lease lease) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.deleting);

      final result = await deleteStaticLease(server: serversProvider.selectedServer!, data: {
        "mac": lease.mac,
        "ip": lease.ip,
        "hostname": lease.hostname
      });

      processModal.close();

      if (result['result'] == 'success') {
        DhcpData data = serversProvider.dhcp.data!;
        data.dhcpStatus.staticLeases = data.dhcpStatus.staticLeases.where((l) => l.mac != lease.mac).toList();
        serversProvider.setDhcpData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseDeleted, 
          color: Colors.green
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseNotDeleted, 
          color: Colors.red
        );
      }
    }

    void createLease(Lease lease) async {
      ProcessModal processModal = ProcessModal(context: context);
      processModal.open(AppLocalizations.of(context)!.creating);

      final result = await createStaticLease(server: serversProvider.selectedServer!, data: {
        "mac": lease.mac,
        "ip": lease.ip,
        "hostname": lease.hostname,
      });

      processModal.close();

      if (result['result'] == 'success') {
        DhcpData data = serversProvider.dhcp.data!;
        data.dhcpStatus.staticLeases.add(lease);
        serversProvider.setDhcpData(data);

        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseCreated, 
          color: Colors.green
        );
      }
      else if (result['result'] == 'error' && result['message'] == 'already_exists' ) {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseExists, 
          color: Colors.red
        );
      }
      else if (result['result'] == 'error' && result['message'] == 'server_not_configured' ) {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.serverNotConfigured, 
          color: Colors.red
        );
      }
      else {
        appConfigProvider.addLog(result['log']);
        showSnacbkar(
          context: context, 
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.staticLeaseNotCreated, 
          color: Colors.red
        );
      }
    }

    void openAddStaticLease() {
      showModalBottomSheet(
        context: context, 
        builder: (context) => AddStaticLeaseModal(
          onConfirm: createLease
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar.large(
                    title: Text(
                      widget.staticLeases == true
                        ? AppLocalizations.of(context)!.dhcpStatic
                        : AppLocalizations.of(context)!.dhcpLeases,
                    ),
                  ),
                ),
              )
            ], 
            body: widget.items.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) => ListTile(
                    isThreeLine: true,
                    title: Text(widget.items[index].ip),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.items[index].mac),
                        Text(widget.items[index].hostname),
                      ],
                    ),
                    trailing: widget.staticLeases == true
                      ? IconButton(
                          onPressed: () {
                            showModal(
                              context: context,
                              builder: (context) => DeleteStaticLeaseModal(
                                onConfirm: () => deleteLease(widget.items[index])
                              )
                            );
                          }, 
                          icon: const Icon(Icons.delete)
                        )
                      : null,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.staticLeases == true
                        ? AppLocalizations.of(context)!.noDhcpStaticLeases
                        : AppLocalizations.of(context)!.noLeases,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 22
                      ),
                    ),
                  ),
                ),
          ),
          if (widget.staticLeases == true) AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: isVisible ?
              appConfigProvider.showingSnackbar
                ? 70 : 20
              : -70,
            right: 20,
            child: FloatingActionButton(
              onPressed: openAddStaticLease,
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
              ),
            )
          ),
        ],
      ),
    );
  }
}