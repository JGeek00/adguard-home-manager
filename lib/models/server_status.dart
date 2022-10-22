import 'package:adguard_home_manager/models/clients.dart';
import 'package:adguard_home_manager/models/dns_statistics.dart';

class ServerStatus {
  int loadStatus;
  ServerStatusData? data;

  ServerStatus({
    required this.loadStatus,
    this.data
  });
}
class ServerStatusData {
  final DnsStatistics stats;
  final List<Client> clients;
  bool generalEnabled;
  bool filteringEnabled;
  bool safeSearchEnabled;
  bool safeBrowsingEnabled;
  bool parentalControlEnabled;

  ServerStatusData({
    required this.stats,
    required this.clients,
    required this.generalEnabled,
    required this.filteringEnabled,
    required this.safeSearchEnabled,
    required this.safeBrowsingEnabled,
    required this.parentalControlEnabled
  });

  factory ServerStatusData.fromJson(Map<String, dynamic> json) => ServerStatusData(
    stats: DnsStatistics.fromJson(json['stats']),
    clients: json["clients"] != null ? List<Client>.from(json["clients"].map((x) => Client.fromJson(x))) : [],
    generalEnabled: json['generalEnabled']['protection_enabled'],
    filteringEnabled: json['filteringEnabled']['enabled'],
    safeSearchEnabled: json['safeSearchEnabled']['enabled'],
    safeBrowsingEnabled: json['safeBrowsingEnabled']['enabled'],
    parentalControlEnabled: json['parentalControlEnabled']['enabled']
  );
}