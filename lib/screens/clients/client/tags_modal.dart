import 'package:flutter/material.dart';
import 'package:adguard_home_manager/l10n/app_localizations.dart';


class TagsModal extends StatefulWidget {
  final List<String> selectedTags;
  final List<String> tags;
  final void Function(List<String>) onConfirm;

  const TagsModal({
    super.key,
    required this.selectedTags,
    required this.tags,
    required this.onConfirm,
  });

  @override
  State<TagsModal> createState() => _TagsModalState();
}

class _TagsModalState extends State<TagsModal> {
  List<String> selectedTags = [];

  @override
  void initState() {
    selectedTags = widget.selectedTags;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void checkUncheckTag(bool value, String tag) {
      if (value == true) {
        setState(() {
          selectedTags.add(tag);
        });
      }
      else if (value == false) {
        setState(() {
          selectedTags = selectedTags.where((s) => s != tag).toList();
        });
      }
    }
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16
      ),
      title: Column(
        children: [
          Icon(
            Icons.label_rounded,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.tags,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        height: MediaQuery.of(context).size.height*0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tags.length,
          itemBuilder: (context, index) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => checkUncheckTag(!selectedTags.contains(widget.tags[index]), widget.tags[index]),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 8,
                  bottom: 8,
                  right: 12
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.tags[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Checkbox(
                      value: selectedTags.contains(widget.tags[index]), 
                      onChanged: (value) => checkUncheckTag(value!, widget.tags[index]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // itemBuilder: (context, index) => CheckboxListTile(
          //   title: Text(
          //     widget.tags[index],
          //     style: TextStyle(
          //       fontWeight: FontWeight.normal,
          //       color: Theme.of(context).colorScheme.onSurface
          //     ),
          //   ),
          //   value: selectedTags.contains(widget.tags[index]), 
          //   checkboxShape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5)
          //   ),
          //   onChanged: (value) => checkUncheckTag(value!, widget.tags[index])
          // )
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: selectedTags.isNotEmpty
            ? () {
                widget.onConfirm(selectedTags);
                Navigator.pop(context);
              }
            : null, 
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: TextStyle(
              color: selectedTags.isNotEmpty
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
            ),
          )
        ),
      ],
    );
  }
}