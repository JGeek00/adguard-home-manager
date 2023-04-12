DateTime generateTimeDeadline(int time) {
  DateTime date = DateTime.now();
  date = date.add(Duration(milliseconds: time));
  return date;
}

String generateRemainingTimeString(Duration difference) {
  final int seconds = difference.inSeconds+1;
  final DateTime time = DateTime(0, 0, 0, 0, 0, seconds > 0 ? seconds : 0);
  return "${time.hour > 0 ? "${time.hour}:" : ''}${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
}