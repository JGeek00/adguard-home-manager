import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/logs_settings/logs_settings.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/master_switch.dart';
import 'package:adguard_home_manager/widgets/custom_checkbox_list_tile.dart';

class LogsConfigOptions extends StatelessWidget {
  final bool generalSwitch;
  final void Function(bool) updateGeneralSwitch;
  final bool anonymizeClientIp;
  final void Function(bool) updateAnonymizeClientIp;
  final List<String> retentionItems; 
  final String? retentionTime;
  final void Function(String?) updateRetentionTime;
  final void Function() onClear;
  final void Function() onConfirm;
  final List<DomainListItemController> ignoredDomainsControllers;
  final void Function(List<DomainListItemController>) updateIgnoredDomainsControllers;
  final TextEditingController customTimeController;
  final String? customTimeError;
  final void Function(String) validateCustomTime;

  const LogsConfigOptions({
    super.key,
    required this.generalSwitch,
    required this.updateGeneralSwitch,
    required this.anonymizeClientIp,
    required this.updateAnonymizeClientIp,
    required this.retentionItems,
    required this.retentionTime,
    required this.updateRetentionTime,
    required this.onClear,
    required this.onConfirm,
    required this.ignoredDomainsControllers,
    required this.updateIgnoredDomainsControllers,
    required this.customTimeController,
    required this.customTimeError,
    required this.validateCustomTime,
  });

  @override
  Widget build(BuildContext context) {
    const Uuid uuid = Uuid();
    
    final List<String> dropdownItemTranslation = [
      AppLocalizations.of(context)!.custom,
      AppLocalizations.of(context)!.hours6,
      AppLocalizations.of(context)!.hours24,
      AppLocalizations.of(context)!.days7,
      AppLocalizations.of(context)!.days30,
      AppLocalizations.of(context)!.days90,
    ];

    void validateDomain(String value, String id) {
      final domainRegex = RegExp(r'^([a-z0-9|-]+\.)*[a-z0-9|-]+\.[a-z]+$');
      bool error = false;
      if (domainRegex.hasMatch(value)) {
        error = false;
      }
      else {
        error = true;
      }
      updateIgnoredDomainsControllers(
        ignoredDomainsControllers.map((entry) {
          if (entry.id != id) return entry;
          return DomainListItemController(
            id: id, 
            controller: entry.controller, 
            error: error
          );
        }).toList()
      );
    }
print(retentionTime);
    return ListView(
      children: [
        const SizedBox(height: 16),
        MasterSwitch(
          label: AppLocalizations.of(context)!.enableLog, 
          value: generalSwitch, 
          onChange: updateGeneralSwitch
        ),
        const SizedBox(height: 16),
        CustomCheckboxListTile(
          value: anonymizeClientIp, 
          onChanged: (_) => updateAnonymizeClientIp(!anonymizeClientIp),
          title: AppLocalizations.of(context)!.anonymizeClientIp,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField(
            items: retentionItems.asMap().entries.map((item) => DropdownMenuItem(
              value: item.value,
              child: Text(dropdownItemTranslation[item.key]),
            )).toList(),
            value: retentionTime,
            onChanged: (value) => updateRetentionTime(value.toString()),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                )
              ),
              label: Text(AppLocalizations.of(context)!.retentionTime)
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        if (retentionTime == "custom") Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: TextFormField(
            controller: customTimeController,
            onChanged: validateCustomTime,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.schedule_rounded),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10)
                )
              ),
              labelText: AppLocalizations.of(context)!.customTimeInHours,
              errorText: customTimeError
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionLabel(
                label: AppLocalizations.of(context)!.ignoredDomains,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton(
                  onPressed: () => updateIgnoredDomainsControllers([
                    ...ignoredDomainsControllers,
                    DomainListItemController(
                      id: uuid.v4(), 
                      controller: TextEditingController(),
                      error: false
                    ),
                  ]),
                  icon: const Icon(Icons.add)
                ),
              )
            ],
          ),
        ),
        if (ignoredDomainsControllers.isNotEmpty) ...ignoredDomainsControllers.map((controller) => Padding(
          padding: const EdgeInsets.only(
            top: 12, bottom: 12, left: 16, right: 6
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.controller,
                  onChanged: (v) => validateDomain(v, controller.id),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.link_rounded),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    labelText: AppLocalizations.of(context)!.domain,
                    errorText: controller.error 
                      ? AppLocalizations.of(context)!.invalidDomain
                      : null
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: controller.error
                  ? const EdgeInsets.only(bottom: 24)
                  : const EdgeInsets.all(0),
                child: IconButton(
                  onPressed: () => updateIgnoredDomainsControllers(
                    ignoredDomainsControllers.where((e) => e.id != controller.id).toList()
                  ),
                  icon: const Icon(Icons.remove_circle_outline_outlined)
                ),
              )
            ],
          ),
        )),
        if (ignoredDomainsControllers.isEmpty) Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            AppLocalizations.of(context)!.noIgnoredDomainsAdded,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}