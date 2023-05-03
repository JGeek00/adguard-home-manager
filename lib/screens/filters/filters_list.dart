// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/filters/add_button.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/tab_content_list.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/models/filtering.dart';

class FiltersList extends StatefulWidget {
  final LoadStatus loadStatus;
  final ScrollController scrollController;
  final List<Filter> data;
  final Future<void> Function() fetchData;
  final String type;
  final void Function(Filter, String) onOpenDetailsScreen;

  const FiltersList({
    Key? key,
    required this.loadStatus,
    required this.scrollController,
    required this.data,
    required this.fetchData,
    required this.type,
    required this.onOpenDetailsScreen
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

    return CustomTabContentList(
      loadingGenerator: () => SizedBox(
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
      ), 
      itemsCount: widget.data.length, 
      contentWidget: (index) => CustomListTile(
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
        onTap: () => widget.onOpenDetailsScreen(widget.data[index], widget.type),
      ), 
      noData: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                widget.type == 'blacklist'
                  ? AppLocalizations.of(context)!.noBlackLists
                  : AppLocalizations.of(context)!.noWhiteLists,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
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
      errorGenerator: () => SizedBox(
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
      ), 
      loadStatus: widget.loadStatus, 
      onRefresh: widget.fetchData,
      fab: AddFiltersButton(
        type: widget.type,
        widget: (fn) => FloatingActionButton(
          onPressed: fn,
          child: const Icon(Icons.add),
        ),
      ),
      fabVisible: isVisible,
    );
  }
}