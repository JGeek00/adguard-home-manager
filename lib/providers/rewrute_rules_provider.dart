import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';

class RewriteRulesProvider with ChangeNotifier {
  LoadStatus _loadStatus = LoadStatus.loading;
  List<RewriteRules>? _rewriteRules;

  LoadStatus get loadStatus {
    return _loadStatus;
  }

  List<RewriteRules>? get rewriteRules {
    return _rewriteRules;
  }

  void setRewriteRulesData(List<RewriteRules> data) {
    _rewriteRules = data;
    notifyListeners();
  }

  void setRewriteRulesLoadStatus(LoadStatus status, bool notify) {
    _loadStatus = status;
    if (notify == true) {
      notifyListeners();
    }
  }
}