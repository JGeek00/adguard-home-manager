import 'package:adguard_home_manager/functions/time_server_disabled.dart';
import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/dns_statistics.dart';
import 'package:adguard_home_manager/models/filtering_status.dart';

class ServerStatus {
  final DnsStatistics stats;
  final List<Client> clients;
  final FilteringStatus filteringStatus;
  int timeGeneralDisabled;
  DateTime? disabledUntil;
  bool generalEnabled;
  bool filteringEnabled;
  bool safeSearchEnabled;
  bool safeBrowsingEnabled;
  bool parentalControlEnabled;
  final String serverVersion;
  bool? safeSeachBing;
  bool? safeSearchGoogle;
  bool? safeSearchDuckduckgo;
  bool? safeSearchPixabay;
  bool? safeSearchYandex;
  bool? safeSearchYoutube;
  bool dhcpAvailable;

  ServerStatus({
    required this.stats,
    required this.clients,
    required this.filteringStatus,
    required this.timeGeneralDisabled,
    this.disabledUntil,
    required this.generalEnabled,
    required this.filteringEnabled,
    required this.safeSearchEnabled,
    required this.safeBrowsingEnabled,
    required this.parentalControlEnabled,
    required this.serverVersion,
    required this.safeSeachBing,
    required this.safeSearchGoogle,
    required this.safeSearchDuckduckgo,
    required this.safeSearchPixabay,
    required this.safeSearchYandex,
    required this.safeSearchYoutube,
    required this.dhcpAvailable,
  });

  factory ServerStatus.fromJson(Map<String, dynamic> json) => ServerStatus(
    stats: DnsStatistics.fromJson(json['stats']),
    clients: json["clients"] != null ? List<Client>.from(json["clients"].map((x) => Client.fromJson(x))) : [],
    generalEnabled: json['status']['protection_enabled'],
    timeGeneralDisabled: json['status']['protection_disabled_duration'] ?? 0,
    disabledUntil: json['status']['protection_disabled_duration'] != null
      ? json['status']['protection_disabled_duration'] > 0 
        ? generateTimeDeadline(json['status']['protection_disabled_duration'])
        : null
      : null,
    filteringStatus: FilteringStatus.fromJson(json['filtering']),
    filteringEnabled: json['filtering']['enabled'],
    safeSearchEnabled: json['safeSearch']['enabled'],
    safeBrowsingEnabled: json['safeBrowsingEnabled']['enabled'],
    parentalControlEnabled: json['parentalControlEnabled']['enabled'],
    serverVersion: json['status']['version'],
    safeSeachBing: json['safeSearch']['bing'],
    safeSearchDuckduckgo: json['safeSearch']['duckduckgo'],
    safeSearchGoogle: json['safeSearch']['google'],
    safeSearchPixabay: json['safeSearch']['pixabay'],
    safeSearchYandex: json['safeSearch']['yandex'],
    safeSearchYoutube: json['safeSearch']['youtube'],
    dhcpAvailable: json['status']['dhcp_available'] ?? false
  );
}