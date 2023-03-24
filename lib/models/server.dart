class Server {
  final String id;
  String name;
  String connectionMethod;
  String domain;
  String? path;
  int? port;
  String? user;
  String? password;
  bool defaultServer;
  String? authToken;
  bool runningOnHa;

  Server({
    required this.id,
    required this.name,
    required this.connectionMethod,
    required this.domain,
    this.path,
    this.port,
    this.user,
    this.password,
    required this.defaultServer,
    this.authToken,
    required this.runningOnHa,
  });
}