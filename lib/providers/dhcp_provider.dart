import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/dhcp.dart';

class DhcpProvider with ChangeNotifier {
  LoadStatus _loadStatus = LoadStatus.loading;
  DhcpModel? _dhcp;

  DhcpModel? get dhcp {
    return _dhcp;
  }

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  void setDhcpData(DhcpModel data) {
    _dhcp = data;
    notifyListeners();
  }

  void setDhcpLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
} 