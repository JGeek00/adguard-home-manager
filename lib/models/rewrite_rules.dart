import 'dart:convert';

class RewriteRules {
  int loadStatus = 0;
  List<RewriteRulesData>? data;

  RewriteRules({
    required this.loadStatus,
    this.data
  });
}

List<RewriteRulesData> rewriteRulesDataFromJson(String str) => List<RewriteRulesData>.from(json.decode(str).map((x) => RewriteRulesData.fromJson(x)));

String rewriteRulesDataToJson(List<RewriteRulesData> data) => json.encode(List<RewriteRulesData>.from(data.map((x) => x.toJson())));

class RewriteRulesData {
  final String domain;
  final String answer;

  RewriteRulesData({
    required this.domain,
    required this.answer,
  });

  factory RewriteRulesData.fromJson(Map<String, dynamic> json) => RewriteRulesData(
    domain: json["domain"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "domain": domain,
    "answer": answer,
  };
}
