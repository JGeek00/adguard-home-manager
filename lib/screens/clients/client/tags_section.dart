import 'package:adguard_home_manager/screens/clients/client/client_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagsSection extends StatelessWidget {
  final List<String> selectedTags;
  final void Function(List<String>) onTagsSelected;

  const TagsSection({
    Key? key,
    required this.selectedTags,
    required this.onTagsSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openTagsModal(
          context: context,
          selectedTags: selectedTags,
          onSelectedTags: onTagsSelected
        ) ,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0, horizontal: 24
          ),
          child: Row(
            children: [
              Icon(
                Icons.label_rounded,
                color: Theme.of(context).listTileTheme.iconColor
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.selectTags,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    selectedTags.isNotEmpty
                      ? "${selectedTags.length} ${AppLocalizations.of(context)!.tagsSelected}"
                      : AppLocalizations.of(context)!.noTagsSelected,
                    style: TextStyle(
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}