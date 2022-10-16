import 'dart:convert';

FilteringData filteringFromJson(String str) => FilteringData.fromJson(json.decode(str));

String filteringToJson(FilteringData data) => json.encode(data.toJson());

class Filtering {
  int loadStatus = 0;
  FilteringData? data;

  Filtering({
    required this.loadStatus,
    this.data
  });
}

class FilteringData {
  final List<Filter> filters;
  final List<Filter> whitelistFilters;
  List<String> userRules;
  List<String> blockedServices;
  int interval;
  bool enabled;

  FilteringData({
    required this.filters,
    required this.whitelistFilters,
    required this.userRules,
    required this.blockedServices,
    required this.interval,
    required this.enabled,
  });

  factory FilteringData.fromJson(Map<String, dynamic> json) => FilteringData(
    filters: json["filters"] != null ? List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))) : [],
    whitelistFilters: json["whitelist_filters"] != null ? List<Filter>.from(json["whitelist_filters"].map((x) => Filter.fromJson(x))) : [],
    userRules: json["user_rules"] != null ? List<String>.from(json["user_rules"].map((x) => x)).where((i) => i != '').toList() : [],
    blockedServices: json["blocked_services"] != null ? List<String>.from(json["blocked_services"].map((x) => x)).where((i) => i != '').toList() : [],
    interval: json["interval"],
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
    "whitelist_filters": List<dynamic>.from(whitelistFilters.map((x) => x.toJson())),
    "user_rules": List<dynamic>.from(userRules.map((x) => x)),
    "blocked_services": List<dynamic>.from(blockedServices.map((x) => x)),
    "interval": interval,
    "enabled": enabled,
  };
}

class Filter {
  final String url;
  final String name;
  final DateTime? lastUpdated;
  final int id;
  final int rulesCount;
  final bool enabled;

  Filter({
    required this.url,
    required this.name,
    required this.lastUpdated,
    required this.id,
    required this.rulesCount,
    required this.enabled,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    url: json["url"],
    name: json["name"],
    lastUpdated: json["last_updated"] != '' ? DateTime.parse(json["last_updated"]) : null,
    id: json["id"],
    rulesCount: json["rules_count"],
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "last_updated": lastUpdated != null ? lastUpdated!.toIso8601String() : null,
    "id": id,
    "rules_count": rulesCount,
    "enabled": enabled,
  };
}
