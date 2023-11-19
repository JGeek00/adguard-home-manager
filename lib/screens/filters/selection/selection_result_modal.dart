import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/filtering.dart';

enum SelectionResultMode { delete, enableDisable }

class SelectionResultModal extends StatelessWidget {
  final List<ProcessedList> results;
  final void Function() onClose;
  final SelectionResultMode mode;

  const SelectionResultModal({
    super.key, 
    required this.results,
    required this.onClose,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final failedItems = results.where((r) => r.successful == false).toList();

    return AlertDialog(
      title: Column(
        children: [
          Icon(
            mode == SelectionResultMode.delete
              ? Icons.delete_rounded
              : Icons.remove_moderator_rounded,
            size: 24,
            color: Theme.of(context).listTileTheme.iconColor
          ),
          const SizedBox(height: 16),
          Text(
            mode == SelectionResultMode.delete
              ? AppLocalizations.of(context)!.deletionResult
              : AppLocalizations.of(context)!.enableDisableResult,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          )
        ],
      ),
      content: failedItems.isEmpty
        ? Text(
            mode == SelectionResultMode.delete
              ? AppLocalizations.of(context)!.allSelectedListsDeletedSuccessfully
              : AppLocalizations.of(context)!.selectedListsEnabledDisabledSuccessfully,
          )
        : SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        child: Text(
                          AppLocalizations.of(context)!.failedElements,
                          textAlign: TextAlign.center,
                          style: const  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: failedItems.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text("• ${failedItems[index].list.name}"),
                    ),
                  ),
                ],
              ),
            ),
          ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onClose();
              }, 
              child: Text(AppLocalizations.of(context)!.close)
            ),
          ],
        )
      ],
    );
  }
}