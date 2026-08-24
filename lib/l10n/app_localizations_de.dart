// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Einstellungen';

  @override
  String get connect => 'Verbinden';

  @override
  String get servers => 'Server';

  @override
  String get createConnection => 'Verbindung erstellen';

  @override
  String get editConnection => 'Verbindung bearbeiten';

  @override
  String get name => 'Name';

  @override
  String get ipDomain => 'IP-Adresse oder Domain';

  @override
  String get path => 'Pfad';

  @override
  String get port => 'Port';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get defaultServer => 'Standardserver';

  @override
  String get general => 'Allgemein';

  @override
  String get connection => 'Verbindung';

  @override
  String get authentication => 'Authentifizierung';

  @override
  String get other => 'Sonstiges';

  @override
  String get invalidPort => 'Ungültiger Port';

  @override
  String get invalidPath => 'Ungültiger Pfad';

  @override
  String get invalidIpDomain => 'Ungültige IP oder Domain';

  @override
  String get ipDomainNotEmpty => 'IP oder Domain darf nicht leer sein';

  @override
  String get nameNotEmpty => 'Name darf nicht leer sein';

  @override
  String get invalidUsernamePassword => 'Ungültiger Benutzername oder Passwort';

  @override
  String get tooManyAttempts => 'Zu viele Versuche. Versuche es später erneut.';

  @override
  String get cantReachServer =>
      'Server kann nicht erreicht werden. Überprüfe die Verbindungsdaten.';

  @override
  String get sslError =>
      'SSL-Handshake-Fehler. Es konnte keine sichere Verbindung zum Server hergestellt werden. Dies kann ein SSL-Fehler sein. Gehe zu Einstellungen > Erweiterte Einstellungen und aktiviere SSL-Zertifikat nicht prüfen.';

  @override
  String get unknownError => 'Unbekannter Fehler';

  @override
  String get connectionNotCreated =>
      'Verbindung konnte nicht hergestellt werden';

  @override
  String get connecting => 'Verbinden...';

  @override
  String get connected => 'Verbunden';

  @override
  String get selectedDisconnected => 'Ausgewählt, aber getrennt';

  @override
  String get connectionDefaultSuccessfully =>
      'Verbindung erfolgreich als Standard festgelegt.';

  @override
  String get connectionDefaultFailed =>
      'Verbindung konnte nicht als Standard festgelegt werden.';

  @override
  String get noSavedConnections => 'Keine gespeicherten Verbindungen';

  @override
  String get cannotConnect => 'Server kann nicht erreicht werden';

  @override
  String get connectionRemoved => 'Verbindung erfolgreich entfernt';

  @override
  String get connectionCannotBeRemoved =>
      'Verbindung kann nicht entfernt werden.';

  @override
  String get remove => 'Entfernen';

  @override
  String get removeWarning =>
      'Bist du sicher, dass du die Verbindung mit diesem AdGuard Home Server entfernen möchtest?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get defaultConnection => 'Standardverbindung';

  @override
  String get setDefault => 'Als Standard festlegen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get serverStatus => 'Serverstatus';

  @override
  String get connectionNotUpdated => 'Verbindung nicht aktualisiert';

  @override
  String get ruleFilteringWidget => 'Regelfilterung';

  @override
  String get safeBrowsingWidget => 'Safe Browsing';

  @override
  String get parentalFilteringWidget => 'Kindersicherung';

  @override
  String get safeSearchWidget => 'Sichere Suche';

  @override
  String get ruleFiltering => 'Regelfilterung';

  @override
  String get safeBrowsing => 'Safe Browsing';

  @override
  String get parentalFiltering => 'Kindersicherung';

  @override
  String get safeSearch => 'Sichere Suche';

  @override
  String get serverStatusNotRefreshed =>
      'Serverstatus konnte nicht aktualisiert werden';

  @override
  String get loadingStatus => 'Status wird geladen...';

  @override
  String get errorLoadServerStatus =>
      'Serverstatus konnte nicht geladen werden';

  @override
  String get topQueriedDomains => 'Angefragte Domains';

  @override
  String get viewMore => 'Mehr anzeigen';

  @override
  String get topClients => 'Clients';

  @override
  String get topBlockedDomains => 'Blockierte Domains';

  @override
  String get appSettings => 'App-Einstellungen';

  @override
  String get theme => 'Design';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get systemDefined => 'Systemstandard';

  @override
  String get close => 'Schließen';

  @override
  String get connectedTo => 'Verbunden mit:';

  @override
  String get selectedServer => 'Ausgewählter Server:';

  @override
  String get noServerSelected => 'Kein Server ausgewählt';

  @override
  String get manageServer => 'Server verwalten';

  @override
  String get allProtections => 'Alle Schutzfunktionen';

  @override
  String get userNotEmpty => 'Benutzername darf nicht leer sein';

  @override
  String get passwordNotEmpty => 'Passwort darf nicht leer sein';

  @override
  String get examplePath => 'Beispiel: /adguard';

  @override
  String get helperPath => 'Falls du einen Reverse-Proxy verwendest';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get appVersion => 'Appversion';

  @override
  String get createdBy => 'Erstellt von';

  @override
  String get clients => 'Clients';

  @override
  String get allowed => 'Erlaubt';

  @override
  String get blocked => 'Blockiert';

  @override
  String get noClientsList => 'Keine Clients auf dieser Liste vorhanden';

  @override
  String get activeClients => 'Aktiv';

  @override
  String get removeClient => 'Client entfernen';

  @override
  String get removeClientMessage =>
      'Bist du dir sicher, dass du diesen Client von der Liste entfernen möchtest?';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get removingClient => 'Client wird entfernt...';

  @override
  String get clientNotRemoved =>
      'Client konnte nicht von der Liste entfernt werden';

  @override
  String get addClient => 'Client hinzufügen';

  @override
  String get list => 'Liste';

  @override
  String get ipAddress => 'IP-Adresse';

  @override
  String get ipNotValid => 'Ungültige IP-Adresse';

  @override
  String get clientAddedSuccessfully =>
      'Client erfolgreich zur Liste hinzugefügt';

  @override
  String get addingClient => 'Client wird hinzugefügt...';

  @override
  String get clientNotAdded =>
      'Client konnte nicht zur Liste hinzugefügt werden';

  @override
  String get clientAnotherList =>
      'Dieser Client ist bereits in einer anderen Liste';

  @override
  String get noSavedLogs => 'Keine gespeicherten Logs';

  @override
  String get logs => 'Logs';

  @override
  String get copyLogsClipboard => 'Logs in die Zwischenablage kopieren';

  @override
  String get logsCopiedClipboard => 'Logs in die Zwischenablage kopiert';

  @override
  String get advancedSettings => 'Erweiterte Einstellungen';

  @override
  String get dontCheckCertificate => 'SSL-Zertifikat nicht prüfen';

  @override
  String get dontCheckCertificateDescription =>
      'Überschreibt die SSL-Zertifikatsprüfung des Servers';

  @override
  String get advancedSetupDescription => 'Erweiterte Optionen';

  @override
  String get settingsUpdatedSuccessfully =>
      'Einstellungen erfolgreich aktualisiert.';

  @override
  String get cannotUpdateSettings =>
      'Einstellungen konnten nicht aktualisiert werden.';

  @override
  String get restartAppTakeEffect => 'App neu starten';

  @override
  String get loadingLogs => 'Logs werden geladen...';

  @override
  String get logsNotLoaded => 'Logliste konnte nicht geladen werden';

  @override
  String get processed => 'Verarbeitet\nKeine Liste';

  @override
  String get processedRow => 'Verarbeitet (keine Liste)';

  @override
  String get blockedBlacklist => 'Blockiert\nSperrliste';

  @override
  String get blockedBlacklistRow => 'Blockiert (Sperrliste)';

  @override
  String get blockedSafeBrowsing => 'Blockiert\nSafe Browsing';

  @override
  String get blockedSafeBrowsingRow => 'Blockiert (Safe Browsing)';

  @override
  String get blockedParental => 'Blockiert\nKindersicherung';

  @override
  String get blockedParentalRow => 'Blockiert (Kindersicherung)';

  @override
  String get blockedInvalid => 'Blockiert\nUngültig';

  @override
  String get blockedInvalidRow => 'Blockiert (ungültig)';

  @override
  String get blockedSafeSearch => 'Blockiert\nSichere Suche';

  @override
  String get blockedSafeSearchRow => 'Blockiert (Sichere Suche)';

  @override
  String get blockedService => 'Blockiert\nBlockierter Dienst';

  @override
  String get blockedServiceRow => 'Blockiert (blockierter Dienst)';

  @override
  String get processedWhitelist => 'Verarbeitet\nWhitelist';

  @override
  String get processedWhitelistRow => 'Verarbeitet (Whitelist)';

  @override
  String get processedError => 'Verarbeitet\nFehler';

  @override
  String get processedErrorRow => 'Verarbeitet (Fehler)';

  @override
  String get rewrite => 'Umschreiben';

  @override
  String get status => 'Status';

  @override
  String get result => 'Ergebnis';

  @override
  String get time => 'Zeit';

  @override
  String get blocklist => 'Sperrliste';

  @override
  String get request => 'Anfrage';

  @override
  String get domain => 'Domain';

  @override
  String get type => 'Typ';

  @override
  String get clas => 'Klasse';

  @override
  String get response => 'Antwort';

  @override
  String get dnsServer => 'DNS-Server';

  @override
  String get elapsedTime => 'Dauer';

  @override
  String get responseCode => 'Antwortcode';

  @override
  String get client => 'Client';

  @override
  String get deviceIp => 'IP-Adresse';

  @override
  String get deviceName => 'Name';

  @override
  String get logDetails => 'Logdetails';

  @override
  String get blockingRule => 'Blockierregel';

  @override
  String get blockDomain => 'Domain blockieren';

  @override
  String get couldntGetFilteringStatus =>
      'Filterstatus konnte nicht ermittelt werden';

  @override
  String get unblockDomain => 'Domain freigeben';

  @override
  String get userFilteringRulesNotUpdated =>
      'Benutzerdefinierte Filterregeln konnten nicht aktualisiert werden';

  @override
  String get userFilteringRulesUpdated =>
      'Benutzerdefinierte Filterregeln erfolgreich aktualisiert';

  @override
  String get savingUserFilters =>
      'Benutzerdefinierte Filter werden gespeichert...';

  @override
  String get filters => 'Filter';

  @override
  String get logsOlderThan => 'Logs älter als';

  @override
  String get responseStatus => 'Antwortstatus';

  @override
  String get selectTime => 'Zeitraum auswählen';

  @override
  String get notSelected => 'Nicht ausgewählt';

  @override
  String get resetFilters => 'Filter zurücksetzen';

  @override
  String get noLogsDisplay => 'Keine Logs zum Anzeigen';

  @override
  String get noLogsThatOld =>
      'Möglicherweise sind für die ausgewählte Zeit keine Logs gespeichert. Versuche, einen aktuelleren Zeitpunkt auszuwählen.';

  @override
  String get apply => 'Anwenden';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get unselectAll => 'Alle abwählen';

  @override
  String get all => 'Alle';

  @override
  String get filtered => 'Gefiltert';

  @override
  String get checkAppLogs => 'App-Logs prüfen';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get search => 'Suchen';

  @override
  String get dnsQueries => 'DNS-Anfragen';

  @override
  String get average => 'Durchschnitt';

  @override
  String get blockedFilters => 'Durch Filter blockiert';

  @override
  String get malwarePhishingBlocked => 'Blockierte Malware/Phishing Webseiten';

  @override
  String get blockedAdultWebsites => 'Blockierte jugendgefährdende Webseiten';

  @override
  String get generalSettings => 'Allgemeine Einstellungen';

  @override
  String get generalSettingsDescription => 'Verschiedene Einstellungen';

  @override
  String get hideZeroValues => 'Nullwerte ausblenden';

  @override
  String get hideZeroValuesDescription =>
      'Auf dem Startbildschirm Blöcke ohne Werte ausblenden';

  @override
  String get webAdminPanel => 'Web-Admin-Oberfläche';

  @override
  String get visitGooglePlay => 'Google Play Seite besuchen';

  @override
  String get gitHub => 'App-Code auf GitHub verfügbar';

  @override
  String get blockClient => 'Client blockieren';

  @override
  String get selectTags => 'Tags auswählen';

  @override
  String get noTagsSelected => 'Keine Tags ausgewählt';

  @override
  String get tags => 'Tags';

  @override
  String get identifiers => 'Identifikatoren';

  @override
  String get identifier => 'Identifikator';

  @override
  String get identifierHelper => 'IP-Adresse, CIDR, MAC-Adresse oder ClientID';

  @override
  String get noIdentifiers => 'Keine Identifikatoren hinzugefügt';

  @override
  String get useGlobalSettings => 'Globale Einstellungen verwenden';

  @override
  String get enableFiltering => 'Filterung aktivieren';

  @override
  String get enableSafeBrowsing => 'Safe Browsing aktivieren';

  @override
  String get enableParentalControl => 'Kindersicherung aktivieren';

  @override
  String get enableSafeSearch => 'Sichere Suche aktivieren';

  @override
  String get blockedServices => 'Blockierte Dienste';

  @override
  String get selectBlockedServices => 'Zu blockierende Dienste auswählen';

  @override
  String get noBlockedServicesSelected => 'Keine blockierten Dienste';

  @override
  String get services => 'Dienste';

  @override
  String get servicesBlocked => 'Dienste blockiert';

  @override
  String get tagsSelected => 'Ausgewählte Tags';

  @override
  String get upstreamServers => 'Upstreamserver';

  @override
  String get serverAddress => 'Serveradresse';

  @override
  String get noUpstreamServers => 'Keine Upstreamserver.';

  @override
  String get willBeUsedGeneralServers =>
      'Allgemeine Upstreamserver werden verwendet.';

  @override
  String get added => 'Hinzugefügt';

  @override
  String get clientUpdatedSuccessfully => 'Client erfolgreich aktualisiert';

  @override
  String get clientNotUpdated => 'Client konnte nicht aktualisiert werden';

  @override
  String get clientDeletedSuccessfully => 'Client erfolgreich entfernt';

  @override
  String get clientNotDeleted => 'Client konnte nicht gelöscht werden';

  @override
  String get options => 'Optionen';

  @override
  String get loadingFilters => 'Filter werden geladen...';

  @override
  String get filtersNotLoaded => 'Filter konnten nicht geladen werden.';

  @override
  String get whitelists => 'Whitelists';

  @override
  String get blacklists => 'Blacklists';

  @override
  String get rules => 'Regeln';

  @override
  String get customRules => 'Benutzerdefinierte Regeln';

  @override
  String get enabledRules => 'Aktivierte Regeln';

  @override
  String get enabled => 'Aktiviert';

  @override
  String get disabled => 'Deaktiviert';

  @override
  String get rule => 'Regel';

  @override
  String get addCustomRule => 'Benutzerdefinierte Regel hinzufügen';

  @override
  String get removeCustomRule => 'Benutzerdefinierte Regel entfernen';

  @override
  String get removeCustomRuleMessage =>
      'Bist du sicher, dass du diese benutzerdefinierte Regel entfernen möchtest?';

  @override
  String get updatingRules =>
      'Benutzerdefinierte Regeln werden aktualisiert...';

  @override
  String get ruleRemovedSuccessfully => 'Regel erfolgreich entfernt';

  @override
  String get ruleNotRemoved => 'Regel konnte nicht entfernt werden';

  @override
  String get ruleAddedSuccessfully => 'Regel erfolgreich hinzugefügt';

  @override
  String get ruleNotAdded => 'Regel konnte nicht hinzugefügt werden';

  @override
  String get noCustomFilters => 'Keine benutzerdefinierten Filter';

  @override
  String get noBlockedClients => 'Keine blockierten Clients';

  @override
  String get noBlackLists => 'Keine Blacklists';

  @override
  String get noWhiteLists => 'Keine Whitelists';

  @override
  String get addWhitelist => 'Whitelist hinzufügen';

  @override
  String get addBlacklist => 'Blacklist hinzufügen';

  @override
  String get urlNotValid => 'URL ist ungültig';

  @override
  String get urlAbsolutePath => 'URL oder absoluter Pfad';

  @override
  String get addingList => 'Liste wird hinzugefügt...';

  @override
  String get listAdded =>
      'Liste erfolgreich hinzugefügt. Hinzugefügte Elemente:';

  @override
  String get listAlreadyAdded => 'Liste bereits hinzugefügt';

  @override
  String get listUrlInvalid => 'Ungültige Listen-URL';

  @override
  String get listNotAdded => 'Liste konnte nicht hinzugefügt werden';

  @override
  String get listDetails => 'Listendetails';

  @override
  String get listType => 'Listen-Typ';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get latestUpdate => 'Letztes Update';

  @override
  String get disable => 'Deaktivieren';

  @override
  String get enable => 'Aktivieren';

  @override
  String get currentStatus => 'Aktueller Status';

  @override
  String get listDataUpdated => 'Listendaten erfolgreich aktualisiert';

  @override
  String get listDataNotUpdated =>
      'Listendaten konnten nicht aktualisiert werden';

  @override
  String get updatingListData => 'Listendaten werden aktualisiert...';

  @override
  String get editWhitelist => 'Whitelist verwalten';

  @override
  String get editBlacklist => 'Blacklist verwalten';

  @override
  String get deletingList => 'Liste wird gelöscht...';

  @override
  String get listDeleted => 'Liste erfolgreich gelöscht';

  @override
  String get listNotDeleted => 'Die Liste konnte nicht gelöscht werden';

  @override
  String get deleteList => 'Liste löschen';

  @override
  String get deleteListMessage =>
      'Bist du sicher, dass du diese Liste löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get serverSettings => 'Servereinstellungen';

  @override
  String get serverInformation => 'Serverinformationen';

  @override
  String get serverInformationDescription => 'Serverinformationen und Status';

  @override
  String get loadingServerInfo => 'Serverinformationen werden geladen...';

  @override
  String get serverInfoNotLoaded =>
      'Serverinformationen konnten nicht geladen werden.';

  @override
  String get dnsAddresses => 'DNS-Adressen';

  @override
  String get seeDnsAddresses => 'DNS-Adressen anzeigen';

  @override
  String get dnsPort => 'DNS-Port';

  @override
  String get httpPort => 'HTTP-Port';

  @override
  String get protectionEnabled => 'Schutz aktiviert';

  @override
  String get dhcpAvailable => 'DHCP verfügbar';

  @override
  String get serverRunning => 'Server läuft';

  @override
  String get serverVersion => 'Serverversion';

  @override
  String get serverLanguage => 'Serversprache';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get allowedClients => 'Erlaubte Clients';

  @override
  String get disallowedClients => 'Blockierte Clients';

  @override
  String get disallowedDomains => 'Blockierte Domains';

  @override
  String get accessSettings => 'Zugriffseinstellungen';

  @override
  String get accessSettingsDescription =>
      'Konfiguriere Zugriffsregeln für den Server';

  @override
  String get loadingClients => 'Clients werden geladen...';

  @override
  String get clientsNotLoaded => 'Clients konnten nicht geladen werden.';

  @override
  String get noAllowedClients => 'Keine erlaubten Clients';

  @override
  String get allowedClientsDescription =>
      'Wenn diese Liste Einträge enthält, akzeptiert AdGuard Home nur Anfragen von diesen Clients.';

  @override
  String get blockedClientsDescription =>
      'Wenn diese Liste Einträge enthält, verwirft AdGuard Home Anfragen von diesen Clients. Dieses Feld wird ignoriert, wenn Einträge in \"Erlaubte Clients\" vorhanden sind.';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home verwirft DNS-Anfragen, die mit diesen Domains übereinstimmen. Diese Anfragen erscheinen nicht einmal im Log.';

  @override
  String get addClientFieldDescription => 'CIDRs, IP-Adresse oder ClientID';

  @override
  String get clientIdentifier => 'Clientidentifikator';

  @override
  String get allowClient => 'Client erlauben';

  @override
  String get disallowClient => 'Client blockieren';

  @override
  String get noDisallowedDomains => 'Keine blockierten Domains';

  @override
  String get domainNotAdded => 'Die Domain konnte nicht hinzugefügt werden';

  @override
  String get statusSelected => 'Status ausgewählt';

  @override
  String get updateLists => 'Listen aktualisieren';

  @override
  String get checkHostFiltered => 'Host prüfen';

  @override
  String get updatingLists => 'Listen werden aktualisiert...';

  @override
  String get listsUpdated => 'Listen aktualisiert';

  @override
  String get listsNotUpdated => 'Listen konnten nicht aktualisiert werden';

  @override
  String get listsNotLoaded => 'Listen konnten nicht geladen werden';

  @override
  String get domainNotValid => 'Ungültige Domain';

  @override
  String get check => 'Prüfen';

  @override
  String get checkingHost => 'Host wird geprüft...';

  @override
  String get errorCheckingHost => 'Host konnte nicht geprüft werden';

  @override
  String get block => 'Blockieren';

  @override
  String get unblock => 'Freigeben';

  @override
  String get custom => 'Benutzerdefiniert';

  @override
  String get addImportant => '\$important hinzufügen';

  @override
  String get howCreateRules => 'Wie benutzerdefinierte Regeln erstellt werden';

  @override
  String get examples => 'Beispiele';

  @override
  String get example1 =>
      'Zugriff auf example.org und alle Subdomains blockieren.';

  @override
  String get example2 =>
      'Gibt den Zugriff auf example.org und alle Subdomains frei.';

  @override
  String get example3 => 'Fügt einen Kommentar hinzu.';

  @override
  String get example4 =>
      'Blockiert den Zugriff auf Domains, die mit dem angegebenen regulären Ausdruck übereinstimmen.';

  @override
  String get moreInformation => 'Mehr Informationen';

  @override
  String get addingRule => 'Regel wird hinzugefügt...';

  @override
  String get deletingRule => 'Regel wird gelöscht...';

  @override
  String get enablingList => 'Liste wird aktiviert...';

  @override
  String get disablingList => 'Liste wird deaktiviert...';

  @override
  String get savingList => 'Liste wird gespeichert...';

  @override
  String get disableFiltering => 'Filterung deaktivieren';

  @override
  String get enablingFiltering => 'Filterung wird aktiviert...';

  @override
  String get disablingFiltering => 'Filterung wird deaktiviert...';

  @override
  String get filteringStatusUpdated =>
      'Filterungsstatus erfolgreich aktualisiert';

  @override
  String get filteringStatusNotUpdated =>
      'Filterungsstatus konnte nicht aktualisiert werden';

  @override
  String get updateFrequency => 'Aktualisierungsintervall';

  @override
  String get never => 'Nie';

  @override
  String get hour1 => '1 Stunde';

  @override
  String get hours12 => '12 Stunden';

  @override
  String get hours24 => '24 Stunden';

  @override
  String get days3 => '3 Tage';

  @override
  String get days7 => '7 Tage';

  @override
  String get changingUpdateFrequency => 'Ändern...';

  @override
  String get updateFrequencyChanged =>
      'Aktualisierungsintervall erfolgreich geändert';

  @override
  String get updateFrequencyNotChanged =>
      'Aktualisierungsintervall konnte nicht geändert werden';

  @override
  String get updating => 'Werte werden aktualisiert...';

  @override
  String get blockedServicesUpdated =>
      'Blockierte Dienste erfolgreich aktualisiert';

  @override
  String get blockedServicesNotUpdated =>
      'Blockierte Dienste konnten nicht aktualisiert werden';

  @override
  String get insertDomain => 'Gib eine Domain ein, um deren Status zu prüfen.';

  @override
  String get dhcpSettings => 'DHCP-Einstellungen';

  @override
  String get dhcpSettingsDescription => 'DHCP-Server konfigurieren';

  @override
  String get dhcpSettingsNotLoaded =>
      'DHCP-Einstellungen konnten nicht geladen werden';

  @override
  String get loadingDhcp => 'DHCP-Einstellungen werden geladen...';

  @override
  String get enableDhcpServer => 'DHCP-Server aktivieren';

  @override
  String get selectInterface => 'Netzwerkschnittstelle auswählen';

  @override
  String get hardwareAddress => 'Hardwareadresse';

  @override
  String get gatewayIp => 'Gateway-IP';

  @override
  String get ipv4addresses => 'IPv4-Adressen';

  @override
  String get ipv6addresses => 'IPv6-Adressen';

  @override
  String get neededSelectInterface =>
      'Du musst eine Netzwerkschnittstelle auswählen, um den DHCP-Server zu konfigurieren.';

  @override
  String get ipv4settings => 'IPv4-Einstellungen';

  @override
  String get startOfRange => 'Anfang des Bereichs';

  @override
  String get endOfRange => 'Ende des Bereichs';

  @override
  String get ipv6settings => 'IPv6-Einstellungen';

  @override
  String get subnetMask => 'Subnetzmaske';

  @override
  String get subnetMaskNotValid => 'Ungültige Subnetzmaske';

  @override
  String get gateway => 'Gateway';

  @override
  String get gatewayNotValid => 'Ungültiges Gateway';

  @override
  String get leaseTime => 'Lease-Dauer';

  @override
  String seconds(Object time) {
    return '$time Sekunden';
  }

  @override
  String get leaseTimeNotValid => 'Ungültige Lease-Dauer';

  @override
  String get restoreConfiguration => 'Konfiguration zurücksetzen';

  @override
  String get restoreConfigurationMessage =>
      'Bist du sicher, dass du fortfahren möchtest? Dies setzt die gesamte Konfiguration zurück. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get changeInterface => 'Schnittstelle ändern';

  @override
  String get savingSettings => 'Einstellungen werden gespeichert...';

  @override
  String get settingsSaved => 'Einstellungen erfolgreich gespeichert';

  @override
  String get settingsNotSaved =>
      'Einstellungen konnten nicht gespeichert werden';

  @override
  String get restoringConfig => 'Konfiguration wird zurückgesetzt...';

  @override
  String get configRestored => 'Konfiguration erfolgreich zurückgesetzt';

  @override
  String get configNotRestored =>
      'Die Konfiguration konnte nicht zurückgesetzt werden';

  @override
  String get dhcpStatic => 'Statische DHCP-Leases';

  @override
  String get noDhcpStaticLeases => 'Keine statischen DHCP-Leases gefunden';

  @override
  String get deleting => 'Wird gelöscht...';

  @override
  String get staticLeaseDeleted => 'Statische DHCP-Lease erfolgreich gelöscht';

  @override
  String get staticLeaseNotDeleted =>
      'Die statische DHCP-Lease konnte nicht gelöscht werden';

  @override
  String get deleteStaticLease => 'Statische Lease löschen';

  @override
  String get deleteStaticLeaseDescription =>
      'Die statische DHCP-Lease wird gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get addStaticLease => 'Statische Lease hinzufügen';

  @override
  String get macAddress => 'MAC-Adresse';

  @override
  String get macAddressNotValid => 'Ungültige MAC-Adresse';

  @override
  String get hostName => 'Hostname';

  @override
  String get hostNameError => 'Hostname darf nicht leer sein';

  @override
  String get creating => 'Wird erstellt...';

  @override
  String get staticLeaseCreated => 'Statische DHCP-Lease erfolgreich erstellt';

  @override
  String get staticLeaseNotCreated =>
      'Die statische DHCP-Lease konnte nicht erstellt werden';

  @override
  String get staticLeaseExists => 'Die statische DHCP-Lease existiert bereits';

  @override
  String get serverNotConfigured => 'Server nicht konfiguriert';

  @override
  String get restoreLeases => 'Leases zurücksetzen';

  @override
  String get restoreLeasesMessage =>
      'Bist du sicher, dass du fortfahren möchtest? Dies setzt alle bestehenden Leases zurück. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get restoringLeases => 'Leases werden zurückgesetzt...';

  @override
  String get leasesRestored => 'Leases erfolgreich zurückgesetzt';

  @override
  String get leasesNotRestored =>
      'Die Leases konnten nicht zurückgesetzt werden';

  @override
  String get dhcpLeases => 'DHCP-Leases';

  @override
  String get noLeases => 'Keine DHCP-Leases verfügbar';

  @override
  String get dnsRewrites => 'DNS-Umschreibungen';

  @override
  String get dnsRewritesDescription =>
      'Benutzerdefinierte DNS-Regeln konfigurieren';

  @override
  String get loadingRewriteRules => 'Umschreibungsregeln werden geladen...';

  @override
  String get rewriteRulesNotLoaded =>
      'DNS-Umschreibungsregeln konnten nicht geladen werden.';

  @override
  String get noRewriteRules => 'Keine DNS-Umschreibungsregeln';

  @override
  String get answer => 'Antwort';

  @override
  String get deleteDnsRewrite => 'DNS-Umschreibung löschen';

  @override
  String get deleteDnsRewriteMessage =>
      'Bist du sicher, dass du diese DNS-Umschreibung löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get dnsRewriteRuleDeleted =>
      'DNS-Umschreibungsregel erfolgreich gelöscht';

  @override
  String get dnsRewriteRuleNotDeleted =>
      'Die DNS-Umschreibungsregel konnte nicht gelöscht werden';

  @override
  String get addDnsRewrite => 'DNS-Umschreibung hinzufügen';

  @override
  String get addingRewrite => 'DNS-Umschreibung wird hinzugefügt...';

  @override
  String get dnsRewriteRuleAdded =>
      'DNS-Umschreibungsregel erfolgreich hinzugefügt';

  @override
  String get dnsRewriteRuleNotAdded =>
      'DNS-Umschreibungsregel konnte nicht hinzugefügt werden';

  @override
  String get logsSettings => 'Logeinstellungen';

  @override
  String get enableLog => 'Log aktivieren';

  @override
  String get clearLogs => 'Logs löschen';

  @override
  String get anonymizeClientIp => 'Client-IP anonymisieren';

  @override
  String get hours6 => '6 Stunden';

  @override
  String get days30 => '30 Tage';

  @override
  String get days90 => '90 Tage';

  @override
  String get retentionTime => 'Aufbewahrungszeit';

  @override
  String get selectOneItem => 'Ein Element auswählen';

  @override
  String get logSettingsNotLoaded =>
      'Logeinstellungen konnten nicht geladen werden.';

  @override
  String get updatingSettings => 'Einstellungen werden aktualisiert...';

  @override
  String get logsConfigUpdated => 'Logeinstellungen erfolgreich aktualisiert';

  @override
  String get logsConfigNotUpdated =>
      'Logeinstellungen konnten nicht aktualisiert werden';

  @override
  String get deletingLogs => 'Logs werden gelöscht...';

  @override
  String get logsCleared => 'Logs erfolgreich gelöscht';

  @override
  String get logsNotCleared => 'Logs konnten nicht gelöscht werden';

  @override
  String get runningHomeAssistant => 'Läuft auf Home Assistant';

  @override
  String get serverError => 'Serverfehler';

  @override
  String get noItems => 'Keine Elemente zum Anzeigen vorhanden';

  @override
  String get dnsSettings => 'DNS-Einstellungen';

  @override
  String get dnsSettingsDescription =>
      'Verbindung mit DNS-Servern konfigurieren';

  @override
  String get upstreamDns => 'Upstream-DNS-Server';

  @override
  String get bootstrapDns => 'Bootstrap-DNS-Server';

  @override
  String get noUpstreamDns => 'Keine Upstream-DNS-Server hinzugefügt.';

  @override
  String get dnsMode => 'DNS-Modus';

  @override
  String get noDnsMode => 'Kein DNS-Modus ausgewählt';

  @override
  String get loadBalancing => 'Lastverteilung';

  @override
  String get parallelRequests => 'Parallele Anfragen';

  @override
  String get fastestIpAddress => 'Schnellste IP-Adresse';

  @override
  String get loadBalancingDescription =>
      'Fragt einen Upstreamserver nach dem anderen an. AdGuard Home verwendet seinen gewichteten Zufallsalgorithmus zur Auswahl des Servers, sodass der schnellste Server häufiger genutzt wird.';

  @override
  String get parallelRequestsDescription =>
      'Verwendet parallele Anfragen, um die Auflösung zu beschleunigen, indem alle Upstreamserver gleichzeitig angefragt werden.';

  @override
  String get fastestIpAddressDescription =>
      'Fragt alle DNS-Server an und gibt die schnellste IP-Adresse unter allen Antworten zurück. Dies verlangsamt DNS-Anfragen, da AdGuard Home auf Antworten von allen DNS-Servern warten muss, verbessert aber die allgemeine Konnektivität.';

  @override
  String get noBootstrapDns => 'Keine Bootstrap-DNS-Server hinzugefügt.';

  @override
  String get bootstrapDnsServersInfo =>
      'Bootstrap-DNS-Server werden verwendet, um die IP-Adressen der von dir als Upstream angegebenen DoH/DoT-Resolver aufzulösen.';

  @override
  String get privateReverseDnsServers => 'Private Reverse-DNS-Server';

  @override
  String get privateReverseDnsServersDescription =>
      'Die DNS-Server, die AdGuard Home für lokale PTR-Anfragen verwendet. Diese Server werden verwendet, um PTR-Anfragen für Adressen in privaten IP-Bereichen (z. B. \"192.168.12.34\") mittels Reverse-DNS aufzulösen. Wenn nicht konfiguriert, verwendet AdGuard Home die Adressen der Standard-Reverse-DNS-Resolver deines Betriebssystems (mit Ausnahme der Adressen von AdGuard Home selbst).';

  @override
  String get reverseDnsDefault =>
      'Standardmäßig verwendet AdGuard Home die folgenden Reverse-DNS-Resolver';

  @override
  String get addItem => 'Element hinzufügen';

  @override
  String get noServerAddressesAdded => 'Keine Serveradressen hinzugefügt.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Private Reverse-DNS-Resolver verwenden';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Führe Reverse-DNS-Abfragen für lokal bediente Adressen über diese Upstreamserver aus. Wenn deaktiviert, antwortet AdGuard Home auf alle solchen PTR-Anfragen mit NXDOMAIN, außer bei Clients, die aus DHCP, /etc/hosts usw. bekannt sind.';

  @override
  String get enableReverseResolving =>
      'Rückwärtsauflösung von Client-IP-Adressen aktivieren';

  @override
  String get enableReverseResolvingDescription =>
      'Löst Client-IP-Adressen rückwärts in deren Hostnamen auf, indem PTR-Anfragen an entsprechende Resolver gesendet werden (private DNS-Server für lokale Clients, Upstreamserver für Clients mit öffentlicher IP-Adresse).';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS-Servereinstellungen';

  @override
  String get limitRequestsSecond => 'Ratenbegrenzung pro Sekunde';

  @override
  String get valueNotNumber => 'Wert ist keine Zahl';

  @override
  String get enableEdns => 'EDNS-Client-Subnetz aktivieren';

  @override
  String get enableEdnsDescription =>
      'Fügt die Option EDNS-Client-Subnetz (ECS) zu Upstream-Anfragen hinzu und protokolliert die von den Clients gesendeten Werte im Anfrage-Log.';

  @override
  String get enableDnssec => 'DNSSEC aktivieren';

  @override
  String get enableDnssecDescription =>
      'Setzt das DNSSEC-Flag in den ausgehenden DNS-Anfragen und prüft das Ergebnis (erfordert einen DNSSEC-fähigen Resolver).';

  @override
  String get disableResolvingIpv6 => 'Auflösung von IPv6-Adressen deaktivieren';

  @override
  String get disableResolvingIpv6Description =>
      'Verwirft alle DNS-Anfragen für IPv6-Adressen (Typ AAAA).';

  @override
  String get blockingMode => 'Blockiermodus';

  @override
  String get defaultMode => 'Standard';

  @override
  String get defaultDescription =>
      'Antwortet mit einer Null-IP-Adresse (0.0.0.0 für A; :: für AAAA), wenn durch eine Regel im Adblock-Stil blockiert; antwortet mit der in der Regel angegebenen IP-Adresse, wenn durch eine Regel im /etc/hosts-Stil blockiert';

  @override
  String get refusedDescription => 'Antwortet mit dem Code REFUSED';

  @override
  String get nxdomainDescription => 'Antwortet mit dem Code NXDOMAIN';

  @override
  String get nullIp => 'Null-IP';

  @override
  String get nullIpDescription =>
      'Antwortet mit einer Null-IP-Adresse (0.0.0.0 für A; :: für AAAA)';

  @override
  String get customIp => 'Benutzerdefinierte IP';

  @override
  String get customIpDescription =>
      'Antwortet mit einer manuell festgelegten IP-Adresse';

  @override
  String get dnsCacheConfig => 'DNS-Cache-Konfiguration';

  @override
  String get cacheSize => 'Cachegröße';

  @override
  String get inBytes => 'In Bytes';

  @override
  String get overrideMinimumTtl => 'Minimale TTL überschreiben';

  @override
  String get overrideMinimumTtlDescription =>
      'Verlängert kurze TTL-Werte (Sekunden), die vom Upstreamserver empfangen werden, beim Caching von DNS-Antworten.';

  @override
  String get overrideMaximumTtl => 'Maximale TTL überschreiben';

  @override
  String get overrideMaximumTtlDescription =>
      'Legt einen maximalen TTL-Wert (Sekunden) für Einträge im DNS-Cache fest.';

  @override
  String get optimisticCaching => 'Optimistisches Caching';

  @override
  String get optimisticCachingDescription =>
      'Lässt AdGuard Home auch bei abgelaufenen Cache-Einträgen aus dem Cache antworten und versucht gleichzeitig, diese zu aktualisieren.';

  @override
  String get loadingDnsConfig => 'DNS-Konfiguration wird geladen...';

  @override
  String get dnsConfigNotLoaded =>
      'DNS-Konfiguration konnte nicht geladen werden.';

  @override
  String get blockingIpv4 => 'Blockierende IPv4';

  @override
  String get blockingIpv4Description =>
      'IP-Adresse, die für eine blockierte A-Anfrage zurückgegeben wird';

  @override
  String get blockingIpv6 => 'Blockierende IPv6';

  @override
  String get blockingIpv6Description =>
      'IP-Adresse, die für eine blockierte AAAA-Anfrage zurückgegeben wird';

  @override
  String get invalidIp => 'Ungültige IP-Adresse';

  @override
  String get dnsConfigSaved =>
      'DNS-Serverkonfiguration erfolgreich gespeichert';

  @override
  String get dnsConfigNotSaved =>
      'Die DNS-Serverkonfiguration konnte nicht gespeichert werden';

  @override
  String get savingConfig => 'Konfiguration wird gespeichert...';

  @override
  String get someValueNotValid => 'Ein Wert ist ungültig';

  @override
  String get upstreamDnsDescription =>
      'Upstreamserver und DNS-Modus konfigurieren';

  @override
  String get bootstrapDnsDescription => 'Bootstrap-DNS-Server konfigurieren';

  @override
  String get privateReverseDnsDescription =>
      'Benutzerdefinierte DNS-Resolver konfigurieren und private Reverse-DNS-Auflösung aktivieren';

  @override
  String get dnsServerSettingsDescription =>
      'Ratenbegrenzung, Blockiermodus und mehr konfigurieren';

  @override
  String get dnsCacheConfigDescription =>
      'Konfiguriere, wie der Server den DNS-Cache verwalten soll';

  @override
  String get comment => 'Kommentar';

  @override
  String get address => 'Adresse';

  @override
  String get commentsDescription =>
      'Kommentare beginnen immer mit #. Du musst es nicht hinzufügen, es wird automatisch ergänzt.';

  @override
  String get encryptionSettings => 'Verschlüsselungseinstellungen';

  @override
  String get encryptionSettingsDescription =>
      'Unterstützung für Verschlüsselung (HTTPS/QUIC/TLS)';

  @override
  String get loadingEncryptionSettings =>
      'Verschlüsselungseinstellungen werden geladen...';

  @override
  String get encryptionSettingsNotLoaded =>
      'Verschlüsselungseinstellungen konnten nicht geladen werden.';

  @override
  String get enableEncryption => 'Verschlüsselung aktivieren';

  @override
  String get enableEncryptionTypes => 'HTTPS, DNS-over-HTTPS und DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      'Wenn die Verschlüsselung aktiviert ist, arbeitet die AdGuard Home Verwaltungsoberfläche über HTTPS, und der DNS-Server lauscht auf Anfragen über DNS-over-HTTPS und DNS-over-TLS.';

  @override
  String get serverConfiguration => 'Serverkonfiguration';

  @override
  String get domainName => 'Domainname';

  @override
  String get domainNameDescription =>
      'Wenn gesetzt, erkennt AdGuard Home ClientIDs, beantwortet DDR-Anfragen und führt zusätzliche Verbindungsvalidierungen durch. Wenn nicht gesetzt, sind diese Funktionen deaktiviert. Muss mit einem der DNS-Namen im Zertifikat übereinstimmen.';

  @override
  String get redirectHttps => 'Automatisch zu HTTPS umleiten';

  @override
  String get httpsPort => 'HTTPS-Port';

  @override
  String get tlsPort => 'DNS-over-TLS-Port';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC-Port';

  @override
  String get certificates => 'Zertifikate';

  @override
  String get certificatesDescription =>
      'Um die Verschlüsselung zu nutzen, musst du eine gültige SSL-Zertifikatskette für deine Domain bereitstellen. Du kannst ein kostenloses Zertifikat auf letsencrypt.org erhalten oder eines von einer vertrauenswürdigen Zertifizierungsstelle kaufen.';

  @override
  String get certificateFilePath => 'Zertifikatsdateipfad festlegen';

  @override
  String get pasteCertificateContent => 'Zertifikatsinhalt einfügen';

  @override
  String get certificatePath => 'Zertifikatspfad';

  @override
  String get certificateContent => 'Zertifikatsinhalt';

  @override
  String get privateKey => 'Privater Schlüssel';

  @override
  String get privateKeyFile => 'Datei für privaten Schlüssel festlegen';

  @override
  String get pastePrivateKey => 'Inhalt des privaten Schlüssels einfügen';

  @override
  String get usePreviousKey => 'Zuvor gespeicherten Schlüssel verwenden';

  @override
  String get privateKeyPath => 'Pfad zum privaten Schlüssel';

  @override
  String get invalidCertificate => 'Ungültiges Zertifikat';

  @override
  String get invalidPrivateKey => 'Ungültiger privater Schlüssel';

  @override
  String get validatingData => 'Daten werden validiert';

  @override
  String get dataValid => 'Daten sind gültig';

  @override
  String get dataNotValid => 'Ungültige Daten';

  @override
  String get encryptionConfigSaved =>
      'Verschlüsselungskonfiguration erfolgreich gespeichert';

  @override
  String get encryptionConfigNotSaved =>
      'Verschlüsselungskonfiguration konnte nicht gespeichert werden';

  @override
  String get configError => 'Konfigurationsfehler';

  @override
  String get enterOnlyCertificate =>
      'Gib nur das Zertifikat ein. Füge nicht die ---BEGIN--- und ---END--- Zeilen ein.';

  @override
  String get enterOnlyPrivateKey =>
      'Gib nur den Schlüssel ein. Füge nicht die ---BEGIN--- und ---END--- Zeilen ein.';

  @override
  String get noItemsSearch => 'Keine Ergebnisse für diese Suche.';

  @override
  String get clearSearch => 'Suche leeren';

  @override
  String get exitSearch => 'Suche beenden';

  @override
  String get searchClients => 'Clients suchen';

  @override
  String get noClientsSearch => 'Keine Clients für diese Suche.';

  @override
  String get customization => 'Anpassung';

  @override
  String get customizationDescription => 'Diese App anpassen';

  @override
  String get color => 'Farbe';

  @override
  String get useDynamicTheme => 'Dynamisches Design verwenden';

  @override
  String get red => 'Rot';

  @override
  String get green => 'Grün';

  @override
  String get blue => 'Blau';

  @override
  String get yellow => 'Gelb';

  @override
  String get orange => 'Orange';

  @override
  String get brown => 'Braun';

  @override
  String get cyan => 'Cyan';

  @override
  String get purple => 'Lila';

  @override
  String get pink => 'Pink';

  @override
  String get deepOrange => 'Dunkelorange';

  @override
  String get indigo => 'Indigo';

  @override
  String get useThemeColorStatus => 'Designfarbe für Status verwenden';

  @override
  String get useThemeColorStatusDescription =>
      'Ersetzt die grünen und roten Statusfarben durch Designfarbe und Grau';

  @override
  String get invalidCertificateChain => 'Ungültige Zertifikatskette';

  @override
  String get validCertificateChain => 'Gültige Zertifikatskette';

  @override
  String get subject => 'Betreff';

  @override
  String get issuer => 'Aussteller';

  @override
  String get expires => 'Läuft ab';

  @override
  String get validPrivateKey => 'Gültiger privater Schlüssel';

  @override
  String get expirationDate => 'Ablaufdatum';

  @override
  String get keysNotMatch =>
      'Ungültiges Zertifikat oder Schlüssel: tls: Privater Schlüssel stimmt nicht mit dem öffentlichen Schlüssel überein';

  @override
  String get timeLogs => 'Zeit in Logs';

  @override
  String get timeLogsDescription =>
      'Verarbeitungszeit in der Logliste anzeigen';

  @override
  String get hostNames => 'Hostnamen';

  @override
  String get keyType => 'Schlüsseltyp';

  @override
  String get updateAvailable => 'Update verfügbar';

  @override
  String get installedVersion => 'Installierte Version';

  @override
  String get newVersion => 'Neue Version';

  @override
  String get source => 'Quelle';

  @override
  String get downloadUpdate => 'Update herunterladen';

  @override
  String get download => 'Herunterladen';

  @override
  String get doNotRememberAgainUpdate =>
      'Für diese Version nicht mehr erinnern';

  @override
  String get downloadingUpdate => 'Wird heruntergeladen';

  @override
  String get completed => 'abgeschlossen';

  @override
  String get permissionNotGranted => 'Berechtigung nicht erteilt';

  @override
  String get inputSearchTerm => 'Suchbegriff eingeben.';

  @override
  String get answers => 'Antworten';

  @override
  String get copyClipboard => 'In die Zwischenablage kopieren';

  @override
  String get domainCopiedClipboard => 'Domain in die Zwischenablage kopiert';

  @override
  String get clearDnsCache => 'DNS-Cache leeren';

  @override
  String get clearDnsCacheMessage =>
      'Bist du sicher, dass du den DNS-Cache leeren möchtest?';

  @override
  String get dnsCacheCleared => 'DNS-Cache erfolgreich geleert';

  @override
  String get clearingDnsCache => 'Cache wird geleert...';

  @override
  String get dnsCacheNotCleared => 'DNS-Cache konnte nicht geleert werden';

  @override
  String get clientsSelected => 'Clients ausgewählt';

  @override
  String get invalidDomain => 'Ungültige Domain';

  @override
  String get loadingBlockedServicesList =>
      'Liste der blockierten Dienste wird geladen...';

  @override
  String get blockedServicesListNotLoaded =>
      'Die Liste der blockierten Dienste konnte nicht geladen werden';

  @override
  String get error => 'Fehler';

  @override
  String get updates => 'Updates';

  @override
  String get updatesDescription => 'Den AdGuard Home Server aktualisieren';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get currentVersion => 'Aktuelle Version';

  @override
  String get requestStartUpdateFailed =>
      'Anfrage zum Starten des Updates fehlgeschlagen';

  @override
  String get requestStartUpdateSuccessful =>
      'Anfrage zum Starten des Updates erfolgreich';

  @override
  String get serverUpdated => 'Server ist aktuell';

  @override
  String get unknownStatus => 'Unbekannter Status';

  @override
  String get checkingUpdates => 'Updates werden geprüft...';

  @override
  String get checkUpdates => 'Updates prüfen';

  @override
  String get requestingUpdate => 'Update wird angefordert...';

  @override
  String get autoupdateUnavailable => 'Automatische Updates nicht verfügbar';

  @override
  String get autoupdateUnavailableDescription =>
      'Der automatische Update-Dienst ist für diesen Server nicht verfügbar. Möglicherweise läuft der Server in einem Docker-Container. Du musst den Server manuell aktualisieren.';

  @override
  String minute(Object time) {
    return '$time Minute';
  }

  @override
  String minutes(Object time) {
    return '$time Minuten';
  }

  @override
  String hour(Object time) {
    return '$time Stunde';
  }

  @override
  String hours(Object time) {
    return '$time Stunden';
  }

  @override
  String get remainingTime => 'Verbleibende Zeit';

  @override
  String get safeSearchSettings => 'Einstellungen für sichere Suche';

  @override
  String get loadingSafeSearchSettings =>
      'Einstellungen für sichere Suche werden geladen...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Fehler beim Laden der Einstellungen für sichere Suche.';

  @override
  String get loadingLogsSettings => 'Logeinstellungen werden geladen...';

  @override
  String get selectOptionLeftColumn => 'Wähle eine Option in der linken Spalte';

  @override
  String get selectClientLeftColumn =>
      'Wähle einen Client in der linken Spalte';

  @override
  String get disableList => 'Liste deaktivieren';

  @override
  String get enableList => 'Liste aktivieren';

  @override
  String get screens => 'Bildschirme';

  @override
  String get copiedClipboard => 'In die Zwischenablage kopiert';

  @override
  String get seeDetails => 'Details anzeigen';

  @override
  String get listNotAvailable => 'Liste nicht verfügbar';

  @override
  String get copyListUrl => 'Listen-URL kopieren';

  @override
  String get listUrlCopied => 'Listen-URL in die Zwischenablage kopiert';

  @override
  String get unsupportedVersion => 'Nicht unterstützte Version';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'Die Unterstützung für deine Serverversion $version ist nicht garantiert. Diese App könnte Probleme mit dieser Serverversion haben.\n\nAdGuard Home Manager ist für die stabilen Releases des AdGuard Home Servers konzipiert. Die App funktioniert möglicherweise auch mit Alpha- und Beta-Releases, aber die Kompatibilität ist nicht garantiert.';
  }

  @override
  String get iUnderstand => 'Verstanden';

  @override
  String get appUpdates => 'App-Updates';

  @override
  String get usingLatestVersion => 'Du verwendest die neueste Version';

  @override
  String get ipLogs => 'IP in Logs';

  @override
  String get ipLogsDescription =>
      'Immer die IP-Adresse in Logs anzeigen anstatt des Clientnamens';

  @override
  String get application => 'App';

  @override
  String get combinedChart => 'Kombiniertes Diagramm';

  @override
  String get combinedChartDescription => 'Alle Diagramme in einem kombinieren';

  @override
  String get statistics => 'Statistiken';

  @override
  String get errorLoadFilters => 'Fehler beim Laden der Filter.';

  @override
  String get clientRemovedSuccessfully => 'Client erfolgreich entfernt.';

  @override
  String get editRewriteRule => 'Umschreibungsregel bearbeiten';

  @override
  String get dnsRewriteRuleUpdated =>
      'DNS-Umschreibungsregel erfolgreich aktualisiert';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'DNS-Umschreibungsregel konnte nicht aktualisiert werden';

  @override
  String get updatingRule => 'Regel wird aktualisiert...';

  @override
  String get serverUpdateNeeded => 'Serverupdate erforderlich';

  @override
  String updateYourServer(Object version) {
    return 'Aktualisiere deinen AdGuard Home Server auf $version oder höher, um diese Funktion zu nutzen.';
  }

  @override
  String get january => 'Januar';

  @override
  String get february => 'Februar';

  @override
  String get march => 'März';

  @override
  String get april => 'April';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juni';

  @override
  String get july => 'Juli';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'Oktober';

  @override
  String get november => 'November';

  @override
  String get december => 'Dezember';

  @override
  String get malwarePhishing => 'Malware/Phishing';

  @override
  String get queries => 'Anfragen';

  @override
  String get adultSites => 'Jugendgefährdende Seiten';

  @override
  String get quickFilters => 'Schnellfilter';

  @override
  String get searchDomainInternet => 'Domain im Internet suchen';

  @override
  String get hideServerAddress => 'Serveradresse ausblenden';

  @override
  String get hideServerAddressDescription =>
      'Blendet die Serveradresse auf dem Startbildschirm aus';

  @override
  String get topItemsOrder => 'Reihenfolge der Top-Elemente';

  @override
  String get topItemsOrderDescription =>
      'Reihenfolge der Top-Listen auf dem Startbildschirm festlegen';

  @override
  String get topItemsReorderInfo =>
      'Halte ein Element gedrückt und ziehe es, um die Reihenfolge zu ändern.';

  @override
  String get discardChanges => 'Änderungen verwerfen';

  @override
  String get discardChangesDescription =>
      'Bist du sicher, dass du die Änderungen verwerfen möchtest?';

  @override
  String get others => 'Sonstige';

  @override
  String get showChart => 'Diagramm anzeigen';

  @override
  String get hideChart => 'Diagramm ausblenden';

  @override
  String get showTopItemsChart => 'Top-Elemente-Diagramm anzeigen';

  @override
  String get showTopItemsChartDescription =>
      'Zeigt standardmäßig das Ringdiagramm in den Top-Bereichen an. Betrifft nur die mobile Ansicht.';

  @override
  String get openMenu => 'Menü öffnen';

  @override
  String get closeMenu => 'Menü schließen';

  @override
  String get openListUrl => 'Listen-URL öffnen';

  @override
  String get selectionMode => 'Auswahlmodus';

  @override
  String get enableDisableSelected =>
      'Ausgewählte Elemente aktivieren oder deaktivieren';

  @override
  String get deleteSelected => 'Ausgewählte Elemente löschen';

  @override
  String get deleteSelectedLists => 'Ausgewählte Listen löschen';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'Alle ausgewählten Listen wurden erfolgreich gelöscht.';

  @override
  String get deletionResult => 'Ergebnis der Löschung';

  @override
  String get deletingLists => 'Listen werden gelöscht...';

  @override
  String get failedElements => 'Fehlgeschlagene Elemente';

  @override
  String get processingLists => 'Listen werden verarbeitet...';

  @override
  String get enableDisableResult => 'Ergebnis der Aktivierung/Deaktivierung';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'Alle ausgewählten Listen wurden erfolgreich aktiviert oder deaktiviert';

  @override
  String get sslWarning =>
      'Wenn du eine HTTPS-Verbindung mit einem selbstsignierten Zertifikat verwendest, aktiviere \"SSL-Zertifikat nicht prüfen\" unter Einstellungen > Erweiterte Einstellungen.';

  @override
  String get unsupportedServerVersion => 'Nicht unterstützte Serverversion';

  @override
  String get unsupportedServerVersionMessage =>
      'Deine AdGuard Home Serverversion ist zu alt und wird von AdGuard Home Manager nicht unterstützt. Du musst deinen AdGuard Home Server auf eine neuere Version aktualisieren, um diese App zu verwenden.';

  @override
  String yourVersion(Object version) {
    return 'Deine Version: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Mindestens erforderliche Version: $version';
  }

  @override
  String get topUpstreams => 'Top-Upstreams';

  @override
  String get averageUpstreamResponseTime =>
      'Durchschnittliche Upstream-Antwortzeit';

  @override
  String get dhcpNotAvailable => 'Der DHCP-Server ist nicht verfügbar.';

  @override
  String get osServerInstalledIncompatible =>
      'Das Betriebssystem, auf dem der Server installiert ist, ist mit dieser Funktion nicht kompatibel.';

  @override
  String get resetSettings => 'Einstellungen zurücksetzen';

  @override
  String get resetEncryptionSettingsDescription =>
      'Bist du sicher, dass du die Verschlüsselungseinstellungen auf die Standardwerte zurücksetzen möchtest?';

  @override
  String get resettingConfig => 'Konfiguration wird zurückgesetzt...';

  @override
  String get configurationResetSuccessfully =>
      'Konfiguration erfolgreich zurückgesetzt';

  @override
  String get configurationResetError =>
      'Die Konfiguration konnte nicht zurückgesetzt werden';

  @override
  String get testUpstreamDnsServers => 'Upstream-DNS-Server testen';

  @override
  String get errorTestUpstreamDns =>
      'Fehler beim Testen der Upstream-DNS-Server.';

  @override
  String get useCustomIpEdns => 'Benutzerdefinierte IP für EDNS verwenden';

  @override
  String get useCustomIpEdnsDescription =>
      'Verwendung einer benutzerdefinierten IP für EDNS erlauben';

  @override
  String get sortingOptions => 'Sortieroptionen';

  @override
  String get fromHighestToLowest => 'Vom höchsten zum niedrigsten';

  @override
  String get fromLowestToHighest => 'Vom niedrigsten zum höchsten';

  @override
  String get queryLogsAndStatistics => 'Anfrage-Logs und Statistiken';

  @override
  String get ignoreClientQueryLog => 'Diesen Client im Anfrage-Log ignorieren';

  @override
  String get ignoreClientStatistics =>
      'Diesen Client in Statistiken ignorieren';

  @override
  String get savingChanges => 'Änderungen werden gespeichert...';

  @override
  String get fallbackDnsServers => 'Fallback-DNS-Server';

  @override
  String get fallbackDnsServersDescription =>
      'Fallback-DNS-Server konfigurieren';

  @override
  String get fallbackDnsServersInfo =>
      'Liste der Fallback-DNS-Server, die verwendet werden, wenn die Upstream-DNS-Server nicht antworten. Die Syntax ist dieselbe wie im Feld für die Haupt-Upstreams oben.';

  @override
  String get noFallbackDnsAdded => 'Keine Fallback-DNS-Server hinzugefügt.';

  @override
  String get blockedResponseTtl => 'TTL für blockierte Antworten';

  @override
  String get blockedResponseTtlDescription =>
      'Gibt an, wie viele Sekunden Clients eine gefilterte Antwort cachen sollen';

  @override
  String get invalidValue => 'Ungültiger Wert';

  @override
  String get noDataChart =>
      'Es sind keine Daten vorhanden, um dieses Diagramm anzuzeigen.';

  @override
  String get noData => 'Keine Daten';

  @override
  String get unblockClient => 'Client freigeben';

  @override
  String get blockingClient => 'Client wird blockiert...';

  @override
  String get unblockingClient => 'Client wird freigegeben...';

  @override
  String get upstreamDnsCacheConfiguration =>
      'DNS-Upstream-Cache-Konfiguration';

  @override
  String get enableDnsCachingClient =>
      'DNS-Caching für diesen Client aktivieren';

  @override
  String get dnsCacheSize => 'DNS-Cachegröße';

  @override
  String get nameInvalid => 'Name ist erforderlich';

  @override
  String get oneIdentifierRequired =>
      'Mindestens ein Identifikator ist erforderlich';

  @override
  String get dnsCacheNumber => 'DNS-Cachegröße muss eine Zahl sein';

  @override
  String get errors => 'Fehler';

  @override
  String get redirectHttpsWarning =>
      'Wenn du \"Automatisch zu HTTPS umleiten\" auf deinem AdGuard Home Server aktiviert hast, musst du eine HTTPS-Verbindung wählen und den HTTPS-Port deines Servers verwenden.';

  @override
  String get logsSettingsDescription => 'Anfrage-Logs konfigurieren';

  @override
  String get ignoredDomains => 'Ignorierte Domains';

  @override
  String get noIgnoredDomainsAdded =>
      'Keine zu ignorierenden Domains hinzugefügt';

  @override
  String get pauseServiceBlocking => 'Diensteblockierung pausieren';

  @override
  String get newSchedule => 'Neuer Zeitplan';

  @override
  String get editSchedule => 'Zeitplan bearbeiten';

  @override
  String get timezone => 'Zeitzone';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get saturday => 'Samstag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get from => 'Von';

  @override
  String get to => 'Bis';

  @override
  String get selectStartTime => 'Startzeit auswählen';

  @override
  String get selectEndTime => 'Endzeit auswählen';

  @override
  String get startTimeBeforeEndTime => 'Startzeit muss vor der Endzeit liegen.';

  @override
  String get noBlockingScheduleThisDevice =>
      'Es gibt keinen Blockierzeitplan für dieses Gerät.';

  @override
  String get selectTimezone => 'Zeitzone auswählen';

  @override
  String get selectClientsFiltersInfo =>
      'Wähle die Clients aus, die angezeigt werden sollen. Wenn keine Clients ausgewählt sind, werden alle angezeigt.';

  @override
  String get noDataThisSection =>
      'Für diesen Bereich sind keine Daten vorhanden.';

  @override
  String get statisticsSettings => 'Statistikeinstellungen';

  @override
  String get statisticsSettingsDescription =>
      'Datenerfassung für Statistiken konfigurieren';

  @override
  String get loadingStatisticsSettings =>
      'Statistikeinstellungen werden geladen...';

  @override
  String get statisticsSettingsLoadError =>
      'Beim Laden der Statistikeinstellungen ist ein Fehler aufgetreten.';

  @override
  String get statisticsConfigUpdated =>
      'Statistikeinstellungen erfolgreich aktualisiert';

  @override
  String get statisticsConfigNotUpdated =>
      'Statistikeinstellungen konnten nicht aktualisiert werden';

  @override
  String get customTimeInHours => 'Benutzerdefinierte Zeit (in Stunden)';

  @override
  String get invalidTime => 'Ungültige Zeit';

  @override
  String get removeDomain => 'Domain entfernen';

  @override
  String get addDomain => 'Domain hinzufügen';

  @override
  String get notLess1Hour =>
      'Die Zeit darf nicht weniger als 1 Stunde betragen';

  @override
  String get rateLimit => 'Ratenbegrenzung';

  @override
  String get subnetPrefixLengthIpv4 => 'Subnetz-Präfixlänge für IPv4';

  @override
  String get subnetPrefixLengthIpv6 => 'Subnetz-Präfixlänge für IPv6';

  @override
  String get rateLimitAllowlist => 'Ratenbegrenzung Ausnahmeliste';

  @override
  String get rateLimitAllowlistDescription =>
      'Von der Ratenbegrenzung ausgenommene IP-Adressen';

  @override
  String get dnsOptions => 'DNS-Optionen';

  @override
  String get editor => 'Editor';

  @override
  String get editCustomRules => 'Benutzerdefinierte Regeln bearbeiten';

  @override
  String get savingCustomRules =>
      'Benutzerdefinierte Regeln werden gespeichert...';

  @override
  String get customRulesUpdatedSuccessfully =>
      'Benutzerdefinierte Regeln erfolgreich aktualisiert';

  @override
  String get customRulesNotUpdated =>
      'Benutzerdefinierte Regeln konnten nicht aktualisiert werden';

  @override
  String get reorder => 'Neu anordnen';

  @override
  String get showHide => 'Anzeigen/Ausblenden';

  @override
  String get noElementsReorderMessage =>
      'Aktiviere Elemente im Tab Anzeigen/Ausblenden, um sie hier neu anzuordnen.';

  @override
  String get enablePlainDns => 'Unverschlüsseltes DNS aktivieren';

  @override
  String get enablePlainDnsDescription =>
      'Unverschlüsseltes DNS ist standardmäßig aktiviert. Du kannst es deaktivieren, um alle Geräte zur Nutzung von verschlüsseltem DNS zu zwingen. Dazu muss mindestens ein verschlüsseltes DNS-Protokoll aktiviert sein.';

  @override
  String get date => 'Datum';

  @override
  String get loadingChangelog => 'Änderungsprotokoll wird geladen...';

  @override
  String get invalidIpOrUrl => 'Ungültige IP-Adresse oder URL';

  @override
  String get addPersistentClient => 'Als dauerhaften Client hinzufügen';

  @override
  String get blockThisClientOnly => 'Nur für diesen Client blockieren';

  @override
  String get unblockThisClientOnly => 'Nur für diesen Client freigeben';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain für diesen Client blockiert';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return '$domain für diesen Client freigegeben';
  }

  @override
  String get disallowThisClient => 'Diesen Client blockieren';

  @override
  String get allowThisClient => 'Diesen Client erlauben';

  @override
  String get clientAllowedSuccessfully => 'Client erfolgreich erlaubt';

  @override
  String get clientDisallowedSuccessfully => 'Client erfolgreich blockiert';

  @override
  String get changesNotSaved => 'Änderungen konnten nicht gespeichert werden';

  @override
  String get allowingClient => 'Client wird erlaubt...';

  @override
  String get disallowingClient => 'Client wird blockiert...';

  @override
  String get clientIpCopied => 'Client-IP in die Zwischenablage kopiert';

  @override
  String get clientNameCopied => 'Clientname in die Zwischenablage kopiert';

  @override
  String get dnsServerAddressCopied =>
      'DNS-Serveradresse in die Zwischenablage kopiert';

  @override
  String get select => 'Auswählen';

  @override
  String get liveLogs => 'Live-Logs';

  @override
  String get hereWillAppearRealtimeLogs =>
      'Hier erscheinen die Logs in Echtzeit.';

  @override
  String get applicationDetails => 'App-Details';

  @override
  String get applicationDetailsDescription =>
      'App-Repository, Verfügbarkeit in Stores und mehr';

  @override
  String get myOtherApps => 'Meine anderen Apps';

  @override
  String get myOtherAppsDescription =>
      'Sieh dir meine anderen Apps an, spende, kontaktiere den Support und mehr';

  @override
  String get topToBottom => 'Von oben nach unten';

  @override
  String get bottomToTop => 'Von unten nach oben';

  @override
  String get upstreamTimeout => 'Upstream-Timeout';

  @override
  String get upstreamTimeoutHelper =>
      'Gibt die Anzahl der Sekunden an, die auf eine Antwort vom Upstreamserver gewartet werden soll';

  @override
  String get fieldCannotBeEmpty => 'Dieses Feld darf nicht leer sein';

  @override
  String get enableDnsRewriteRules => 'DNS-Umschreibungsregeln aktivieren';

  @override
  String get dnsRewriteRuleEnabled =>
      'DNS-Umschreibungsregel erfolgreich aktiviert';

  @override
  String get dnsRewriteRuleDisabled =>
      'DNS-Umschreibungsregel erfolgreich deaktiviert';

  @override
  String get allDnsRewriteRulesEnabled =>
      'Alle DNS-Umschreibungsregeln erfolgreich aktiviert';

  @override
  String get allDnsRewriteRulesDisabled =>
      'Alle DNS-Umschreibungsregeln erfolgreich deaktiviert';

  @override
  String get errorEnablingAllDnsRewriteRules =>
      'Fehler beim Aktivieren aller DNS-Umschreibungsregeln';

  @override
  String get errorDisablingAllDnsRewriteRules =>
      'Fehler beim Deaktivieren aller DNS-Umschreibungsregeln';

  @override
  String get enablingDnsRewriteRule =>
      'DNS-Umschreibungsregeln werden aktiviert...';

  @override
  String get disablingDnsRewriteRule =>
      'DNS-Umschreibungsregeln werden deaktiviert...';

  @override
  String get selectIdToFilter => 'ID zum Filtern auswählen';

  @override
  String get clientIds => 'Client-IDs';
}
