class DnsServer {
  final String id;
  final String name;
  final bool isDefault;
  final List<String> deviceIds;
  final DnsServerSettings settings;

  DnsServer({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.deviceIds,
    required this.settings,
  });

  factory DnsServer.fromJson(Map<String, dynamic> json) {
    return DnsServer(
      id: json['id'],
      name: json['name'],
      isDefault: json['default'],
      deviceIds: List<String>.from(json['device_ids'] ?? []),
      settings: DnsServerSettings.fromJson(json['settings']),
    );
  }
}

class DnsServerSettings {
  final bool protectionEnabled;
  final bool ipLogEnabled;
  final bool blockChromePrefetch;
  final bool blockFirefoxCanary;
  final bool blockPrivateRelay;
  final int blockTtlSeconds;
  final BlockingModeSettings blockingModeSettings;
  final FilterListsSettings filterListsSettings;
  final ParentalControlSettings parentalControlSettings;
  final SafeBrowsingSettings safeBrowsingSettings;
  final UserRulesSettings userRulesSettings;
  // access_settings omitted for brevity, can add later

  DnsServerSettings({
    required this.protectionEnabled,
    required this.ipLogEnabled,
    required this.blockChromePrefetch,
    required this.blockFirefoxCanary,
    required this.blockPrivateRelay,
    required this.blockTtlSeconds,
    required this.blockingModeSettings,
    required this.filterListsSettings,
    required this.parentalControlSettings,
    required this.safeBrowsingSettings,
    required this.userRulesSettings,
  });

  factory DnsServerSettings.fromJson(Map<String, dynamic> json) {
    return DnsServerSettings(
      protectionEnabled: json['protection_enabled'],
      ipLogEnabled: json['ip_log_enabled'],
      blockChromePrefetch: json['block_chrome_prefetch'],
      blockFirefoxCanary: json['block_firefox_canary'],
      blockPrivateRelay: json['block_private_relay'],
      blockTtlSeconds: json['block_ttl_seconds'],
      blockingModeSettings: BlockingModeSettings.fromJson(json['blocking_mode_settings']),
      filterListsSettings: FilterListsSettings.fromJson(json['filter_lists_settings']),
      parentalControlSettings: ParentalControlSettings.fromJson(json['parental_control_settings']),
      safeBrowsingSettings: SafeBrowsingSettings.fromJson(json['safebrowsing_settings']),
      userRulesSettings: UserRulesSettings.fromJson(json['user_rules_settings']),
    );
  }
}

class BlockingModeSettings {
  final String blockingMode;
  final String? ipv4BlockingAddress;
  final String? ipv6BlockingAddress;

  BlockingModeSettings({
    required this.blockingMode,
    this.ipv4BlockingAddress,
    this.ipv6BlockingAddress,
  });

  factory BlockingModeSettings.fromJson(Map<String, dynamic> json) {
    return BlockingModeSettings(
      blockingMode: json['blocking_mode'],
      ipv4BlockingAddress: json['ipv4_blocking_address'],
      ipv6BlockingAddress: json['ipv6_blocking_address'],
    );
  }
}

class FilterListsSettings {
  final bool enabled;
  final List<FilterListItem> filterList;

  FilterListsSettings({
    required this.enabled,
    required this.filterList,
  });

  factory FilterListsSettings.fromJson(Map<String, dynamic> json) {
    return FilterListsSettings(
      enabled: json['enabled'],
      filterList: (json['filter_list'] as List?)
          ?.map((e) => FilterListItem.fromJson(e))
          .toList() ?? [],
    );
  }
}

class FilterListItem {
  final String filterId;
  final bool enabled;

  FilterListItem({
    required this.filterId,
    required this.enabled,
  });

  factory FilterListItem.fromJson(Map<String, dynamic> json) {
    return FilterListItem(
      filterId: json['filter_id'],
      enabled: json['enabled'],
    );
  }
}

class ParentalControlSettings {
  final bool enabled;
  final bool blockAdultWebsitesEnabled;
  final bool youtubeSafeSearchEnabled;
  final bool enginesSafeSearchEnabled;

  ParentalControlSettings({
    required this.enabled,
    required this.blockAdultWebsitesEnabled,
    required this.youtubeSafeSearchEnabled,
    required this.enginesSafeSearchEnabled,
  });

  factory ParentalControlSettings.fromJson(Map<String, dynamic> json) {
    return ParentalControlSettings(
      enabled: json['enabled'],
      blockAdultWebsitesEnabled: json['block_adult_websites_enabled'],
      youtubeSafeSearchEnabled: json['youtube_safe_search_enabled'],
      enginesSafeSearchEnabled: json['engines_safe_search_enabled'],
    );
  }
}

class SafeBrowsingSettings {
  final bool enabled;
  final bool blockDangerousDomains;
  final bool blockNrd; // Newly registered domains

  SafeBrowsingSettings({
    required this.enabled,
    required this.blockDangerousDomains,
    required this.blockNrd,
  });

  factory SafeBrowsingSettings.fromJson(Map<String, dynamic> json) {
    return SafeBrowsingSettings(
      enabled: json['enabled'],
      blockDangerousDomains: json['block_dangerous_domains'],
      blockNrd: json['block_nrd'],
    );
  }
}

class UserRulesSettings {
  final bool enabled;
  final List<String> rules;
  final int rulesCount;

  UserRulesSettings({
    required this.enabled,
    required this.rules,
    required this.rulesCount,
  });

  factory UserRulesSettings.fromJson(Map<String, dynamic> json) {
    return UserRulesSettings(
      enabled: json['enabled'],
      rules: List<String>.from(json['rules'] ?? []),
      rulesCount: json['rules_count'],
    );
  }
}
