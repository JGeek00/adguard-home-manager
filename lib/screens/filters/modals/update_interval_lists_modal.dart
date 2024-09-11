import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/option_box.dart';


class UpdateIntervalListsModal extends StatefulWidget {
  final int interval;
  final void Function(int) onChange;
  final bool dialog;

  const UpdateIntervalListsModal({
    super.key,
    required this.interval,
    required this.onChange,
    required this.dialog
  });

  @override
  State<UpdateIntervalListsModal> createState() => _UpdateIntervalListsModalState();
}

class _UpdateIntervalListsModalState extends State<UpdateIntervalListsModal> {
  int? selectedOption;

  void _updateRadioValue(int value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  void initState() {
    selectedOption = widget.interval;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);  

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: _Content(
            selectedOption: selectedOption,
            onUpdateValue: _updateRadioValue,
            onConfirm: () => widget.onChange(selectedOption!),
          )
        ),
      );
    }
    else {
      return Padding(
        padding: mediaQueryData.viewInsets,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            ),
          ),
          child: SafeArea(
            child: _Content(
              selectedOption: selectedOption,
              onUpdateValue: _updateRadioValue,
              onConfirm: () => widget.onChange(selectedOption!),
            ),
          )
        ),
      );
    }
  }
}

class _Content extends StatelessWidget {
  final int? selectedOption;
  final void Function(int) onUpdateValue;
  final void Function() onConfirm;

  const _Content({
    required this.selectedOption,
    required this.onUpdateValue,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Icon(
                              Icons.update_rounded,
                              size: 24,
                              color: Theme.of(context).listTileTheme.iconColor
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.updateFrequency,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).colorScheme.onSurface
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Wrap(
                    runSpacing: 16,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 0,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.never,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 1,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.hour1,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 12,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.hours12,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 24,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.hours24,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 72,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.days3,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OptionBox(
                            optionsValue: selectedOption,
                            itemValue: 168,
                            onTap: (v) => onUpdateValue(v as int),
                            label: AppLocalizations.of(context)!.days7,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: selectedOption != null
                  ? () {
                    Navigator.pop(context);
                    onConfirm();
                  }
                  : null,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    selectedOption != null
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  ),
                ), 
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          ),
        ),
        if (Platform.isIOS) const SizedBox(height: 16)
      ],
    );
  }
}