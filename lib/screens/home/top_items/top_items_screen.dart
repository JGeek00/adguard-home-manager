// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/options_menu.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/models/menu_option.dart';
import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/functions/number_format.dart';
import 'package:adguard_home_manager/providers/status_provider.dart';

enum _SortingOptions { highestToLowest, lowestToHighest }

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
  bool searchActive = false;
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> screenData = [];

  void search(String value) {
    List<Map<String, dynamic>> newValues = widget.data.where((item) => item.keys.toList()[0].contains(value)).toList();
    setState(() => screenData = newValues);
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
    
    if (widget.isFullscreen == true) {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: searchActive == true
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18
                    ),
                    autofocus: true,
                  ),
                )
              : Text(widget.title),
            leading: searchActive == true ?
              IconButton(
                onPressed: () => setState(() {
                  searchActive = false;
                  searchController.text = '';
                  screenData = data;
                }), 
                icon: const Icon(Icons.arrow_back),
                tooltip: AppLocalizations.of(context)!.exitSearch,
              ) : null,
            actions: [
              if (searchActive == false) IconButton(
                onPressed: () => setState(() => searchActive = true), 
                icon: const Icon(Icons.search),
                tooltip: AppLocalizations.of(context)!.search,
              ),
              if (searchActive == true) IconButton(
                onPressed: () => setState(() {
                  searchController.text = '';
                  screenData = data;
                }), 
                icon: const Icon(Icons.clear_rounded),
                tooltip: AppLocalizations.of(context)!.clearSearch,
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
          ),
          body: SafeArea(
            child: _Content(
              buildValue: widget.buildValue,
              isClient: widget.isClient,
              onTapEntry: widget.onTapEntry,
              options: widget.options,
              screenData: sortedValues,
              total: total,
              withProgressBar: widget.withProgressBar,
            ),
          ),
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
                child: _Content(
                  buildValue: widget.buildValue,
                  isClient: widget.isClient,
                  onTapEntry: widget.onTapEntry,
                  options: widget.options,
                  screenData: sortedValues,
                  total: total,
                  withProgressBar: widget.withProgressBar,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _Content extends StatelessWidget {
  final List<Map<String, dynamic>> screenData;
  final bool? isClient;
  final List<MenuOption> Function(dynamic) options;
  final bool withProgressBar;
  final void Function(dynamic)? onTapEntry;
  final String Function(dynamic) buildValue;
  final double total;

  const _Content({
    required this.screenData,
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

    if (screenData.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        itemCount: screenData.length,
        itemBuilder: (context, index) {
          String? name;
          if (isClient != null && isClient == true) {
            try {
              name = statusProvider.serverStatus!.clients.firstWhere((c) => c.ids.contains(screenData[index].keys.toList()[0])).name;
            } catch (e) {
              // ---- //
            }
          }
               
          return OptionsMenu(
            options: options,
            value: screenData[index].keys.toList()[0],
            onTap: onTapEntry != null
              ? (v) {
                  onTapEntry!(v);
                  Navigator.pop(context);
                }
              : null,
            child: CustomListTile(
              title: screenData[index].keys.toList()[0],
              trailing: Text(
                buildValue(screenData[index].values.toList()[0]),
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
                          "${doubleFormat((screenData[index].values.toList()[0]/total*100), Platform.localeName)}%",
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
                          percent: screenData[index].values.toList()[0]/total,
                          barRadius: const Radius.circular(5),
                          progressColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
      );
    }
    else { 
      return Center(
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
      );
    }
  }
}