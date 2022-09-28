import 'package:intl/intl.dart';

String intFormat(int value, String locale) {
  final f = NumberFormat("#,###", locale);
  return f.format(value);
}

String doubleFormat(double value, String locale) {
  final f = NumberFormat("#.##", locale);
  return f.format(value);
}