class AccountLimits {
  final Limit accessRules;
  final Limit dedicatedIpv4;
  final Limit devices;
  final Limit dnsServers;
  final Limit requests;
  final Limit userRules;

  AccountLimits({
    required this.accessRules,
    required this.dedicatedIpv4,
    required this.devices,
    required this.dnsServers,
    required this.requests,
    required this.userRules,
  });

  factory AccountLimits.fromJson(Map<String, dynamic> json) {
    return AccountLimits(
      accessRules: Limit.fromJson(json['access_rules']),
      dedicatedIpv4: Limit.fromJson(json['dedicated_ipv4']),
      devices: Limit.fromJson(json['devices']),
      dnsServers: Limit.fromJson(json['dns_servers']),
      requests: Limit.fromJson(json['requests']),
      userRules: Limit.fromJson(json['user_rules']),
    );
  }
}

class Limit {
  final int limit;
  final int used;

  Limit({
    required this.limit,
    required this.used,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      limit: json['limit'],
      used: json['used'],
    );
  }
}
