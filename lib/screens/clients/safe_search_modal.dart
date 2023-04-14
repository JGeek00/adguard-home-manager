import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';

import 'package:adguard_home_manager/models/safe_search.dart';

class SafeSearchModal extends StatefulWidget {
  final SafeSearch safeSearch;
  final bool disabled;
  final void Function(SafeSearch) onConfirm;
  
  const SafeSearchModal({
    Key? key,
    required this.safeSearch,
    required this.disabled,
    required this.onConfirm
  }) : super(key: key);

  @override
  State<SafeSearchModal> createState() => _SafeSearchModalState();
}

class _SafeSearchModalState extends State<SafeSearchModal> {
  bool generalEnabled = false;
  bool bingEnabled = false;
  bool duckduckgoEnabled = false;
  bool googleEnabled = false;
  bool pixabayEnabled = false;
  bool yandexEnabled = false;
  bool youtubeEnabled = false;

  @override
  void initState() {
    generalEnabled = widget.safeSearch.enabled;
    bingEnabled = widget.safeSearch.bing;
    duckduckgoEnabled = widget.safeSearch.duckduckgo;
    googleEnabled = widget.safeSearch.google;
    pixabayEnabled = widget.safeSearch.pixabay;
    yandexEnabled = widget.safeSearch.yandex;
    youtubeEnabled = widget.safeSearch.youtube;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      title: Column(
        children: [
          Icon(
            Icons.search_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.safeSearch,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: widget.disabled == true
                  ? null
                  : () => setState(() => generalEnabled = !generalEnabled),
                borderRadius: BorderRadius.circular(28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.enable,
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.disabled == true
                            ? Colors.grey
                            : Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                      Switch(
                        value: generalEnabled, 
                        onChanged: widget.disabled == true
                          ? null
                          : (value) => setState(() => generalEnabled = value),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4, width: double.maxFinite),
          CustomCheckboxListTile(
            value: bingEnabled, 
            onChanged: (value) => setState(() => bingEnabled = value), 
            title: "Bing",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
          CustomCheckboxListTile(
            value: duckduckgoEnabled, 
            onChanged: (value) => setState(() => duckduckgoEnabled = value), 
            title: "DuckDuckGo",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
          CustomCheckboxListTile(
            value: googleEnabled, 
            onChanged: (value) => setState(() => googleEnabled = value), 
            title: "Google",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
          CustomCheckboxListTile(
            value: pixabayEnabled, 
            onChanged: (value) => setState(() => pixabayEnabled = value), 
            title: "Pixabay",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
          CustomCheckboxListTile(
            value: yandexEnabled, 
            onChanged: (value) => setState(() => yandexEnabled = value), 
            title: "Yandex",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
          CustomCheckboxListTile(
            value: youtubeEnabled, 
            onChanged: (value) => setState(() => youtubeEnabled = value), 
            title: "YouTube",
            disabled: widget.disabled || !generalEnabled,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 4
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: widget.disabled == false ? () {
            widget.onConfirm(
              SafeSearch(
                enabled: generalEnabled, 
                bing: bingEnabled, 
                duckduckgo: duckduckgoEnabled, 
                google: googleEnabled, 
                pixabay: pixabayEnabled, 
                yandex: yandexEnabled, 
                youtube: youtubeEnabled
              )
            );
            Navigator.pop(context);
          } : null, 
          child: Text(AppLocalizations.of(context)!.confirm)
        ),
      ],
    );
  }
}