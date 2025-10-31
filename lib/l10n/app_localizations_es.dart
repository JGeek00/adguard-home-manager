// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Inicio';

  @override
  String get settings => 'Ajustes';

  @override
  String get connect => 'Conectar';

  @override
  String get servers => 'Servidores';

  @override
  String get createConnection => 'Crear conexión';

  @override
  String get editConnection => 'Editar conexión';

  @override
  String get name => 'Nombre';

  @override
  String get ipDomain => 'Dirección IP o dominio';

  @override
  String get path => 'Ruta';

  @override
  String get port => 'Puerto';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get defaultServer => 'Servidor por defecto';

  @override
  String get general => 'General';

  @override
  String get connection => 'Conexión';

  @override
  String get authentication => 'Autenticación';

  @override
  String get other => 'Otros';

  @override
  String get invalidPort => 'Puerto no válido';

  @override
  String get invalidPath => 'Ruta no válida';

  @override
  String get invalidIpDomain => 'IP o dominio no válido';

  @override
  String get ipDomainNotEmpty => 'IP o dominio no puede estar vacío';

  @override
  String get nameNotEmpty => 'El nombre no puede estar vacío';

  @override
  String get invalidUsernamePassword => 'Usuario o contraseña no válidos.';

  @override
  String get tooManyAttempts =>
      'Demasiados intentos. Prueba de nuevo más tarde.';

  @override
  String get cantReachServer =>
      'No se puede alcanzar el servidor. Comprueba los datos de conexión.';

  @override
  String get sslError =>
      'Handshake exception. No se ha podido establecer una conexión segura con el servidor. Es posible que sea un error de SSL. Ve a Ajustes > Ajustes avanzados y activa No comprobar SSL.';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get connectionNotCreated => 'No se pudo crear la conexión';

  @override
  String get connecting => 'Conectando...';

  @override
  String get connected => 'Conectado';

  @override
  String get selectedDisconnected => 'Seleccionado pero desconectado';

  @override
  String get connectionDefaultSuccessfully =>
      'Conexión definida como por defecto.';

  @override
  String get connectionDefaultFailed =>
      'No se ha podido definir como conexión por defecto.';

  @override
  String get noSavedConnections => 'No hay conexiones guardadas';

  @override
  String get cannotConnect => 'No se puede conectar con el servidor';

  @override
  String get connectionRemoved => 'Conexión eliminada satisfactoriamente.';

  @override
  String get connectionCannotBeRemoved =>
      'No se ha podido eliminar la conexión.';

  @override
  String get remove => 'Eliminar';

  @override
  String get removeWarning =>
      '¿Estás seguro de que deseas eliminar la conexión con este servidor?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get defaultConnection => 'Conexión por defecto';

  @override
  String get setDefault => 'Seleccionar por defecto';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get serverStatus => 'Estado del servidor';

  @override
  String get connectionNotUpdated => 'Conexión no actualizada';

  @override
  String get ruleFilteringWidget => 'Bloqueo por filtros';

  @override
  String get safeBrowsingWidget => 'Navegación segura';

  @override
  String get parentalFilteringWidget => 'Control parental';

  @override
  String get safeSearchWidget => 'Búsqueda segura';

  @override
  String get ruleFiltering => 'Bloqueo por filtros';

  @override
  String get safeBrowsing => 'Navegación segura';

  @override
  String get parentalFiltering => 'Control parental';

  @override
  String get safeSearch => 'Búsqueda segura';

  @override
  String get serverStatusNotRefreshed =>
      'No se ha podido actualizar el estado del servidor';

  @override
  String get loadingStatus => 'Cargando estado...';

  @override
  String get errorLoadServerStatus => 'Error al cargar el estado';

  @override
  String get topQueriedDomains => 'Dominios solicitados';

  @override
  String get viewMore => 'Ver más';

  @override
  String get topClients => 'Clientes recurrentes';

  @override
  String get topBlockedDomains => 'Dominios bloqueados';

  @override
  String get appSettings => 'Ajustes de la app';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get systemDefined => 'Definido por el sistema';

  @override
  String get close => 'Cerrar';

  @override
  String get connectedTo => 'Conectado a:';

  @override
  String get selectedServer => 'Servidor seleccionado:';

  @override
  String get noServerSelected => 'No hay servidor seleccionado';

  @override
  String get manageServer => 'Gestión del servidor';

  @override
  String get allProtections => 'Todas las protecciones';

  @override
  String get userNotEmpty => 'Usuario no puede estar vacío';

  @override
  String get passwordNotEmpty => 'Contraseña no puede estar vacío';

  @override
  String get examplePath => 'Ejemplo: /adguard';

  @override
  String get helperPath => 'Si estás usando un reverse proxy';

  @override
  String get aboutApp => 'Sobre la aplicación';

  @override
  String get appVersion => 'Versión de la app';

  @override
  String get createdBy => 'Creado por';

  @override
  String get clients => 'Clientes';

  @override
  String get allowed => 'Permitidos';

  @override
  String get blocked => 'Bloqueados';

  @override
  String get noClientsList => 'No hay clientes en esta lista';

  @override
  String get activeClients => 'Activos';

  @override
  String get removeClient => 'Eliminar cliente';

  @override
  String get removeClientMessage =>
      'Estás seguro que deseas eliminar este cliente de la lista?';

  @override
  String get confirm => 'Confirmar';

  @override
  String get removingClient => 'Eliminando cliente...';

  @override
  String get clientNotRemoved => 'El cliente no pudo ser eliminado de la lista';

  @override
  String get addClient => 'Agregar cliente';

  @override
  String get list => 'Lista';

  @override
  String get ipAddress => 'Dirección IP';

  @override
  String get ipNotValid => 'Dirección IP no válida';

  @override
  String get clientAddedSuccessfully =>
      'Cliente añadido a la lista satisfactoriamente';

  @override
  String get addingClient => 'Añadiendo cliente...';

  @override
  String get clientNotAdded => 'El cliente no se pudo añadir a la lista';

  @override
  String get clientAnotherList => 'El cliente ya está en otra lista';

  @override
  String get noSavedLogs => 'No hay logs guardados';

  @override
  String get logs => 'Registros';

  @override
  String get copyLogsClipboard => 'Copiar logs al portapapeles';

  @override
  String get logsCopiedClipboard => 'Registros copiados al portapapeles';

  @override
  String get advancedSettings => 'Ajustes avanzados';

  @override
  String get dontCheckCertificate => 'No comprobar el certificado SSL';

  @override
  String get dontCheckCertificateDescription =>
      'Anula la validación del certificado SSL del servidor';

  @override
  String get advancedSetupDescription => 'Opciones avanzadas';

  @override
  String get settingsUpdatedSuccessfully =>
      'Ajustes actualizados correctamente.';

  @override
  String get cannotUpdateSettings => 'No se han podido actualizar los ajustes.';

  @override
  String get restartAppTakeEffect =>
      'Reinicia la aplicación para que se apliquen los cambios.';

  @override
  String get loadingLogs => 'Cargando registros...';

  @override
  String get logsNotLoaded => 'No se pudieron cargar los registros';

  @override
  String get processed => 'Procesada\nSin lista';

  @override
  String get processedRow => 'Procesada (sin lista)';

  @override
  String get blockedBlacklist => 'Bloqueada\nLista negra';

  @override
  String get blockedBlacklistRow => 'Bloqueada (lista negra)';

  @override
  String get blockedSafeBrowsing => 'Bloqueada\nNavegación segura';

  @override
  String get blockedSafeBrowsingRow => 'Bloqueada (navegación segura)';

  @override
  String get blockedParental => 'Bloqueada\nCcontrol parental';

  @override
  String get blockedParentalRow => 'Bloqueada (control parental)';

  @override
  String get blockedInvalid => 'Bloqueada\nInválida';

  @override
  String get blockedInvalidRow => 'Bloqueada (inválida)';

  @override
  String get blockedSafeSearch => 'Bloqueada\nBúsqueda segura';

  @override
  String get blockedSafeSearchRow => 'Bloqueada (búsqueda segura)';

  @override
  String get blockedService => 'Bloqueada\nServicio bloqueado';

  @override
  String get blockedServiceRow => 'Bloqueada (servicio bloqueado)';

  @override
  String get processedWhitelist => 'Procesada\nLista blanca';

  @override
  String get processedWhitelistRow => 'Procesada (lista blanca)';

  @override
  String get processedError => 'Procesada\nError';

  @override
  String get processedErrorRow => 'Procesada (error)';

  @override
  String get rewrite => 'Reescrita';

  @override
  String get status => 'Estado';

  @override
  String get result => 'Resultado';

  @override
  String get time => 'Hora';

  @override
  String get blocklist => 'Lista de bloqueo';

  @override
  String get request => 'Petición';

  @override
  String get domain => 'Dominio';

  @override
  String get type => 'Tipo';

  @override
  String get clas => 'Clase';

  @override
  String get response => 'Respuesta';

  @override
  String get dnsServer => 'Servidor DNS';

  @override
  String get elapsedTime => 'Tiempo transcurrido';

  @override
  String get responseCode => 'Código de respuesta';

  @override
  String get client => 'Cliente';

  @override
  String get deviceIp => 'Dirección IP';

  @override
  String get deviceName => 'Nombre';

  @override
  String get logDetails => 'Detalles del registro';

  @override
  String get blockingRule => 'Regla de bloqueo';

  @override
  String get blockDomain => 'Bloquear dominio';

  @override
  String get couldntGetFilteringStatus =>
      'No se pudo obtener el estado de filtrado';

  @override
  String get unblockDomain => 'Desbloquear dominio';

  @override
  String get userFilteringRulesNotUpdated =>
      'No se pudieron actualizar las reglas de filtrado del usuario';

  @override
  String get userFilteringRulesUpdated =>
      'Reglas de filtrado del usuario actualizadas correctamente';

  @override
  String get savingUserFilters => 'Guardando filtros de usuario...';

  @override
  String get filters => 'Filtros';

  @override
  String get logsOlderThan => 'Logs anteriores a';

  @override
  String get responseStatus => 'Estado de la respuesta';

  @override
  String get selectTime => 'Seleccionar hora';

  @override
  String get notSelected => 'No seleccionado';

  @override
  String get resetFilters => 'Resetear filtros';

  @override
  String get noLogsDisplay => 'No hay registros para mostrar';

  @override
  String get noLogsThatOld =>
      'Es posible que no haya registros guardados para ese tiempo seleccionado. Prueba a seleccionar un tiempo más reciente.';

  @override
  String get apply => 'Aplicar';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get unselectAll => 'Deseleccionar todo';

  @override
  String get all => 'Todas';

  @override
  String get filtered => 'Filtrada';

  @override
  String get checkAppLogs => 'Comprueba los logs de la app';

  @override
  String get refresh => 'Actualizar';

  @override
  String get search => 'Buscar';

  @override
  String get dnsQueries => 'Consultas DNS';

  @override
  String get average => 'Promedio';

  @override
  String get blockedFilters => 'Bloqueado por filtros';

  @override
  String get malwarePhishingBlocked => 'Malware/phising bloqueado';

  @override
  String get blockedAdultWebsites => 'Sitios para adultos bloqueados';

  @override
  String get generalSettings => 'Ajustes generales';

  @override
  String get generalSettingsDescription => 'Varios ajustes generales';

  @override
  String get hideZeroValues => 'Oculta valores a cero';

  @override
  String get hideZeroValuesDescription =>
      'En la pantalla de inicio, oculta bloqueos con valor cero';

  @override
  String get webAdminPanel => 'Panel de admin. web';

  @override
  String get visitGooglePlay => 'Visita la página de Google Play';

  @override
  String get gitHub => 'Código de la app disponible en GitHub';

  @override
  String get blockClient => 'Bloquear cliente';

  @override
  String get selectTags => 'Seleccionar etiquetas';

  @override
  String get noTagsSelected => 'No hay etiquetas seleccionadas';

  @override
  String get tags => 'Etiquetas';

  @override
  String get identifiers => 'Identificadores';

  @override
  String get identifier => 'Identificador';

  @override
  String get identifierHelper =>
      'Dirección IP, CIDR, dirección MAC, o ClientID';

  @override
  String get noIdentifiers => 'No hay identificadores añadidos';

  @override
  String get useGlobalSettings => 'Usar configuración global';

  @override
  String get enableFiltering => 'Activar filtrado';

  @override
  String get enableSafeBrowsing => 'Activar navegación segura';

  @override
  String get enableParentalControl => 'Activar control parental';

  @override
  String get enableSafeSearch => 'Activar búsqueda segura';

  @override
  String get blockedServices => 'Servicios bloqueados';

  @override
  String get selectBlockedServices => 'Seleccionar servicios para bloquear';

  @override
  String get noBlockedServicesSelected => 'No hay servicios bloqueados';

  @override
  String get services => 'Servicios';

  @override
  String get servicesBlocked => 'servicios bloqueados';

  @override
  String get tagsSelected => 'etiquetas seleccionadas';

  @override
  String get upstreamServers => 'Servidores de salida';

  @override
  String get serverAddress => 'Dirección del servidor';

  @override
  String get noUpstreamServers => 'No hay servidores de salida.';

  @override
  String get willBeUsedGeneralServers =>
      'Se usarán los servidores de salida generales.';

  @override
  String get added => 'Añadidos';

  @override
  String get clientUpdatedSuccessfully => 'Cliente actualizado correctamente';

  @override
  String get clientNotUpdated => 'El cliente no pudo ser actualizado';

  @override
  String get clientDeletedSuccessfully => 'Cliente eliminado correctamente';

  @override
  String get clientNotDeleted => 'El cliente no pudo ser eliminado';

  @override
  String get options => 'Opciones';

  @override
  String get loadingFilters => 'Cargando filtros...';

  @override
  String get filtersNotLoaded => 'No se han podido cargar los filtros.';

  @override
  String get whitelists => 'Listas blancas';

  @override
  String get blacklists => 'Listas negras';

  @override
  String get rules => 'Reglas';

  @override
  String get customRules => 'Reglas personalizadas';

  @override
  String get enabledRules => 'Reglas activas';

  @override
  String get enabled => 'Activada';

  @override
  String get disabled => 'Desactivada';

  @override
  String get rule => 'Regla';

  @override
  String get addCustomRule => 'Añadir regla personalizada';

  @override
  String get removeCustomRule => 'Eliminar regla personalizada';

  @override
  String get removeCustomRuleMessage =>
      '¿Estás seguro que deseas eliminar esta regla personalizada?';

  @override
  String get updatingRules => 'Actualizando reglas personalizadas...';

  @override
  String get ruleRemovedSuccessfully => 'Regla eliminada correctamente';

  @override
  String get ruleNotRemoved => 'No se ha podido eliminar la regla';

  @override
  String get ruleAddedSuccessfully => 'Regla añadida correctamente';

  @override
  String get ruleNotAdded => 'No se ha podido añadir la regla';

  @override
  String get noCustomFilters => 'No hay filtros personalizados';

  @override
  String get noBlockedClients => 'No hay clientes bloqueados';

  @override
  String get noBlackLists => 'No hay listas negras';

  @override
  String get noWhiteLists => 'No hay listas blancas';

  @override
  String get addWhitelist => 'Añadir lista blanca';

  @override
  String get addBlacklist => 'Añadir lista negra';

  @override
  String get urlNotValid => 'La URL no es válida';

  @override
  String get urlAbsolutePath => 'URL o ruta absoluta';

  @override
  String get addingList => 'Añadiendo lista...';

  @override
  String get listAdded => 'Lista añadida correctamente. Items añadidos:';

  @override
  String get listAlreadyAdded => 'La lista ya estaba añadida';

  @override
  String get listUrlInvalid => 'URL de la lista no válida';

  @override
  String get listNotAdded => 'La lista no se pudo añadir';

  @override
  String get listDetails => 'Detalles de la lista';

  @override
  String get listType => 'Tipo de lista';

  @override
  String get whitelist => 'Lista blanca';

  @override
  String get blacklist => 'Lista negra';

  @override
  String get latestUpdate => 'Última actualización';

  @override
  String get disable => 'Deshabilitar';

  @override
  String get enable => 'Habilitar';

  @override
  String get currentStatus => 'Estado actual';

  @override
  String get listDataUpdated => 'Datos de lista actualizados correctamente';

  @override
  String get listDataNotUpdated =>
      'No se han podido actualizar los datos de la lista';

  @override
  String get updatingListData => 'Actualizando datos de lista...';

  @override
  String get editWhitelist => 'Editar lista blanca';

  @override
  String get editBlacklist => 'Editar lista negra';

  @override
  String get deletingList => 'Eliminando lista...';

  @override
  String get listDeleted => 'Lista eliminada correctamente';

  @override
  String get listNotDeleted => 'La lista no pudo ser eliminada';

  @override
  String get deleteList => 'Eliminar lista';

  @override
  String get deleteListMessage =>
      '¿Estás seguro que deseas eliminar esta lista? Esta acción no se puede revertir.';

  @override
  String get serverSettings => 'Ajustes del servidor';

  @override
  String get serverInformation => 'Información del servidor';

  @override
  String get serverInformationDescription =>
      'Información del servidor y estado';

  @override
  String get loadingServerInfo => 'Cargando información del servidor...';

  @override
  String get serverInfoNotLoaded =>
      'No se ha podido cargar la información del servidor.';

  @override
  String get dnsAddresses => 'Direcciones DNS';

  @override
  String get seeDnsAddresses => 'Ver direcciones DNS';

  @override
  String get dnsPort => 'Puerto DNS';

  @override
  String get httpPort => 'Puerto HTTP';

  @override
  String get protectionEnabled => 'Protección activada';

  @override
  String get dhcpAvailable => 'DHCP disponible';

  @override
  String get serverRunning => 'Servidor en ejecución';

  @override
  String get serverVersion => 'Versión del servidor';

  @override
  String get serverLanguage => 'Idioma del servidor';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get allowedClients => 'Clientes permitidos';

  @override
  String get disallowedClients => 'Clientes no permitidos';

  @override
  String get disallowedDomains => 'Dominios no permitidos';

  @override
  String get accessSettings => 'Ajustes de acceso';

  @override
  String get accessSettingsDescription =>
      'Configura reglas de acceso para el servidor';

  @override
  String get loadingClients => 'Cargando clientes...';

  @override
  String get clientsNotLoaded => 'Los clientes no pudieron ser cargados.';

  @override
  String get noAllowedClients => 'No hay clientes permitidos';

  @override
  String get allowedClientsDescription =>
      'Si esta lista tiene entradas, AdGuard Home aceptará peticiones solo de estos clientes.';

  @override
  String get blockedClientsDescription =>
      'Si esta lista tiene entradas, AdGuard Home descartará las peticiones de estos clientes. Este campo será ignorado si hay entradas en clientes permitidos.';

  @override
  String get disallowedDomainsDescription =>
      ' AdGuard Home descartará las consultas DNS que coincidan con estos dominios, y estas consultas ni siquiera aparecerán en el registro de consultas.';

  @override
  String get addClientFieldDescription => 'CIDRs, Dirección IP, o ClientID';

  @override
  String get clientIdentifier => 'Identificador de cliente';

  @override
  String get allowClient => 'Permitir cliente';

  @override
  String get disallowClient => 'No permitir cliente';

  @override
  String get noDisallowedDomains => 'No hay dominios no permitidos';

  @override
  String get domainNotAdded => 'El dominio no pudo ser añadido';

  @override
  String get statusSelected => 'estado/s seleccionados';

  @override
  String get updateLists => 'Actualizar listas';

  @override
  String get checkHostFiltered => 'Comprobar host';

  @override
  String get updatingLists => 'Actualizando listas...';

  @override
  String get listsUpdated => 'listas actualizadas';

  @override
  String get listsNotUpdated => 'No se pudieron actualizar las listas';

  @override
  String get listsNotLoaded => 'No se pudieron cargar las listas';

  @override
  String get domainNotValid => 'Dominio no válido';

  @override
  String get check => 'Comprobar';

  @override
  String get checkingHost => 'Comprobando host...';

  @override
  String get errorCheckingHost => 'No se pudo comprobar el host';

  @override
  String get block => 'Bloquear';

  @override
  String get unblock => 'Desbloquear';

  @override
  String get custom => 'Personalizado';

  @override
  String get addImportant => 'Añadir \$important';

  @override
  String get howCreateRules => 'Cómo crear reglas personalizadas';

  @override
  String get examples => 'Ejemplos';

  @override
  String get example1 =>
      'Bloquea el acceso al dominio ejemplo.org y a todos sus subdominios.';

  @override
  String get example2 =>
      'Desbloquea el acceso al dominio ejemplo.org y a todos sus subdominios.';

  @override
  String get example3 => 'Añade un comentario.';

  @override
  String get example4 =>
      'Bloquea el acceso a los dominios que coincidan con la expresión regular especificada.';

  @override
  String get moreInformation => 'Más información';

  @override
  String get addingRule => 'Añadiendo regla...';

  @override
  String get deletingRule => 'Eliminando regla...';

  @override
  String get enablingList => 'Habilitando lista...';

  @override
  String get disablingList => 'Deshabilitando lista...';

  @override
  String get savingList => 'Guardando lista...';

  @override
  String get disableFiltering => 'Deshabilitar filtrado';

  @override
  String get enablingFiltering => 'Habilitando filtrado...';

  @override
  String get disablingFiltering => 'Deshabilitando filtrado...';

  @override
  String get filteringStatusUpdated =>
      'Estado de filtrado actualizado correctamente';

  @override
  String get filteringStatusNotUpdated =>
      'El estado de filtrado no pudo ser actualizado';

  @override
  String get updateFrequency => 'Frecuencia de actualización';

  @override
  String get never => 'Nunca';

  @override
  String get hour1 => '1 hora';

  @override
  String get hours12 => '12 horas';

  @override
  String get hours24 => '24 horas';

  @override
  String get days3 => '3 días';

  @override
  String get days7 => '7 días';

  @override
  String get changingUpdateFrequency => 'Cambiando...';

  @override
  String get updateFrequencyChanged =>
      'Frecuencia de actualización cambiada correctamente';

  @override
  String get updateFrequencyNotChanged =>
      'La frecuencia de actualización no pudo ser cambiada';

  @override
  String get updating => 'Actualizando valores...';

  @override
  String get blockedServicesUpdated =>
      'Servicios bloqueados actualizados correctamente';

  @override
  String get blockedServicesNotUpdated =>
      'No se pudieron actualizar los servicios bloqueados';

  @override
  String get insertDomain => 'Inserta un dominio para comprobar su estado.';

  @override
  String get dhcpSettings => 'Configuración de DHCP';

  @override
  String get dhcpSettingsDescription => 'Configura el servidor DHCP';

  @override
  String get dhcpSettingsNotLoaded =>
      'No se ha podido cargar la configuración de DHCP';

  @override
  String get loadingDhcp => 'Cargando configuración de DHCP...';

  @override
  String get enableDhcpServer => 'Habilitar servidor DHCP';

  @override
  String get selectInterface => 'Seleccionar interfaz';

  @override
  String get hardwareAddress => 'Dirección física';

  @override
  String get gatewayIp => 'Puerta de enlace';

  @override
  String get ipv4addresses => 'Direcciones IPv4';

  @override
  String get ipv6addresses => 'Direcciones IPv6';

  @override
  String get neededSelectInterface =>
      'Necesitas seleccionar una interfaz para configurar el servidor DHCP.';

  @override
  String get ipv4settings => 'Configuración IPv4';

  @override
  String get startOfRange => 'Inicio de rango';

  @override
  String get endOfRange => 'Final de rango';

  @override
  String get ipv6settings => 'Configuración IPv6';

  @override
  String get subnetMask => 'Máscara de subred';

  @override
  String get subnetMaskNotValid => 'Máscara de subred no válida';

  @override
  String get gateway => 'Puerta de enlace';

  @override
  String get gatewayNotValid => 'Puerta de enlace no válida';

  @override
  String get leaseTime => 'Tiempo de asignación';

  @override
  String seconds(Object time) {
    return '$time segundos';
  }

  @override
  String get leaseTimeNotValid => 'Tiempo de asignación no válido';

  @override
  String get restoreConfiguration => 'Restaurar configuración';

  @override
  String get restoreConfigurationMessage =>
      '¿Estás seguro de que deseas continuar? Se reseteará toda la configuración. Esta acción no se puede deshacer.';

  @override
  String get changeInterface => 'Cambiar interfaz';

  @override
  String get savingSettings => 'Guardando configuración...';

  @override
  String get settingsSaved => 'Configuración guardada correctamente';

  @override
  String get settingsNotSaved => 'No se ha podido guardar la configuración';

  @override
  String get restoringConfig => 'Restaurando configuración...';

  @override
  String get configRestored => 'Configuración restaurada correctamente';

  @override
  String get configNotRestored =>
      'La configuración no ha podido ser restaurada';

  @override
  String get dhcpStatic => 'Asignaciones DHCP estáticas';

  @override
  String get noDhcpStaticLeases =>
      'No se han encontrado asignaciones DHCP estáticas';

  @override
  String get deleting => 'Eliminando...';

  @override
  String get staticLeaseDeleted =>
      'Asignación DHCP estática eliminada correctamente';

  @override
  String get staticLeaseNotDeleted =>
      'La asignación DHCP estática no pudo ser eliminada';

  @override
  String get deleteStaticLease => 'Eliminar asignación estática';

  @override
  String get deleteStaticLeaseDescription =>
      'La asignación DHCP estática será eliminada. Esta acción no puede ser revertida.';

  @override
  String get addStaticLease => 'Añadir asignación estática';

  @override
  String get macAddress => 'Dirección MAC';

  @override
  String get macAddressNotValid => 'Dirección MAC no válida';

  @override
  String get hostName => 'Nombre del host';

  @override
  String get hostNameError => 'Nombre del host no puede estar vacío';

  @override
  String get creating => 'Creando...';

  @override
  String get staticLeaseCreated =>
      'Asignación DHCP estática creada correctamente';

  @override
  String get staticLeaseNotCreated =>
      'No se ha podido crear la asignación DHCP estática';

  @override
  String get staticLeaseExists => 'La asignación DHCP estática ya existe';

  @override
  String get serverNotConfigured => 'El servidor no está configurado';

  @override
  String get restoreLeases => 'Restaurar asignaciones';

  @override
  String get restoreLeasesMessage =>
      '¿Estás seguro de que deseas continuar? Se resetearán todas las asignaciones estáticas configuradas. Esta acción no se puede deshacer';

  @override
  String get restoringLeases => 'Restaurando asignaciones...';

  @override
  String get leasesRestored => 'Asignaciones restauradas correctamente';

  @override
  String get leasesNotRestored =>
      'Las asignaciones no pudieron ser restauradas';

  @override
  String get dhcpLeases => 'Asignaciones DHCP';

  @override
  String get noLeases => 'No hay asignaciones DHCP disponibles';

  @override
  String get dnsRewrites => 'Reescrituras DNS';

  @override
  String get dnsRewritesDescription => 'Configurar reglas DNS personalizadas';

  @override
  String get loadingRewriteRules => 'Cargando reescrituras DNS...';

  @override
  String get rewriteRulesNotLoaded =>
      'No se han podido cargar las reescrituras DNS.';

  @override
  String get noRewriteRules => 'No hay reescrituras DNS.';

  @override
  String get answer => 'Respuesta';

  @override
  String get deleteDnsRewrite => 'Eliminar reescritura DNS';

  @override
  String get deleteDnsRewriteMessage =>
      '¿Estás seguro que deseas eliminar esta reescritura DNS? Esta acción no se puede deshacer.';

  @override
  String get dnsRewriteRuleDeleted => 'Reescritura DNS eliminada correctamente';

  @override
  String get dnsRewriteRuleNotDeleted =>
      'La reescritura DNS no pudo ser eliminada';

  @override
  String get addDnsRewrite => 'Añadir reescritura DNS';

  @override
  String get addingRewrite => 'Añadiendo reescritura...';

  @override
  String get dnsRewriteRuleAdded =>
      'Regla de reescritura DNS añadida correctamente';

  @override
  String get dnsRewriteRuleNotAdded =>
      'La regla de reescritura DNS no ha podido ser añadida';

  @override
  String get logsSettings => 'Ajustes de registros';

  @override
  String get enableLog => 'Habilitar registro';

  @override
  String get clearLogs => 'Borrar registros';

  @override
  String get anonymizeClientIp => 'Anonimizar IP de los clientes';

  @override
  String get hours6 => '6 horas';

  @override
  String get days30 => '30 días';

  @override
  String get days90 => '90 días';

  @override
  String get retentionTime => 'Tiempo de retención';

  @override
  String get selectOneItem => 'Selecciona un elemento';

  @override
  String get logSettingsNotLoaded =>
      'Los ajustes de registros no han podido ser cargados.';

  @override
  String get updatingSettings => 'Actualizando ajustes...';

  @override
  String get logsConfigUpdated =>
      'Configuración de registros actualizada correctamente';

  @override
  String get logsConfigNotUpdated =>
      'La configuración de registros no ha podido ser actualizada';

  @override
  String get deletingLogs => 'Borrando registros...';

  @override
  String get logsCleared => 'Registros borrados correctamente';

  @override
  String get logsNotCleared => 'No se han podido borrar los registros';

  @override
  String get runningHomeAssistant => 'Ejecutando en Home Assistant';

  @override
  String get serverError => 'Error del servidor';

  @override
  String get noItems => 'No hay elementos para mostrar aquí';

  @override
  String get dnsSettings => 'Configuración de DNS';

  @override
  String get dnsSettingsDescription => 'Configurar conexión con servidores DNS';

  @override
  String get upstreamDns => 'Servidores DNS de subida';

  @override
  String get bootstrapDns => 'Servidores DNS de arranque';

  @override
  String get noUpstreamDns => 'No hay servidores DNS de subida añadidos.';

  @override
  String get dnsMode => 'Modo DNS';

  @override
  String get noDnsMode => 'No se ha seleccionado modo DNS';

  @override
  String get loadBalancing => 'Balanceo de carga';

  @override
  String get parallelRequests => 'Peticiones paralelas';

  @override
  String get fastestIpAddress => 'Dirección IP más rápida';

  @override
  String get loadBalancingDescription =>
      'Consulta un servidor DNS de subida a la vez. AdGuard Home utiliza su algoritmo aleatorio ponderado para elegir el servidor más rápido y sea utilizado con más frecuencia.';

  @override
  String get parallelRequestsDescription =>
      'Usar consultas paralelas para acelerar la resolución al consultar simultáneamente a todos los servidores DNS de subida.';

  @override
  String get fastestIpAddressDescription =>
      'Consulta todos los servidores DNS y devuelve la dirección IP más rápida de todas las respuestas. Esto ralentiza las consultas DNS ya que AdGuard Home tiene que esperar las respuestas de todos los servidores DNS, pero mejora la conectividad general.';

  @override
  String get noBootstrapDns => 'No hay servidores DNS de arranque añadidos.';

  @override
  String get bootstrapDnsServersInfo =>
      'Los servidores DNS de arranque se utilizan para resolver las direcciones IP de los resolutores DoH/DoT que especifiques como DNS de subida.';

  @override
  String get privateReverseDnsServers => 'Servidores DNS privados e inversos';

  @override
  String get privateReverseDnsServersDescription =>
      'Los servidores DNS que AdGuard Home utiliza para las consultas PTR locales. Estos servidores se utilizan para resolver las peticiones PTR de direcciones en rangos de IP privadas, por ejemplo \"192.168.12.34\", utilizando DNS inverso. Si no está establecido, AdGuard Home utilizará los resolutores DNS predeterminados de tu sistema operativo, excepto las direcciones del propio AdGuard Home.';

  @override
  String get reverseDnsDefault =>
      'Por defecto, AdGuard Home utiliza los siguientes resolutores DNS inversos';

  @override
  String get addItem => 'Añadir elemento';

  @override
  String get noServerAddressesAdded =>
      'No hay direcciones de servidores añadidas.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Usar resolutores DNS inversos y privados';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Realiza búsquedas DNS inversas para direcciones servidas localmente utilizando estos servidores DNS de subida. Si está deshabilitado, AdGuard Home responderá con NXDOMAIN a todas las peticiones PTR de este tipo, excepto para los clientes conocidos por DHCP, /etc/hosts, etc.';

  @override
  String get enableReverseResolving =>
      'Habilitar la resolución inversa de las direcciones IP de clientes';

  @override
  String get enableReverseResolvingDescription =>
      'Resuelve de manera inversa las direcciones IP de los clientes a sus nombres de hosts enviando consultas PTR a los resolutores correspondientes (servidores DNS privados para clientes locales, servidores DNS de subida para clientes con direcciones IP públicas).';

  @override
  String get dnsServerSettings =>
      'Configuración del servidor DNS de AdGuard Home';

  @override
  String get limitRequestsSecond => 'Límite de peticiones por segundo';

  @override
  String get valueNotNumber => 'El valor no es un número';

  @override
  String get enableEdns => 'Habilitar subred de cliente EDNS';

  @override
  String get enableEdnsDescription =>
      'Añade la opción subred de cliente EDNS (ECS) a las peticiones del DNS de subida y registra los valores enviados por los clientes en el registro de consultas.';

  @override
  String get enableDnssec => 'Habilitar DNSSEC';

  @override
  String get enableDnssecDescription =>
      'Establece el indicador DNSSEC en las consultas DNS salientes y comprueba el resultado (se requiere un resolutor habilitado para DNSSEC).';

  @override
  String get disableResolvingIpv6 =>
      'Deshabilitar resolución de direcciones IPv6';

  @override
  String get disableResolvingIpv6Description =>
      'Descarta todas las consultas DNS para direcciones IPv6 (tipo AAAA).';

  @override
  String get blockingMode => 'Modo de bloqueo';

  @override
  String get defaultMode => 'Por defecto';

  @override
  String get defaultDescription =>
      'Responde con dirección IP cero (0.0.0.0 para A; :: para AAAA) cuando está bloqueado por la regla de estilo Adblock; responde con la dirección IP especificada en la regla cuando está bloqueado por una regla de estilo /etc/hosts';

  @override
  String get refusedDescription => 'Responde con el código REFUSED';

  @override
  String get nxdomainDescription => 'Responde con el código NXDOMAIN';

  @override
  String get nullIp => 'IP nula';

  @override
  String get nullIpDescription =>
      'Responde con dirección IP cero (0.0.0.0 para A; :: para AAAA)';

  @override
  String get customIp => 'IP personalizada';

  @override
  String get customIpDescription =>
      'Responde con una dirección IP establecida manualmente.';

  @override
  String get dnsCacheConfig => 'Configuración de la caché DNS';

  @override
  String get cacheSize => 'Tamaño de la caché';

  @override
  String get inBytes => 'En bytes';

  @override
  String get overrideMinimumTtl => 'Anular TTL mínimo';

  @override
  String get overrideMinimumTtlDescription =>
      'Amplía el corto tiempo de vida (segundos) de los valores recibidos del servidor DNS de subida al almacenar en caché las respuestas DNS.';

  @override
  String get overrideMaximumTtl => 'Anular TTL máximo';

  @override
  String get overrideMaximumTtlDescription =>
      'Establece un valor de tiempo de vida (segundos) máximo para las entradas en la caché DNS.';

  @override
  String get optimisticCaching => 'Cacheado optimista';

  @override
  String get optimisticCachingDescription =>
      'Haz que AdGuard Home responda desde la caché incluso cuando las entradas estén expiradas y también intente actualizarlas.';

  @override
  String get loadingDnsConfig => 'Cargando configuración de DNS...';

  @override
  String get dnsConfigNotLoaded =>
      'No se ha podido cargar la configuración de DNS.';

  @override
  String get blockingIpv4 => 'Bloqueo de IPv4';

  @override
  String get blockingIpv4Description =>
      'Dirección IP devolverá una petición A bloqueada';

  @override
  String get blockingIpv6 => 'Bloqueo de IPv6';

  @override
  String get blockingIpv6Description =>
      'Dirección IP devolverá una petición AAAA bloqueada';

  @override
  String get invalidIp => 'Dirección IP no válida';

  @override
  String get dnsConfigSaved =>
      'La configuración del servidor DNS se ha guardado correctamente';

  @override
  String get dnsConfigNotSaved =>
      'La configuración del servidor DNS no ha podido ser guardada';

  @override
  String get savingConfig => 'Guardando configuración...';

  @override
  String get someValueNotValid => 'Algún valor no es válido';

  @override
  String get upstreamDnsDescription =>
      'Configura los servidores de subida y el modo DNS';

  @override
  String get bootstrapDnsDescription =>
      'Configura los servidores DNS de arranque';

  @override
  String get privateReverseDnsDescription =>
      'Configura DNS resolutores personalizados y habilita resolutores internos y privados';

  @override
  String get dnsServerSettingsDescription =>
      'Configura el límite de peticiones, el modo de bloqueo y más';

  @override
  String get dnsCacheConfigDescription =>
      'Configura cómo el servidor debe manejar la caché del DNS';

  @override
  String get comment => 'Comentario';

  @override
  String get address => 'Dirección';

  @override
  String get commentsDescription =>
      'Los comentarios siempre van precedidos por #. No necesitas añadirlo. Se añadirá automáticamente.';

  @override
  String get encryptionSettings => 'Configuración de cifrado';

  @override
  String get encryptionSettingsDescription =>
      'Soporte de cifrado (HTTPS/QUIC/TLS)';

  @override
  String get loadingEncryptionSettings =>
      'Cargando configuración de cifrado...';

  @override
  String get encryptionSettingsNotLoaded =>
      'No se ha podido cargar la configuración de cifrado.';

  @override
  String get enableEncryption => 'Habilitar cifrado';

  @override
  String get enableEncryptionTypes =>
      'HTTPS, DNS mediante HTTPS y DNS mediante TLS';

  @override
  String get enableEncryptionDescription =>
      'Si el cifrado está habilitado, la interfaz de administración de AdGuard Home funcionará a través de HTTPS, y el servidor DNS escuchará las peticiones DNS mediante HTTPS y DNS mediante TLS.';

  @override
  String get serverConfiguration => 'Configuración del servidor';

  @override
  String get domainName => 'Nombre de dominio';

  @override
  String get domainNameDescription =>
      'Si se configura, AdGuard Home detecta los ID de clientes, responde a las consultas DDR y realiza validaciones de conexión adicionales. Si no se configura, estas funciones se deshabilitarán. Debe coincidir con uno de los nombres DNS del certificado.';

  @override
  String get redirectHttps => 'Redireccionar automáticamente a HTTPS';

  @override
  String get httpsPort => 'Puerto HTTPS';

  @override
  String get tlsPort => 'Puerto DNS sobre TLS';

  @override
  String get dnsOverQuicPort => 'Puerto DNS sobre QUIC';

  @override
  String get certificates => 'Certificados';

  @override
  String get certificatesDescription =>
      'Para utilizar el cifrado, debes proporcionar una cadena de certificado SSL válida para tu dominio. Puedes obtener un certificado gratuito en letsencrypt.org o puedes comprarlo en una de las autoridades de certificación de confianza.';

  @override
  String get certificateFilePath =>
      'Establecer una ruta para el archivo de certificado';

  @override
  String get pasteCertificateContent => 'Pegar el contenido del certificado';

  @override
  String get certificatePath => 'Ruta de acceso al certificado';

  @override
  String get certificateContent => 'Contenido del certificado';

  @override
  String get privateKey => 'Clave privada';

  @override
  String get privateKeyFile => 'Establecer un archivo de clave privada';

  @override
  String get pastePrivateKey => 'Pegar el contenido de la clave privada';

  @override
  String get usePreviousKey => 'Usar la clave privada guardada previamente';

  @override
  String get privateKeyPath => 'Ruta de la clave privada';

  @override
  String get invalidCertificate => 'Certificado no válido';

  @override
  String get invalidPrivateKey => 'Clave privada no válida';

  @override
  String get validatingData => 'Validando datos';

  @override
  String get dataValid => 'Datos válidos';

  @override
  String get dataNotValid => 'Datos no válidos';

  @override
  String get encryptionConfigSaved =>
      'Configuración de cifrado guardada correctamente';

  @override
  String get encryptionConfigNotSaved =>
      'No se pudo guardar la configuración de encriptado';

  @override
  String get configError => 'Configuration error';

  @override
  String get enterOnlyCertificate =>
      'Introduce sólo el certificado. No introduzcas las líneas ---BEGIN--- y ---END---.';

  @override
  String get enterOnlyPrivateKey =>
      'Introduce sólo la clave privada. No introduzcas las líneas ---BEGIN--- y ---END---.';

  @override
  String get noItemsSearch => 'No hay items para esa búsqueda.';

  @override
  String get clearSearch => 'Limpiar búsqueda';

  @override
  String get exitSearch => 'Salir de la búsqueda';

  @override
  String get searchClients => 'Buscar clientes';

  @override
  String get noClientsSearch => 'No hay clientes con esa búsqueda.';

  @override
  String get customization => 'Personalización';

  @override
  String get customizationDescription => 'Personaliza esta aplicación';

  @override
  String get color => 'Color';

  @override
  String get useDynamicTheme => 'Usar tema dinámico';

  @override
  String get red => 'Rojo';

  @override
  String get green => 'Verde';

  @override
  String get blue => 'Azul';

  @override
  String get yellow => 'Amarillo';

  @override
  String get orange => 'Naranja';

  @override
  String get brown => 'Marrón';

  @override
  String get cyan => 'Cyan';

  @override
  String get purple => 'Morado';

  @override
  String get pink => 'Rosa';

  @override
  String get deepOrange => 'Naranja oscuro';

  @override
  String get indigo => 'Índigo';

  @override
  String get useThemeColorStatus => 'Usar el color del tema para estados';

  @override
  String get useThemeColorStatusDescription =>
      'Reemplaza el verde y rojo por el color del tema y gris';

  @override
  String get invalidCertificateChain => 'Cadena de certificado inválida';

  @override
  String get validCertificateChain => 'Cadena de certificado válida';

  @override
  String get subject => 'Asunto';

  @override
  String get issuer => 'Emisor';

  @override
  String get expires => 'Expira';

  @override
  String get validPrivateKey => 'Clave privada válida';

  @override
  String get expirationDate => 'Fecha de expiración';

  @override
  String get keysNotMatch =>
      'Certificado o clave inválido: tls: la clave privada no corresponde con la clave pública';

  @override
  String get timeLogs => 'Tiempo en logs';

  @override
  String get timeLogsDescription =>
      'Mostrar el tiempo de procesamiento en la lista de logs';

  @override
  String get hostNames => 'Nombres de host';

  @override
  String get keyType => 'Tipo de clave';

  @override
  String get updateAvailable => 'Actualización disponible';

  @override
  String get installedVersion => 'Versión instalada';

  @override
  String get newVersion => 'Nueva versión';

  @override
  String get source => 'Fuente';

  @override
  String get downloadUpdate => 'Descargar actualización';

  @override
  String get download => 'Descargar';

  @override
  String get doNotRememberAgainUpdate =>
      'No recordar de nuevo para esta actualización';

  @override
  String get downloadingUpdate => 'Descargando';

  @override
  String get completed => 'completado';

  @override
  String get permissionNotGranted => 'Permiso no concedido';

  @override
  String get inputSearchTerm => 'Introduce un término de búsqueda.';

  @override
  String get answers => 'Respuestas';

  @override
  String get copyClipboard => 'Copiar al portapapeles';

  @override
  String get domainCopiedClipboard => 'Dominio copiado al portapapeles';

  @override
  String get clearDnsCache => 'Borrar caché de DNS';

  @override
  String get clearDnsCacheMessage =>
      '¿Estás seguro que deseas eliminar la caché de DNS?';

  @override
  String get dnsCacheCleared => 'Caché de DNS borrada correctamente';

  @override
  String get clearingDnsCache => 'Borrando caché...';

  @override
  String get dnsCacheNotCleared => 'La caché de DNS no pudo ser borrada';

  @override
  String get clientsSelected => 'clientes seleccionados';

  @override
  String get invalidDomain => 'Dominio no válido';

  @override
  String get loadingBlockedServicesList =>
      'Cargando lista de servicios bloqueados...';

  @override
  String get blockedServicesListNotLoaded =>
      'No se ha podido cargar la lista de servicios bloqueados';

  @override
  String get error => 'Error';

  @override
  String get updates => 'Actualizaciones';

  @override
  String get updatesDescription => 'Actualiza el servidor AdGuard Home';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get currentVersion => 'Versión actual';

  @override
  String get requestStartUpdateFailed =>
      'Petición para iniciar la actualización fallida';

  @override
  String get requestStartUpdateSuccessful =>
      'Petición para iniciar la actualización satisfactoria';

  @override
  String get serverUpdated => 'Servidor actualizado';

  @override
  String get unknownStatus => 'Estado desconocido';

  @override
  String get checkingUpdates => 'Comprobando actualizaciones...';

  @override
  String get checkUpdates => 'Comprobar actualizaciones';

  @override
  String get requestingUpdate => 'Solicitando actualización...';

  @override
  String get autoupdateUnavailable => 'Autoactualización no disponible';

  @override
  String get autoupdateUnavailableDescription =>
      'El servicio de actualización automática del servidor no está disponible. Puede ser porque el servidor se esté ejecutando en un contenedor Docker. Tienes que actualizar tu servidor manualmente.';

  @override
  String minute(Object time) {
    return '$time minuto';
  }

  @override
  String minutes(Object time) {
    return '$time minutos';
  }

  @override
  String hour(Object time) {
    return '$time hora';
  }

  @override
  String hours(Object time) {
    return '$time horas';
  }

  @override
  String get remainingTime => 'Tiempo restante';

  @override
  String get safeSearchSettings => 'Configuración de búsqueda segura';

  @override
  String get loadingSafeSearchSettings =>
      'Cargando configuración de búsqueda segura...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Error al cargar la configuración de búsqueda segura.';

  @override
  String get loadingLogsSettings => 'Cargando configuración de registros...';

  @override
  String get selectOptionLeftColumn =>
      'Selecciona una opción de la columna de la izquierda';

  @override
  String get selectClientLeftColumn =>
      'Selecciona un cliente de la columna de la izquierda';

  @override
  String get disableList => 'Deshabilitar lista';

  @override
  String get enableList => 'Habilitar lista';

  @override
  String get screens => 'Pantallas';

  @override
  String get copiedClipboard => 'Copiado al portapapeles';

  @override
  String get seeDetails => 'Ver los detalles';

  @override
  String get listNotAvailable => 'Lista no disponible';

  @override
  String get copyListUrl => 'Copiar URL de lista';

  @override
  String get listUrlCopied => 'URL de la lista copiada al portapapeles';

  @override
  String get unsupportedVersion => 'Versión no soportada';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'El soporte para la versión del servidor $version no está garantizada. Esta aplicación puede tener problemas al trabajar con esa versión del servidor.\n\nAdGuard Home Manager está diseñado para trabajar con las versiones estables del servidor AdGuard Home. Puede funcionar con versiones alpha y beta, pero la compatibilidad no está asegurada y la aplicación puede tener problemas para trabajar con esas versiones.';
  }

  @override
  String get iUnderstand => 'Lo entiendo';

  @override
  String get appUpdates => 'Actualizaciones de la app';

  @override
  String get usingLatestVersion => 'Estás usando la última versión';

  @override
  String get ipLogs => 'IP en registros';

  @override
  String get ipLogsDescription =>
      'Mostrar siempre dirección IP en vez del nombre del cliente';

  @override
  String get application => 'Aplicación';

  @override
  String get combinedChart => 'Gráfico combinado';

  @override
  String get combinedChartDescription =>
      'Combina todos los gráficos en uno solo';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get errorLoadFilters => 'Error al cargar los filtros.';

  @override
  String get clientRemovedSuccessfully => 'Cliente eliminado correctamente.';

  @override
  String get editRewriteRule => 'Editar reescritura DNS';

  @override
  String get dnsRewriteRuleUpdated =>
      'Regla de reescritura DNS actualizada correctamente';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'La regla de reescritura DNS no ha podido ser actualizada';

  @override
  String get updatingRule => 'Actualizando regla...';

  @override
  String get serverUpdateNeeded => 'Actualización del servidor necesaria';

  @override
  String updateYourServer(Object version) {
    return 'Actualiza tu servidor AdGuard Home a $version para utilizar esta funcionalidad.';
  }

  @override
  String get january => 'Enero';

  @override
  String get february => 'Febrero';

  @override
  String get march => 'Marzo';

  @override
  String get april => 'Abril';

  @override
  String get may => 'Mayo';

  @override
  String get june => 'Junio';

  @override
  String get july => 'Julio';

  @override
  String get august => 'Agosto';

  @override
  String get september => 'Septiembre';

  @override
  String get october => 'Octubre';

  @override
  String get november => 'Noviembre';

  @override
  String get december => 'Diciembre';

  @override
  String get malwarePhishing => 'Malware/phising';

  @override
  String get queries => 'Peticiones';

  @override
  String get adultSites => 'Sitios de adultos';

  @override
  String get quickFilters => 'Filtros rápidos';

  @override
  String get searchDomainInternet => 'Buscar dominio en internet';

  @override
  String get hideServerAddress => 'Ocultar dirección del servidor';

  @override
  String get hideServerAddressDescription =>
      'Oculta la dirección del servidor en la pantalla de inicio';

  @override
  String get topItemsOrder => 'Orden de los top';

  @override
  String get topItemsOrderDescription =>
      'Ordena las listas de top de elementos en la pantalla de inicio';

  @override
  String get topItemsReorderInfo =>
      'Mantén presionado y desliza un elemento para reordenarlo.';

  @override
  String get discardChanges => 'Descartar cambios';

  @override
  String get discardChangesDescription =>
      '¿Estás seguro de que deseas descartar los cambios realizados?';

  @override
  String get others => 'Otros';

  @override
  String get showChart => 'Mostrar gráfico';

  @override
  String get hideChart => 'Ocultar gráfico';

  @override
  String get showTopItemsChart => 'Mostrar gráfico en top de items';

  @override
  String get showTopItemsChartDescription =>
      'Muestra por defecto el gráfico de anillo en las secciones de top de items. Sólo afecta a la vista móvil.';

  @override
  String get openMenu => 'Abrir menú';

  @override
  String get closeMenu => 'Cerrar menú';

  @override
  String get openListUrl => 'Abrir URL de lista';

  @override
  String get selectionMode => 'Modo de selección';

  @override
  String get enableDisableSelected =>
      'Activar o desactivar elementos seleccionados';

  @override
  String get deleteSelected => 'Eliminar elementos seleccionados';

  @override
  String get deleteSelectedLists => 'Eliminar listas seleccionadas';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'Todas las listas seleccionadas han sido eliminadas correctamente.';

  @override
  String get deletionResult => 'Resultado de eliminación';

  @override
  String get deletingLists => 'Eliminando listas...';

  @override
  String get failedElements => 'Elementos fallidos';

  @override
  String get processingLists => 'Procesando listas...';

  @override
  String get enableDisableResult => 'Resultado de activar o desactivar';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'Todas las listas seleccionadas se han activado o desactivado correctamente.';

  @override
  String get sslWarning =>
      'Si estás usando una conexión HTTPS con un certificado autofirmado, asegúrate de activar \"No comprobar el certificado SSL\" en Ajustes > Ajustes avanzados.';

  @override
  String get unsupportedServerVersion => 'Versión del servidor no soportada';

  @override
  String get unsupportedServerVersionMessage =>
      'La versión de tu servidor AdGuard Home es demasiado antigua y no está soportada por AdGuard Home Manager. Necesitarás actualizar tu servidor AdGuard Home a una versión más actual para utilizar esta aplicación.';

  @override
  String yourVersion(Object version) {
    return 'Tu versión: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Versión mínima requerida: $version';
  }

  @override
  String get topUpstreams => 'DNS de subida más frecuentes';

  @override
  String get averageUpstreamResponseTime =>
      'Tiempo promedio de respuesta upstream';

  @override
  String get dhcpNotAvailable => 'El servidor DHCP no está disponible.';

  @override
  String get osServerInstalledIncompatible =>
      'El SO donde el servidor está instalado no es compatible con esta característica.';

  @override
  String get resetSettings => 'Resetear configuración';

  @override
  String get resetEncryptionSettingsDescription =>
      'Estás seguro que deseas restaurar a valores por defecto la configuración de encriptación?';

  @override
  String get resettingConfig => 'Reseteando configuración...';

  @override
  String get configurationResetSuccessfully =>
      'Configuración reseteada correctamente';

  @override
  String get configurationResetError =>
      'La configuración no ha podido ser reseteada';

  @override
  String get testUpstreamDnsServers => 'Probar servidores DNS de subida';

  @override
  String get errorTestUpstreamDns =>
      'Error al probar los servidores DNS de subida.';

  @override
  String get useCustomIpEdns => 'Usar IP personalizada para EDNS';

  @override
  String get useCustomIpEdnsDescription =>
      'Permitir usar IP personalizada para EDNS';

  @override
  String get sortingOptions => 'Opciones de ordenación';

  @override
  String get fromHighestToLowest => 'De mayor a menor';

  @override
  String get fromLowestToHighest => 'De menor a mayor';

  @override
  String get queryLogsAndStatistics => 'Registro de consultas y estadísticas';

  @override
  String get ignoreClientQueryLog =>
      'Ignorar este cliente en el registro de consultas';

  @override
  String get ignoreClientStatistics =>
      'Ignorar este cliente en las estadísticas';

  @override
  String get savingChanges => 'Guardando cambios...';

  @override
  String get fallbackDnsServers => 'Servidores DNS alternativos';

  @override
  String get fallbackDnsServersDescription =>
      'Configura los servidores DNS alternativos';

  @override
  String get fallbackDnsServersInfo =>
      'Lista de servidores DNS alternativos utilizados cuando los servidores DNS de subida no responden. La sintaxis es la misma que en el campo de los principales DNS de subida anterior.';

  @override
  String get noFallbackDnsAdded =>
      'No hay servidores DNS alternativos añadidos.';

  @override
  String get blockedResponseTtl => 'Respuesta TTL bloqueada';

  @override
  String get blockedResponseTtlDescription =>
      'Especifica durante cuántos segundos los clientes deben almacenar en cache una respuesta filtrada';

  @override
  String get invalidValue => 'Valor no válido';

  @override
  String get noDataChart => 'No hay datos para mostrar este gráfico.';

  @override
  String get noData => 'No hay datos';

  @override
  String get unblockClient => 'Desbloquear cliente';

  @override
  String get blockingClient => 'Bloqueando cliente...';

  @override
  String get unblockingClient => 'Desbloqueando cliente...';

  @override
  String get upstreamDnsCacheConfiguration =>
      'Configuración de la caché DNS upstream';

  @override
  String get enableDnsCachingClient =>
      'Habilitar caché de DNS para este cliente';

  @override
  String get dnsCacheSize => 'Tamaño de caché de DNS';

  @override
  String get nameInvalid => 'Se requiere un nombre';

  @override
  String get oneIdentifierRequired => 'Se require al menos un identificador';

  @override
  String get dnsCacheNumber => 'El tamaño de caché de DNS debe ser un número';

  @override
  String get errors => 'Errores';

  @override
  String get redirectHttpsWarning =>
      'Si tienes activado \"Redireccionar a HTTPS automáticamente\" en tu servidor AdGuard Home, debes seleccionar una conexión HTTPS y utilizar el puerto de HTTPS de tu servidor.';

  @override
  String get logsSettingsDescription => 'Configura los registros de peticiones';

  @override
  String get ignoredDomains => 'Dominios ignorados';

  @override
  String get noIgnoredDomainsAdded => 'No hay añadidos dominios para ignorar';

  @override
  String get pauseServiceBlocking => 'Pausa del servicio de bloqueo';

  @override
  String get newSchedule => 'Nueva programación';

  @override
  String get editSchedule => 'Editar programación';

  @override
  String get timezone => 'Zona horaria';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get from => 'Desde';

  @override
  String get to => 'Hasta';

  @override
  String get selectStartTime => 'Seleccionar hora de inicio';

  @override
  String get selectEndTime => 'Seleccionar hora de fin';

  @override
  String get startTimeBeforeEndTime =>
      'La hora de inicio debe ser anterior a la hora de fin.';

  @override
  String get noBlockingScheduleThisDevice =>
      'No hay programación de bloqueo para este dispositivo.';

  @override
  String get selectTimezone => 'Selecciona una zona horaria';

  @override
  String get selectClientsFiltersInfo =>
      'Selecciona los clientes que quieres mostrar. Si no hay clientes seleccionados, se mostrarán todos.';

  @override
  String get noDataThisSection => 'No hay datos para esta sección.';

  @override
  String get statisticsSettings => 'Ajustes de estadísticas';

  @override
  String get statisticsSettingsDescription =>
      'Configura la recolección de datos para estadísticas';

  @override
  String get loadingStatisticsSettings => 'Cargando ajustes de estadísticas...';

  @override
  String get statisticsSettingsLoadError =>
      'Ocurrió un error al cargar los ajustes de estadísticas.';

  @override
  String get statisticsConfigUpdated =>
      'Configuración de estadísticas actualizada correctamente.';

  @override
  String get statisticsConfigNotUpdated =>
      'La configuración de estadísticas no pudo ser actualizada.';

  @override
  String get customTimeInHours => 'Tiempo personalizado (en horas)';

  @override
  String get invalidTime => 'Tiempo no válido';

  @override
  String get removeDomain => 'Eliminar dominio';

  @override
  String get addDomain => 'Añadir dominio';

  @override
  String get notLess1Hour => 'El tiempo no puede ser inferior a 1 hora';

  @override
  String get rateLimit => 'Limitación de velocidad';

  @override
  String get subnetPrefixLengthIpv4 =>
      'Longitud del prefijo de subred para IPv4';

  @override
  String get subnetPrefixLengthIpv6 =>
      'Longitud del prefijo de subred para IPv6';

  @override
  String get rateLimitAllowlist =>
      'Lista de permitidos de limitación de velocidad';

  @override
  String get rateLimitAllowlistDescription =>
      'Direcciones IP excluidas de la limitación de velocidad';

  @override
  String get dnsOptions => 'Opciones de DNS';

  @override
  String get editor => 'Editor';

  @override
  String get editCustomRules => 'Editar reglas personalizadas';

  @override
  String get savingCustomRules => 'Guardando reglas personalizadas...';

  @override
  String get customRulesUpdatedSuccessfully =>
      'Reglas personalizadas actualizadas correctamente';

  @override
  String get customRulesNotUpdated =>
      'Las reglas personalizadas no pudieron ser actualizadas';

  @override
  String get reorder => 'Reordenar';

  @override
  String get showHide => 'Mostrar/ocultar';

  @override
  String get noElementsReorderMessage =>
      'Activa algunos elementos en la pestaña de mostrar/ocultar para reordenarlos aquí.';

  @override
  String get enablePlainDns => 'Activar DNS simple (sin cifrado)';

  @override
  String get enablePlainDnsDescription =>
      'El DNS simple (sin cifrado) está activado de forma predeterminada. Puedes desactivarlo para obligar a todos los dispositivos a utilizar DNS cifrado. Para ello, debes habilitar al menos un protocolo DNS cifrado.';

  @override
  String get date => 'Fecha';

  @override
  String get loadingChangelog => 'Cargando registro de cambios...';

  @override
  String get invalidIpOrUrl => 'Dirección IP o URL no válida';

  @override
  String get addPersistentClient => 'Añadir como cliente persistente';

  @override
  String get blockThisClientOnly => 'Bloquear sólo para este cliente';

  @override
  String get unblockThisClientOnly => 'Desbloquear sólo para este cliente';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain bloqueado para este cliente';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return '$domain desbloqueado para este cliente';
  }

  @override
  String get disallowThisClient => 'No permitir este cliente';

  @override
  String get allowThisClient => 'Permitir este cliente';

  @override
  String get clientAllowedSuccessfully => 'Cliente permitido correctamente';

  @override
  String get clientDisallowedSuccessfully =>
      'Cliente no permitido correctamente';

  @override
  String get changesNotSaved => 'Los cambios no han podido ser guardados';

  @override
  String get allowingClient => 'Permitiendo cliente...';

  @override
  String get disallowingClient => 'No permitiendo cliente...';

  @override
  String get clientIpCopied =>
      'Dirección IP del cliente copiada al portapapeles';

  @override
  String get clientNameCopied => 'Nombre del cliente copiado al portapapeles';

  @override
  String get dnsServerAddressCopied =>
      'Dirección del servidor DNS copiada al portapapeles';

  @override
  String get select => 'Seleccionar';

  @override
  String get liveLogs => 'Registros en directo';

  @override
  String get hereWillAppearRealtimeLogs =>
      'Aquí aparecerán los registros en tiempo real.';

  @override
  String get applicationDetails => 'Detalles de la aplicación';

  @override
  String get applicationDetailsDescription =>
      'Repositorio de la app, tiendas donde está disponible, y más';

  @override
  String get myOtherApps => 'Mis otras apps';

  @override
  String get myOtherAppsDescription =>
      'Comprueba mis otras apps, hacer una donación, contactar al soporte, y más';

  @override
  String get topToBottom => 'Desde arriba hacia abajo';

  @override
  String get bottomToTop => 'Desde abajo hacia arriba';

  @override
  String get upstreamTimeout => 'Tiempo de espera del upstream';

  @override
  String get upstreamTimeoutHelper =>
      'Especifica el número de segundos que se debe esperar para recibir una respuesta del servidor upstream';

  @override
  String get fieldCannotBeEmpty => 'El campo no puede estar vacío';

  @override
  String get enableDnsRewriteRules => 'Habilitar reglas de reescritura DNS';

  @override
  String get dnsRewriteRuleEnabled =>
      'Regla de reescritura DNS habilitada exitosamente';

  @override
  String get dnsRewriteRuleDisabled =>
      'Regla de reescritura DNS deshabilitada exitosamente';

  @override
  String get allDnsRewriteRulesEnabled =>
      'Todas las reglas de reescritura DNS habilitadas exitosamente';

  @override
  String get allDnsRewriteRulesDisabled =>
      'Todas las reglas de reescritura DNS deshabilitadas exitosamente';

  @override
  String get errorEnablingAllDnsRewriteRules =>
      'Error al habilitar todas las reglas de reescritura DNS';

  @override
  String get errorDisablingAllDnsRewriteRules =>
      'Error al deshabilitar todas las reglas de reescritura DNS';

  @override
  String get enablingDnsRewriteRule =>
      'Habilitando reglas de reescritura DNS...';

  @override
  String get disablingDnsRewriteRule =>
      'Deshabilitando reglas de reescritura DNS...';
}
