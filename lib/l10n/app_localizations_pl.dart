// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get home => 'Dom';

  @override
  String get settings => 'Ustawienia';

  @override
  String get connect => 'Połączyć';

  @override
  String get servers => 'Serwery';

  @override
  String get createConnection => 'Utwórz połączenie';

  @override
  String get editConnection => 'Edit connection';

  @override
  String get name => 'Nazwa';

  @override
  String get ipDomain => 'Adres IP lub domena';

  @override
  String get path => 'Ścieżka';

  @override
  String get port => 'Port';

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get password => 'Hasło';

  @override
  String get defaultServer => 'Serwer domyślny';

  @override
  String get general => 'Ogólne';

  @override
  String get connection => 'Połączenie';

  @override
  String get authentication => 'Uwierzytelnianie';

  @override
  String get other => 'Inne';

  @override
  String get invalidPort => 'Nieprawidłowy port';

  @override
  String get invalidPath => 'Nieprawidłowa ścieżka';

  @override
  String get invalidIpDomain => 'Nieprawidłowy adres IP lub domena';

  @override
  String get ipDomainNotEmpty => 'Adres IP lub domena nie mogą być puste';

  @override
  String get nameNotEmpty => 'Nazwa nie może być pusta';

  @override
  String get invalidUsernamePassword =>
      'Nieprawidłowa nazwa użytkownika lub hasło';

  @override
  String get tooManyAttempts => 'Zbyt wiele prób, spróbuj ponownie później';

  @override
  String get cantReachServer =>
      'Nie można połączyć się z serwerem. Sprawdź dane połączenia.';

  @override
  String get sslError =>
      'Błąd SSL. Przejdź do pozycji Ustawienia > Ustawienia zaawansowane i włącz opcję Zastąp sprawdzanie poprawności SSL.';

  @override
  String get unknownError => 'Nieznany błąd';

  @override
  String get connectionNotCreated => 'Nie można utworzyć połączenia';

  @override
  String get connecting => 'Łączenie...';

  @override
  String get connected => 'Połączony';

  @override
  String get selectedDisconnected => 'Zaznaczone, ale rozłączone';

  @override
  String get connectionDefaultSuccessfully =>
      'Połączenie ustawione jako domyślne pomyślnie.';

  @override
  String get connectionDefaultFailed =>
      'Nie można ustawić połączenia jako domyślne.';

  @override
  String get noSavedConnections => 'Brak zapisanych połączeń';

  @override
  String get cannotConnect => 'Nie można połączyć się z serwerem';

  @override
  String get connectionRemoved => 'Połączenie zostało pomyślnie usunięte.';

  @override
  String get connectionCannotBeRemoved => 'Nie można usunąć połączenia.';

  @override
  String get remove => 'Usuń';

  @override
  String get removeWarning =>
      'Czy na pewno chcesz usunąć połączenie z tym serwerem AdGuard Home?';

  @override
  String get cancel => 'Anuluj';

  @override
  String get defaultConnection => 'Połączenie domyślne';

  @override
  String get setDefault => 'Ustaw jako domyślne';

  @override
  String get edit => 'Edytuj';

  @override
  String get delete => 'Usuń';

  @override
  String get save => 'Zapisz';

  @override
  String get serverStatus => 'Stan serwera';

  @override
  String get connectionNotUpdated => 'Połączenie nie zostało zaktualizowane';

  @override
  String get ruleFilteringWidget => 'Widget Reguł filtrowania';

  @override
  String get safeBrowsingWidget => 'Widget Bezpieczne przeglądanie';

  @override
  String get parentalFilteringWidget => 'Widget Filtrowania rodzicielskiego';

  @override
  String get safeSearchWidget => 'Widget Bezpiecznego wyszukiwania';

  @override
  String get ruleFiltering => 'Reguły filtrowania';

  @override
  String get safeBrowsing => 'Bezpieczne przeglądanie';

  @override
  String get parentalFiltering => 'Filtrowanie rodzicielskie';

  @override
  String get safeSearch => 'Bezpieczne wyszukiwanie';

  @override
  String get serverStatusNotRefreshed => 'Nie można odświeżyć stanu serwera';

  @override
  String get loadingStatus => 'Stan ładowania...';

  @override
  String get errorLoadServerStatus => 'Nie można załadować stanu serwera';

  @override
  String get topQueriedDomains => 'Najczęściej wyszukiwane domeny';

  @override
  String get viewMore => 'Zobacz więcej';

  @override
  String get topClients => 'Najlepsi klienci';

  @override
  String get topBlockedDomains => 'Najczęściej blokowane domeny';

  @override
  String get appSettings => 'Ustawienia aplikacji';

  @override
  String get theme => 'Motyw';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get systemDefined => 'Zdefiniowany przez system';

  @override
  String get close => 'Zamknij';

  @override
  String get connectedTo => 'Połączony z:';

  @override
  String get selectedServer => 'Wybrany serwer:';

  @override
  String get noServerSelected => 'Nie wybrano serwera';

  @override
  String get manageServer => 'Zarządzanie serwerem';

  @override
  String get allProtections => 'Wszystkie zabezpieczenia';

  @override
  String get userNotEmpty => 'Nazwa użytkownika nie może być pusta';

  @override
  String get passwordNotEmpty => 'Hasło nie może być puste';

  @override
  String get examplePath => 'Przykład: /adguard';

  @override
  String get helperPath => 'Jeśli używasz zwrotnego serwera proxy';

  @override
  String get aboutApp => 'O aplikacji';

  @override
  String get appVersion => 'Wersja aplikacji';

  @override
  String get createdBy => 'Stworzone przez';

  @override
  String get clients => 'Klienci';

  @override
  String get allowed => 'Dozwolone';

  @override
  String get blocked => 'Zablokowane';

  @override
  String get noClientsList => 'Na tej liście nie ma klientów';

  @override
  String get activeClients => 'Aktywny';

  @override
  String get removeClient => 'Usuń klienta';

  @override
  String get removeClientMessage =>
      'Czy na pewno chcesz usunąć tego klienta z listy?';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get removingClient => 'Usuwanie klienta...';

  @override
  String get clientNotRemoved => 'Nie można usunąć klienta z listy';

  @override
  String get addClient => 'Dodaj klienta';

  @override
  String get list => 'Lista';

  @override
  String get ipAddress => 'Adres IP';

  @override
  String get ipNotValid => 'Adres IP jest nieprawidłowy';

  @override
  String get clientAddedSuccessfully =>
      'Klient został pomyślnie dodany do listy.';

  @override
  String get addingClient => 'Dodawanie klienta...';

  @override
  String get clientNotAdded => 'Nie można dodać klienta do listy.';

  @override
  String get clientAnotherList => 'Ten klient jest już na innej liście.';

  @override
  String get noSavedLogs => 'Brak zapisanych danych w dzienniku logów';

  @override
  String get logs => 'Logi';

  @override
  String get copyLogsClipboard => 'Kopiowanie dzienników logów do schowka';

  @override
  String get logsCopiedClipboard => 'Dzienniki logów skopiowane do schowka';

  @override
  String get advancedSettings => 'Ustawienia zaawansowane';

  @override
  String get dontCheckCertificate => 'Nie sprawdzaj certyfikatu SSL';

  @override
  String get dontCheckCertificateDescription =>
      'Zastępuje sprawdzanie poprawności certyfikatu SSL serwera';

  @override
  String get advancedSetupDescription => 'Opcje zaawansowane';

  @override
  String get settingsUpdatedSuccessfully =>
      'Ustawienia zostały pomyślnie zaktualizowane.';

  @override
  String get cannotUpdateSettings => 'Nie można zaktualizować ustawień.';

  @override
  String get restartAppTakeEffect => 'Uruchom ponownie aplikację';

  @override
  String get loadingLogs => 'Ładowanie logów dzienników...';

  @override
  String get logsNotLoaded => 'Nie można załadować listy dzienników';

  @override
  String get processed => 'Przetworzone\nBrak listy';

  @override
  String get processedRow => 'Przetworzone (brak listy)';

  @override
  String get blockedBlacklist => 'Zablokowane\nCzarna lista';

  @override
  String get blockedBlacklistRow => 'Zablokowane (czarna lista)';

  @override
  String get blockedSafeBrowsing => 'Zablokowane\nBezpieczne przeglądanie';

  @override
  String get blockedSafeBrowsingRow => 'Zablokowane (bezpieczne przeglądanie)';

  @override
  String get blockedParental => 'Zablokowane\nFiltrowanie rodzicielskie';

  @override
  String get blockedParentalRow => 'Zablokowane (filtrowanie rodzicielskie)';

  @override
  String get blockedInvalid => 'Zablokowany\nNieprawidłowy';

  @override
  String get blockedInvalidRow => 'Zablokowane (nieprawidłowe)';

  @override
  String get blockedSafeSearch => 'Zablokowane\nBezpieczne wyszukiwanie';

  @override
  String get blockedSafeSearchRow => 'Zablokowane (bezpieczne wyszukiwanie)';

  @override
  String get blockedService => 'Zablokowana\nZablokowana usługa';

  @override
  String get blockedServiceRow => 'Zablokowana (zablokowana usługa)';

  @override
  String get processedWhitelist => 'Przetworzone\nBiała lista';

  @override
  String get processedWhitelistRow => 'Przetworzone (biała lista)';

  @override
  String get processedError => 'Przetworzone\nBłąd';

  @override
  String get processedErrorRow => 'Przetworzone (błąd)';

  @override
  String get rewrite => 'Nadpisać';

  @override
  String get status => 'Status';

  @override
  String get result => 'Wynik';

  @override
  String get time => 'Czas';

  @override
  String get blocklist => 'Lista zablokowanych';

  @override
  String get request => 'Żądanie';

  @override
  String get domain => 'Domena';

  @override
  String get type => 'Type';

  @override
  String get clas => 'Klasa';

  @override
  String get response => 'Odpowiedź';

  @override
  String get dnsServer => 'DNS server';

  @override
  String get elapsedTime => 'Czas, który upłynął';

  @override
  String get responseCode => 'Kod odpowiedzi';

  @override
  String get client => 'Klient';

  @override
  String get deviceIp => 'Adres IP urządzenia';

  @override
  String get deviceName => 'Nazwa urządzenia';

  @override
  String get logDetails => 'Szczegóły dziennika logów';

  @override
  String get blockingRule => 'Reguła blokowania';

  @override
  String get blockDomain => 'Blokowanie domeny';

  @override
  String get couldntGetFilteringStatus =>
      'Nie można uzyskać stanu filtrowanias';

  @override
  String get unblockDomain => 'Odblokuj domenę';

  @override
  String get userFilteringRulesNotUpdated =>
      'Nie można zaktualizować reguł filtrowania użytkowników.';

  @override
  String get userFilteringRulesUpdated =>
      'Reguły filtrowania użytkowników zostały pomyślnie zaktualizowane';

  @override
  String get savingUserFilters => 'Zapisywanie filtrów użytkownika...';

  @override
  String get filters => 'Filtry';

  @override
  String get logsOlderThan => 'Dzienniki logów starsze niż';

  @override
  String get responseStatus => 'Stan odpowiedzi';

  @override
  String get selectTime => 'Wybierz czas';

  @override
  String get notSelected => 'Nie wybrano';

  @override
  String get resetFilters => 'Resetowanie filtrów';

  @override
  String get noLogsDisplay => 'Brak dzienników logów do wyświetlenia';

  @override
  String get noLogsThatOld =>
      'Możliwe, że dla wybranego czasu nie zapisano żadnych dzienników logów. Spróbuj wybrać nowszą godzinę.';

  @override
  String get apply => 'Zastosować';

  @override
  String get selectAll => 'Zaznacz wszystko';

  @override
  String get unselectAll => 'Odznacz wszystko';

  @override
  String get all => 'Wszystko';

  @override
  String get filtered => 'Przefiltrowano';

  @override
  String get checkAppLogs => 'Sprawdź dzienniki logów aplikacji';

  @override
  String get refresh => 'Odśwież';

  @override
  String get search => 'Szukaj';

  @override
  String get dnsQueries => 'Zapytania DNS';

  @override
  String get average => 'Średnia';

  @override
  String get blockedFilters => 'Zablokowane przez filtry';

  @override
  String get malwarePhishingBlocked =>
      'Zablokowane złośliwe oprogramowanie/phishing';

  @override
  String get blockedAdultWebsites => 'Zablokowane witryny dla dorosłych';

  @override
  String get generalSettings => 'Ustawienia główne';

  @override
  String get generalSettingsDescription => 'Różne ustawienia';

  @override
  String get hideZeroValues => 'Ukryj wartości zerowe';

  @override
  String get hideZeroValuesDescription =>
      'Na ekranie głównym ukryj bloki o zerowej wartości';

  @override
  String get webAdminPanel => 'Panel administracyjny WWW';

  @override
  String get visitGooglePlay => 'Odwiedź stronę Google Play';

  @override
  String get gitHub => 'Kod aplikacji dostępny na GitHub';

  @override
  String get blockClient => 'Zablokuj klienta';

  @override
  String get selectTags => 'Wybierz tagi';

  @override
  String get noTagsSelected => 'Brak zaznaczonych tagów';

  @override
  String get tags => 'Tagi';

  @override
  String get identifiers => 'Identyfikatory';

  @override
  String get identifier => 'Identyfikator';

  @override
  String get identifierHelper => 'Adres IP , CIDR, Adres MAC, or ClientID';

  @override
  String get noIdentifiers => 'Nie dodano identyfikatorów';

  @override
  String get useGlobalSettings => 'Użyj ustawień globalnych';

  @override
  String get enableFiltering => 'Włącz filtrowanie';

  @override
  String get enableSafeBrowsing => 'Włącz bezpieczne przeglądanie';

  @override
  String get enableParentalControl => 'Włącz kontrolę rodzicielską';

  @override
  String get enableSafeSearch => 'Włącz bezpieczne wyszukiwanie';

  @override
  String get blockedServices => 'Zablokowane usługi';

  @override
  String get selectBlockedServices => 'Wybierz usługi do zablokowaniak';

  @override
  String get noBlockedServicesSelected => 'Brak zablokowanych usług';

  @override
  String get services => 'Usługi';

  @override
  String get servicesBlocked => 'Usługi zablokowane';

  @override
  String get tagsSelected => 'wybrane tagi';

  @override
  String get upstreamServers => 'Serwery nadrzędne';

  @override
  String get serverAddress => ' Adres servera';

  @override
  String get noUpstreamServers => 'Brak serwerów nadrzędnych.';

  @override
  String get willBeUsedGeneralServers =>
      'Wykorzystane zostaną ogólne serwery nadrzędne.';

  @override
  String get added => 'Dodane';

  @override
  String get clientUpdatedSuccessfully =>
      'Klient został pomyślnie zaktualizowany';

  @override
  String get clientNotUpdated => 'Nie można zaktualizować klienta';

  @override
  String get clientDeletedSuccessfully => 'Klient został pomyślnie usunięty';

  @override
  String get clientNotDeleted => 'Nie można usunąć klienta';

  @override
  String get options => 'Opcje';

  @override
  String get loadingFilters => 'Ładowanie filtrów...';

  @override
  String get filtersNotLoaded => 'Nie można załadować filtrów.';

  @override
  String get whitelists => 'Biała lista';

  @override
  String get blacklists => 'Czarna lista';

  @override
  String get rules => 'Zasady';

  @override
  String get customRules => 'Reguły niestandardowe';

  @override
  String get enabledRules => 'Włączone reguły';

  @override
  String get enabled => 'Włączone';

  @override
  String get disabled => 'Wyłączone';

  @override
  String get rule => 'Reguła';

  @override
  String get addCustomRule => 'Dodaj niestandardową regułę';

  @override
  String get removeCustomRule => 'Usuń regułę niestandardową';

  @override
  String get removeCustomRuleMessage =>
      'Czy na pewno chcesz usunąć tę regułę niestandardową?';

  @override
  String get updatingRules => 'Aktualizowanie reguł niestandardowych...';

  @override
  String get ruleRemovedSuccessfully => 'Reguła została pomyślnie usunięta';

  @override
  String get ruleNotRemoved => 'Nie można usunąć reguły';

  @override
  String get ruleAddedSuccessfully => 'Reguła dodana pomyślnie';

  @override
  String get ruleNotAdded => 'Nie można dodać reguły';

  @override
  String get noCustomFilters => 'Brak filtrów niestandardowych';

  @override
  String get noBlockedClients => 'Brak zablokowanych klientów';

  @override
  String get noBlackLists => 'Brak czarnych list';

  @override
  String get noWhiteLists => 'Brak białych list';

  @override
  String get addWhitelist => 'Dodaj białą listę';

  @override
  String get addBlacklist => 'Dodaj czarną listę';

  @override
  String get urlNotValid => 'Adres URL jest nieprawidłowy';

  @override
  String get urlAbsolutePath => 'Adres URL lub ścieżka bezwzględna';

  @override
  String get addingList => 'Dodawanie listy...';

  @override
  String get listAdded => 'Lista została dodana pomyślnie. Dodane elementy:';

  @override
  String get listAlreadyAdded => 'Lista została już dodana';

  @override
  String get listUrlInvalid => 'Adres URL listy jest nieprawidłowy';

  @override
  String get listNotAdded => 'Nie można dodać listy';

  @override
  String get listDetails => 'Szczegóły listy';

  @override
  String get listType => 'Typ listy';

  @override
  String get whitelist => 'Biała lista';

  @override
  String get blacklist => 'Czarna list';

  @override
  String get latestUpdate => 'Najnowsza aktualizacja';

  @override
  String get disable => 'Wyłączyć';

  @override
  String get enable => 'Włączać';

  @override
  String get currentStatus => 'Aktualny stan';

  @override
  String get listDataUpdated => 'Dane listy zostały pomyślnie zaktualizowane';

  @override
  String get listDataNotUpdated => 'Nie można zaktualizować danych listy';

  @override
  String get updatingListData => 'Aktualizowanie danych listy...';

  @override
  String get editWhitelist => 'Edytuj białą listę';

  @override
  String get editBlacklist => 'Edytuj czarną listę';

  @override
  String get deletingList => 'Usuwanie listy...';

  @override
  String get listDeleted => 'Lista usunięta pomyślnie';

  @override
  String get listNotDeleted => 'Nie można usunąć listy';

  @override
  String get deleteList => 'Usuń listę';

  @override
  String get deleteListMessage =>
      'Czy na pewno chcesz usunąć tę listę? Tej akcji nie można cofnąć.';

  @override
  String get serverSettings => 'Ustawienia serwera';

  @override
  String get serverInformation => 'Informacje o serwerze';

  @override
  String get serverInformationDescription => 'Informacje i status serwera';

  @override
  String get loadingServerInfo => 'Ładowanie informacji o serwerze...';

  @override
  String get serverInfoNotLoaded =>
      'Nie można załadować informacji o serwerze.';

  @override
  String get dnsAddresses => 'Adresy DNS';

  @override
  String get seeDnsAddresses => 'Zobacz adresy DNS';

  @override
  String get dnsPort => 'Port DNS';

  @override
  String get httpPort => 'Port HTTP';

  @override
  String get protectionEnabled => 'Ochrona włączona';

  @override
  String get dhcpAvailable => 'Dostępne DHCP';

  @override
  String get serverRunning => 'Serwer działa';

  @override
  String get serverVersion => 'Wersia Serwera';

  @override
  String get serverLanguage => 'Język serwera';

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get allowedClients => 'Dozwoleni klienci';

  @override
  String get disallowedClients => 'Niedozwoloni klienci';

  @override
  String get disallowedDomains => 'Niedozwolone domeny';

  @override
  String get accessSettings => 'Ustawienia dostępu';

  @override
  String get accessSettingsDescription =>
      'Konfigurowanie reguł dostępu dla serwera';

  @override
  String get loadingClients => 'Ładowanie klientów...';

  @override
  String get clientsNotLoaded => 'Nie można załadować klientów.';

  @override
  String get noAllowedClients => 'Brak dozwolonych klientów.';

  @override
  String get allowedClientsDescription =>
      'Jeśli ta lista zawiera wpisy, AdGuard Home będzie akceptować żądania tylko od tych klientów.';

  @override
  String get blockedClientsDescription =>
      'Jeśli ta lista zawiera wpisy, AdGuard Home odrzuci żądania od tych klientów. To pole jest ignorowane, jeśli w obszarze Dozwolone klienty znajdują się wpisy';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home usuwa zapytania DNS pasujące do tych domen, a zapytania te nawet nie pojawiają się w dzienniku zapytań';

  @override
  String get addClientFieldDescription => 'CIDRs, adres IP or ClientID';

  @override
  String get clientIdentifier => 'Identyfikator klienta';

  @override
  String get allowClient => 'Zezwól klientowi';

  @override
  String get disallowClient => 'Nie zezwalaj klientowi';

  @override
  String get noDisallowedDomains => 'Brak niedozwolonych domen';

  @override
  String get domainNotAdded => 'Nie można dodać domeny';

  @override
  String get statusSelected => 'Wybrany status';

  @override
  String get updateLists => 'Aktualizuj listy';

  @override
  String get checkHostFiltered => 'Sprawdź hosta';

  @override
  String get updatingLists => 'Aktualizowanie list...';

  @override
  String get listsUpdated => 'Zaktualizowano listy';

  @override
  String get listsNotUpdated => 'Nie można zaktualizować list';

  @override
  String get listsNotLoaded => 'Nie można załadować list';

  @override
  String get domainNotValid => 'Nieprawidłowa domena';

  @override
  String get check => 'Sprawdź';

  @override
  String get checkingHost => 'Sprawdzanie hosta...';

  @override
  String get errorCheckingHost => 'Nie można sprawdzić hosta';

  @override
  String get block => 'Zablokować';

  @override
  String get unblock => 'Odblokować';

  @override
  String get custom => 'Niestandardowy';

  @override
  String get addImportant => 'Dodawaj \$important';

  @override
  String get howCreateRules => 'Jak tworzyć reguły niestandardowe';

  @override
  String get examples => 'Przykłady';

  @override
  String get example1 =>
      'Zablokuj dostęp do example.org i wszystkich jej subdomen.';

  @override
  String get example2 =>
      'Odblokowuje dostęp do example.org i wszystkich jego subdomen.';

  @override
  String get example3 => 'Dodaje komentarz.';

  @override
  String get example4 =>
      'Blokowanie dostępu do domen zgodnych z określonym wyrażeniem regularnym.';

  @override
  String get moreInformation => 'Więcej informacji';

  @override
  String get addingRule => 'Dodawanie reguły...';

  @override
  String get deletingRule => 'Usuwanie reguły...';

  @override
  String get enablingList => 'Włączanie listy...';

  @override
  String get disablingList => 'Wyłączanie listy...';

  @override
  String get savingList => 'Saving list...';

  @override
  String get disableFiltering => 'Wyłącz filtrowanie';

  @override
  String get enablingFiltering => 'Włączanie filtrowania...';

  @override
  String get disablingFiltering => 'Wyłączanie filtrowania...';

  @override
  String get filteringStatusUpdated =>
      'Stan filtrowania został pomyślnie zaktualizowany';

  @override
  String get filteringStatusNotUpdated =>
      'Nie można zaktualizować stanu filtrowania';

  @override
  String get updateFrequency => 'Częstotliwość aktualizacji';

  @override
  String get never => 'Nigdy';

  @override
  String get hour1 => 'Co 1 godzinę';

  @override
  String get hours12 => 'Co 12 godzin';

  @override
  String get hours24 => 'Co 24 godziny';

  @override
  String get days3 => 'Co 3 dni';

  @override
  String get days7 => 'Co 7 dni';

  @override
  String get changingUpdateFrequency => 'Zmieniam...';

  @override
  String get updateFrequencyChanged =>
      'Częstotliwość aktualizacji została pomyślnie zmieniona';

  @override
  String get updateFrequencyNotChanged =>
      'Nie można zmienić częstotliwości aktualizacji';

  @override
  String get updating => 'Aktualizowanie wartości...';

  @override
  String get blockedServicesUpdated =>
      'Zablokowane usługi zostały pomyślnie zaktualizowane';

  @override
  String get blockedServicesNotUpdated =>
      'Nie można zaktualizować zablokowanych usług';

  @override
  String get insertDomain => 'Wstaw domenę, aby sprawdzić jej status.';

  @override
  String get dhcpSettings => 'Ustawienia DHCP';

  @override
  String get dhcpSettingsDescription => 'Konfigurowanie serwera DHCP';

  @override
  String get dhcpSettingsNotLoaded => 'Nie można załadować ustawień DHCP';

  @override
  String get loadingDhcp => 'Ładowanie ustawień DHCP...';

  @override
  String get enableDhcpServer => 'Włącz serwer DHCP';

  @override
  String get selectInterface => 'Wybierz interfejs';

  @override
  String get hardwareAddress => 'Adres sprzętowy';

  @override
  String get gatewayIp => 'Adres IP bramy';

  @override
  String get ipv4addresses => 'Adres IPv4';

  @override
  String get ipv6addresses => 'Adres IPv6';

  @override
  String get neededSelectInterface =>
      'Aby skonfigurować serwer DHCP, należy wybrać interfejs.';

  @override
  String get ipv4settings => 'Ustawienia IPv4';

  @override
  String get startOfRange => 'Początek zakresu';

  @override
  String get endOfRange => 'Koniec zakresu';

  @override
  String get ipv6settings => 'Ustawienia IPv6';

  @override
  String get subnetMask => 'Maska podsieci';

  @override
  String get subnetMaskNotValid => 'Maska podsieci jest nieprawidłowa';

  @override
  String get gateway => 'Brama';

  @override
  String get gatewayNotValid => 'Brama jest nieprawidłowa';

  @override
  String get leaseTime => 'Czas dzierżawy';

  @override
  String seconds(Object time) {
    return '$time sekund';
  }

  @override
  String get leaseTimeNotValid => 'Czas dzierżawy jest nieaktualny';

  @override
  String get restoreConfiguration => 'Zresetuj konfigurację';

  @override
  String get restoreConfigurationMessage =>
      'Czy na pewno chcesz kontynuować? Spowoduje to zresetowanie całej konfiguracji. Tej czynności nie można cofnąć.';

  @override
  String get changeInterface => 'Zmień interfejs';

  @override
  String get savingSettings => 'Zapisywanie ustawień...';

  @override
  String get settingsSaved => 'Ustawienia zapisane pomyślnie';

  @override
  String get settingsNotSaved => 'Nie można zapisać ustawień';

  @override
  String get restoringConfig => 'Przywracanie konfiguracji...';

  @override
  String get configRestored => 'Konfiguracja została zresetowana pomyślnie';

  @override
  String get configNotRestored => 'Nie można zresetować konfiguracji';

  @override
  String get dhcpStatic => 'Dzierżawy statyczne DHCP';

  @override
  String get noDhcpStaticLeases => 'Nie znaleziono dzierżaw statycznych DHCP';

  @override
  String get deleting => 'Usuwanie...';

  @override
  String get staticLeaseDeleted =>
      'Dzierżawa statyczna DHCP została pomyślnie usunięta';

  @override
  String get staticLeaseNotDeleted =>
      'Nie można usunąć dzierżawy statycznej DHCP';

  @override
  String get deleteStaticLease => 'Usuwanie dzierżawy statycznej...';

  @override
  String get deleteStaticLeaseDescription =>
      'Dzierżawa statyczna DHCP zostanie usunięta. Tej akcji nie można cofnąć.';

  @override
  String get addStaticLease => 'Dodawanie dzierżawy statycznej';

  @override
  String get macAddress => 'Adres MAC';

  @override
  String get macAddressNotValid => 'Nieprawidłowy adres MAC';

  @override
  String get hostName => 'Nazwa hosta';

  @override
  String get hostNameError => 'Nazwa hosta nie może być pusta';

  @override
  String get creating => 'Tworzenie...';

  @override
  String get staticLeaseCreated =>
      'Dzierżawa statyczna DHCP utworzona pomyślnie';

  @override
  String get staticLeaseNotCreated =>
      'Nie można utworzyć dzierżawy statycznej DHCP';

  @override
  String get staticLeaseExists => 'Dzierżawa statyczna DHCP już istnieje';

  @override
  String get serverNotConfigured => 'Serwer nie jest skonfigurowany';

  @override
  String get restoreLeases => 'Resetowanie dzierżaw';

  @override
  String get restoreLeasesMessage =>
      'Czy na pewno chcesz kontynuować? Spowoduje to zresetowanie wszystkich istniejących dzierżaw. Tej czynności nie można cofnąć.';

  @override
  String get restoringLeases => 'Resetowanie dzierżaw...';

  @override
  String get leasesRestored => 'Dzierżawy zostały pomyślnie zresetowane';

  @override
  String get leasesNotRestored => 'Nie można zresetować dzierżaw';

  @override
  String get dhcpLeases => 'Dzierżawy DHCP';

  @override
  String get noLeases => 'Brak dostępnych dzierżaw DHCP';

  @override
  String get dnsRewrites => 'Przepisywanie DNS';

  @override
  String get dnsRewritesDescription =>
      'Konfigurowanie niestandardowych reguł DNS';

  @override
  String get loadingRewriteRules => 'Wczytywanie reguł przepisywania...';

  @override
  String get rewriteRulesNotLoaded =>
      'Nie można załadować reguł przepisywania DNS.';

  @override
  String get noRewriteRules => 'Brak reguł przepisywania DNS.';

  @override
  String get answer => 'Odpowiedź';

  @override
  String get deleteDnsRewrite => 'Usuń przepisywanie DNS';

  @override
  String get deleteDnsRewriteMessage =>
      'Czy na pewno chcesz usunąć to przepisanie DNS? Tej akcji nie można cofnąć.';

  @override
  String get dnsRewriteRuleDeleted =>
      'Reguła przepisywania DNS została pomyślnie usunięta';

  @override
  String get dnsRewriteRuleNotDeleted =>
      'Nie można usunąć reguły przepisywania DNS';

  @override
  String get addDnsRewrite => 'Dodaj przepisywanie DNS';

  @override
  String get addingRewrite => 'Dodawanie przepisywania...';

  @override
  String get dnsRewriteRuleAdded => 'Pomyślnie dodano regułę przepisywania DNS';

  @override
  String get dnsRewriteRuleNotAdded =>
      'Nie można dodać reguły przepisywania DNS';

  @override
  String get logsSettings => 'Ustawienia dzienników logów';

  @override
  String get enableLog => 'Włącz dziennik logów';

  @override
  String get clearLogs => 'Czyszczenie dzienników logów';

  @override
  String get anonymizeClientIp => 'Anonimizuj adres IP klienta';

  @override
  String get hours6 => 'co 6 godzin';

  @override
  String get days30 => 'co 30 dni';

  @override
  String get days90 => 'co 90 dni';

  @override
  String get retentionTime => 'Czas retencji';

  @override
  String get selectOneItem => 'Wybierz jeden element';

  @override
  String get logSettingsNotLoaded =>
      'Nie można załadować ustawień dziennika logów.';

  @override
  String get updatingSettings => 'Aktualizowanie ustawień...';

  @override
  String get logsConfigUpdated =>
      'Ustawienia dzienników logów zostały pomyślnie zaktualizowane';

  @override
  String get logsConfigNotUpdated =>
      'Nie można zaktualizować ustawień dzienników logów';

  @override
  String get deletingLogs => 'Czyszczenie dzienników logów...';

  @override
  String get logsCleared => 'Dzienniki logów wyczyszczone pomyślnie';

  @override
  String get logsNotCleared => 'Nie można wyczyścić dzienników logów';

  @override
  String get runningHomeAssistant => 'Działa na Home Assistant';

  @override
  String get serverError => 'Błąd serwera';

  @override
  String get noItems => 'Brak elementów do pokazania w tym miejscu';

  @override
  String get dnsSettings => 'Ustawienia DNS';

  @override
  String get dnsSettingsDescription =>
      'Konfigurowanie połączenia z serwerami DNS';

  @override
  String get upstreamDns => 'Nadrzędne serwery DNS';

  @override
  String get bootstrapDns => 'Serwery DNS Bootstrap';

  @override
  String get noUpstreamDns => 'Nie dodano nadrzędnych serwerów DNS.';

  @override
  String get dnsMode => 'Tryb DNS';

  @override
  String get noDnsMode => 'Nie wybrano trybu DNS';

  @override
  String get loadBalancing => 'Równoważenie obciążenia';

  @override
  String get parallelRequests => 'Równoległe żądania';

  @override
  String get fastestIpAddress => 'Najszybszy adres IP';

  @override
  String get loadBalancingDescription =>
      'Wysyłaj zapytania do jednego serwera nadrzędnego naraz. AdGuard Home wykorzystuje ważony algorytm losowy, aby wybrać serwer, dzięki czemu najszybszy serwer jest używany częściej.';

  @override
  String get parallelRequestsDescription =>
      'Użyj zapytań równoległych, aby przyspieszyć rozwiązywanie problemów, wysyłając jednocześnie zapytania do wszystkich serwerów nadrzędnych.';

  @override
  String get fastestIpAddressDescription =>
      'Odpytuj wszystkie serwery DNS i zwracaj najszybszy adres IP spośród wszystkich odpowiedzi. Spowalnia to zapytania DNS, ponieważ AdGuard Home musi czekać na odpowiedzi ze wszystkich serwerów DNS, ale poprawia ogólną łączność.';

  @override
  String get noBootstrapDns => 'Nie dodano żadnych serwerów Bootstrap DNS.';

  @override
  String get bootstrapDnsServersInfo =>
      'Serwery DNS Bootstrap służą do rozpoznawania adresów IP programów rozpoznawania nazw DoH/DoT określonych jako nadrzędne.';

  @override
  String get privateReverseDnsServers => 'Prywatne zwrotne serwery DNS';

  @override
  String get privateReverseDnsServersDescription =>
      'Serwery DNS, których AdGuard Home używa do lokalnych zapytań PST. Serwery te są używane na przykład do rozwiązywania żądań PST dotyczących adresów w prywatnych zakresach adresów IP \"192.168.12.34\", przy użyciu odwrotnego DNS. Jeśli nie jest ustawiony, AdGuard Home używa adresów domyślnych programów rozpoznawania nazw DNS systemu operacyjnego, z wyjątkiem adresów samego AdGuard Home.';

  @override
  String get reverseDnsDefault =>
      'Domyślnie AdGuard Home używa następujących programów do rozpoznawania odwrotnych nazw DNS';

  @override
  String get addItem => 'Dodaj element';

  @override
  String get noServerAddressesAdded => 'Nie dodano adresów serwerów.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Użyj prywatnych programów do rozpoznawania nazw zwrotnych DNS';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Wykonaj odwrotne wyszukiwanie DNS dla adresów obsługiwanych lokalnie przy użyciu tych serwerów nadrzędnych. Jeśli jest wyłączona, AdGuard Home odpowiada NXDOMAIN na wszystkie takie żądania PST, z wyjątkiem klientów znanych z DHCP, /etc/hosts itd.';

  @override
  String get enableReverseResolving =>
      'Włącz odwrotne rozpoznawanie adresów IP klientów';

  @override
  String get enableReverseResolvingDescription =>
      'Odwrotne rozpoznawanie adresów IP klientów w ich nazwach hostów przez wysyłanie zapytań PTR do odpowiednich programów rozpoznawania nazw (prywatne serwery DNS dla klientów lokalnych, serwery nadrzędne dla klientów z publicznymi adresami IP).';

  @override
  String get dnsServerSettings => 'Ustawienia serwera DNS AdGuard Home';

  @override
  String get limitRequestsSecond => 'Limit szybkości na sekundę';

  @override
  String get valueNotNumber => 'Wartość nie jest liczbą';

  @override
  String get enableEdns => 'Włączanie podsieci klienta EDNS';

  @override
  String get enableEdnsDescription =>
      'Dodaj opcję podsieci klienta EDNS (ECS) do żądań nadrzędnych i rejestruj wartości wysyłane przez klientów w dzienniku zapytań.';

  @override
  String get enableDnssec => 'Włącz usługę DNSSEC';

  @override
  String get enableDnssecDescription =>
      'Ustaw flagę DNSSEC w wychodzących zapytaniach DNS i sprawdź wynik (wymagany jest moduł rozpoznawania nazw obsługujący DNSSEC).';

  @override
  String get disableResolvingIpv6 => 'Wyłączanie rozpoznawania adresów IPv6';

  @override
  String get disableResolvingIpv6Description =>
      'Usuń wszystkie zapytania DNS dotyczące adresów IPv6 (typ AAAA).';

  @override
  String get blockingMode => 'Tryb blokowania';

  @override
  String get defaultMode => 'Domyślny';

  @override
  String get defaultDescription =>
      'Odpowiedz zerowym adresem IP (0.0.0.0 dla A; :: dla AAAA), gdy zostanie zablokowany przez regułę w stylu Adblock; odpowiedz adresem IP określonym w regule, jeśli zostanie zablokowany przez regułę w stylu /etc/hosts';

  @override
  String get refusedDescription => 'Odpowiedz kodem REFUSED';

  @override
  String get nxdomainDescription => 'Odpowiadanie za pomocą kodu NXDOMAIN';

  @override
  String get nullIp => 'Null IP';

  @override
  String get nullIpDescription =>
      'Odpowiedz, podając zerowy adres IP (0.0.0.0 dla A; :: dla AAAA)';

  @override
  String get customIp => 'Niestandardowy adres IP';

  @override
  String get customIpDescription =>
      'Odpowiadanie przy użyciu ręcznie ustawionego adresu IP';

  @override
  String get dnsCacheConfig => 'Konfiguracja pamięci podręcznej DNS';

  @override
  String get cacheSize => 'Rozmiar pamięci podręcznej';

  @override
  String get inBytes => 'W bajtach';

  @override
  String get overrideMinimumTtl => 'Zastąp minimalny czas TTL';

  @override
  String get overrideMinimumTtlDescription =>
      'Wydłużanie wartości krótkiego czasu wygaśnięcia (sekund) odbieranych z serwera nadrzędnego podczas buforowania odpowiedzi DNS.';

  @override
  String get overrideMaximumTtl => 'Zastąp maksymalne ustawienie TTL';

  @override
  String get overrideMaximumTtlDescription =>
      'Ustaw maksymalną wartość czasu wygaśnięcia (sekundy) dla wpisów w pamięci podręcznej DNS.';

  @override
  String get optimisticCaching => 'Optymistyczne buforowanie';

  @override
  String get optimisticCachingDescription =>
      'Spraw, aby AdGuard Home odpowiadał z pamięci podręcznej, nawet gdy wpisy wygasły, a także spróbuj je odświeżyć.';

  @override
  String get loadingDnsConfig => 'Ładowanie konfiguracji DNS...';

  @override
  String get dnsConfigNotLoaded => 'Nie można załadować konfiguracji DNS.';

  @override
  String get blockingIpv4 => 'Blokowanie protokołu IPv4';

  @override
  String get blockingIpv4Description =>
      'Adres IP do zwrócenia w przypadku zablokowanego żądania A';

  @override
  String get blockingIpv6 => 'Blokowanie protokołu IPv6';

  @override
  String get blockingIpv6Description =>
      'Adres IP, który ma zostać zwrócony w przypadku zablokowanego żądania AAAA';

  @override
  String get invalidIp => 'Nieprawidłowy adres IP';

  @override
  String get dnsConfigSaved => 'Konfiguracja serwera DNS zapisana pomyślnie';

  @override
  String get dnsConfigNotSaved => 'Nie można zapisać konfiguracji serwera DNS';

  @override
  String get savingConfig => 'Zapisywanie konfiguracji...';

  @override
  String get someValueNotValid => 'Niektóre wartości są nieprawidłowe';

  @override
  String get upstreamDnsDescription =>
      'Konfigurowanie serwerów nadrzędnych i trybu DNS';

  @override
  String get bootstrapDnsDescription =>
      'Konfigurowanie serwerów DNS ładowania początkowego';

  @override
  String get privateReverseDnsDescription =>
      'Konfigurowanie niestandardowych programów rozpoznawania nazw DNS i włączanie prywatnego rozpoznawania zwrotnej domeny DNS';

  @override
  String get dnsServerSettingsDescription =>
      'Konfigurowanie limitu szybkości, trybu blokowania i innych funkcji';

  @override
  String get dnsCacheConfigDescription =>
      'Konfigurowanie sposobu zarządzania pamięcią podręczną DNS przez serwer';

  @override
  String get comment => 'Komentarz';

  @override
  String get address => 'Adres';

  @override
  String get commentsDescription =>
      'Komentarze są zawsze poprzedzone znakiem #. Nie musisz go dodawać, zostanie dodany automatycznie.';

  @override
  String get encryptionSettings => 'Ustawienia szyfrowania';

  @override
  String get encryptionSettingsDescription =>
      'Obsługa szyfrowania (HTTPS/QUIC/TLS)';

  @override
  String get loadingEncryptionSettings => 'Ładowanie ustawień szyfrowania...';

  @override
  String get encryptionSettingsNotLoaded =>
      'Nie można załadować ustawień szyfrowania.';

  @override
  String get enableEncryption => 'Włącz szyfrowanie';

  @override
  String get enableEncryptionTypes => 'HTTPS, DNS przez HTTPS i DNS przez TLS';

  @override
  String get enableEncryptionDescription =>
      'Jeśli szyfrowanie jest włączone, interfejs administratora AdGuard Home będzie działał przez HTTPS, a serwer DNS będzie nasłuchiwał żądań przez DNS przez HTTPS i DNS przez TLS.';

  @override
  String get serverConfiguration => 'Konfiguracja serwera';

  @override
  String get domainName => 'Nazwa domeny';

  @override
  String get domainNameDescription =>
      'Jeśli jest ustawiony, AdGuard Home wykrywa identyfikatory klientów, odpowiada na zapytania DDR i wykonuje dodatkowe walidacje połączeń. Jeśli te funkcje nie są ustawione, są wyłączone. Musi być zgodna z jedną z nazw DNS w certyfikacie.';

  @override
  String get redirectHttps =>
      'Automatyczne przekierowywanie do protokołu HTTPS';

  @override
  String get httpsPort => 'Port HTTPS';

  @override
  String get tlsPort => 'DNS przez port TLS';

  @override
  String get dnsOverQuicPort => 'DNS przez port QUIC';

  @override
  String get certificates => 'Certifikaty';

  @override
  String get certificatesDescription =>
      'Aby korzystać z szyfrowania, musisz podać prawidłowy łańcuch certyfikatów SSL dla swojej domeny. Możesz uzyskać bezpłatny certyfikat na letsencrypt.org lub kupić go w jednym z zaufanych urzędów certyfikacji.';

  @override
  String get certificateFilePath => 'Ustaw ścieżkę pliku certyfikatów';

  @override
  String get pasteCertificateContent => 'Wklejanie zawartości certyfikatów';

  @override
  String get certificatePath => 'Ścieżka certyfikatu';

  @override
  String get certificateContent => 'Zawartość certyfikatu';

  @override
  String get privateKey => 'Klucz prywatny';

  @override
  String get privateKeyFile => 'Ustaw plik klucza prywatnego';

  @override
  String get pastePrivateKey => 'Wklejanie zawartości klucza prywatnego';

  @override
  String get usePreviousKey => 'Użyj wcześniej zapisanego klucza';

  @override
  String get privateKeyPath => 'Ścieżka klucza prywatnego';

  @override
  String get invalidCertificate => 'Nieprawidłowy certyfikat';

  @override
  String get invalidPrivateKey => 'Nieprawidłowy klucz prywatny';

  @override
  String get validatingData => 'Sprawdzanie poprawności danych';

  @override
  String get dataValid => 'Dane prawidłowe';

  @override
  String get dataNotValid => 'Dane nieprawidłowe';

  @override
  String get encryptionConfigSaved =>
      'Konfiguracja szyfrowania zapisana pomyślnie';

  @override
  String get encryptionConfigNotSaved =>
      'Nie można zapisać konfiguracji szyfrowania';

  @override
  String get configError => 'Błąd konfiguracji';

  @override
  String get enterOnlyCertificate =>
      'Wprowadź tylko certyfikat. Nie wpisuj linii ---BEGIN--- i ---END---.';

  @override
  String get enterOnlyPrivateKey =>
      'Wprowadź tylko klucz. Nie wpisuj linii ---BEGIN--- i ---END---.';

  @override
  String get noItemsSearch => 'Brak elementów dla tego wyszukiwania.';

  @override
  String get clearSearch => 'Wyczyść wyszukiwanie';

  @override
  String get exitSearch => 'Zakończ wyszukiwanie';

  @override
  String get searchClients => 'Wyszukaj klientów';

  @override
  String get noClientsSearch => 'Brak klientów dla tego wyszukiwania.';

  @override
  String get customization => 'Personalizacja';

  @override
  String get customizationDescription => 'Dostosuj tę aplikację';

  @override
  String get color => 'Kolor';

  @override
  String get useDynamicTheme => 'Użyj motywu dynamicznego';

  @override
  String get red => 'Czerwony';

  @override
  String get green => 'Zielony';

  @override
  String get blue => 'Niebieski';

  @override
  String get yellow => 'Żółty';

  @override
  String get orange => 'Pomarańczowy';

  @override
  String get brown => 'Brązowy';

  @override
  String get cyan => 'Błękitny';

  @override
  String get purple => 'Fioletowy';

  @override
  String get pink => 'Różowy';

  @override
  String get deepOrange => 'Głęboki pomarańczowy';

  @override
  String get indigo => 'Indygo';

  @override
  String get useThemeColorStatus => 'Użyj koloru motywu dla statusu';

  @override
  String get useThemeColorStatusDescription =>
      'Zastępuje zielone i czerwone kolory statusu kolorami motywu i szarością';

  @override
  String get invalidCertificateChain => 'Nieprawidłowy łańcuch certyfikatów';

  @override
  String get validCertificateChain => 'Prawidłowy łańcuch certyfikatów';

  @override
  String get subject => 'Temat';

  @override
  String get issuer => 'Wydawca';

  @override
  String get expires => 'Wygasa';

  @override
  String get validPrivateKey => 'Prawidłowy klucz prywatny';

  @override
  String get expirationDate => 'Data ważności';

  @override
  String get keysNotMatch =>
      'Nieprawidłowy certyfikat lub klucz: TLS: klucz prywatny nie jest zgodny z kluczem publicznym';

  @override
  String get timeLogs => 'Czas w dziennikach logów';

  @override
  String get timeLogsDescription =>
      'Pokaż czas przetwarzania na liście dzienników logów';

  @override
  String get hostNames => 'Nazwy hostów';

  @override
  String get keyType => 'Typ klucza';

  @override
  String get updateAvailable => 'Dostępna aktualizacja';

  @override
  String get installedVersion => 'Zainstalowana wersja';

  @override
  String get newVersion => 'Nowa wersja';

  @override
  String get source => 'Źródło';

  @override
  String get downloadUpdate => 'Pobierz aktualizację';

  @override
  String get download => 'Pobierz';

  @override
  String get doNotRememberAgainUpdate => 'Nie pamiętam ponownie dla tej wersji';

  @override
  String get downloadingUpdate => 'Pobieranie aktualizacji';

  @override
  String get completed => 'ukończone';

  @override
  String get permissionNotGranted => 'Pozwolenie nie zostało udzielone';

  @override
  String get inputSearchTerm => 'Wprowadź wyszukiwany termin.';

  @override
  String get answers => 'Odpowiedzi';

  @override
  String get copyClipboard => 'Kopiuj do schowka';

  @override
  String get domainCopiedClipboard => 'Domena skopiowana do schowka';

  @override
  String get clearDnsCache => 'Wyczyść pamięć podręczną DNS';

  @override
  String get clearDnsCacheMessage =>
      'Czy na pewno chcesz wyczyścić pamięć podręczną DNS?';

  @override
  String get dnsCacheCleared =>
      'Pamięć podręczna DNS została pomyślnie wyczyszczona';

  @override
  String get clearingDnsCache => 'Czyszczenie pamięci podręcznej...';

  @override
  String get dnsCacheNotCleared => 'Nie można wyczyścić pamięci podręcznej DNS';

  @override
  String get clientsSelected => 'Wybrani klienci';

  @override
  String get invalidDomain => 'Nieprawidłowa domena';

  @override
  String get loadingBlockedServicesList =>
      'Ładowanie listy zablokowanych usług...';

  @override
  String get blockedServicesListNotLoaded =>
      'Nie można załadować listy zablokowanych usług';

  @override
  String get error => 'Błąd';

  @override
  String get updates => 'Aktualizacje';

  @override
  String get updatesDescription => 'Zaktualizuj serwer AdGuard Home';

  @override
  String get updateNow => 'Aktualizuj teraz';

  @override
  String get currentVersion => 'Aktualna wersja';

  @override
  String get requestStartUpdateFailed =>
      'Żądanie rozpoczęcia aktualizacji nie powiodło się';

  @override
  String get requestStartUpdateSuccessful =>
      'Żądanie rozpoczęcia aktualizacji powiodło się';

  @override
  String get serverUpdated => 'Serwer jest aktualizowany';

  @override
  String get unknownStatus => 'Status nieznany';

  @override
  String get checkingUpdates => 'Sprawdzanie aktualizacji...';

  @override
  String get checkUpdates => 'Sprawdź aktualizacje';

  @override
  String get requestingUpdate => 'Żądanie aktualizacji...';

  @override
  String get autoupdateUnavailable =>
      'Automatyczna aktualizacja jest niedostępna';

  @override
  String get autoupdateUnavailableDescription =>
      'Usługa automatycznej aktualizacji nie jest dostępna dla tego serwera. Może to być spowodowane tym, że serwer działa w kontenerze Docker. Musisz zaktualizować serwer ręcznie.';

  @override
  String minute(Object time) {
    return '$time minut';
  }

  @override
  String minutes(Object time) {
    return '$time minut';
  }

  @override
  String hour(Object time) {
    return '$time godzina';
  }

  @override
  String hours(Object time) {
    return '$time godzin';
  }

  @override
  String get remainingTime => 'Pozostały czas';

  @override
  String get safeSearchSettings => 'Ustawienia bezpiecznego wyszukiwania';

  @override
  String get loadingSafeSearchSettings =>
      'Ładowanie ustawień bezpiecznego wyszukiwania...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Błąd podczas ładowania ustawień bezpiecznego wyszukiwania.';

  @override
  String get loadingLogsSettings => 'Ładowanie ustawień dzienników logów...';

  @override
  String get selectOptionLeftColumn => 'Wybierz opcję lewej kolumny';

  @override
  String get selectClientLeftColumn => 'Wybierz klienta z lewej kolumny';

  @override
  String get disableList => 'Wyłącz listę';

  @override
  String get enableList => 'Włącz listę';

  @override
  String get screens => 'Ekrany';

  @override
  String get copiedClipboard => 'Skopiowane do schowka';

  @override
  String get seeDetails => 'Zobacz szczegóły';

  @override
  String get listNotAvailable => 'Lista niedostępna';

  @override
  String get copyListUrl => 'Skopiuj adres URL listy';

  @override
  String get listUrlCopied => 'Adres URL listy skopiowany do schowka';

  @override
  String get unsupportedVersion => 'Nieobsługiwana wersja';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'Nie gwarantuje się wsparcia dla wersji serwera $version. Ta aplikacja może mieć pewne problemy z działaniem na tej wersji serwera.\n\nAdGuard Home Manager został zaprojektowany do współpracy ze stabilnymi wersjami serwera AdGuard Home. Może działać z wersjami alfa i beta, ale kompatybilność nie jest gwarantowana, a aplikacja może mieć pewne problemy z działaniem w tych wersjach.';
  }

  @override
  String get iUnderstand => 'Rozumiem';

  @override
  String get appUpdates => 'Aktualizacje aplikacji';

  @override
  String get usingLatestVersion => 'Używasz najnowszej wersji';

  @override
  String get ipLogs => 'IP w dziennikach logów';

  @override
  String get ipLogsDescription =>
      'Pokaż zawsze adres IP w dziennikach logów zamiast nazwy klienta';

  @override
  String get application => 'Aplikacja';

  @override
  String get combinedChart => 'Wykres łączony';

  @override
  String get combinedChartDescription => 'Połącz wszystkie wykresy w jeden';

  @override
  String get statistics => 'Statystyka';

  @override
  String get errorLoadFilters => 'Błąd podczas ładowania filtrów.';

  @override
  String get clientRemovedSuccessfully => 'Klient został pomyślnie usunięty.';

  @override
  String get editRewriteRule => 'Edytowanie reguły przepisywania';

  @override
  String get dnsRewriteRuleUpdated =>
      'Reguła przepisywania DNS została pomyślnie zaktualizowana';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'Nie można zaktualizować reguły przepisywania DNS';

  @override
  String get updatingRule => 'Aktualizuję regułę...';

  @override
  String get serverUpdateNeeded => 'Wymagana aktualizacja serwera';

  @override
  String updateYourServer(Object version) {
    return 'Aby móc korzystać z tej funkcji, zaktualizuj serwer AdGuard Home do wersji $version lub nowszej.';
  }

  @override
  String get january => 'Styczeń';

  @override
  String get february => 'Luty';

  @override
  String get march => 'Mrzec';

  @override
  String get april => 'Kwiecień';

  @override
  String get may => 'Maj';

  @override
  String get june => 'Czerwiec';

  @override
  String get july => 'Lipiec';

  @override
  String get august => 'Sierpień';

  @override
  String get september => 'Wrzesień';

  @override
  String get october => 'Październik';

  @override
  String get november => 'Listopad';

  @override
  String get december => 'Grudzień';

  @override
  String get malwarePhishing =>
      'Złośliwe oprogramowanie / wyłudzanie informacji';

  @override
  String get queries => 'Zapytania';

  @override
  String get adultSites => 'Strony dla dorosłych';

  @override
  String get quickFilters => 'Szybkie filtry';

  @override
  String get searchDomainInternet => 'Wyszukaj domenę w Internecie';

  @override
  String get hideServerAddress => 'Hide server address';

  @override
  String get hideServerAddressDescription =>
      'Hides the server address on the home screen';

  @override
  String get topItemsOrder => 'Top items order';

  @override
  String get topItemsOrderDescription =>
      'Order the home screen top items lists';

  @override
  String get topItemsReorderInfo => 'Hold and swipe an item to reorder it.';

  @override
  String get discardChanges => 'Discard changes';

  @override
  String get discardChangesDescription =>
      'Are you sure you want to discard the changes?';

  @override
  String get others => 'Others';

  @override
  String get showChart => 'Show chart';

  @override
  String get hideChart => 'Hide chart';

  @override
  String get showTopItemsChart => 'Show top items chart';

  @override
  String get showTopItemsChartDescription =>
      'Shows by default the ring chart on the top items sections. Only affects to the mobile view.';

  @override
  String get openMenu => 'Open menu';

  @override
  String get closeMenu => 'Close menu';

  @override
  String get openListUrl => 'Open list URL';

  @override
  String get selectionMode => 'Selection mode';

  @override
  String get enableDisableSelected => 'Enable or disable selected items';

  @override
  String get deleteSelected => 'Delete selected items';

  @override
  String get deleteSelectedLists => 'Delete selected lists';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'All selected lists have been deleted successfully.';

  @override
  String get deletionResult => 'Deletion result';

  @override
  String get deletingLists => 'Deleting lists...';

  @override
  String get failedElements => 'Failed elements';

  @override
  String get processingLists => 'Processing lists...';

  @override
  String get enableDisableResult => 'Enable or disable result';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'All selected lists have been enabled or disabled successfully';

  @override
  String get sslWarning =>
      'If you are using an HTTPS connection with a self signed certificate, make sure to enable \"Don\'t check SSL certificate\" at Settings > Advanced settings.';

  @override
  String get unsupportedServerVersion => 'Unsupported server version';

  @override
  String get unsupportedServerVersionMessage =>
      'Your AdGuard Home server version is too old and is not supported by AdGuard Home Manager. You will need to upgrade your AdGuard Home server to a newer version to use this application.';

  @override
  String yourVersion(Object version) {
    return 'Your version: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Minimum required version: $version';
  }

  @override
  String get topUpstreams => 'Top upstreams';

  @override
  String get averageUpstreamResponseTime => 'Average upstream response time';

  @override
  String get dhcpNotAvailable => 'The DHCP server is not available.';

  @override
  String get osServerInstalledIncompatible =>
      'The OS where the server is installed is not compatible with this feature.';

  @override
  String get resetSettings => 'Reset settings';

  @override
  String get resetEncryptionSettingsDescription =>
      'Are you sure you want to reset to default values the encryption settings?';

  @override
  String get resettingConfig => 'Resetting configuration...';

  @override
  String get configurationResetSuccessfully =>
      'Configuration resetted successfully';

  @override
  String get configurationResetError =>
      'The configuration couldn\'t be resetted';

  @override
  String get testUpstreamDnsServers => 'Test upstream DNS servers';

  @override
  String get errorTestUpstreamDns => 'Error when testing upstream DNS servers.';

  @override
  String get useCustomIpEdns => 'Use custom IP for EDNS';

  @override
  String get useCustomIpEdnsDescription => 'Allow to use custom IP for EDNS';

  @override
  String get sortingOptions => 'Sorting options';

  @override
  String get fromHighestToLowest => 'From highest to lowest';

  @override
  String get fromLowestToHighest => 'From lowest to highest';

  @override
  String get queryLogsAndStatistics => 'Query logs and statistics';

  @override
  String get ignoreClientQueryLog => 'Ignore this client in query log';

  @override
  String get ignoreClientStatistics => 'Ignore this client in statistics';

  @override
  String get savingChanges => 'Saving changes...';

  @override
  String get fallbackDnsServers => 'Fallback DNS servers';

  @override
  String get fallbackDnsServersDescription => 'Configure fallback DNS servers';

  @override
  String get fallbackDnsServersInfo =>
      'List of fallback DNS servers used when upstream DNS servers are not responding. The syntax is the same as in the main upstreams field above.';

  @override
  String get noFallbackDnsAdded => 'No fallback DNS servers added.';

  @override
  String get blockedResponseTtl => 'Blocked response TTL';

  @override
  String get blockedResponseTtlDescription =>
      'Specifies for how many seconds the clients should cache a filtered response';

  @override
  String get invalidValue => 'Invalid value';

  @override
  String get noDataChart => 'There\'s no data to display this chart.';

  @override
  String get noData => 'No data';

  @override
  String get unblockClient => 'Unblock client';

  @override
  String get blockingClient => 'Blocking client...';

  @override
  String get unblockingClient => 'Unblocking client...';

  @override
  String get upstreamDnsCacheConfiguration =>
      'DNS upstream cache configuration';

  @override
  String get enableDnsCachingClient => 'Enable DNS caching for this client';

  @override
  String get dnsCacheSize => 'DNS cache size';

  @override
  String get nameInvalid => 'Name is required';

  @override
  String get oneIdentifierRequired => 'At least one identifier is required';

  @override
  String get dnsCacheNumber => 'DNS cache size must be a number';

  @override
  String get errors => 'Errors';

  @override
  String get redirectHttpsWarning =>
      'If you have enabled \"Redirect to HTTPS automatically\" on your AdGuard Home server, you must select an HTTPS connection and use the HTTPS port of your server.';

  @override
  String get logsSettingsDescription => 'Configure query logs';

  @override
  String get ignoredDomains => 'Ignored domains';

  @override
  String get noIgnoredDomainsAdded => 'No domains to ignore added';

  @override
  String get pauseServiceBlocking => 'Pause service blocking';

  @override
  String get newSchedule => 'New schedule';

  @override
  String get editSchedule => 'Edit schedule';

  @override
  String get timezone => 'Timezone';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get selectStartTime => 'Select start time';

  @override
  String get selectEndTime => 'Select end time';

  @override
  String get startTimeBeforeEndTime => 'Start time must be before end time.';

  @override
  String get noBlockingScheduleThisDevice =>
      'There\'s no blocking schedule for this device.';

  @override
  String get selectTimezone => 'Select a timezone';

  @override
  String get selectClientsFiltersInfo =>
      'Select the clients you want to display. If no clients are selected, all will be displayed.';

  @override
  String get noDataThisSection => 'There\'s no data for this section.';

  @override
  String get statisticsSettings => 'Statistics settings';

  @override
  String get statisticsSettingsDescription =>
      'Configure data collection for statistics';

  @override
  String get loadingStatisticsSettings => 'Loading statistics settings...';

  @override
  String get statisticsSettingsLoadError =>
      'An error occured when loading statistics settings.';

  @override
  String get statisticsConfigUpdated =>
      'Statistics settings updated successfully';

  @override
  String get statisticsConfigNotUpdated =>
      'Statistics settings couldn\'t be updated';

  @override
  String get customTimeInHours => 'Custom time (in hours)';

  @override
  String get invalidTime => 'Invalid time';

  @override
  String get removeDomain => 'Remove domain';

  @override
  String get addDomain => 'Add domain';

  @override
  String get notLess1Hour => 'Time cannot be less than 1 hour';

  @override
  String get rateLimit => 'Rate limit';

  @override
  String get subnetPrefixLengthIpv4 => 'Subnet prefix length for IPv4';

  @override
  String get subnetPrefixLengthIpv6 => 'Subnet prefix length for IPv6';

  @override
  String get rateLimitAllowlist => 'Rate limit allowlist';

  @override
  String get rateLimitAllowlistDescription =>
      'IP addresses excluded from rate limiting';

  @override
  String get dnsOptions => 'DNS options';

  @override
  String get editor => 'Editor';

  @override
  String get editCustomRules => 'Edit custom rules';

  @override
  String get savingCustomRules => 'Saving custom rules...';

  @override
  String get customRulesUpdatedSuccessfully =>
      'Custom rules updated successfully';

  @override
  String get customRulesNotUpdated => 'Custom rules could not be updated';

  @override
  String get reorder => 'Reorder';

  @override
  String get showHide => 'Show/hide';

  @override
  String get noElementsReorderMessage =>
      'Enable some elements on the show/hide tab to reorder them here.';

  @override
  String get enablePlainDns => 'Enable plain DNS';

  @override
  String get enablePlainDnsDescription =>
      'Plain DNS is enabled by default. You can disable it to force all devices to use encrypted DNS. To do this, you must enable at least one encrypted DNS protocol.';

  @override
  String get date => 'Date';

  @override
  String get loadingChangelog => 'Loading changelog...';

  @override
  String get invalidIpOrUrl => 'Invalid IP address or URL';

  @override
  String get addPersistentClient => 'Add as a persistent client';

  @override
  String get blockThisClientOnly => 'Block for this client only';

  @override
  String get unblockThisClientOnly => 'Unblock for this client only';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain blocked for this client';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return '$domain unblocked for this client';
  }

  @override
  String get disallowThisClient => 'Disallow this client';

  @override
  String get allowThisClient => 'Allow this client';

  @override
  String get clientAllowedSuccessfully => 'Client allowed successfully';

  @override
  String get clientDisallowedSuccessfully => 'Client disallowed successfully';

  @override
  String get changesNotSaved => 'Changes could not be saved';

  @override
  String get allowingClient => 'Allowing client...';

  @override
  String get disallowingClient => 'Disallowing client...';

  @override
  String get clientIpCopied => 'Client IP copied to the clipboard';

  @override
  String get clientNameCopied => 'Client name copied to the clipboard';

  @override
  String get dnsServerAddressCopied =>
      'DNS server address copied to the clipboard';

  @override
  String get select => 'Select';

  @override
  String get liveLogs => 'Live logs';

  @override
  String get hereWillAppearRealtimeLogs =>
      'Here there will appear the logs on realtime.';

  @override
  String get applicationDetails => 'Application details';

  @override
  String get applicationDetailsDescription =>
      'App repository, stores where it\'s available, and more';

  @override
  String get myOtherApps => 'My other apps';

  @override
  String get myOtherAppsDescription =>
      'Check my other apps, make a donation, contact support, and more';

  @override
  String get topToBottom => 'From top to bottom';

  @override
  String get bottomToTop => 'From bottom to top';

  @override
  String get upstreamTimeout => 'Upstream timeout';

  @override
  String get upstreamTimeoutHelper =>
      'Specifies the number of seconds to wait for a response from the upstream server';

  @override
  String get fieldCannotBeEmpty => 'This field cannot be empty';
}
