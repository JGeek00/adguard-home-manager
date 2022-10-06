import 'dart:convert';

AddClient addClientFromJson(String str) => AddClient.fromJson(json.decode(str));

String addClientToJson(AddClient data) => json.encode(data.toJson());

class AddClient {
  AddClient({
    required this.name,
    required this.ids,
    required this.useGlobalSettings,
    required this.filteringEnabled,
    required this.parentalEnabled,
    required this.safebrowsingEnabled,
    required this.safesearchEnabled,
    required this.useGlobalBlockedServices,
    required this.blockedServices,
    required this.upstreams,
    required this.tags,
  });

  final String name;
  final List<String> ids;
  final bool useGlobalSettings;
  final bool filteringEnabled;
  final bool parentalEnabled;
  final bool safebrowsingEnabled;
  final bool safesearchEnabled;
  final bool useGlobalBlockedServices;
  final List<String> blockedServices;
  final List<String> upstreams;
  final List<String> tags;

  factory AddClient.fromJson(Map<String, dynamic> json) => AddClient(
    name: json["name"],
    ids: List<String>.from(json["ids"].map((x) => x)),
    useGlobalSettings: json["use_global_settings"],
    filteringEnabled: json["filtering_enabled"],
    parentalEnabled: json["parental_enabled"],
    safebrowsingEnabled: json["safebrowsing_enabled"],
    safesearchEnabled: json["safesearch_enabled"],
    useGlobalBlockedServices: json["use_global_blocked_services"],
    blockedServices: List<String>.from(json["blocked_services"].map((x) => x)),
    upstreams: List<String>.from(json["upstreams"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ids": List<dynamic>.from(ids.map((x) => x)),
    "use_global_settings": useGlobalSettings,
    "filtering_enabled": filteringEnabled,
    "parental_enabled": parentalEnabled,
    "safebrowsing_enabled": safebrowsingEnabled,
    "safesearch_enabled": safesearchEnabled,
    "use_global_blocked_services": useGlobalBlockedServices,
    "blocked_services": List<dynamic>.from(blockedServices.map((x) => x)),
    "upstreams": List<dynamic>.from(upstreams.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
  };
}
