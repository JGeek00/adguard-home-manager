import 'dart:convert';

import 'package:adguard_home_manager/models/clients_allowed_blocked.dart';

class Clients {
  int loadStatus;
  ClientsData? data;

  Clients({
    required this.loadStatus,
    this.data
  });
}

ClientsData clientsFromJson(String str) => ClientsData.fromJson(json.decode(str));

String clientsToJson(ClientsData data) => json.encode(data.toJson());

class ClientsData {
  final List<Client> clients;
  final List<AutoClient> autoClientsData;
  final List<String> supportedTags;
  ClientsAllowedBlocked? clientsAllowedBlocked;

  ClientsData({
    required this.clients,
    required this.autoClientsData,
    required this.supportedTags,
    this.clientsAllowedBlocked
  });

  factory ClientsData.fromJson(Map<String, dynamic> json) => ClientsData(
    clients: json["clients"] != null ? List<Client>.from(json["clients"].map((x) => Client.fromJson(x))) : [],
    autoClientsData: json["auto_clients"] != null ? List<AutoClient>.from(json["auto_clients"].map((x) => AutoClient.fromJson(x))) : [],
    supportedTags: json["supported_tags"] != null ? List<String>.from(json["supported_tags"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
    "auto_clients": List<dynamic>.from(autoClientsData.map((x) => x.toJson())),
    "supported_tags": List<dynamic>.from(supportedTags.map((x) => x)),
  };
}

class AutoClient {
  final WhoisInfo whoisInfo;
  final String? name;
  final String source;
  final String ip;

  AutoClient({
    required this.whoisInfo,
    this.name,
    required this.source,
    required this.ip,
  });

  factory AutoClient.fromJson(Map<String, dynamic> json) => AutoClient(
    whoisInfo: WhoisInfo.fromJson(json["whois_info"]),
    name: json["name"],
    source: json["source"],
    ip: json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "whois_info": whoisInfo.toJson(),
    "name": name,
    "source": source,
    "ip": ip,
  };
}

class WhoisInfo {
  WhoisInfo();

  factory WhoisInfo.fromJson(Map<String, dynamic> json) => WhoisInfo();

  Map<String, dynamic> toJson() => {};
}

class Client {
  final String name;
  final dynamic blockedServices;
  final List<String> ids;
  final List<String> tags;
  final List<dynamic> upstreams;
  final bool filteringEnabled;
  final bool parentalEnabled;
  final bool safebrowsingEnabled;
  final bool safesearchEnabled;
  final bool useGlobalBlockedServices;
  final bool useGlobalSettings;

  Client({
    required this.name,
    required this.blockedServices,
    required this.ids,
    required this.tags,
    required this.upstreams,
    required this.filteringEnabled,
    required this.parentalEnabled,
    required this.safebrowsingEnabled,
    required this.safesearchEnabled,
    required this.useGlobalBlockedServices,
    required this.useGlobalSettings,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    name: json["name"],
    blockedServices: json["blocked_services"],
    ids: List<String>.from(json["ids"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
    upstreams: List<dynamic>.from(json["upstreams"].map((x) => x)),
    filteringEnabled: json["filtering_enabled"],
    parentalEnabled: json["parental_enabled"],
    safebrowsingEnabled: json["safebrowsing_enabled"],
    safesearchEnabled: json["safesearch_enabled"],
    useGlobalBlockedServices: json["use_global_blocked_services"],
    useGlobalSettings: json["use_global_settings"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "blocked_services": blockedServices,
    "ids": List<dynamic>.from(ids.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "upstreams": List<dynamic>.from(upstreams.map((x) => x)),
    "filtering_enabled": filteringEnabled,
    "parental_enabled": parentalEnabled,
    "safebrowsing_enabled": safebrowsingEnabled,
    "safesearch_enabled": safesearchEnabled,
    "use_global_blocked_services": useGlobalBlockedServices,
    "use_global_settings": useGlobalSettings,
  };
}