import 'dart:convert';

ClientsAllowedBlocked allowedBlockedFromJson(String str) => ClientsAllowedBlocked.fromJson(json.decode(str));

String allowedBlockedToJson(ClientsAllowedBlocked data) => json.encode(data.toJson());

class ClientsAllowedBlocked {
  ClientsAllowedBlocked({
    required this.allowedClients,
    required this.disallowedClients,
    required this.blockedHosts,
  });

  final List<String> allowedClients;
  final List<String> disallowedClients;
  final List<String> blockedHosts;

  factory ClientsAllowedBlocked.fromJson(Map<String, dynamic> json) => ClientsAllowedBlocked(
    allowedClients: List<String>.from(json["allowed_clients"].map((x) => x)),
    disallowedClients: List<String>.from(json["disallowed_clients"].map((x) => x)),
    blockedHosts: List<String>.from(json["blocked_hosts"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "allowed_clients": List<dynamic>.from(allowedClients.map((x) => x)),
    "disallowed_clients": List<dynamic>.from(disallowedClients.map((x) => x)),
    "blocked_hosts": List<dynamic>.from(blockedHosts.map((x) => x)),
  };
}
