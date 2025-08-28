import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


import 'package:adguard_home_manager/config/globals.dart';

class FloatingSearchBar extends StatefulWidget {
  final void Function(String) onSearchCompleted;
  final RenderBox? searchButtonRenderBox;
  final String? existingSearchValue;
  final void Function(String)? onSearchFieldUpdated;
  final void Function()? onSearchFieldCleared;

  const FloatingSearchBar({
    super.key, 
    required this.onSearchCompleted,
    required this.searchButtonRenderBox,
    this.existingSearchValue,
    this.onSearchFieldUpdated,
    this.onSearchFieldCleared,
  });

  @override
  State<FloatingSearchBar> createState() => _SearchState();
}

class _SearchState extends State<FloatingSearchBar> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    if (widget.existingSearchValue != null) {
      _searchController.text = widget.existingSearchValue!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = widget.searchButtonRenderBox?.localToGlobal(Offset.zero);
    final topPadding = MediaQuery.of(globalNavigatorKey.currentContext!).viewPadding.top;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Material(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth - 32  > 500 ? 500 : constraints.maxWidth - 32;
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: position != null ? position.dy - topPadding : topPadding,
                  child: SizedBox(
                    width: width,
                    child: GestureDetector(
                      onTap: () => {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: widget.onSearchFieldUpdated,
                            onFieldSubmitted: (v) {
                              widget.onSearchCompleted(v);
                              Navigator.pop(context);
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.search,
                              prefixIcon: const Icon(Icons.search_rounded),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.2),
                              suffixIcon: _searchController.text != ""
                                ? IconButton(
                                    onPressed: () {
                                      setState(() => _searchController.text = "");
                                      if (widget.onSearchFieldCleared != null) {
                                        widget.onSearchFieldCleared!();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      size: 20,
                                    ),
                                    tooltip: AppLocalizations.of(context)!.clearSearch,
                                  )
                                : null,
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}