import 'dart:convert';
class DhcpModel {
  bool dhcpAvailable;
  List<NetworkInterface> networkInterfaces;
  DhcpStatus? dhcpStatus;

  DhcpModel({
    required this.dhcpAvailable,
    required this.networkInterfaces,
    required this.dhcpStatus,
  });
}

NetworkInterface networkInterfaceFromJson(String str) => NetworkInterface.fromJson(json.decode(str));

String networkInterfaceToJson(NetworkInterface data) => json.encode(data.toJson());

class NetworkInterface {
  String name;
  String hardwareAddress;
  List<String> flags;
  String? gatewayIp;
  List<String> ipv4Addresses;
  List<String> ipv6Addresses;

  NetworkInterface({
    required this.name,
    required this.hardwareAddress,
    required this.flags,
    required this.gatewayIp,
    required this.ipv4Addresses,
    required this.ipv6Addresses,
  });

  factory NetworkInterface.fromJson(Map<String, dynamic> json) => NetworkInterface(
    name: json["name"],
    hardwareAddress: json["hardware_address"],
    flags: json["flags"] != null ? json["flags"].split("|") : [],
    gatewayIp: json["gateway_ip"],
    ipv4Addresses: json["ipv4_addresses"] != null ? List<String>.from(json["ipv4_addresses"].map((x) => x)) : [],
    ipv6Addresses: json["ipv6_addresses"] != null ? List<String>.from(json["ipv6_addresses"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "hardware_address": hardwareAddress,
    "flags": flags,
    "gateway_ip": gatewayIp,
    "ipv4_addresses": List<dynamic>.from(ipv4Addresses.map((x) => x)),
    "ipv6_addresses": List<dynamic>.from(ipv6Addresses.map((x) => x)),
  };
}

DhcpStatus dhcpStatusFromJson(String str) => DhcpStatus.fromJson(json.decode(str));

String dhcpStatusToJson(DhcpStatus data) => json.encode(data.toJson());

class DhcpStatus {
  String? interfaceName;
  IpVersion? v4;
  IpVersion? v6;
  List<Lease> leases;
  List<Lease> staticLeases;
  bool enabled;

  DhcpStatus({
    required this.interfaceName,
    required this.v4,
    required this.v6,
    required this.leases,
    required this.staticLeases,
    required this.enabled,
  });

  factory DhcpStatus.fromJson(Map<String, dynamic> json) => DhcpStatus(
    interfaceName: json["interface_name"],
    v4: json["v4"] != null ? IpVersion.fromJson(json["v4"]) : null,
    v6: json["v6"] != null ? IpVersion.fromJson(json["v6"]) : null,
    leases: List<Lease>.from(json["leases"].map((x) => Lease.fromJson(x))),
    staticLeases: List<Lease>.from(json["static_leases"].map((x) => Lease.fromJson(x))),
    enabled: json["enabled"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "interface_name": interfaceName,
    "v4": v4 != null ? v4!.toJson() : null,
    "v6": v6 != null ? v6!.toJson() : null,
    "leases": List<Lease>.from(leases.map((x) => x)),
    "static_leases": List<Lease>.from(staticLeases.map((x) => x)),
    "enabled": enabled,
  };
}

class IpVersion {
  String? gatewayIp;
  String? subnetMask;
  String rangeStart;
  String? rangeEnd;
  int leaseDuration;

  IpVersion({
    this.gatewayIp,
    this.subnetMask,
    required this.rangeStart,
    this.rangeEnd,
    required this.leaseDuration,
  });

  factory IpVersion.fromJson(Map<String, dynamic> json) => IpVersion(
    gatewayIp: json["gateway_ip"],
    subnetMask: json["subnet_mask"],
    rangeStart: json["range_start"],
    rangeEnd: json["range_end"],
    leaseDuration: json["lease_duration"],
  );

  Map<String, dynamic> toJson() => {
    "gateway_ip": gatewayIp,
    "subnet_mask": subnetMask,
    "range_start": rangeStart,
    "range_end": rangeEnd,
    "lease_duration": leaseDuration,
  };
}

class Lease {
  final String mac;
  final String hostname;
  final String ip;

  Lease({
    required this.mac,
    required this.hostname,
    required this.ip,
  });

  factory Lease.fromJson(Map<String, dynamic> json) => Lease(
    mac: json["mac"],
    hostname: json["hostname"],
    ip: json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "mac": mac,
    "hostname": hostname,
    "ip": ip,
  };
}
