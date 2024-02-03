class DnsInfo {
  List<String> upstreamDns;
  String? upstreamDnsFile;
  List<String> bootstrapDns;
  List<String>? fallbackDns;
  bool protectionEnabled;
  int ratelimit;
  String blockingMode;
  bool ednsCsEnabled;
  bool? ednsCsUseCustom;
  String? ednsCsCustomIp;
  bool dnssecEnabled;
  bool disableIpv6;
  String? upstreamMode;
  int? cacheSize;
  int? cacheTtlMin;
  int? cacheTtlMax;
  bool? cacheOptimistic;
  bool? resolveClients;
  bool? usePrivatePtrResolvers;
  List<String> localPtrUpstreams;
  String blockingIpv4;
  String blockingIpv6;
  List<String> defaultLocalPtrUpstreams;
  int? blockedResponseTtl;
  int? ratelimitSubnetLenIpv4;
  int? ratelimitSubnetLenIpv6;
  List<String>? ratelimitWhitelist;

  DnsInfo({
    required this.upstreamDns,
    required this.upstreamDnsFile,
    required this.bootstrapDns,
    required this.fallbackDns,
    required this.protectionEnabled,
    required this.ratelimit,
    required this.blockingMode,
    required this.ednsCsEnabled,
    required this.ednsCsUseCustom,
    required this.ednsCsCustomIp,
    required this.dnssecEnabled,
    required this.disableIpv6,
    required this.upstreamMode,
    required this.cacheSize,
    required this.cacheTtlMin,
    required this.cacheTtlMax,
    required this.cacheOptimistic,
    required this.resolveClients,
    required this.usePrivatePtrResolvers,
    required this.localPtrUpstreams,
    required this.blockingIpv4,
    required this.blockingIpv6,
    required this.defaultLocalPtrUpstreams,
    required this.blockedResponseTtl,
    required this.ratelimitSubnetLenIpv4,
    required this.ratelimitSubnetLenIpv6,
    required this.ratelimitWhitelist,
  });

  factory DnsInfo.fromJson(Map<String, dynamic> json) => DnsInfo(
    upstreamDns: json["upstream_dns"] != null ? List<String>.from(json["upstream_dns"].map((x) => x)) : [],
    upstreamDnsFile: json["upstream_dns_file"],
    bootstrapDns: json["bootstrap_dns"] != null ? List<String>.from(json["bootstrap_dns"].map((x) => x)) : [],
    fallbackDns: json["fallback_dns"] != null ? List<String>.from(json["fallback_dns"].map((x) => x)) : [],
    protectionEnabled: json["protection_enabled"],
    ratelimit: json["ratelimit"],
    blockingMode: json["blocking_mode"],
    ednsCsEnabled: json["edns_cs_enabled"],
    ednsCsUseCustom: json["edns_cs_use_custom"],
    ednsCsCustomIp: json["edns_cs_custom_ip"],
    dnssecEnabled: json["dnssec_enabled"],
    disableIpv6: json["disable_ipv6"],
    upstreamMode: json["upstream_mode"],
    cacheSize: json["cache_size"],
    cacheTtlMin: json["cache_ttl_min"],
    cacheTtlMax: json["cache_ttl_max"],
    cacheOptimistic: json["cache_optimistic"],
    resolveClients: json["resolve_clients"],
    usePrivatePtrResolvers: json["use_private_ptr_resolvers"],
    localPtrUpstreams: json["local_ptr_upstreams"] != null ? List<String>.from(json["local_ptr_upstreams"].map((x) => x)) : [],
    blockingIpv4: json["blocking_ipv4"],
    blockingIpv6: json["blocking_ipv6"],
    defaultLocalPtrUpstreams: json["default_local_ptr_upstreams"] != null ? List<String>.from(json["default_local_ptr_upstreams"].map((x) => x)) : [],
    blockedResponseTtl: json["blocked_response_ttl"],
    ratelimitSubnetLenIpv4: json["ratelimit_subnet_len_ipv4"],
    ratelimitSubnetLenIpv6: json["ratelimit_subnet_len_ipv6"],
    ratelimitWhitelist:  json["ratelimit_whitelist"] != null ? List<String>.from(json["ratelimit_whitelist"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() => {
    "upstream_dns": List<dynamic>.from(upstreamDns.map((x) => x)),
    "upstream_dns_file": upstreamDnsFile,
    "bootstrap_dns": List<dynamic>.from(bootstrapDns.map((x) => x)),
    "fallback_dns": List<dynamic>.from(bootstrapDns.map((x) => x)),
    "protection_enabled": protectionEnabled,
    "ratelimit": ratelimit,
    "blocking_mode": blockingMode,
    "edns_cs_enabled": ednsCsEnabled,
    "edns_cs_use_custom": ednsCsUseCustom,
    "edns_cs_custom_ip": ednsCsCustomIp,
    "dnssec_enabled": dnssecEnabled,
    "disable_ipv6": disableIpv6,
    "upstream_mode": upstreamMode,
    "cache_size": cacheSize,
    "cache_ttl_min": cacheTtlMin,
    "cache_ttl_max": cacheTtlMax,
    "cache_optimistic": cacheOptimistic,
    "resolve_clients": resolveClients,
    "use_private_ptr_resolvers": usePrivatePtrResolvers,
    "local_ptr_upstreams": List<dynamic>.from(localPtrUpstreams.map((x) => x)),
    "blocking_ipv4": blockingIpv4,
    "blocking_ipv6": blockingIpv6,
    "default_local_ptr_upstreams": List<dynamic>.from(defaultLocalPtrUpstreams.map((x) => x)),
    "blocked_response_ttl": blockedResponseTtl,
    "ratelimit_subnet_len_ipv4": ratelimitSubnetLenIpv4,
    "ratelimit_subnet_len_ipv6": ratelimitSubnetLenIpv6,
    "ratelimit_whitelist": ratelimitWhitelist != null ? List<String>.from(ratelimitWhitelist!.map((x) => x)) : null,
  };
}
