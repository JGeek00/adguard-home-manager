import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimestamp(DateTime timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(timestamp);
}

String convertTimestampLocalTimezone(DateTime timestamp, String format) {
  return DateFormat(format).format(timestamp.toLocal());
}

String formatTimeOfDay(TimeOfDay timestamp, String format) {
  DateFormat f = DateFormat(format);
  return f.format(DateTime(0, 0, 0, timestamp.hour, timestamp.minute));
}

String formatRemainingSeconds(int seconds) {
  int h, m, s;
  h = seconds ~/ 3600;
  m = ((seconds - h * 3600)) ~/ 60;
  s = seconds - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

  return "$hourLeft:$minuteLeft:$secondsLeft";
}