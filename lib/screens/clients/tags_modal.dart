import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagsModal extends StatefulWidget {
  final String? selectedTag;
  final List<String> tags;
  final void Function(String) onConfirm;

  const TagsModal({
    Key? key,
    this.selectedTag,
    required this.tags,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<TagsModal> createState() => _TagsModalState();
}

class _TagsModalState extends State<TagsModal> {
  String? selectedTag;

  @override
  void initState() {
    selectedTag = widget.selectedTag;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 20
      ),
      title: Column(
        children: [
          const Icon(Icons.label_rounded),
          const SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.tags)
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        height: MediaQuery.of(context).size.height*0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tags.length,
          itemBuilder: (context, index) => RadioListTile(
            title: Text(
              widget.tags[index],
              style: const TextStyle(
                fontWeight: FontWeight.normal
              ),
            ),
            value: widget.tags[index], 
            groupValue: selectedTag, 
            onChanged: (value) => setState(() => selectedTag = value)
          )
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(AppLocalizations.of(context)!.cancel)
        ),
        TextButton(
          onPressed: selectedTag != null 
            ? () {
                widget.onConfirm(selectedTag!);
                Navigator.pop(context);
              }
            : null, 
          child: Text(
            AppLocalizations.of(context)!.confirm,
            style: TextStyle(
              color: selectedTag != null 
                ? Theme.of(context).primaryColor
                : Colors.grey
            ),
          )
        ),
      ],
    );
  }
}