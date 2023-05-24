import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/dns_info.dart';

class DnsProvider with ChangeNotifier {
  LoadStatus _loadStatus = LoadStatus.loading;
  DnsInfo? _dnsInfo;

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  DnsInfo? get dnsInfo {
    return _dnsInfo;
  }

  void setDnsInfoData(DnsInfo data) {
    _dnsInfo = data;
    notifyListeners();
  }

  void setDnsInfoLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
}