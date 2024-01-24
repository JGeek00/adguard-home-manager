class QueryLogConfig {
  final List<String>? ignored;
  final int? interval;
  final bool? enabled;
  final bool? anonymizeClientIp;

  QueryLogConfig({
    this.ignored,
    this.interval,
    this.enabled,
    this.anonymizeClientIp,
  });

  factory QueryLogConfig.fromJson(Map<String, dynamic> json) => QueryLogConfig(
    ignored: json["ignored"] == null ? [] : List<String>.from(json["ignored"]!.map((x) => x)),
    interval: json["interval"],
    enabled: json["enabled"],
    anonymizeClientIp: json["anonymize_client_ip"],
  );

  Map<String, dynamic> toJson() => {
    "ignored": ignored == null ? [] : List<dynamic>.from(ignored!.map((x) => x)),
    "interval": interval,
    "enabled": enabled,
    "anonymize_client_ip": anonymizeClientIp,
  };
}
