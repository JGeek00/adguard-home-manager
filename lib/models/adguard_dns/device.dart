class Device {
  final String id;
  final String name;
  final String dnsServerId;
  final String deviceType;
  final DnsAddresses dnsAddresses;
  final DeviceSettings settings;

  Device({
    required this.id,
    required this.name,
    required this.dnsServerId,
    required this.deviceType,
    required this.dnsAddresses,
    required this.settings,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      dnsServerId: json['dns_server_id'],
      deviceType: json['device_type'],
      dnsAddresses: DnsAddresses.fromJson(json['dns_addresses']),
      settings: DeviceSettings.fromJson(json['settings']),
    );
  }
}

class DnsAddresses {
  final String dnsOverHttps;
  final String dnsOverTls;
  final String dnsOverQuic;
  final String? dnsOverHttpsWithAuth;
  final List<IpAddress> ipAddresses;

  DnsAddresses({
    required this.dnsOverHttps,
    required this.dnsOverTls,
    required this.dnsOverQuic,
    this.dnsOverHttpsWithAuth,
    required this.ipAddresses,
  });

  factory DnsAddresses.fromJson(Map<String, dynamic> json) {
    return DnsAddresses(
      dnsOverHttps: json['dns_over_https_url'],
      dnsOverTls: json['dns_over_tls_url'],
      dnsOverQuic: json['dns_over_quic_url'],
      dnsOverHttpsWithAuth: json['dns_over_https_with_auth_url'],
      ipAddresses: (json['ip_addresses'] as List?)
          ?.map((e) => IpAddress.fromJson(e))
          .toList() ?? [],
    );
  }
}

class IpAddress {
  final String ipAddress;
  final String type;

  IpAddress({
    required this.ipAddress,
    required this.type,
  });

  factory IpAddress.fromJson(Map<String, dynamic> json) {
    return IpAddress(
      ipAddress: json['ip_address'],
      type: json['type'],
    );
  }
}

class DeviceSettings {
  final bool protectionEnabled;
  final bool detectDohAuthOnly;

  DeviceSettings({
    required this.protectionEnabled,
    required this.detectDohAuthOnly,
  });

  factory DeviceSettings.fromJson(Map<String, dynamic> json) {
    return DeviceSettings(
      protectionEnabled: json['protection_enabled'],
      detectDohAuthOnly: json['detect_doh_auth_only'],
    );
  }
}
