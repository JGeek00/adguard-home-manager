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
  final DateTime notBefore;
  final DateTime notAfter;
  final dynamic dnsNames;
  final bool validKey;
  final bool validPair;
  final bool enabled;
  final bool forceHttps;
  final int portHttps;
  final int portDnsOverTls;
  final int portDnsOverQuic;
  final int portDnscrypt;
  final String dnscryptConfigFile;
  final bool allowUnencryptedDoh;
  final String certificateChain;
  final String privateKey;
  final String certificatePath;
  final String privateKeyPath;
  final bool privateKeySaved;

  EncryptionData({
    required this.validCert,
    required this.validChain,
    required this.notBefore,
    required this.notAfter,
    required this.dnsNames,
    required this.validKey,
    required this.validPair,
    required this.enabled,
    required this.forceHttps,
    required this.portHttps,
    required this.portDnsOverTls,
    required this.portDnsOverQuic,
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
    notBefore: DateTime.parse(json["not_before"]),
    notAfter: DateTime.parse(json["not_after"]),
    dnsNames: json["dns_names"],
    validKey: json["valid_key"],
    validPair: json["valid_pair"],
    enabled: json["enabled"],
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
    "valid_cert": validCert,
    "valid_chain": validChain,
    "not_before": notBefore.toIso8601String(),
    "not_after": notAfter.toIso8601String(),
    "dns_names": dnsNames,
    "valid_key": validKey,
    "valid_pair": validPair,
    "enabled": enabled,
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
