class Server {
  final String name;
  final String connectionMethod;
  final String domain;
  final String? path;
  final int? port;
  final String user;
  final String password;
  final bool defaultServer;

  const Server({
    required this.name,
    required this.connectionMethod,
    required this.domain,
    this.path,
    this.port,
    required this.user,
    required this.password,
    required this.defaultServer
  });
}