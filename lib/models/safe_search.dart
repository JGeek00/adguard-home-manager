class SafeSearch {
  bool enabled = false;
  bool bing = false;
  bool duckduckgo = false;
  bool google = false;
  bool pixabay = false;
  bool yandex = false;
  bool youtube = false;

  SafeSearch({
    required this.enabled,
    required this.bing,
    required this.duckduckgo,
    required this.google,
    required this.pixabay,
    required this.yandex,
    required this.youtube,
  });

  factory SafeSearch.fromJson(Map<String, dynamic> json) => SafeSearch(
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
