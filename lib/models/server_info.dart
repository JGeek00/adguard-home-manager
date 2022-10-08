import 'dart:convert';

class ServerInfo {
  int loadStatus = 0;
  ServerInfoData? data;

  ServerInfo({
    required this.loadStatus,
    this.data
  });
}

ServerInfoData serverInfoDataFromJson(String str) => ServerInfoData.fromJson(json.decode(str));

String serverInfoDataToJson(ServerInfoData data) => json.encode(data.toJson());

class ServerInfoData {
  final List<String> dnsAddresses;
  final int dnsPort;
  final int httpPort;
  final bool protectionEnabled;
  final bool dhcpAvailable;
  final bool running;
  final String version;
  final String language;

  ServerInfoData({
    required this.dnsAddresses,
    required this.dnsPort,
    required this.httpPort,
    required this.protectionEnabled,
    required this.dhcpAvailable,
    required this.running,
    required this.version,
    required this.language,
  });


  factory ServerInfoData.fromJson(Map<String, dynamic> json) => ServerInfoData(
    dnsAddresses: List<String>.from(json["dns_addresses"].map((x) => x)),
    dnsPort: json["dns_port"],
    httpPort: json["http_port"],
    protectionEnabled: json["protection_enabled"],
    dhcpAvailable: json["dhcp_available"],
    running: json["running"],
    version: json["version"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "dns_addresses": List<dynamic>.from(dnsAddresses.map((x) => x)),
    "dns_port": dnsPort,
    "http_port": httpPort,
    "protection_enabled": protectionEnabled,
    "dhcp_available": dhcpAvailable,
    "running": running,
    "version": version,
    "language": language,
  };
}
