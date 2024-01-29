class StatisticsConfig {
  final List<dynamic>? ignored;
  final int? interval;
  final bool? enabled;

  StatisticsConfig({
    this.ignored,
    this.interval,
    this.enabled,
  });

  factory StatisticsConfig.fromJson(Map<String, dynamic> json) => StatisticsConfig(
    ignored: json["ignored"] == null ? [] : List<dynamic>.from(json["ignored"]!.map((x) => x)),
    interval: json["interval"],
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "ignored": ignored == null ? [] : List<dynamic>.from(ignored!.map((x) => x)),
    "interval": interval,
    "enabled": enabled,
  };
}
