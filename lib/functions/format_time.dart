import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimestamp(DateTime timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(timestamp);
}

String formatTimestampUTC(DateTime timestamp, String format) {
  return DateFormat(format).format(timestamp.toLocal());
}

String formatTimeOfDay(TimeOfDay timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(DateTime(0, 0, 0, timestamp.hour, timestamp.minute));
}