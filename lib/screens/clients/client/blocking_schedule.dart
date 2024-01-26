import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/clients/client/blocking_schedule_modal.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/models/clients.dart';

class EditBlockingSchedule {
  final String timezone;
  final List<String> weekday;
  final int start;
  final int end;

  const EditBlockingSchedule({
    required this.timezone,
    required this.weekday,
    required this.start,
    required this.end,
  });
}

class BlockingSchedule extends StatelessWidget {
  final BlockedServicesSchedule blockedServicesSchedule;
  final void Function(BlockedServicesSchedule) setBlockedServicesSchedule;

  const BlockingSchedule({
    super.key,
    required this.blockedServicesSchedule,
    required this.setBlockedServicesSchedule,
  });

  @override
  Widget build(BuildContext context) {
    void updateSchedule(EditBlockingSchedule v) {
      final scheduleJson = blockedServicesSchedule.toJson();
      for (var weekday in v.weekday) {
        scheduleJson[weekday] = {
          "start": v.start,
          "end": v.end
        };
      }
      scheduleJson["time_zone"] = v.timezone;
      setBlockedServicesSchedule(BlockedServicesSchedule.fromJson(scheduleJson));
    }

    void openAddScheduleModal() {
      showDialog(
        context: context, 
        builder: (context) => BlockingScheduleModal(
          onConfirm: updateSchedule,
        ),
      );
    }

    void openEditScheduleModal(String weekday) {
      showDialog(
        context: context, 
        builder: (context) => BlockingScheduleModal(
          schedule: EditBlockingSchedule(
            timezone: blockedServicesSchedule.timeZone!, 
            weekday: [weekday], 
            start: blockedServicesSchedule.toJson()[weekday]['start'], 
            end: blockedServicesSchedule.toJson()[weekday]['end'], 
          ),
          onConfirm: updateSchedule,
        ),
      );
    }

    String formatTime(int time) {
      final formatted = Duration(milliseconds: time);
      final hours = formatted.inHours;
      final minutes = formatted.inMinutes - hours*60;
      return "${hours.toString().padLeft(2 , '0')}:${minutes.toString().padLeft(2, '0')}";
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionLabel(label: AppLocalizations.of(context)!.pauseServiceBlocking),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: openAddScheduleModal, 
                icon: const Icon(Icons.add)
              ),
            )
          ],
        ),
        const SizedBox(height: 2),
        if (blockedServicesSchedule.mon != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.monday, 
          schedule: "${formatTime(blockedServicesSchedule.mon!.start!)} - ${formatTime(blockedServicesSchedule.mon!.end!)}", 
          onEdit: () => openEditScheduleModal("mon"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.tue != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.tuesday, 
          schedule: "${formatTime(blockedServicesSchedule.tue!.start!)} - ${formatTime(blockedServicesSchedule.tue!.end!)}", 
          onEdit: () => openEditScheduleModal("tue"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.wed != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.wednesday, 
          schedule: "${formatTime(blockedServicesSchedule.wed!.start!)} - ${formatTime(blockedServicesSchedule.wed!.end!)}", 
          onEdit: () => openEditScheduleModal("wed"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.thu != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.thursday, 
          schedule: "${formatTime(blockedServicesSchedule.thu!.start!)} - ${formatTime(blockedServicesSchedule.thu!.end!)}", 
          onEdit: () => openEditScheduleModal("thu"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.fri != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.friday, 
          schedule: "${formatTime(blockedServicesSchedule.fri!.start!)} - ${formatTime(blockedServicesSchedule.fri!.end!)}", 
          onEdit: () => openEditScheduleModal("fri"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.sat != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.saturday, 
          schedule: "${formatTime(blockedServicesSchedule.sat!.start!)} - ${formatTime(blockedServicesSchedule.sat!.end!)}", 
          onEdit: () => openEditScheduleModal("sat"), 
          onDelete: () => {}
        ),
        if (blockedServicesSchedule.sun != null) _ScheduleTile(
          weekday: AppLocalizations.of(context)!.sunday, 
          schedule: "${formatTime(blockedServicesSchedule.sun!.start!)} - ${formatTime(blockedServicesSchedule.sun!.end!)}", 
          onEdit: () => openEditScheduleModal("sun"), 
          onDelete: () => {}
        ),
      ],
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  final String weekday;
  final String schedule;
  final void Function() onEdit;
  final void Function() onDelete;

  const _ScheduleTile({
    required this.weekday,
    required this.schedule,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: weekday,
      subtitle: schedule,
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onEdit, 
            icon: const Icon(Icons.edit_rounded),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onDelete, 
            icon: const Icon(Icons.delete_rounded),
            tooltip: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 16, 
        top: 6,
        right: 12,
        bottom: 6
      )
    );
  }
}