import 'dart:convert';

ClientsAllowedBlocked allowedBlockedFromJson(String str) => ClientsAllowedBlocked.fromJson(json.decode(str));

String allowedBlockedToJson(ClientsAllowedBlocked data) => json.encode(data.toJson());

class ClientsAllowedBlocked {
  List<String> allowedClients;
  List<String> disallowedClients;
  List<String> blockedHosts;

  ClientsAllowedBlocked({
    required this.allowedClients,
    required this.disallowedClients,
    required this.blockedHosts,
  });

  factory ClientsAllowedBlocked.fromJson(Map<String, dynamic> json) => ClientsAllowedBlocked(
    allowedClients: json["allowed_clients"] != null ? List<String>.from(json["allowed_clients"].map((x) => x)) : [],
    disallowedClients: json["disallowed_clients"] != null ? List<String>.from(json["disallowed_clients"].map((x) => x)) : [],
    blockedHosts: json["blocked_hosts"] != null ? List<String>.from(json["blocked_hosts"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "allowed_clients": List<dynamic>.from(allowedClients.map((x) => x)),
    "disallowed_clients": List<dynamic>.from(disallowedClients.map((x) => x)),
    "blocked_hosts": List<dynamic>.from(blockedHosts.map((x) => x)),
  };
}
