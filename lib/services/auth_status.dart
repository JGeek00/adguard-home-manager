enum AuthStatus {
  success,
  invalidCredentials,
  manyAttepts,
  serverError,
  socketException,
  timeoutException,
  handshakeException,
  /// The address did not answer the GL.iNet `/rpc` challenge.
  glinetNotFound,
  /// The router login succeeded, but AdGuard rejected the session cookie.
  glinetSessionRejected,
  unknown
}
