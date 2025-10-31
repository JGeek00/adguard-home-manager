class RewriteRules {
  final String domain;
  final String answer;
  bool enabled;

  RewriteRules({
    required this.domain,
    required this.answer,
    required this.enabled,
  });

  factory RewriteRules.fromJson(Map<String, dynamic> json) => RewriteRules(
    domain: json["domain"],
    answer: json["answer"],
    enabled: json["enabled"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "domain": domain,
    "answer": answer,
    "enabled": enabled,
  };
}

class PutRewriteRules {
  final RewriteRules target;
  final RewriteRules update;

  PutRewriteRules({
    required this.target,
    required this.update,
  });

  Map<String, dynamic> toJson() => {
    "target": target.toJson(),
    "update": update.toJson(),
  };
}
