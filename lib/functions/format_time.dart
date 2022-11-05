import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimestamp(DateTime timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(timestamp);
}

String formatTimestampUTC(DateTime timestamp, String format) {
  final DateFormat dateFormat = DateFormat(format);
  final String utcDate = dateFormat.format(DateTime.parse(timestamp.toString()));
  final String localDate = dateFormat.parse(utcDate, true).toLocal().toIso8601String();
  return dateFormat.format(DateTime.parse(localDate));
}

String formatTimestampUTCFromAPI(DateTime timestamp, String format) {
  final DateFormat dateFormat = DateFormat(format);
  final DateTime date = DateTime(
    timestamp.year,
    timestamp.month,
    timestamp.day,
    timestamp.hour,
    timestamp.minute,
    timestamp.second
  );
  final String utcDate = dateFormat.format(DateTime.parse(date.toString()));
  final String localDate = dateFormat.parse(utcDate, true).toLocal().toIso8601String();
  return dateFormat.format(DateTime.parse(localDate));
}

String formatTimeOfDay(TimeOfDay timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(DateTime(0, 0, 0, timestamp.hour, timestamp.minute));
}