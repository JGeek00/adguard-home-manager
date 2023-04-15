Map<String, dynamic> removePropFromMap(Map<String, dynamic> o, String prop) {
  Map<String, dynamic> obj = {...o};
  obj.remove(prop);
  return o;
}