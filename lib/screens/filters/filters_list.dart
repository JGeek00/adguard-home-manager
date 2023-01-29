// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/fab.dart';
import 'package:adguard_home_manager/screens/filters/list_details_screen.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class FiltersList extends StatefulWidget {
  final int loadStatus;
  final ScrollController scrollController;
  final List<Filter> data;
  final void Function() fetchData;
  final String type;

  const FiltersList({
    Key? key,
    required this.loadStatus,
    required this.scrollController,
    required this.data,
    required this.fetchData,
    required this.type,
  }) : super(key: key);

  @override
  State<FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  late bool isVisible;

  @override
  initState(){
    super.initState();

    isVisible = true;
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (mounted && isVisible == true) {
          setState(() => isVisible = false);
        }
      } 
      else {
        if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (mounted && isVisible == false) {
            setState(() => isVisible = true);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    
    void openDetailsModal(Filter filter) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>  ListDetailsScreen(
            list: filter, 
            type: widget.type,
          )
        )
      );
    }

    switch (widget.loadStatus) {
      case 0:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.loadingFilters,
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            ],
          ),
        );

      case 1:
        return Stack(
          children: [
            if (widget.data.isNotEmpty) ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: widget.data.length,
              itemBuilder: (context, index) => CustomListTile(
                title: widget.data[index].name,
                subtitle: "${intFormat(widget.data[index].rulesCount, Platform.localeName)} ${AppLocalizations.of(context)!.enabledRules}",
                trailing: Icon(
                  widget.data[index].enabled == true
                    ? Icons.check_circle_rounded
                    : Icons.cancel,
                  color: widget.data[index].enabled == true
                    ? appConfigProvider.useThemeColorForStatus == true
                      ? Theme.of(context).colorScheme.primary
                      : Colors.green
                    : appConfigProvider.useThemeColorForStatus == true
                      ? Colors.grey
                      : Colors.red
                ),
                onTap: () => openDetailsModal(widget.data[index]),
              ),
            ),
            if (widget.data.isEmpty) if (widget.data.isEmpty) SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.type == 'blacklist'
                      ? AppLocalizations.of(context)!.noBlackLists
                      : AppLocalizations.of(context)!.noWhiteLists,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextButton.icon(
                    onPressed: widget.fetchData, 
                    icon: const Icon(Icons.refresh_rounded), 
                    label: Text(AppLocalizations.of(context)!.refresh),
                  )
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              bottom: isVisible ?
                appConfigProvider.showingSnackbar
                  ? 70 : 20
                : -70,
              right: 20,
              child: FiltersFab(
                type: widget.type
              )
            )
          ],
        );

      case 2:
        return SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height-171,
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
                AppLocalizations.of(context)!.filtersNotLoaded,
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
}