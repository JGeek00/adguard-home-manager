class AppLog {
  final String type;
  final DateTime dateTime;
  final String message;
  final String? statusCode;
  final String? resBody;

  const AppLog({
    required this.type,
    required this.dateTime,
    required this.message,
    this.statusCode,
    this.resBody,
  });

  Map<String, String> toMap() {
    return {
      'type': type,
      'dateTime': dateTime.toString(),
      'message': message,
      'statusCode': statusCode.toString(),
      'resBody': resBody.toString()
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}