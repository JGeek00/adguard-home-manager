import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/widgets/option_box.dart';


class UpdateIntervalListsModal extends StatefulWidget {
  final int interval;
  final void Function(int) onChange;

  const UpdateIntervalListsModal({
    Key? key,
    required this.interval,
    required this.onChange,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                physics: (Platform.isIOS ? 426 : 410) < MediaQuery.of(context).size.height
                  ? const NeverScrollableScrollPhysics() 
                  : null,
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
                    width: double.maxFinite,
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
                  SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 5,
                                  bottom: 5
                                ),
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
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                  bottom: 5
                                ),
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 5,
                                  right: 5,
                                  bottom: 5
                                ),
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
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 5,
                                  left: 5,
                                  bottom: 5
                                ),
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 5,
                                  right: 5,
                                  bottom: 10
                                ),
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
                              Container(
                                width: (mediaQueryData.size.width-70)/2,
                                margin: const EdgeInsets.only(
                                  top: 5,
                                  left: 5,
                                  bottom: 10
                                ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }
}