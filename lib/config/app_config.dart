/// Configuración centralizada de la aplicación.
///
/// Reemplaza el antiguo `.env` + `flutter_dotenv`.
/// Los valores se inyectan en tiempo de compilación:
///
/// ```sh
/// flutter build ... --dart-define=SENTRY_DSN=<tu-dsn> --dart-define=ENABLE_SENTRY=true
/// ```
///
/// Por defecto Sentry está desactivado (DSN vacío).
const String sentryDsn = String.fromEnvironment('SENTRY_DSN', defaultValue: '');

const bool enableSentry = bool.fromEnvironment('ENABLE_SENTRY', defaultValue: false);
