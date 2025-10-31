class RewriteStatus {
  final bool enabled;

  RewriteStatus({
    required this.enabled,
  });

  factory RewriteStatus.fromJson(Map<String, dynamic> json) {
    return RewriteStatus(
      enabled: json['enabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
    };
  }
}