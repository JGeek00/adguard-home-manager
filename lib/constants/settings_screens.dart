import 'package:flutter/material.dart';

import 'package:adguard_home_manager/screens/servers/servers.dart';
import 'package:adguard_home_manager/screens/settings/access_settings/access_settings.dart';
import 'package:adguard_home_manager/screens/settings/advanced_setings.dart';
import 'package:adguard_home_manager/screens/settings/customization/customization.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/dns_rewrites.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption.dart';
import 'package:adguard_home_manager/screens/settings/general_settings.dart';
import 'package:adguard_home_manager/screens/settings/server_info/server_info.dart';

const List<Widget> settingsScreens = [
  AccessSettings(),
  Dhcp(),
  DnsSettings(),
  EncryptionSettings(),
  DnsRewrites(),
  ServerInformation(),
  Customization(),
  Servers(),
  GeneralSettings(),
  AdvancedSettings()
];