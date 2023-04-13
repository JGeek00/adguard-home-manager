import 'package:adguard_home_manager/constants/enums.dart';

class SafeSearch {
  LoadStatus loadStatus = LoadStatus.loading;
  SafeSearchData? data;

  SafeSearch({
    required this.loadStatus,
    this.data
  });
}

class SafeSearchData {
  final bool enabled;
  final bool bing;
  final bool duckduckgo;
  final bool google;
  final bool pixabay;
  final bool yandex;
  final bool youtube;

  SafeSearchData({
    required this.enabled,
    required this.bing,
    required this.duckduckgo,
    required this.google,
    required this.pixabay,
    required this.yandex,
    required this.youtube,
  });

  factory SafeSearchData.fromJson(Map<String, dynamic> json) => SafeSearchData(
    enabled: json["enabled"],
    bing: json["bing"],
    duckduckgo: json["duckduckgo"],
    google: json["google"],
    pixabay: json["pixabay"],
    yandex: json["yandex"],
    youtube: json["youtube"],
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled,
    "bing": bing,
    "duckduckgo": duckduckgo,
    "google": google,
    "pixabay": pixabay,
    "yandex": yandex,
    "youtube": youtube,
  };
}
