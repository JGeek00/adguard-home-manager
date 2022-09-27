import 'package:adguard_home_manager/models/dns_statistics.dart';

class ServerStatus {
  final DnsStatistics stats;
  final bool generalEnabled;
  final bool filteringEnabled;
  final bool safeSearchEnabled;
  final bool safeBrowsingEnabled;
  final bool parentalControlEnabled;

  const ServerStatus({
    required this.stats,
    required this.generalEnabled,
    required this.filteringEnabled,
    required this.safeSearchEnabled,
    required this.safeBrowsingEnabled,
    required this.parentalControlEnabled
  });

  factory ServerStatus.fromJson(Map<String, dynamic> json) => ServerStatus(
    stats: DnsStatistics.fromJson(json['stats']),
    generalEnabled: json['generalEnabled']['protection_enabled'],
    filteringEnabled: json['filteringEnabled']['enabled'],
    safeSearchEnabled: json['safeSearchEnabled']['enabled'],
    safeBrowsingEnabled: json['safeBrowsingEnabled']['enabled'],
    parentalControlEnabled: json['parentalControlEnabled']['enabled']
  );
}