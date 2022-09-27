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
  final bool generalEnabled;
  final bool filteringEnabled;
  final bool safeSearchEnabled;
  final bool safeBrowsingEnabled;
  final bool parentalControlEnabled;

  const ServerStatusData({
    required this.stats,
    required this.generalEnabled,
    required this.filteringEnabled,
    required this.safeSearchEnabled,
    required this.safeBrowsingEnabled,
    required this.parentalControlEnabled
  });

  factory ServerStatusData.fromJson(Map<String, dynamic> json) => ServerStatusData(
    stats: DnsStatistics.fromJson(json['stats']),
    generalEnabled: json['generalEnabled']['protection_enabled'],
    filteringEnabled: json['filteringEnabled']['enabled'],
    safeSearchEnabled: json['safeSearchEnabled']['enabled'],
    safeBrowsingEnabled: json['safeBrowsingEnabled']['enabled'],
    parentalControlEnabled: json['parentalControlEnabled']['enabled']
  );
}