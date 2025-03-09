import 'package:adguard_home_manager/constants/regexps.dart';

bool isIpAddress(String value) {
  if (Regexps.ipv4Address.hasMatch(value) || Regexps.ipv6Address.hasMatch(value)) {
    return true;
  }
  else {
    return false;
  }
}