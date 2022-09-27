class Server {
  final String id;
  String name;
  String connectionMethod;
  String domain;
  String? path;
  int? port;
  String user;
  String password;
  bool defaultServer;
  String authToken;

  Server({
    required this.id,
    required this.name,
    required this.connectionMethod,
    required this.domain,
    this.path,
    this.port,
    required this.user,
    required this.password,
    required this.defaultServer,
    required this.authToken
  });
}