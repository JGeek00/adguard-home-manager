import 'package:flutter/material.dart';

class AppLanguage {
  final String languageCode;
  final String? countryCode;
  final String name;

  const AppLanguage({
    required this.languageCode,
    this.countryCode,
    required this.name,
  });

  Locale get locale => Locale(languageCode, countryCode ?? '');

  /// BCP 47 tag, used by the Android and iOS locale settings.
  String get tag => countryCode != null
    ? '$languageCode-$countryCode'
    : languageCode;
}

/// zh-CN is left out on purpose: it resolves to the same translations as zh.
const List<AppLanguage> appLanguages = [
  AppLanguage(languageCode: 'de', name: 'Deutsch'),
  AppLanguage(languageCode: 'en', name: 'English'),
  AppLanguage(languageCode: 'es', name: 'Español'),
  AppLanguage(languageCode: 'pl', name: 'Polski'),
  AppLanguage(languageCode: 'tr', name: 'Türkçe'),
  AppLanguage(languageCode: 'ru', name: 'Русский'),
  AppLanguage(languageCode: 'zh', name: '中文'),
];

List<AppLanguage> get sortedAppLanguages {
  final sorted = List<AppLanguage>.from(appLanguages);
  sorted.sort((a, b) => a.name.compareTo(b.name));
  return sorted;
}

AppLanguage? languageFromTag(String? tag) {
  if (tag == null) return null;
  for (final language in appLanguages) {
    if (language.tag == tag) return language;
  }
  // A system tag like de-DE still means German.
  final languageCode = tag.split('-').first;
  for (final language in appLanguages) {
    if (language.languageCode == languageCode) return language;
  }
  return null;
}
