import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/models/clients.dart';

class BlockingScheduleModal extends StatefulWidget {
  final void Function(BlockedServicesSchedule) onConfirm;

  const BlockingScheduleModal({
    super.key,
    required this.onConfirm,
  });

  @override
  State<BlockingScheduleModal> createState() => _BlockingScheduleModalState();
}

class _BlockingScheduleModalState extends State<BlockingScheduleModal> {
  String? _timezone;
  List<String> _weekdays = [];
  TimeOfDay? _from;
  TimeOfDay? _to;

  bool _compareTimes(TimeOfDay startTime, TimeOfDay endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;

    if (endTimeInt > startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  bool _validate() {
    return _timezone != null &&
      _weekdays.isNotEmpty &&
      _from != null &&
      _to != null &&
      _compareTimes(_from!, _to!);
  }

  int _timeOfDayToInt(TimeOfDay timeOfDay) {
    return Duration(
      days: 0,
      hours: timeOfDay.hour,
      minutes: timeOfDay.minute,
      seconds: 0
    ).inMinutes;
  }

  @override
  void initState() {
    tz.initializeTimeZones();
    _timezone = tz.local.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onSelectWeekday(bool newStatus, String day) {
      if (newStatus == true && !_weekdays.contains(day)) {
        setState(() => _weekdays.add(day));
      }
      else if (newStatus == false) {
        setState(() => _weekdays = _weekdays.where((e) => e != day).toList());
      }
    }

    void onConfirm() {
      widget.onConfirm(
        BlockedServicesSchedule(
          timeZone: _timezone,
          mon: _weekdays.contains("mon") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          tue: _weekdays.contains("tue") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          wed: _weekdays.contains("wed") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          thu: _weekdays.contains("thu") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          fri: _weekdays.contains("fri") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          sat: _weekdays.contains("sat") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
          sun: _weekdays.contains("sun") ? BlockedServicesScheduleDay(start: _timeOfDayToInt(_from!), end: _timeOfDayToInt(_to!)) : null,
        )
      );
    }

    final valid = _validate();
    final validTimes = _from != null && _to != null 
      ? _compareTimes(_from!, _to!) 
      : null;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 24,
                      color: Theme.of(context).listTileTheme.iconColor
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.newSchedule,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 30),
                    LayoutBuilder(
                      builder: (context, constraints) => DropdownButtonFormField(
                        items: tz.timeZoneDatabase.locations.keys.map((item) => DropdownMenuItem(
                          value: item,
                          child: SizedBox(
                            width: constraints.maxWidth-48,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )).toList(),
                        value: _timezone,
                        onChanged: (v) => setState(() => _timezone = v),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10)
                            )
                          ),
                          label: Text(AppLocalizations.of(context)!.timezone)
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.monday), 
                            selected: _weekdays.contains("mon"),
                            onSelected: (value) => onSelectWeekday(value, "mon")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.tuesday), 
                            selected: _weekdays.contains("tue"),
                            onSelected: (value) => onSelectWeekday(value, "tue")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.wednesday), 
                            selected: _weekdays.contains("wed"),
                            onSelected: (value) => onSelectWeekday(value, "wed")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.thursday), 
                            selected: _weekdays.contains("thu"),
                            onSelected: (value) => onSelectWeekday(value, "thu")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.friday), 
                            selected: _weekdays.contains("fri"),
                            onSelected: (value) => onSelectWeekday(value, "fri")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.saturday), 
                            selected: _weekdays.contains("sat"),
                            onSelected: (value) => onSelectWeekday(value, "sat")
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: Text(AppLocalizations.of(context)!.sunday), 
                            selected: _weekdays.contains("sun"),
                            onSelected: (value) => onSelectWeekday(value, "sun")
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final selected = await showTimePicker(
                              context: context, 
                              initialTime: _from ?? const TimeOfDay(hour: 0, minute: 0),
                              helpText: AppLocalizations.of(context)!.selectStartTime,
                              confirmText: AppLocalizations.of(context)!.confirm,
                            );
                            setState(() => _from = selected); 
                          },
                          child: Text(
                            AppLocalizations.of(context)!.from(
                              _from != null ? "${_from!.hour.toString().padLeft(2, '0')}:${_from!.minute.toString().padLeft(2, '0')}" : "--:--"
                            )
                          )
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final selected = await showTimePicker(
                              context: context, 
                              initialTime: _to ?? const TimeOfDay(hour: 23, minute: 59),
                              helpText: AppLocalizations.of(context)!.selectEndTime,
                              confirmText: AppLocalizations.of(context)!.confirm
                            ); 
                            setState(() => _to = selected); 
                          },
                          child: Text(
                            AppLocalizations.of(context)!.to(
                              _to != null ? "${_to!.hour.toString().padLeft(2, '0')}:${_to!.minute.toString().padLeft(2, '0')}" : "--:--"
                            )
                          )
                        ),
                      ],
                    ),
                    if (validTimes == false) Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        color: const Color.fromARGB(255, 255, 182, 175),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_rounded,
                                color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.startTimeBeforeEndTime,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: Text(AppLocalizations.of(context)!.close)
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: valid ? () => onConfirm() : null, 
                  child: Text(AppLocalizations.of(context)!.confirm)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}