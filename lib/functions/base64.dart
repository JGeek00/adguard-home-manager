import 'dart:convert';

String encodeBase64UserPass(String user, String pass) {
  String credentials = "$user:$pass";
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  return stringToBase64.encode(credentials);
}

String encodeBase64(String value) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  return stringToBase64.encode(value);
}

String decodeBase64(String value) {
  return utf8.decode(base64.decode(value)); 
}