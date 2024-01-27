import 'dart:io';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/blocking_schedule.dart';

class BlockingScheduleModal extends StatefulWidget {
  final EditBlockingSchedule? schedule;
  final void Function(EditBlockingSchedule) onConfirm;

  const BlockingScheduleModal({
    super.key,
    this.schedule,
    required this.onConfirm,
  });

  @override
  State<BlockingScheduleModal> createState() => _BlockingScheduleModalState();
}

class _BlockingScheduleModalState extends State<BlockingScheduleModal> {
  final _weekdaysScrollController = ScrollController();

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
    ).inMilliseconds;
  }

  TimeOfDay _intToTimeOfDay(int value) {
    final duration = Duration(milliseconds: value);
    final minutes = duration.inMinutes - duration.inHours*60;
    return TimeOfDay(hour: duration.inHours, minute: minutes);
  }

  @override
  void initState() {
    tz.initializeTimeZones();
    if (widget.schedule != null) {
      _timezone = widget.schedule!.timezone;
      _weekdays = widget.schedule!.weekday;
      _from = _intToTimeOfDay(widget.schedule!.start);
      _to = _intToTimeOfDay(widget.schedule!.end);
    }

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
        EditBlockingSchedule(
          timezone: _timezone!, 
          weekday: _weekdays, 
          start: _timeOfDayToInt(_from!), 
          end: _timeOfDayToInt(_to!)
        )
      );
      Navigator.pop(context);
    }

    final valid = _validate();
    final validTimes = _from != null && _to != null 
      ? _compareTimes(_from!, _to!) 
      : null;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
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
                        widget.schedule != null
                          ? AppLocalizations.of(context)!.editSchedule
                          : AppLocalizations.of(context)!.newSchedule,
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
                        height: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 66 : 50,
                        child: Scrollbar(
                          controller: _weekdaysScrollController,
                          thumbVisibility: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
                          interactive: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
                          thickness: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 8 : 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 16 : 0
                            ),
                            child: ListView(
                              controller: _weekdaysScrollController,
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  Text(AppLocalizations.of(context)!.from),
                                  const SizedBox(height: 2),
                                  Text(_from != null ? "${_from!.hour.toString().padLeft(2, '0')}:${_from!.minute.toString().padLeft(2, '0')}" : "--:--")
                                ],
                              ),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  Text(AppLocalizations.of(context)!.to),
                                  const SizedBox(height: 2),
                                  Text(_to != null ? "${_to!.hour.toString().padLeft(2, '0')}:${_to!.minute.toString().padLeft(2, '0')}" : "--:--")
                                ],
                              ),
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
      ),
    );
  }
}