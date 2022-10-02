import 'dart:convert';

class LogsList {
  int loadStatus = 0;
  LogsData? logsData;

  LogsList({
    required this.loadStatus,
    this.logsData
  });
}

LogsData logsFromJson(String str) => LogsData.fromJson(json.decode(str));

String logsToJson(LogsData data) => json.encode(data.toJson());

class LogsData {
  List<Log> data;
  final DateTime? oldest;

  LogsData({
    required this.data,
    this.oldest,
  });

  factory LogsData.fromJson(Map<String, dynamic> json) => LogsData(
    data: List<Log>.from(json["data"].map((x) => Log.fromJson(x))),
    oldest: json["oldest"] != '' ? DateTime.parse(json["oldest"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "oldest": oldest != null ? oldest!.toIso8601String() : null,
  };
}

class Log {
  final bool answerDnssec;
  final bool cached;
  final String client;
  final ClientInfo clientInfo;
  final String clientProto;
  final String elapsedMs;
  final Question question;
  final String reason;
  final List<Rule> rules;
  final String status;
  final DateTime time;
  final String upstream;
  final List<Answer>? answer;
  final int? filterId;
  final String? rule;
  final List<Answer>? originalAnswer;

  Log({
    required this.answerDnssec,
    required this.cached,
    required this.client,
    required this.clientInfo,
    required this.clientProto,
    required this.elapsedMs,
    required this.question,
    required this.reason,
    required this.rules,
    required this.status,
    required this.time,
    required this.upstream,
    this.answer,
    this.filterId,
    this.rule,
    this.originalAnswer,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    answerDnssec: json["answer_dnssec"],
    cached: json["cached"],
    client: json["client"],
    clientInfo: ClientInfo.fromJson(json["client_info"]),
    clientProto: json["client_proto"],
    elapsedMs: json["elapsedMs"],
    question: Question.fromJson(json["question"]),
    reason: json["reason"],
    rules: List<Rule>.from(json["rules"].map((x) => Rule.fromJson(x))),
    status: json["status"],
    time: DateTime.parse(json["time"]),
    upstream: json["upstream"],
    answer: json["answer"] == null ? null : List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
    filterId: json["filterId"],
    rule: json["rule"],
    originalAnswer: json["original_answer"] == null ? null : List<Answer>.from(json["original_answer"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "answer_dnssec": answerDnssec,
    "cached": cached,
    "client": client,
    "client_info": clientInfo.toJson(),
    "client_proto": clientProto,
    "elapsedMs": elapsedMs,
    "question": question.toJson(),
    "reason":reason,
    "rules": List<dynamic>.from(rules.map((x) => x.toJson())),
    "status": status,
    "time": time.toIso8601String(),
    "upstream": upstream,
    "answer": answer == null ? null : List<dynamic>.from(answer!.map((x) => x.toJson())),
    "filterId": filterId,
    "rule": rule,
    "original_answer": originalAnswer == null ? null : List<dynamic>.from(originalAnswer!.map((x) => x.toJson())),
  };
}

class Answer {
  final String type;
  final String value;
  final int ttl;

  Answer({
    required this.type,
    required this.value,
    required this.ttl,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    type: json["type"],
    value: json["value"],
    ttl: json["ttl"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
    "ttl": ttl,
  };
}

class ClientInfo {
  final Whois whois;
  final String name;
  final String disallowedRule;
  final bool disallowed;

  ClientInfo({
    required this.whois,
    required this.name,
    required this.disallowedRule,
    required this.disallowed,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) => ClientInfo(
    whois: Whois.fromJson(json["whois"]),
    name: json["name"],
    disallowedRule: json["disallowed_rule"],
    disallowed: json["disallowed"],
  );

  Map<String, dynamic> toJson() => {
    "whois": whois.toJson(),
    "name": name,
    "disallowed_rule": disallowedRule,
    "disallowed": disallowed,
  };
}

class Whois {
  Whois();

  factory Whois.fromJson(Map<String, dynamic> json) => Whois();

  Map<String, dynamic> toJson() => {};
}

class Question {
  final String questionClass;
  final String name;
  final String type;

  Question({
    required this.questionClass,
    required this.name,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionClass: json["class"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "class": questionClass,
    "name": name,
    "type": type,
  };
}

class Rule {
  final int filterListId;
  final String text;

  Rule({
    required this.filterListId,
    required this.text,
  });


  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
    filterListId: json["filter_list_id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "filter_list_id": filterListId,
    "text": text,
  };
}