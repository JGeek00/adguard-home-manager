import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/option_box.dart';


class UpdateIntervalListsModal extends StatefulWidget {
  final int interval;
  final void Function(int) onChange;
  final bool dialog;

  const UpdateIntervalListsModal({
    Key? key,
    required this.interval,
    required this.onChange,
    required this.dialog
  }) : super(key: key);

  @override
  State<UpdateIntervalListsModal> createState() => _UpdateIntervalListsModalState();
}

class _UpdateIntervalListsModalState extends State<UpdateIntervalListsModal> {
  int? selectedOption;

  void _updateRadioValue(value) {
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

    Widget content() {
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Icon(
                              Icons.update_rounded,
                              size: 24,
                              color: Theme.of(context).listTileTheme.iconColor
                            ),
                          ),
                          Container(
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 0
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.never),
                                ),
                              ),
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 1
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.hour1),
                                ),
                              ),
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 12
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.hours12),
                                ),
                              ),
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 24
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.hours24),
                                ),
                              ),
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 72
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.days3),
                                ),
                              ),
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
                              onTap: _updateRadioValue,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 250),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: selectedOption == 168
                                      ? Theme.of(context).colorScheme.onInverseSurface
                                      : Theme.of(context).colorScheme.onSurface
                                  ),
                                  child: Text(AppLocalizations.of(context)!.days7),
                                ),
                              ),
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
                      widget.onChange(selectedOption!);
                    }
                    : null,
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    ),
                    foregroundColor: MaterialStateProperty.all(
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

    if (widget.dialog == true) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500
          ),
          child: content()
        ),
      );
    }
    else {
      return Padding(
        padding: mediaQueryData.viewInsets,
        child: Container(
          height: Platform.isIOS ? 406 : 390,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28)
            ),
          ),
          child: content()
        ),
      );
    }
  }
}