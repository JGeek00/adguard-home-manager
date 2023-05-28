class BlockedServicesFromApi {
  final List<BlockedService> blockedServices;

  BlockedServicesFromApi({
    required this.blockedServices,
  });

  factory BlockedServicesFromApi.fromJson(Map<String, dynamic> json) => BlockedServicesFromApi(
    blockedServices: List<BlockedService>.from(json["blocked_services"].map((x) => BlockedService.fromJson(x))),
  );
}

class BlockedServices {
  List<BlockedService> services; 

  BlockedServices({
    required this.services
  });
}

class BlockedService {
  final String id;
  final String name;
  final String iconSvg;
  final List<String> rules;

  BlockedService({
    required this.id,
    required this.name,
    required this.iconSvg,
    required this.rules,
  });

  factory BlockedService.fromJson(Map<String, dynamic> json) => BlockedService(
    id: json["id"],
    name: json["name"],
    iconSvg: json["icon_svg"],
    rules: List<String>.from(json["rules"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon_svg": iconSvg,
    "rules": List<dynamic>.from(rules.map((x) => x)),
  };
}
