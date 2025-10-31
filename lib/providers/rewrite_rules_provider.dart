import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/enums.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/models/rewrite_rules.dart';

class RewriteRulesProvider with ChangeNotifier {
  ServersProvider? _serversProvider;

  update(ServersProvider? provider) {
    _serversProvider = provider;
  }

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

  Future<bool> addDnsRewrite(RewriteRules rule) async {
    final result = await _serversProvider!.apiClient2!.addDnsRewriteRule(
      data: {
        "domain": rule.domain,
        "answer": rule.answer
      }
    );

    if (result.successful == true) {
      List<RewriteRules> data = rewriteRules!;
      data.add(rule);
      setRewriteRulesData(data);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> editDnsRewrite(RewriteRules newRule, RewriteRules oldRule) async {
    final result = await _serversProvider!.apiClient2!.updateRewriteRule(
      body: {
        "target": {
          "answer": oldRule.answer,
          "domain": oldRule.domain,
          "enabled": oldRule.enabled
        },
        "update": {
          "answer": newRule.answer,
          "domain": newRule.domain,
          "enabled": newRule.enabled
        }
      }
    );

    if (result.successful == true) {
      List<RewriteRules> data = rewriteRules!;
      final index = data.indexOf(oldRule);
      data[index] = newRule;
      setRewriteRulesData(data);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteDnsRewrite(RewriteRules rule) async {
    final result = await _serversProvider!.apiClient2!.deleteDnsRewriteRule(
      data: {
        "domain": rule.domain,
        "answer": rule.answer
      }
    );

    if (result.successful == true) {
      List<RewriteRules> data = rewriteRules!;
      data = data.where((item) => item.domain != rule.domain).toList();
      setRewriteRulesData(data);
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchRules({
    bool? showLoading
  }) async {
    if (showLoading == true) {
      _loadStatus = LoadStatus.loading;
    }

    final result = await _serversProvider!.apiClient2!.getDnsRewriteRules();

    if (result.successful == true) {
      _rewriteRules = result.content as List<RewriteRules>;
      _loadStatus = LoadStatus.loaded;
      notifyListeners();
      return true;
    }
    else {
      if (showLoading == true) {
        _loadStatus = LoadStatus.error;
        notifyListeners();
      }
      return false;
    }
  }
}