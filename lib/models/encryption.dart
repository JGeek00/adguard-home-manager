import 'dart:convert';

class Encryption {
  int loadStatus = 0;
  EncryptionData? data;

  Encryption({
    required this.loadStatus,
    this.data
  });
}

EncryptionData encryptionDataFromJson(String str) => EncryptionData.fromJson(json.decode(str));

String encryptionDataToJson(EncryptionData data) => json.encode(data.toJson());

class EncryptionData {
  final bool validCert;
  final bool validChain;
  final String? subject;
  final String? issuer;
  final DateTime notBefore;
  final DateTime notAfter;
  final List<String> dnsNames;
  final bool validKey;
  final String? keyType;
  final bool validPair;
  final bool enabled;
  final String? serverName;
  final bool? forceHttps;
  final int? portHttps;
  final int? portDnsOverTls;
  final int? portDnsOverQuic;
  final int? portDnscrypt;
  final String? dnscryptConfigFile;
  final bool allowUnencryptedDoh;
  final String certificateChain;
  final String privateKey;
  final String certificatePath;
  final String privateKeyPath;
  final bool privateKeySaved;

  EncryptionData({
    required this.validCert,
    required this.validChain,
    this.subject,
    this.issuer,
    required this.notBefore,
    required this.notAfter,
    required this.dnsNames,
    required this.validKey,
    this.keyType,
    required this.validPair,
    required this.enabled,
    this.serverName,
    required this.forceHttps,
    this.portHttps,
    this.portDnsOverTls,
    this.portDnsOverQuic,
    required this.portDnscrypt,
    required this.dnscryptConfigFile,
    required this.allowUnencryptedDoh,
    required this.certificateChain,
    required this.privateKey,
    required this.certificatePath,
    required this.privateKeyPath,
    required this.privateKeySaved,
  });


  factory EncryptionData.fromJson(Map<String, dynamic> json) => EncryptionData(
    validCert: json["valid_cert"],
    validChain: json["valid_chain"],
    subject: json["subject"],
    issuer: json["issuer"],
    notBefore: DateTime.parse(json["not_before"]),
    notAfter: DateTime.parse(json["not_after"]),
    dnsNames: json["dns_names"] != null ? List<String>.from(json["dns_names"].map((x) => x)) : [],
    validKey: json["valid_key"],
    keyType: json["key_type"],
    validPair: json["valid_pair"],
    enabled: json["enabled"],
    serverName: json["server_name"],
    forceHttps: json["force_https"] ?? false,
    portHttps: json["port_https"],
    portDnsOverTls: json["port_dns_over_tls"],
    portDnsOverQuic: json["port_dns_over_quic"],
    portDnscrypt: json["port_dnscrypt"],
    dnscryptConfigFile: json["dnscrypt_config_file"],
    allowUnencryptedDoh: json["allow_unencrypted_doh"],
    certificateChain: json["certificate_chain"],
    privateKey: json["private_key"],
    certificatePath: json["certificate_path"],
    privateKeyPath: json["private_key_path"],
    privateKeySaved: json["private_key_saved"],
  );

  Map<String, dynamic> toJson() => {
    "valid_cert": validCert,
    "valid_chain": validChain,
    "subject": subject,
    "issuer": issuer,
    "not_before": notBefore.toIso8601String(),
    "not_after": notAfter.toIso8601String(),
    "dns_names": List<dynamic>.from(dnsNames.map((x) => x)),
    "valid_key": validKey,
    "key_type": keyType,
    "valid_pair": validPair,
    "enabled": enabled,
    "server_name": serverName,
    "force_https": forceHttps,
    "port_https": portHttps,
    "port_dns_over_tls": portDnsOverTls,
    "port_dns_over_quic": portDnsOverQuic,
    "port_dnscrypt": portDnscrypt,
    "dnscrypt_config_file": dnscryptConfigFile,
    "allow_unencrypted_doh": allowUnencryptedDoh,
    "certificate_chain": certificateChain,
    "private_key": privateKey,
    "certificate_path": certificatePath,
    "private_key_path": privateKeyPath,
    "private_key_saved": privateKeySaved,
  };
}



