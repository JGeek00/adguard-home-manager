class Server {
  final String id;
  String name;
  String? apiKey; // API Key for AdGuard Private DNS
  bool defaultServer;

  // Legacy fields kept for compatibility or repurposing if needed.
  // We keep them non-nullable where they were required before to avoid breaking legacy code.
  String connectionMethod;
  String domain;
  String? path;
  int? port;
  String? user;
  String? password;
  String? authToken;
  bool runningOnHa;

  Server({
    required this.id,
    required this.name,
    this.apiKey,
    required this.defaultServer,
    required this.connectionMethod,
    required this.domain,
    this.path,
    this.port,
    this.user,
    this.password,
    this.authToken,
    required this.runningOnHa,
  });
}
