import 'package:adguard_home_manager/constants/enums.dart';

class UpdateAvailable {
  LoadStatus loadStatus = LoadStatus.loading;
  UpdateAvailableData? data;

  UpdateAvailable({
    required this.loadStatus,
    required this.data
  });
}

class UpdateAvailableData {
  String currentVersion;
  final String newVersion;
  final String announcement;
  final String announcementUrl;
  final bool canAutoupdate;
  final bool disabled;
  String? changelog;
  bool? updateAvailable;

  UpdateAvailableData({
    required this.currentVersion,
    required this.newVersion,
    required this.announcement,
    required this.announcementUrl,
    required this.canAutoupdate,
    required this.disabled,
    this.changelog,
    this.updateAvailable
  });

  factory UpdateAvailableData.fromJson(Map<String, dynamic> json) => UpdateAvailableData(
    currentVersion: json["current_version"],
    newVersion: json["new_version"],
    announcement: json["announcement"],
    announcementUrl: json["announcement_url"],
    canAutoupdate: json["can_autoupdate"],
    disabled: json["disabled"],
    changelog: json["changelog"],
    updateAvailable: json['update_available']
  );

  Map<String, dynamic> toJson() => {
    "current_version": currentVersion,
    "new_version": newVersion,
    "announcement": announcement,
    "announcement_url": announcementUrl,
    "can_autoupdate": canAutoupdate,
    "disabled": disabled,
    "changelog": changelog,
    "update_available": updateAvailable
  };
}
