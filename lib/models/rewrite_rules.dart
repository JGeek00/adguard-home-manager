class RewriteRules {
  final String domain;
  final String answer;

  RewriteRules({
    required this.domain,
    required this.answer,
  });

  factory RewriteRules.fromJson(Map<String, dynamic> json) => RewriteRules(
    domain: json["domain"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "domain": domain,
    "answer": answer,
  };
}
