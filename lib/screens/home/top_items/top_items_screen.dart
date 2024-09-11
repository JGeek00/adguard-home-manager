// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/options_menu.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/floating_search_bar.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

enum _SortingOptions { highestToLowest, lowestToHighest }
final GlobalKey _searchButtonKey = GlobalKey();

class TopItemsScreen extends StatefulWidget {
  final HomeTopItems type;
  final String title;
  final bool? isClient;
  final List<Map<String, dynamic>> data;
  final bool withProgressBar;
  final String Function(dynamic) buildValue;
  final List<MenuOption> Function(dynamic) options;
  final void Function(dynamic)? onTapEntry;
  final bool isFullscreen;

  const TopItemsScreen({
    super.key,
    required this.type,
    required this.title,
    this.isClient,
    required this.data,
    required this.withProgressBar,
    required this.buildValue,
    required this.options,
    this.onTapEntry,
    required this.isFullscreen,
  });

  @override
  State<TopItemsScreen> createState() => _TopItemsScreenState();
}

class _TopItemsScreenState extends State<TopItemsScreen> {
  _SortingOptions _sortingOptions = _SortingOptions.highestToLowest;
  final TextEditingController searchController = TextEditingController();
  String? _currentSearchValue = "";

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> screenData = [];

  void search(String value) {
    List<Map<String, dynamic>> newValues = widget.data.where((item) => item.keys.toList()[0].contains(value)).toList();
    setState(() {
      screenData = newValues;
      _currentSearchValue = searchController.text;
    });
  }

  @override
  void initState() {
    data = widget.data;
    screenData = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var element in data) {
      total = total + double.parse(element.values.toList()[0].toString());
    }

    final sortedValues = _sortingOptions == _SortingOptions.lowestToHighest
      ? screenData.reversed.toList()
      : screenData.toList();

    void showSearchDialog() {
      showDialog(
        context: context, 
        builder: (context) => FloatingSearchBar(
          existingSearchValue: _currentSearchValue,
          searchButtonRenderBox: _searchButtonKey.currentContext?.findRenderObject() as RenderBox?,
          onSearchCompleted: (v) {
            List<Map<String, dynamic>> newValues = widget.data.where((item) => item.keys.toList()[0].contains(v)).toList();
            setState(() {
              screenData = newValues;
              _currentSearchValue = v;
            });
          },
        ),
      );
    }
    
    if (widget.isFullscreen == true) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar.large(
                title: Text(widget.title),
                actions: [
                  IconButton(
                    key: _searchButtonKey,
                    onPressed: showSearchDialog,
                    icon: const Icon(Icons.search_rounded),
                    tooltip: AppLocalizations.of(context)!.search,
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.sort_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => setState(() => _sortingOptions = _SortingOptions.highestToLowest),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_downward_rounded),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(AppLocalizations.of(context)!.fromHighestToLowest)
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              _sortingOptions == _SortingOptions.highestToLowest
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_unchecked_rounded,
                              color: _sortingOptions == _SortingOptions.highestToLowest
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                            )
                          ],
                        )
                      ),
                      PopupMenuItem(
                        onTap: () => setState(() => _sortingOptions = _SortingOptions.lowestToHighest),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_upward_rounded),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(AppLocalizations.of(context)!.fromLowestToHighest)
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              _sortingOptions == _SortingOptions.lowestToHighest
                                ? Icons.radio_button_checked_rounded
                                : Icons.radio_button_unchecked_rounded,
                              color: _sortingOptions == _SortingOptions.lowestToHighest
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                  const SizedBox(width: 8)
                ],
              )
            )
          ], 
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) => CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  if (sortedValues.isEmpty) Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.noItemsSearch,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  if (sortedValues.isNotEmpty) SliverPadding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
                    sliver: SliverList.builder(
                      itemCount: sortedValues.length,
                      itemBuilder: (context, index) => _Item(
                        data: sortedValues[index], 
                        isClient: widget.isClient, 
                        options: widget.options,
                        total: total,
                        withProgressBar: widget.withProgressBar, 
                        onTapEntry: widget.onTapEntry, 
                        buildValue: widget.buildValue, 
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ),
      );
    }
    else {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context), 
                            icon: const Icon(Icons.clear_rounded),
                            tooltip: AppLocalizations.of(context)!.close,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: searchController,
                        onChanged: search,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          hintText: AppLocalizations.of(context)!.search,
                          prefixIcon: const Icon(Icons.search_rounded),
                          contentPadding: const EdgeInsets.only(left: 14, bottom: 9, top: 11),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: sortedValues.isNotEmpty ? ListView.builder(
                  itemCount: sortedValues.length,
                  itemBuilder: (context, index) => _Item(
                    data: sortedValues[index], 
                    isClient: widget.isClient, 
                    options: widget.options, 
                    withProgressBar: widget.withProgressBar, 
                    onTapEntry: widget.onTapEntry, 
                    buildValue: widget.buildValue, 
                    total: total,
                  ),
                ) : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppLocalizations.of(context)!.noItemsSearch,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _Item extends StatelessWidget {
  final dynamic data;
  final bool? isClient;
  final List<MenuOption> Function(dynamic) options;
  final bool withProgressBar;
  final void Function(dynamic)? onTapEntry;
  final String Function(dynamic) buildValue;
  final double total;

  const _Item({
    required this.data,
    required this.isClient,
    required this.options,
    required this.withProgressBar,
    required this.onTapEntry,
    required this.buildValue,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final statusProvider = Provider.of<StatusProvider>(context);

    String? name;
    if (isClient != null && isClient == true) {
      try {
        name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(data.keys.toList()[0])).name;
      } catch (e) {
        // ---- //
      }
    }
               
    return OptionsMenu(
      options: options,
      value: data.keys.toList()[0],
      onTap: onTapEntry != null
        ? (v) {
            onTapEntry!(v);
            Navigator.pop(context);
          }
        : null,
      child: CustomListTile(
        title: data.keys.toList()[0],
        trailing: Text(
          buildValue(data.values.toList()[0]),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
        ),
        subtitleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (name != null) ...[
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              const SizedBox(height: 5),
            ],
            if (withProgressBar == true) Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    "${doubleFormat((data.values.toList()[0]/total*100), Platform.localeName)}%",
                    style: TextStyle(
                      color: Theme.of(context).listTileTheme.textColor
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 4,
                    animationDuration: 500,
                    curve: Curves.easeOut,
                    percent: data.values.toList()[0]/total,
                    barRadius: const Radius.circular(5),
                    progressColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.surfaceTint.withOpacity(0.2),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        )
      ),
    );
  }
}