EncyptionValidation encyptionValidationFromJson(String str) => EncyptionValidation.fromJson(json.decode(str));

String encyptionValidationToJson(EncyptionValidation data) => json.encode(data.toJson());

class EncyptionValidation {
  final String? subject;
  final String? issuer;
  final String? keyType;
  final DateTime? notBefore;
  final DateTime? notAfter;
  final String? warningValidation;
  final List<String>? dnsNames;
  final bool? validCert;
  final bool? validChain;
  final bool? validKey;
  final bool? validPair;
  final bool? enabled;
  final String? serverName;
  final bool? forceHttps;
  final int? portHttps;
  final int? portDnsOverTls;
  final int? portDnsOverQuic;
  final int? portDnscrypt;
  final String? dnscryptConfigFile;
  final bool? allowUnencryptedDoh;
  final String? certificateChain;
  final String? privateKey;
  final String? certificatePath;
  final String? privateKeyPath;
  final bool? privateKeySaved;

  EncyptionValidation({
    this.subject,
    this.issuer,
    this.keyType,
    this.notBefore,
    this.notAfter,
    this.warningValidation,
    this.dnsNames,
    this.validCert,
    this.validChain,
    this.validKey,
    this.validPair,
    this.enabled,
    this.serverName,
    this.forceHttps,
    this.portHttps,
    this.portDnsOverTls,
    this.portDnsOverQuic,
    this.portDnscrypt,
    this.dnscryptConfigFile,
    this.allowUnencryptedDoh,
    this.certificateChain,
    this.privateKey,
    this.certificatePath,
    this.privateKeyPath,
    this.privateKeySaved,
  });

  factory EncyptionValidation.fromJson(Map<String, dynamic> json) => EncyptionValidation(
    subject: json["subject"],
    issuer: json["issuer"],
    keyType: json["key_type"],
    notBefore: json["not_before"] == null ? null : DateTime.parse(json["not_before"]),
    notAfter: json["not_after"] == null ? null : DateTime.parse(json["not_after"]),
    warningValidation: json["warning_validation"],
    dnsNames: json["dns_names"] == null ? [] : List<String>.from(json["dns_names"]!.map((x) => x)),
    validCert: json["valid_cert"],
    validChain: json["valid_chain"],
    validKey: json["valid_key"],
    validPair: json["valid_pair"],
    enabled: json["enabled"],
    serverName: json["server_name"],
    forceHttps: json["force_https"],
    portHttps: json["port_https"],
    portDnsOverTls: json["port_dns_over_tls"],
    portDnsOverQuic: json["port_dns_over_quic"],
    portDnscrypt: json["port_dnscrypt"],
    dnscryptConfigFile: json["dnscrypt_config_file"],
    allowUnencryptedDoh: json["allow_unencrypted_doh"],
    certificateChain: json["certificate_chain"],
    privateKey: json["private_key"],
    certificatePath: json["certificate_path"],
    privateKeyPath: json["private_key_path"],
    privateKeySaved: json["private_key_saved"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "issuer": issuer,
    "key_type": keyType,
    "not_before": notBefore?.toIso8601String(),
    "not_after": notAfter?.toIso8601String(),
    "warning_validation": warningValidation,
    "dns_names": dnsNames == null ? [] : List<dynamic>.from(dnsNames!.map((x) => x)),
    "valid_cert": validCert,
    "valid_chain": validChain,
    "valid_key": validKey,
    "valid_pair": validPair,
    "enabled": enabled,
    "server_name": serverName,
    "force_https": forceHttps,
    "port_https": portHttps,
    "port_dns_over_tls": portDnsOverTls,
    "port_dns_over_quic": portDnsOverQuic,
    "port_dnscrypt": portDnscrypt,
    "dnscrypt_config_file": dnscryptConfigFile,
    "allow_unencrypted_doh": allowUnencryptedDoh,
    "certificate_chain": certificateChain,
    "private_key": privateKey,
    "certificate_path": certificatePath,
    "private_key_path": privateKeyPath,
    "private_key_saved": privateKeySaved,
  };
}
