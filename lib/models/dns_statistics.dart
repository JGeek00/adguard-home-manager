import 'dart:convert';

DnsStatistics dnsStatisticsFromJson(String str) => DnsStatistics.fromJson(json.decode(str));

String dnsStatisticsToJson(DnsStatistics data) => json.encode(data.toJson());

class DnsStatistics {
  final String? timeUnits;
  final List<Map<String, int>> topQueriedDomains;
  final List<Map<String, int>> topClients;
  final List<Map<String, int>> topBlockedDomains;
  final List<Map<String, int>>? topUpstreamResponses;
  final List<Map<String, double>>? topUpstreamsAvgTime;
  final List<int> dnsQueries;
  final List<int> blockedFiltering;
  final List<int> replacedSafebrowsing;
  final List<int> replacedParental;
  final int numDnsQueries;
  final int numBlockedFiltering;
  final int numReplacedSafebrowsing;
  final int numReplacedSafesearch;
  final int numReplacedParental;
  final double avgProcessingTime;

  DnsStatistics({
    required this.timeUnits,
    required this.topQueriedDomains,
    required this.topClients,
    required this.topBlockedDomains,
    required this.topUpstreamResponses,
    required this.topUpstreamsAvgTime,
    required this.dnsQueries,
    required this.blockedFiltering,
    required this.replacedSafebrowsing,
    required this.replacedParental,
    required this.numDnsQueries,
    required this.numBlockedFiltering,
    required this.numReplacedSafebrowsing,
    required this.numReplacedSafesearch,
    required this.numReplacedParental,
    required this.avgProcessingTime,
  });

  factory DnsStatistics.fromJson(Map<String, dynamic> json) => DnsStatistics(
    timeUnits: json["time_units"],
    topQueriedDomains: json["top_queried_domains"] != null ? List<Map<String, int>>.from(json["top_queried_domains"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))) : [],
    topClients: json["top_clients"] != null ? List<Map<String, int>>.from(json["top_clients"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))) : [],
    topBlockedDomains: json["top_blocked_domains"] != null ? List<Map<String, int>>.from(json["top_blocked_domains"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))): [],
    topUpstreamResponses: json["top_upstreams_responses"] != null ? List<Map<String, int>>.from(json["top_upstreams_responses"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))) : null,
    topUpstreamsAvgTime: json["top_upstreams_avg_time"] != null ? List<Map<String, double>>.from(json["top_upstreams_avg_time"].map((x) => Map.from(x).map((k, v) => MapEntry<String, double>(k, v)))) : null,
    dnsQueries: List<int>.from(json["dns_queries"].map((x) => x)),
    blockedFiltering: List<int>.from(json["blocked_filtering"].map((x) => x)),
    replacedSafebrowsing: List<int>.from(json["replaced_safebrowsing"].map((x) => x)),
    replacedParental: List<int>.from(json["replaced_parental"].map((x) => x)),
    numDnsQueries: json["num_dns_queries"],
    numBlockedFiltering: json["num_blocked_filtering"],
    numReplacedSafebrowsing: json["num_replaced_safebrowsing"],
    numReplacedSafesearch: json["num_replaced_safesearch"],
    numReplacedParental: json["num_replaced_parental"],
    avgProcessingTime: json["avg_processing_time"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time_units": timeUnits,
    "top_queried_domains": List<dynamic>.from(topQueriedDomains.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "top_clients": List<dynamic>.from(topClients.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "top_blocked_domains": List<dynamic>.from(topBlockedDomains.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "top_upstreams_responses": topUpstreamResponses != null ? List<dynamic>.from(topUpstreamResponses!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))) : null,
    "top_upstreams_avg_time": topUpstreamsAvgTime != null ? List<dynamic>.from(topUpstreamsAvgTime!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))) : null,
    "dns_queries": List<dynamic>.from(dnsQueries.map((x) => x)),
    "blocked_filtering": List<dynamic>.from(blockedFiltering.map((x) => x)),
    "replaced_safebrowsing": List<dynamic>.from(replacedSafebrowsing.map((x) => x)),
    "replaced_parental": List<dynamic>.from(replacedParental.map((x) => x)),
    "num_dns_queries": numDnsQueries,
    "num_blocked_filtering": numBlockedFiltering,
    "num_replaced_safebrowsing": numReplacedSafebrowsing,
    "num_replaced_safesearch": numReplacedSafesearch,
    "num_replaced_parental": numReplacedParental,
    "avg_processing_time": avgProcessingTime,
  };
}
