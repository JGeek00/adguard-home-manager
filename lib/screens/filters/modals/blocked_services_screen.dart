// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/blocked_services.dart';
import 'package:adguard_home_manager/functions/snackbar.dart';
import 'package:adguard_home_manager/classes/process_modal.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/filtering_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class BlockedServicesScreen extends StatefulWidget {
  final bool fullScreen;

  const BlockedServicesScreen({
    super.key,
    required this.fullScreen
  });

  @override
  State<BlockedServicesScreen> createState() => _BlockedServicesScreenStateWidget();
}

class _BlockedServicesScreenStateWidget extends State<BlockedServicesScreen> {
  List<String> values = [];

  @override
  void initState() {
    final filteringProvider = Provider.of<FilteringProvider>(context, listen: false);

    if (filteringProvider.blockedServicesLoadStatus != LoadStatus.loaded) {
      filteringProvider.loadBlockedServices(showLoading: true);
    }

    values = filteringProvider.filtering!.blockedServices; 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteringProvider = Provider.of<FilteringProvider>(context);
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    void updateValues(bool value, BlockedService item) {
      if (value == true) {
        setState(() {
          values = values.where((v) => v != item.id).toList();
        });
      }
      else {
        setState(() {
          values.add(item.id);
        });
      }
    }

    void updateBlockedServices() async {
      ProcessModal processModal = ProcessModal();
      processModal.open(AppLocalizations.of(context)!.updating);

      final result = await filteringProvider.updateBlockedServices(values);

      processModal.close();

      if (result == true) {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.blockedServicesUpdated, 
          color: Colors.green
        );
      }
      else {
        showSnackbar(
          appConfigProvider: appConfigProvider,
          label: AppLocalizations.of(context)!.blockedServicesNotUpdated, 
          color: Colors.red
        );
      }
    }

    if (widget.fullScreen == true) {
      return Dialog.fullscreen(
        child: Material(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar.large(
                  pinned: true,
                  floating: true,
                  centerTitle: false,
                  forceElevated: innerBoxIsScrolled,
                  leading: CloseButton(onPressed: () => Navigator.pop(context)),
                  title: Text(AppLocalizations.of(context)!.blockedServices),
                  actions: [
                    IconButton(
                      onPressed: updateBlockedServices, 
                      icon: const Icon(
                        Icons.save_rounded
                      ),
                      tooltip: AppLocalizations.of(context)!.save,
                    ),
                    const SizedBox(width: 10)
                  ],
                )
              )
            ], 
            body: SafeArea(
              top: false,
              bottom: true,
              child: Builder(
                builder: (context) => CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    if (filteringProvider.blockedServicesLoadStatus == LoadStatus.loading) SliverFillRemaining(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 30),
                            Text(
                              AppLocalizations.of(context)!.loadingBlockedServicesList,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (filteringProvider.blockedServicesLoadStatus == LoadStatus.loaded) SliverList.builder(
                      itemCount: filteringProvider.blockedServices!.services.length,
                      itemBuilder: (context, index) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => updateValues(
                            values.contains(filteringProvider.blockedServices!.services[index].id), 
                            filteringProvider.blockedServices!.services[index]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                              right: 12,
                              left: 24
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  filteringProvider.blockedServices!.services[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.onSurface
                                  ),
                                ),
                                Checkbox(
                                  value: values.contains(filteringProvider.blockedServices!.services[index].id), 
                                  onChanged: (value) => updateValues(
                                    value!, 
                                    filteringProvider.blockedServices!.services[index]
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                    if (filteringProvider.blockedServicesLoadStatus == LoadStatus.error) SliverFillRemaining(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              AppLocalizations.of(context)!.blockedServicesListNotLoaded,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ),
        ),
      );
    }
    else {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(         
                          onPressed: () => Navigator.pop(context), 
                          icon: const Icon(Icons.clear_rounded),
                          tooltip: AppLocalizations.of(context)!.close,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.blockedServices,
                          style: const TextStyle(
                            fontSize: 22
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: updateBlockedServices, 
                      icon: const Icon(
                        Icons.save_rounded
                      ),
                      tooltip: AppLocalizations.of(context)!.save,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (ctx) {
                    switch (filteringProvider.blockedServicesLoadStatus) {
                      case LoadStatus.loading:
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 30),
                              Text(
                                AppLocalizations.of(context)!.loadingBlockedServicesList,
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
                        return ListView.builder(
                          itemCount: filteringProvider.blockedServices!.services.length,
                          itemBuilder: (context, index) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => updateValues(
                                values.contains(filteringProvider.blockedServices!.services[index].id), 
                                filteringProvider.blockedServices!.services[index]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  bottom: 6,
                                  right: 12,
                                  left: 24
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filteringProvider.blockedServices!.services[index].name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).colorScheme.onSurface
                                      ),
                                    ),
                                    Checkbox(
                                      value: values.contains(filteringProvider.blockedServices!.services[index].id), 
                                      onChanged: (value) => updateValues(
                                        value!, 
                                        filteringProvider.blockedServices!.services[index]
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        );

                      case LoadStatus.error:
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                AppLocalizations.of(context)!.blockedServicesListNotLoaded,
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
                )
              ),
            ],
          )
        ),
      );
    }
  }
}


void openBlockedServicesModal({
  required BuildContext context,
  required double width,
}) {
  showGeneralDialog(
    context: context, 
    barrierColor: !(width > 700 || !(Platform.isAndroid || Platform.isIOS))
      ?Colors.transparent 
      : Colors.black54,
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1), 
          end: const Offset(0, 0)
        ).animate(
          CurvedAnimation(
            parent: anim1, 
            curve: Curves.easeInOutCubicEmphasized
          )
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => BlockedServicesScreen(
      fullScreen: !(width > 700 || !(Platform.isAndroid || Platform.isIOS)),
    ),
  );
}