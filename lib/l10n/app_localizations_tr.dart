// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get home => 'Ana Sayfa';

  @override
  String get settings => 'Ayarlar';

  @override
  String get connect => 'Bağlan';

  @override
  String get servers => 'Sunucular';

  @override
  String get createConnection => 'Bağlantı oluştur';

  @override
  String get editConnection => 'Bağlantıyı düzenle';

  @override
  String get name => 'Ad';

  @override
  String get ipDomain => 'IP adresi veya alan adı';

  @override
  String get path => 'Yol';

  @override
  String get port => 'Port';

  @override
  String get username => 'Kullanıcı adı';

  @override
  String get password => 'Parola';

  @override
  String get defaultServer => 'Varsayılan sunucu';

  @override
  String get general => 'Genel';

  @override
  String get connection => 'Bağlantı';

  @override
  String get authentication => 'Kimlik doğrulama';

  @override
  String get other => 'Diğer';

  @override
  String get invalidPort => 'Geçersiz port';

  @override
  String get invalidPath => 'Geçersiz yol';

  @override
  String get invalidIpDomain => 'Geçersiz IP adresi veya alan adı';

  @override
  String get ipDomainNotEmpty => 'IP adresi veya alan adı boş bırakılamaz';

  @override
  String get nameNotEmpty => 'Ad alanı boş bırakılamaz';

  @override
  String get invalidUsernamePassword => 'Kullanıcı adı veya parola hatalı';

  @override
  String get tooManyAttempts =>
      'Çok fazla deneme yaptınız. Birazdan tekrar deneyin.';

  @override
  String get cantReachServer =>
      'Sunucuya ulaşılamıyor. Bağlantı bilgilerini kontrol edin.';

  @override
  String get sslError =>
      'El sıkışma hatası. Sunucuyla güvenli bağlantı kurulamıyor; sorun SSL kaynaklı olabilir. Ayarlar > Gelişmiş ayarlar bölümünden \"SSL sertifikasını kontrol etme\" seçeneğini etkinleştirin.';

  @override
  String get unknownError => 'Bilinmeyen hata';

  @override
  String get connectionNotCreated => 'Bağlantı oluşturulamadı';

  @override
  String get connecting => 'Bağlanılıyor...';

  @override
  String get connected => 'Bağlandı';

  @override
  String get selectedDisconnected => 'Seçili ancak bağlantı yok';

  @override
  String get connectionDefaultSuccessfully =>
      'Bağlantı varsayılan olarak ayarlandı.';

  @override
  String get connectionDefaultFailed =>
      'Bağlantı varsayılan olarak ayarlanamadı.';

  @override
  String get noSavedConnections => 'Kayıtlı bağlantı yok';

  @override
  String get cannotConnect => 'Sunucuya bağlanılamıyor';

  @override
  String get connectionRemoved => 'Bağlantı kaldırıldı';

  @override
  String get connectionCannotBeRemoved => 'Bağlantı kaldırılamadı.';

  @override
  String get remove => 'Kaldır';

  @override
  String get removeWarning =>
      'Bu AdGuard Home sunucusuyla olan bağlantıyı kaldırmak istediğinize emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get defaultConnection => 'Varsayılan bağlantı';

  @override
  String get setDefault => 'Varsayılan yap';

  @override
  String get edit => 'Düzenle';

  @override
  String get delete => 'Sil';

  @override
  String get save => 'Kaydet';

  @override
  String get serverStatus => 'Sunucu durumu';

  @override
  String get connectionNotUpdated => 'Bağlantı güncellenemedi';

  @override
  String get ruleFilteringWidget => 'Kural filtreleme';

  @override
  String get safeBrowsingWidget => 'Güvenli gezinme';

  @override
  String get parentalFilteringWidget => 'Ebeveyn denetimi';

  @override
  String get safeSearchWidget => 'Güvenli arama';

  @override
  String get ruleFiltering => 'Kural filtreleme';

  @override
  String get safeBrowsing => 'Güvenli gezinme';

  @override
  String get parentalFiltering => 'Ebeveyn denetimi';

  @override
  String get safeSearch => 'Güvenli arama';

  @override
  String get serverStatusNotRefreshed => 'Sunucu durumu yenilenemedi';

  @override
  String get loadingStatus => 'Durum yükleniyor...';

  @override
  String get errorLoadServerStatus => 'Sunucu durumu yüklenemedi';

  @override
  String get topQueriedDomains => 'Sorgulanan alan adları';

  @override
  String get viewMore => 'Tümünü gör';

  @override
  String get topClients => 'İstemciler';

  @override
  String get topBlockedDomains => 'Engellenen alan adları';

  @override
  String get appSettings => 'Uygulama ayarları';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get systemDefined => 'Sistem varsayılanı';

  @override
  String get close => 'Kapat';

  @override
  String get connectedTo => 'Bağlı sunucu:';

  @override
  String get selectedServer => 'Seçili sunucu:';

  @override
  String get noServerSelected => 'Seçili sunucu yok';

  @override
  String get manageServer => 'Sunucuyu yönet';

  @override
  String get allProtections => 'Tüm korumalar';

  @override
  String get userNotEmpty => 'Kullanıcı adı boş bırakılamaz';

  @override
  String get passwordNotEmpty => 'Parola boş bırakılamaz';

  @override
  String get examplePath => 'Örnek: /adguard';

  @override
  String get helperPath => 'Ters vekil sunucu (reverse proxy) kullanıyorsanız';

  @override
  String get aboutApp => 'Uygulama hakkında';

  @override
  String get appVersion => 'Uygulama sürümü';

  @override
  String get createdBy => 'Geliştirici';

  @override
  String get clients => 'İstemciler';

  @override
  String get allowed => 'İzin verilenler';

  @override
  String get blocked => 'Engellenenler';

  @override
  String get noClientsList => 'Bu listede henüz istemci yok';

  @override
  String get activeClients => 'Etkin';

  @override
  String get removeClient => 'İstemciyi kaldır';

  @override
  String get removeClientMessage =>
      'Bu istemciyi listeden kaldırmak istediğinize emin misiniz?';

  @override
  String get confirm => 'Onayla';

  @override
  String get removingClient => 'İstemci kaldırılıyor...';

  @override
  String get clientNotRemoved => 'İstemci listeden kaldırılamadı';

  @override
  String get addClient => 'İstemci ekle';

  @override
  String get list => 'Liste';

  @override
  String get ipAddress => 'IP adresi';

  @override
  String get ipNotValid => 'Geçersiz IP adresi';

  @override
  String get clientAddedSuccessfully => 'İstemci listeye eklendi';

  @override
  String get addingClient => 'İstemci ekleniyor...';

  @override
  String get clientNotAdded => 'İstemci listeye eklenemedi';

  @override
  String get clientAnotherList => 'Bu istemci zaten başka bir listede';

  @override
  String get noSavedLogs => 'Kayıtlı günlük yok';

  @override
  String get logs => 'Günlükler';

  @override
  String get copyLogsClipboard => 'Günlükleri panoya kopyala';

  @override
  String get logsCopiedClipboard => 'Günlükler panoya kopyalandı';

  @override
  String get advancedSettings => 'Gelişmiş ayarlar';

  @override
  String get dontCheckCertificate => 'SSL sertifikasını kontrol etme';

  @override
  String get dontCheckCertificateDescription =>
      'Sunucunun SSL sertifika doğrulamasını devre dışı bırakır';

  @override
  String get advancedSetupDescription => 'Gelişmiş seçenekler';

  @override
  String get settingsUpdatedSuccessfully => 'Ayarlar güncellendi.';

  @override
  String get cannotUpdateSettings => 'Ayarlar güncellenemedi.';

  @override
  String get restartAppTakeEffect => 'Uygulamayı yeniden başlatın';

  @override
  String get loadingLogs => 'Günlükler yükleniyor...';

  @override
  String get logsNotLoaded => 'Günlük listesi yüklenemedi';

  @override
  String get processed => 'İşlendi\nListe dışı';

  @override
  String get processedRow => 'İşlendi (liste dışı)';

  @override
  String get blockedBlacklist => 'Engellendi\nKara liste';

  @override
  String get blockedBlacklistRow => 'Engellendi (kara liste)';

  @override
  String get blockedSafeBrowsing => 'Engellendi\nGüvenli gezinme';

  @override
  String get blockedSafeBrowsingRow => 'Engellendi (güvenli gezinme)';

  @override
  String get blockedParental => 'Engellendi\nEbeveyn denetimi';

  @override
  String get blockedParentalRow => 'Engellendi (ebeveyn denetimi)';

  @override
  String get blockedInvalid => 'Engellendi\nGeçersiz';

  @override
  String get blockedInvalidRow => 'Engellendi (geçersiz)';

  @override
  String get blockedSafeSearch => 'Engellendi\nGüvenli arama';

  @override
  String get blockedSafeSearchRow => 'Engellendi (güvenli arama)';

  @override
  String get blockedService => 'Engellendi\nHizmet engeli';

  @override
  String get blockedServiceRow => 'Engellendi (hizmet engeli)';

  @override
  String get processedWhitelist => 'İşlendi\nBeyaz liste';

  @override
  String get processedWhitelistRow => 'İşlendi (beyaz liste)';

  @override
  String get processedError => 'İşlendi\nHata';

  @override
  String get processedErrorRow => 'İşlendi (hata)';

  @override
  String get rewrite => 'Yeniden yazım';

  @override
  String get status => 'Durum';

  @override
  String get result => 'Sonuç';

  @override
  String get time => 'Zaman';

  @override
  String get blocklist => 'Engelleme listesi';

  @override
  String get request => 'İstek';

  @override
  String get domain => 'Alan adı';

  @override
  String get type => 'Tür';

  @override
  String get clas => 'Sınıf';

  @override
  String get response => 'Yanıt';

  @override
  String get dnsServer => 'DNS sunucusu';

  @override
  String get elapsedTime => 'Geçen süre';

  @override
  String get responseCode => 'Yanıt kodu';

  @override
  String get client => 'İstemci';

  @override
  String get deviceIp => 'IP adresi';

  @override
  String get deviceName => 'Ad';

  @override
  String get logDetails => 'Günlük ayrıntıları';

  @override
  String get blockingRule => 'Engelleme kuralı';

  @override
  String get blockDomain => 'Alan adını engelle';

  @override
  String get couldntGetFilteringStatus => 'Filtreleme durumu alınamadı';

  @override
  String get unblockDomain => 'Alan adı engelini kaldır';

  @override
  String get userFilteringRulesNotUpdated =>
      'Kullanıcı filtreleme kuralları güncellenemedi';

  @override
  String get userFilteringRulesUpdated =>
      'Kullanıcı filtreleme kuralları güncellendi';

  @override
  String get savingUserFilters => 'Kullanıcı filtreleri kaydediliyor...';

  @override
  String get filters => 'Filtreler';

  @override
  String get logsOlderThan => 'Şu zamandan eski günlükler';

  @override
  String get responseStatus => 'Yanıt durumu';

  @override
  String get selectTime => 'Zaman seçin';

  @override
  String get notSelected => 'Seçilmedi';

  @override
  String get resetFilters => 'Filtreleri sıfırla';

  @override
  String get noLogsDisplay => 'Gösterilecek günlük yok';

  @override
  String get noLogsThatOld =>
      'Seçtiğiniz zamana ait kayıtlı günlük kalmamış olabilir. Daha yakın bir zaman seçmeyi deneyin.';

  @override
  String get apply => 'Uygula';

  @override
  String get selectAll => 'Tümünü seç';

  @override
  String get unselectAll => 'Seçimi kaldır';

  @override
  String get all => 'Tümü';

  @override
  String get filtered => 'Filtrelenenler';

  @override
  String get checkAppLogs => 'Uygulama günlüklerini incele';

  @override
  String get refresh => 'Yenile';

  @override
  String get search => 'Ara';

  @override
  String get dnsQueries => 'DNS sorguları';

  @override
  String get average => 'Ortalama';

  @override
  String get blockedFilters => 'Filtrelerce engellenen';

  @override
  String get malwarePhishingBlocked => 'Engellenen zararlı/oltalama';

  @override
  String get blockedAdultWebsites => 'Engellenen yetişkin siteleri';

  @override
  String get generalSettings => 'Genel ayarlar';

  @override
  String get generalSettingsDescription => 'Uygulamaya dair genel ayarlar';

  @override
  String get hideZeroValues => 'Sıfır değerleri gizle';

  @override
  String get hideZeroValuesDescription =>
      'Ana ekranda değeri sıfır olan kutucukları gizler';

  @override
  String get webAdminPanel => 'Web yönetim paneli';

  @override
  String get visitGooglePlay => 'Google Play sayfasına git';

  @override
  String get gitHub => 'Kaynak kodları GitHub\'da';

  @override
  String get blockClient => 'İstemciyi engelle';

  @override
  String get selectTags => 'Etiket seç';

  @override
  String get noTagsSelected => 'Etiket seçilmedi';

  @override
  String get tags => 'Etiketler';

  @override
  String get identifiers => 'Tanımlayıcılar';

  @override
  String get identifier => 'Tanımlayıcı';

  @override
  String get identifierHelper => 'IP adresi, CIDR, MAC adresi veya ClientID';

  @override
  String get noIdentifiers => 'Henüz tanımlayıcı eklenmedi';

  @override
  String get useGlobalSettings => 'Genel ayarları kullan';

  @override
  String get enableFiltering => 'Filtrelemeyi etkinleştir';

  @override
  String get enableSafeBrowsing => 'Güvenli gezinmeyi etkinleştir';

  @override
  String get enableParentalControl => 'Ebeveyn denetimini etkinleştir';

  @override
  String get enableSafeSearch => 'Güvenli aramayı etkinleştir';

  @override
  String get blockedServices => 'Engellenen hizmetler';

  @override
  String get selectBlockedServices => 'Engellenecek hizmetleri seçin';

  @override
  String get noBlockedServicesSelected => 'Engellenen hizmet yok';

  @override
  String get services => 'Hizmetler';

  @override
  String get servicesBlocked => 'hizmet engellendi';

  @override
  String get tagsSelected => 'etiket seçildi';

  @override
  String get upstreamServers => 'Üst DNS sunucuları';

  @override
  String get serverAddress => 'Sunucu adresi';

  @override
  String get noUpstreamServers => 'Üst DNS sunucusu yok.';

  @override
  String get willBeUsedGeneralServers =>
      'Genel üst DNS sunucuları kullanılacak.';

  @override
  String get added => 'Eklendi';

  @override
  String get clientUpdatedSuccessfully => 'İstemci güncellendi';

  @override
  String get clientNotUpdated => 'İstemci güncellenemedi';

  @override
  String get clientDeletedSuccessfully => 'İstemci silindi';

  @override
  String get clientNotDeleted => 'İstemci silinemedi';

  @override
  String get options => 'Seçenekler';

  @override
  String get loadingFilters => 'Filtreler yükleniyor...';

  @override
  String get filtersNotLoaded => 'Filtreler yüklenemedi.';

  @override
  String get whitelists => 'Beyaz listeler';

  @override
  String get blacklists => 'Kara listeler';

  @override
  String get rules => 'Kurallar';

  @override
  String get customRules => 'Özel kurallar';

  @override
  String get enabledRules => 'Etkin kurallar';

  @override
  String get enabled => 'Etkin';

  @override
  String get disabled => 'Devre dışı';

  @override
  String get rule => 'Kural';

  @override
  String get addCustomRule => 'Özel kural ekle';

  @override
  String get removeCustomRule => 'Özel kuralı kaldır';

  @override
  String get removeCustomRuleMessage =>
      'Bu özel kuralı kaldırmak istediğinize emin misiniz?';

  @override
  String get updatingRules => 'Özel kurallar güncelleniyor...';

  @override
  String get ruleRemovedSuccessfully => 'Kural kaldırıldı';

  @override
  String get ruleNotRemoved => 'Kural kaldırılamadı';

  @override
  String get ruleAddedSuccessfully => 'Kural eklendi';

  @override
  String get ruleNotAdded => 'Kural eklenemedi';

  @override
  String get noCustomFilters => 'Özel filtre yok';

  @override
  String get noBlockedClients => 'Engellenen istemci yok';

  @override
  String get noBlackLists => 'Kara liste yok';

  @override
  String get noWhiteLists => 'Beyaz liste yok';

  @override
  String get addWhitelist => 'Beyaz liste ekle';

  @override
  String get addBlacklist => 'Kara liste ekle';

  @override
  String get urlNotValid => 'Geçersiz URL';

  @override
  String get urlAbsolutePath => 'URL veya tam dosya yolu';

  @override
  String get addingList => 'Liste ekleniyor...';

  @override
  String get listAdded => 'Liste eklendi. Eklenen öğe sayısı:';

  @override
  String get listAlreadyAdded => 'Bu liste zaten ekli';

  @override
  String get listUrlInvalid => 'Liste URL\'si geçersiz';

  @override
  String get listNotAdded => 'Liste eklenemedi';

  @override
  String get listDetails => 'Liste ayrıntıları';

  @override
  String get listType => 'Liste türü';

  @override
  String get whitelist => 'Beyaz liste';

  @override
  String get blacklist => 'Kara liste';

  @override
  String get latestUpdate => 'Son güncelleme';

  @override
  String get disable => 'Devre dışı bırak';

  @override
  String get enable => 'Etkinleştir';

  @override
  String get currentStatus => 'Geçerli durum';

  @override
  String get listDataUpdated => 'Liste bilgileri güncellendi';

  @override
  String get listDataNotUpdated => 'Liste bilgileri güncellenemedi';

  @override
  String get updatingListData => 'Liste bilgileri güncelleniyor...';

  @override
  String get editWhitelist => 'Beyaz listeyi düzenle';

  @override
  String get editBlacklist => 'Kara listeyi düzenle';

  @override
  String get deletingList => 'Liste siliniyor...';

  @override
  String get listDeleted => 'Liste silindi';

  @override
  String get listNotDeleted => 'Liste silinemedi';

  @override
  String get deleteList => 'Listeyi sil';

  @override
  String get deleteListMessage =>
      'Bu listeyi silmek istediğinize emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get serverSettings => 'Sunucu ayarları';

  @override
  String get serverInformation => 'Sunucu bilgileri';

  @override
  String get serverInformationDescription => 'Sunucu durumu ve ayrıntıları';

  @override
  String get loadingServerInfo => 'Sunucu bilgileri yükleniyor...';

  @override
  String get serverInfoNotLoaded => 'Sunucu bilgileri yüklenemedi.';

  @override
  String get dnsAddresses => 'DNS adresleri';

  @override
  String get seeDnsAddresses => 'DNS adreslerini gör';

  @override
  String get dnsPort => 'DNS portu';

  @override
  String get httpPort => 'HTTP portu';

  @override
  String get protectionEnabled => 'Koruma etkin';

  @override
  String get dhcpAvailable => 'DHCP kullanılabilir';

  @override
  String get serverRunning => 'Sunucu çalışıyor';

  @override
  String get serverVersion => 'Sunucu sürümü';

  @override
  String get serverLanguage => 'Sunucu dili';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get allowedClients => 'İzin verilen istemciler';

  @override
  String get disallowedClients => 'İzin verilmeyen istemciler';

  @override
  String get disallowedDomains => 'İzin verilmeyen alan adları';

  @override
  String get accessSettings => 'Erişim ayarları';

  @override
  String get accessSettingsDescription =>
      'Sunucu için erişim kurallarını belirleyin';

  @override
  String get loadingClients => 'İstemciler yükleniyor...';

  @override
  String get clientsNotLoaded => 'İstemciler yüklenemedi.';

  @override
  String get noAllowedClients => 'İzin verilen istemci yok';

  @override
  String get allowedClientsDescription =>
      'Bu listede kayıt varsa AdGuard Home yalnızca bu istemcilerden gelen istekleri kabul eder.';

  @override
  String get blockedClientsDescription =>
      'Bu listede kayıt varsa AdGuard Home bu istemcilerden gelen istekleri yoksayar. \"İzin verilen istemciler\" listesi doluysa bu alan dikkate alınmaz.';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home bu alan adlarıyla eşleşen DNS sorgularını doğrudan düşürür; bu sorgular günlüklerde bile görünmez.';

  @override
  String get addClientFieldDescription => 'CIDR, IP adresi veya ClientID';

  @override
  String get clientIdentifier => 'İstemci tanımlayıcısı';

  @override
  String get allowClient => 'İstemciye izin ver';

  @override
  String get disallowClient => 'İstemciye izin verme';

  @override
  String get noDisallowedDomains => 'İzin verilmeyen alan adı yok';

  @override
  String get domainNotAdded => 'Alan adı eklenemedi';

  @override
  String get statusSelected => 'durum seçildi';

  @override
  String get updateLists => 'Listeleri güncelle';

  @override
  String get checkHostFiltered => 'Alan adını kontrol et';

  @override
  String get updatingLists => 'Listeler güncelleniyor...';

  @override
  String get listsUpdated => 'liste güncellendi';

  @override
  String get listsNotUpdated => 'Listeler güncellenemedi';

  @override
  String get listsNotLoaded => 'Listeler yüklenemedi';

  @override
  String get domainNotValid => 'Geçersiz alan adı';

  @override
  String get check => 'Kontrol et';

  @override
  String get checkingHost => 'Kontrol ediliyor...';

  @override
  String get errorCheckingHost => 'Alan adı kontrol edilemedi';

  @override
  String get block => 'Engelle';

  @override
  String get unblock => 'Engeli kaldır';

  @override
  String get custom => 'Özel';

  @override
  String get addImportant => '\$important ekle';

  @override
  String get howCreateRules => 'Özel kurallar nasıl oluşturulur?';

  @override
  String get examples => 'Örnekler';

  @override
  String get example1 =>
      'example.org ve tüm alt alan adlarına erişimi engeller.';

  @override
  String get example2 =>
      'example.org ve tüm alt alan adlarına erişim engelini kaldırır.';

  @override
  String get example3 => 'Yorum satırı ekler.';

  @override
  String get example4 =>
      'Belirtilen düzenli ifadeyle (regex) eşleşen alan adlarına erişimi engeller.';

  @override
  String get moreInformation => 'Daha fazla bilgi';

  @override
  String get addingRule => 'Kural ekleniyor...';

  @override
  String get deletingRule => 'Kural siliniyor...';

  @override
  String get enablingList => 'Liste etkinleştiriliyor...';

  @override
  String get disablingList => 'Liste devre dışı bırakılıyor...';

  @override
  String get savingList => 'Liste kaydediliyor...';

  @override
  String get disableFiltering => 'Filtrelemeyi devre dışı bırak';

  @override
  String get enablingFiltering => 'Filtreleme etkinleştiriliyor...';

  @override
  String get disablingFiltering => 'Filtreleme devre dışı bırakılıyor...';

  @override
  String get filteringStatusUpdated => 'Filtreleme durumu güncellendi';

  @override
  String get filteringStatusNotUpdated => 'Filtreleme durumu güncellenemedi';

  @override
  String get updateFrequency => 'Güncelleme sıklığı';

  @override
  String get never => 'Hiçbir zaman';

  @override
  String get hour1 => '1 saat';

  @override
  String get hours12 => '12 saat';

  @override
  String get hours24 => '24 saat';

  @override
  String get days3 => '3 gün';

  @override
  String get days7 => '7 gün';

  @override
  String get changingUpdateFrequency => 'Değiştiriliyor...';

  @override
  String get updateFrequencyChanged => 'Güncelleme sıklığı değiştirildi';

  @override
  String get updateFrequencyNotChanged => 'Güncelleme sıklığı değiştirilemedi';

  @override
  String get updating => 'Değerler güncelleniyor...';

  @override
  String get blockedServicesUpdated => 'Engellenen hizmetler güncellendi';

  @override
  String get blockedServicesNotUpdated => 'Engellenen hizmetler güncellenemedi';

  @override
  String get insertDomain => 'Durumunu görmek için bir alan adı girin.';

  @override
  String get dhcpSettings => 'DHCP ayarları';

  @override
  String get dhcpSettingsDescription => 'DHCP sunucusunu yapılandırın';

  @override
  String get dhcpSettingsNotLoaded => 'DHCP ayarları yüklenemedi';

  @override
  String get loadingDhcp => 'DHCP ayarları yükleniyor...';

  @override
  String get enableDhcpServer => 'DHCP sunucusunu etkinleştir';

  @override
  String get selectInterface => 'Arayüz seçin';

  @override
  String get hardwareAddress => 'Donanım adresi';

  @override
  String get gatewayIp => 'Ağ geçidi IP\'si';

  @override
  String get ipv4addresses => 'IPv4 adresleri';

  @override
  String get ipv6addresses => 'IPv6 adresleri';

  @override
  String get neededSelectInterface =>
      'DHCP sunucusunu yapılandırmak için önce bir ağ arayüzü seçmelisiniz.';

  @override
  String get ipv4settings => 'IPv4 ayarları';

  @override
  String get startOfRange => 'Aralık başlangıcı';

  @override
  String get endOfRange => 'Aralık bitişi';

  @override
  String get ipv6settings => 'IPv6 ayarları';

  @override
  String get subnetMask => 'Alt ağ maskesi';

  @override
  String get subnetMaskNotValid => 'Alt ağ maskesi geçersiz';

  @override
  String get gateway => 'Ağ geçidi';

  @override
  String get gatewayNotValid => 'Ağ geçidi adresi geçersiz';

  @override
  String get leaseTime => 'Kiralama süresi';

  @override
  String seconds(Object time) {
    return '$time saniye';
  }

  @override
  String get leaseTimeNotValid => 'Kiralama süresi geçersiz';

  @override
  String get restoreConfiguration => 'Yapılandırmayı sıfırla';

  @override
  String get restoreConfigurationMessage =>
      'Devam etmek istediğinize emin misiniz? Tüm yapılandırma sıfırlanacak ve bu işlem geri alınamayacak.';

  @override
  String get changeInterface => 'Arayüzü değiştir';

  @override
  String get savingSettings => 'Ayarlar kaydediliyor...';

  @override
  String get settingsSaved => 'Ayarlar kaydedildi';

  @override
  String get settingsNotSaved => 'Ayarlar kaydedilemedi';

  @override
  String get restoringConfig => 'Yapılandırma sıfırlanıyor...';

  @override
  String get configRestored => 'Yapılandırma sıfırlandı';

  @override
  String get configNotRestored => 'Yapılandırma sıfırlanamadı';

  @override
  String get dhcpStatic => 'Statik DHCP kiralamaları';

  @override
  String get noDhcpStaticLeases => 'Statik DHCP kiralaması bulunamadı';

  @override
  String get deleting => 'Siliniyor...';

  @override
  String get staticLeaseDeleted => 'Statik DHCP kiralaması silindi';

  @override
  String get staticLeaseNotDeleted => 'Statik DHCP kiralaması silinemedi';

  @override
  String get deleteStaticLease => 'Statik kiralamayı sil';

  @override
  String get deleteStaticLeaseDescription =>
      'Statik DHCP kiralaması silinecek. Bu işlem geri alınamaz.';

  @override
  String get addStaticLease => 'Statik kiralama ekle';

  @override
  String get macAddress => 'MAC adresi';

  @override
  String get macAddressNotValid => 'Geçersiz MAC adresi';

  @override
  String get hostName => 'Ana bilgisayar adı';

  @override
  String get hostNameError => 'Ana bilgisayar adı boş bırakılamaz';

  @override
  String get creating => 'Oluşturuluyor...';

  @override
  String get staticLeaseCreated => 'Statik DHCP kiralaması oluşturuldu';

  @override
  String get staticLeaseNotCreated => 'Statik DHCP kiralaması oluşturulamadı';

  @override
  String get staticLeaseExists => 'Bu statik DHCP kiralaması zaten mevcut';

  @override
  String get serverNotConfigured => 'Sunucu yapılandırılmamış';

  @override
  String get restoreLeases => 'Kiralamaları sıfırla';

  @override
  String get restoreLeasesMessage =>
      'Devam etmek istediğinize emin misiniz? Mevcut tüm kiralamalar sıfırlanacak ve bu işlem geri alınamayacak.';

  @override
  String get restoringLeases => 'Kiralamalar sıfırlanıyor...';

  @override
  String get leasesRestored => 'Kiralamalar sıfırlandı';

  @override
  String get leasesNotRestored => 'Kiralamalar sıfırlanamadı';

  @override
  String get dhcpLeases => 'DHCP kiralamaları';

  @override
  String get noLeases => 'Etkin DHCP kiralaması yok';

  @override
  String get dnsRewrites => 'DNS yeniden yazımları';

  @override
  String get dnsRewritesDescription => 'Özel DNS kurallarını yapılandırın';

  @override
  String get loadingRewriteRules => 'Yeniden yazma kuralları yükleniyor...';

  @override
  String get rewriteRulesNotLoaded =>
      'DNS yeniden yazma kuralları yüklenemedi.';

  @override
  String get noRewriteRules => 'DNS yeniden yazma kuralı yok';

  @override
  String get answer => 'Yanıt';

  @override
  String get deleteDnsRewrite => 'DNS yeniden yazımını sil';

  @override
  String get deleteDnsRewriteMessage =>
      'Bu DNS yeniden yazma kuralını silmek istediğinize emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get dnsRewriteRuleDeleted => 'DNS yeniden yazma kuralı silindi';

  @override
  String get dnsRewriteRuleNotDeleted => 'DNS yeniden yazma kuralı silinemedi';

  @override
  String get addDnsRewrite => 'DNS yeniden yazımı ekle';

  @override
  String get addingRewrite => 'Yeniden yazım ekleniyor...';

  @override
  String get dnsRewriteRuleAdded => 'DNS yeniden yazma kuralı eklendi';

  @override
  String get dnsRewriteRuleNotAdded => 'DNS yeniden yazma kuralı eklenemedi';

  @override
  String get logsSettings => 'Günlük ayarları';

  @override
  String get enableLog => 'Günlük kaydını etkinleştir';

  @override
  String get clearLogs => 'Günlükleri temizle';

  @override
  String get anonymizeClientIp => 'İstemci IP adresini anonimleştir';

  @override
  String get hours6 => '6 saat';

  @override
  String get days30 => '30 gün';

  @override
  String get days90 => '90 gün';

  @override
  String get retentionTime => 'Saklama süresi';

  @override
  String get selectOneItem => 'Bir seçenek belirleyin';

  @override
  String get logSettingsNotLoaded => 'Günlük ayarları yüklenemedi.';

  @override
  String get updatingSettings => 'Ayarlar güncelleniyor...';

  @override
  String get logsConfigUpdated => 'Günlük ayarları güncellendi';

  @override
  String get logsConfigNotUpdated => 'Günlük ayarları güncellenemedi';

  @override
  String get deletingLogs => 'Günlükler temizleniyor...';

  @override
  String get logsCleared => 'Günlükler temizlendi';

  @override
  String get logsNotCleared => 'Günlükler temizlenemedi';

  @override
  String get runningHomeAssistant => 'Home Assistant üzerinde çalışıyor';

  @override
  String get serverError => 'Sunucu hatası';

  @override
  String get noItems => 'Burada gösterilecek bir şey yok';

  @override
  String get dnsSettings => 'DNS ayarları';

  @override
  String get dnsSettingsDescription =>
      'DNS sunucularıyla bağlantıyı yapılandırın';

  @override
  String get upstreamDns => 'Üst DNS sunucuları';

  @override
  String get bootstrapDns => 'Önyükleme DNS sunucuları';

  @override
  String get noUpstreamDns => 'Henüz üst DNS sunucusu eklenmemiş.';

  @override
  String get dnsMode => 'DNS modu';

  @override
  String get noDnsMode => 'DNS modu seçilmedi';

  @override
  String get loadBalancing => 'Yük dengeleme';

  @override
  String get parallelRequests => 'Paralel istekler';

  @override
  String get fastestIpAddress => 'En hızlı IP adresi';

  @override
  String get loadBalancingDescription =>
      'Her seferinde tek bir üst sunucuyu sorgular. AdGuard Home, ağırlıklı rastgele algoritmasıyla en hızlı sunucuyu daha sık tercih eder.';

  @override
  String get parallelRequestsDescription =>
      'Tüm üst sunucuları aynı anda sorgulayarak DNS çözümlemesini hızlandırır.';

  @override
  String get fastestIpAddressDescription =>
      'Tüm DNS sunucularını sorgular ve gelen yanıtlar arasından en hızlı IP adresini döndürür. AdGuard Home tüm sunuculardan yanıt beklediği için sorgular biraz yavaşlasa da genel bağlantı kalitesini artırır.';

  @override
  String get noBootstrapDns => 'Henüz önyükleme DNS sunucusu eklenmemiş.';

  @override
  String get bootstrapDnsServersInfo =>
      'Önyükleme DNS sunucuları, üst sunucu olarak belirttiğiniz DoH/DoT çözümleyicilerinin IP adreslerini çözmek için kullanılır.';

  @override
  String get privateReverseDnsServers => 'Özel ters DNS sunucuları';

  @override
  String get privateReverseDnsServersDescription =>
      'AdGuard Home\'un yerel PTR sorguları için kullandığı DNS sunucularıdır. Örneğin \"192.168.12.34\" gibi özel IP aralıklarındaki adresler için ters DNS ile PTR isteklerini çözer. Belirtilmezse, AdGuard Home\'un kendi adresleri hariç işletim sisteminizin varsayılan DNS çözümleyicileri kullanılır.';

  @override
  String get reverseDnsDefault =>
      'AdGuard Home varsayılan olarak şu ters DNS çözümleyicilerini kullanır';

  @override
  String get addItem => 'Öğe ekle';

  @override
  String get noServerAddressesAdded => 'Henüz sunucu adresi eklenmedi.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Özel ters DNS çözümleyicilerini kullan';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Yerel ağdaki adresler için bu üst sunucuları kullanarak ters DNS aramaları yapar. Devre dışı bırakılırsa AdGuard Home; DHCP, /etc/hosts ve benzeri kaynaklardan bilinen istemciler dışındaki tüm bu tür PTR isteklerine NXDOMAIN yanıtı verir.';

  @override
  String get enableReverseResolving =>
      'İstemci IP adreslerinin ters çözümlenmesini etkinleştir';

  @override
  String get enableReverseResolvingDescription =>
      'İlgili çözümleyicilere (yerel istemciler için özel DNS sunucuları, genel IP\'li istemciler için üst sunucular) PTR sorguları göndererek istemci IP adreslerini ana bilgisayar adlarına dönüştürür.';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS sunucu ayarları';

  @override
  String get limitRequestsSecond => 'Saniye başına istek sınırı';

  @override
  String get valueNotNumber => 'Geçerli bir sayı girin';

  @override
  String get enableEdns => 'EDNS istemci alt ağını etkinleştir';

  @override
  String get enableEdnsDescription =>
      'Üst sunucu isteklerine EDNS İstemci Alt Ağı (ECS) bilgisini ekler ve istemcilerin gönderdiği değerleri sorgu günlüğüne kaydeder.';

  @override
  String get enableDnssec => 'DNSSEC\'i etkinleştir';

  @override
  String get enableDnssecDescription =>
      'Giden DNS sorgularında DNSSEC bayrağını ayarlar ve sonucu doğrular (DNSSEC destekli bir çözümleyici gerekir).';

  @override
  String get disableResolvingIpv6 =>
      'IPv6 adres çözümlemesini devre dışı bırak';

  @override
  String get disableResolvingIpv6Description =>
      'IPv6 adresleri için yapılan tüm DNS sorgularını (AAAA türü) yoksayar.';

  @override
  String get blockingMode => 'Engelleme modu';

  @override
  String get defaultMode => 'Varsayılan';

  @override
  String get defaultDescription =>
      'Adblock tarzı bir kuralla engellendiğinde sıfır IP adresi (A için 0.0.0.0; AAAA için ::), /etc/hosts tarzı bir kuralla engellendiğinde ise kuralda belirtilen IP adresiyle yanıt verir';

  @override
  String get refusedDescription => 'REFUSED koduyla yanıt verir';

  @override
  String get nxdomainDescription => 'NXDOMAIN koduyla yanıt verir';

  @override
  String get nullIp => 'Sıfır IP';

  @override
  String get nullIpDescription =>
      'Sıfır IP adresiyle yanıt verir (A için 0.0.0.0; AAAA için ::)';

  @override
  String get customIp => 'Özel IP';

  @override
  String get customIpDescription =>
      'Elle belirlediğiniz bir IP adresiyle yanıt verir';

  @override
  String get dnsCacheConfig => 'DNS önbellek yapılandırması';

  @override
  String get cacheSize => 'Önbellek boyutu';

  @override
  String get inBytes => 'Bayt cinsinden';

  @override
  String get overrideMinimumTtl => 'En düşük TTL değerini geçersiz kıl';

  @override
  String get overrideMinimumTtlDescription =>
      'DNS yanıtlarını önbelleğe alırken üst sunucudan gelen kısa TTL (yaşam süresi) değerlerini saniye cinsinden uzatır.';

  @override
  String get overrideMaximumTtl => 'En yüksek TTL değerini geçersiz kıl';

  @override
  String get overrideMaximumTtlDescription =>
      'DNS önbelleğindeki kayıtlar için en yüksek TTL (yaşam süresi) sınırını saniye cinsinden belirler.';

  @override
  String get optimisticCaching => 'İyimser önbellekleme';

  @override
  String get optimisticCachingDescription =>
      'Süresi dolmuş kayıtlar için bile önbellekten yanıt verirken arka planda bu kayıtları yenilemeye çalışır.';

  @override
  String get loadingDnsConfig => 'DNS yapılandırması yükleniyor...';

  @override
  String get dnsConfigNotLoaded => 'DNS yapılandırması yüklenemedi.';

  @override
  String get blockingIpv4 => 'Engelleme IPv4 adresi';

  @override
  String get blockingIpv4Description =>
      'Engellenen bir A isteği için döndürülecek IP adresi';

  @override
  String get blockingIpv6 => 'Engelleme IPv6 adresi';

  @override
  String get blockingIpv6Description =>
      'Engellenen bir AAAA isteği için döndürülecek IP adresi';

  @override
  String get invalidIp => 'Geçersiz IP adresi';

  @override
  String get dnsConfigSaved => 'DNS sunucu yapılandırması kaydedildi';

  @override
  String get dnsConfigNotSaved => 'DNS sunucu yapılandırması kaydedilemedi';

  @override
  String get savingConfig => 'Yapılandırma kaydediliyor...';

  @override
  String get someValueNotValid => 'Girilen değerlerden biri geçersiz';

  @override
  String get upstreamDnsDescription =>
      'Üst DNS sunucularını ve DNS modunu ayarlayın';

  @override
  String get bootstrapDnsDescription =>
      'Önyükleme DNS sunucularını yapılandırın';

  @override
  String get privateReverseDnsDescription =>
      'Özel DNS çözümleyicilerini ayarlayın ve özel ters DNS çözümlemesini yönetin';

  @override
  String get dnsServerSettingsDescription =>
      'Hız sınırı, engelleme modu ve diğer sunucu ayarlarını yapın';

  @override
  String get dnsCacheConfigDescription =>
      'Sunucunun DNS önbelleğini nasıl yöneteceğini belirleyin';

  @override
  String get comment => 'Yorum';

  @override
  String get address => 'Adres';

  @override
  String get commentsDescription =>
      'Yorumların başında her zaman # bulunur. Sizin eklemenize gerek yok, otomatik olarak eklenir.';

  @override
  String get encryptionSettings => 'Şifreleme ayarları';

  @override
  String get encryptionSettingsDescription =>
      'Şifreleme (HTTPS/QUIC/TLS) desteği';

  @override
  String get loadingEncryptionSettings => 'Şifreleme ayarları yükleniyor...';

  @override
  String get encryptionSettingsNotLoaded => 'Şifreleme ayarları yüklenemedi.';

  @override
  String get enableEncryption => 'Şifrelemeyi etkinleştir';

  @override
  String get enableEncryptionTypes => 'HTTPS, DNS-over-HTTPS ve DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      'Şifreleme etkinleştirildiğinde AdGuard Home yönetim arayüzü HTTPS üzerinden çalışır ve DNS sunucusu DNS-over-HTTPS ile DNS-over-TLS isteklerini dinler.';

  @override
  String get serverConfiguration => 'Sunucu yapılandırması';

  @override
  String get domainName => 'Alan adı';

  @override
  String get domainNameDescription =>
      'Belirtilirse AdGuard Home, ClientID\'leri algılar, DDR sorgularını yanıtlar ve ek bağlantı doğrulamaları yapar. Boş bırakılırsa bu özellikler devre dışı kalır. Sertifikadaki DNS adlarından biriyle eşleşmelidir.';

  @override
  String get redirectHttps => 'Otomatik olarak HTTPS\'ye yönlendir';

  @override
  String get httpsPort => 'HTTPS portu';

  @override
  String get tlsPort => 'DNS-over-TLS portu';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC portu';

  @override
  String get certificates => 'Sertifikalar';

  @override
  String get certificatesDescription =>
      'Şifrelemeyi kullanabilmek için alan adınıza ait geçerli bir SSL sertifika zinciri sağlamanız gerekir. letsencrypt.org üzerinden ücretsiz bir sertifika alabilir ya da güvenilir bir sertifika otoritesinden satın alabilirsiniz.';

  @override
  String get certificateFilePath => 'Sertifika dosya yolunu belirt';

  @override
  String get pasteCertificateContent => 'Sertifika içeriğini yapıştır';

  @override
  String get certificatePath => 'Sertifika yolu';

  @override
  String get certificateContent => 'Sertifika içeriği';

  @override
  String get privateKey => 'Özel anahtar';

  @override
  String get privateKeyFile => 'Özel anahtar dosya yolunu belirt';

  @override
  String get pastePrivateKey => 'Özel anahtar içeriğini yapıştır';

  @override
  String get usePreviousKey => 'Önceden kaydedilmiş anahtarı kullan';

  @override
  String get privateKeyPath => 'Özel anahtar yolu';

  @override
  String get invalidCertificate => 'Geçersiz sertifika';

  @override
  String get invalidPrivateKey => 'Geçersiz özel anahtar';

  @override
  String get validatingData => 'Veriler doğrulanıyor';

  @override
  String get dataValid => 'Veriler geçerli';

  @override
  String get dataNotValid => 'Veriler geçersiz';

  @override
  String get encryptionConfigSaved => 'Şifreleme yapılandırması kaydedildi';

  @override
  String get encryptionConfigNotSaved =>
      'Şifreleme yapılandırması kaydedilemedi';

  @override
  String get configError => 'Yapılandırma hatası';

  @override
  String get enterOnlyCertificate =>
      'Yalnızca sertifika metnini girin; ---BEGIN--- ve ---END--- satırlarını dahil etmeyin.';

  @override
  String get enterOnlyPrivateKey =>
      'Yalnızca anahtar metnini girin; ---BEGIN--- ve ---END--- satırlarını dahil etmeyin.';

  @override
  String get noItemsSearch => 'Aramanızla eşleşen sonuç bulunamadı.';

  @override
  String get clearSearch => 'Aramayı temizle';

  @override
  String get exitSearch => 'Aramadan çık';

  @override
  String get searchClients => 'İstemci ara';

  @override
  String get noClientsSearch => 'Aramanızla eşleşen istemci bulunamadı.';

  @override
  String get customization => 'Kişiselleştirme';

  @override
  String get customizationDescription =>
      'Uygulamanın görünümünü zevkinize göre ayarlayın';

  @override
  String get language => 'Dil';

  @override
  String get languageDescription => 'Uygulama dilini değiştirin';

  @override
  String get color => 'Renk';

  @override
  String get useDynamicTheme => 'Dinamik temayı kullan';

  @override
  String get red => 'Kırmızı';

  @override
  String get green => 'Yeşil';

  @override
  String get blue => 'Mavi';

  @override
  String get yellow => 'Sarı';

  @override
  String get orange => 'Turuncu';

  @override
  String get brown => 'Kahverengi';

  @override
  String get cyan => 'Camgöbeği';

  @override
  String get purple => 'Mor';

  @override
  String get pink => 'Pembe';

  @override
  String get deepOrange => 'Koyu turuncu';

  @override
  String get indigo => 'Çivit mavisi';

  @override
  String get useThemeColorStatus => 'Durumlar için tema rengini kullan';

  @override
  String get useThemeColorStatusDescription =>
      'Yeşil ve kırmızı durum renklerini tema rengi ve gri ile değiştirir';

  @override
  String get invalidCertificateChain => 'Geçersiz sertifika zinciri';

  @override
  String get validCertificateChain => 'Geçerli sertifika zinciri';

  @override
  String get subject => 'Konu';

  @override
  String get issuer => 'Düzenleyen';

  @override
  String get expires => 'Son geçerlilik';

  @override
  String get validPrivateKey => 'Geçerli özel anahtar';

  @override
  String get expirationDate => 'Son kullanma tarihi';

  @override
  String get keysNotMatch =>
      'Geçersiz sertifika veya anahtar: özel anahtar açık anahtarla eşleşmiyor';

  @override
  String get timeLogs => 'Günlüklerde işlem süresi';

  @override
  String get timeLogsDescription =>
      'Günlük listesinde sorgu işlem süresini gösterir';

  @override
  String get hostNames => 'Ana bilgisayar adları';

  @override
  String get keyType => 'Anahtar türü';

  @override
  String get updateAvailable => 'Yeni güncelleme var';

  @override
  String get installedVersion => 'Yüklü sürüm';

  @override
  String get newVersion => 'Yeni sürüm';

  @override
  String get source => 'Kaynak';

  @override
  String get downloadUpdate => 'Güncellemeyi indir';

  @override
  String get download => 'İndir';

  @override
  String get doNotRememberAgainUpdate => 'Bu sürüm için bir daha hatırlatma';

  @override
  String get downloadingUpdate => 'İndiriliyor';

  @override
  String get completed => 'tamamlandı';

  @override
  String get permissionNotGranted => 'İzin verilmedi';

  @override
  String get inputSearchTerm => 'Aramak istediğiniz ifadeyi yazın.';

  @override
  String get answers => 'Yanıtlar';

  @override
  String get copyClipboard => 'Panoya kopyala';

  @override
  String get domainCopiedClipboard => 'Alan adı panoya kopyalandı';

  @override
  String get clearDnsCache => 'DNS önbelleğini temizle';

  @override
  String get clearDnsCacheMessage =>
      'DNS önbelleğini temizlemek istediğinize emin misiniz?';

  @override
  String get dnsCacheCleared => 'DNS önbelleği temizlendi';

  @override
  String get clearingDnsCache => 'Önbellek temizleniyor...';

  @override
  String get dnsCacheNotCleared => 'DNS önbelleği temizlenemedi';

  @override
  String get clientsSelected => 'istemci seçildi';

  @override
  String get invalidDomain => 'Geçersiz alan adı';

  @override
  String get loadingBlockedServicesList =>
      'Engellenen hizmetler listesi yükleniyor...';

  @override
  String get blockedServicesListNotLoaded =>
      'Engellenen hizmetler listesi yüklenemedi';

  @override
  String get error => 'Hata';

  @override
  String get updates => 'Güncellemeler';

  @override
  String get updatesDescription => 'AdGuard Home sunucusunu güncelleyin';

  @override
  String get updateNow => 'Şimdi güncelle';

  @override
  String get currentVersion => 'Mevcut sürüm';

  @override
  String get requestStartUpdateFailed =>
      'Güncelleme başlatma isteği gönderilemedi';

  @override
  String get requestStartUpdateSuccessful =>
      'Güncelleme başlatma isteği gönderildi';

  @override
  String get serverUpdated => 'Sunucu güncel';

  @override
  String get unknownStatus => 'Bilinmeyen durum';

  @override
  String get checkingUpdates => 'Güncellemeler denetleniyor...';

  @override
  String get checkUpdates => 'Güncellemeleri denetle';

  @override
  String get requestingUpdate => 'Güncelleme isteniyor...';

  @override
  String get autoupdateUnavailable => 'Otomatik güncelleme kullanılamıyor';

  @override
  String get autoupdateUnavailableDescription =>
      'Bu sunucu için otomatik güncelleme hizmeti kullanılamıyor. Sunucunuz bir Docker kapsayıcısı (container) içinde çalışıyor olabilir; bu durumda güncellemeyi elle yapmanız gerekir.';

  @override
  String minute(Object time) {
    return '$time dakika';
  }

  @override
  String minutes(Object time) {
    return '$time dakika';
  }

  @override
  String hour(Object time) {
    return '$time saat';
  }

  @override
  String hours(Object time) {
    return '$time saat';
  }

  @override
  String get remainingTime => 'Kalan süre';

  @override
  String get safeSearchSettings => 'Güvenli arama ayarları';

  @override
  String get loadingSafeSearchSettings =>
      'Güvenli arama ayarları yükleniyor...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Güvenli arama ayarları yüklenirken bir hata oluştu.';

  @override
  String get loadingLogsSettings => 'Günlük ayarları yükleniyor...';

  @override
  String get selectOptionLeftColumn => 'Sol sütundan bir seçenek belirleyin';

  @override
  String get selectClientLeftColumn => 'Sol sütundan bir istemci seçin';

  @override
  String get disableList => 'Listeyi devre dışı bırak';

  @override
  String get enableList => 'Listeyi etkinleştir';

  @override
  String get screens => 'Ekranlar';

  @override
  String get copiedClipboard => 'Panoya kopyalandı';

  @override
  String get seeDetails => 'Ayrıntıları gör';

  @override
  String get listNotAvailable => 'Liste kullanılamıyor';

  @override
  String get copyListUrl => 'Liste URL\'sini kopyala';

  @override
  String get listUrlCopied => 'Liste URL\'si panoya kopyalandı';

  @override
  String get unsupportedVersion => 'Desteklenmeyen sürüm';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'Sunucunuzun $version sürümü için tam destek garanti edilmemektedir. Uygulama bu sürümle çalışırken beklenmedik sorunlar yaşayabilirsiniz.\n\nAdGuard Home Manager, AdGuard Home sunucusunun kararlı sürümleri için tasarlanmıştır. Alfa ve beta sürümlerle de çalışabilir ancak uyumluluk garanti edilmez ve çeşitli hatalarla karşılaşılabilir.';
  }

  @override
  String get iUnderstand => 'Anladım';

  @override
  String get appUpdates => 'Uygulama güncellemeleri';

  @override
  String get usingLatestVersion => 'En güncel sürümü kullanıyorsunuz';

  @override
  String get ipLogs => 'Günlüklerde IP adresi';

  @override
  String get ipLogsDescription =>
      'Günlüklerde istemci adı yerine her zaman IP adresini gösterir';

  @override
  String get application => 'Uygulama';

  @override
  String get combinedChart => 'Birleşik grafik';

  @override
  String get combinedChartDescription =>
      'Tüm grafikleri tek bir grafikte birleştirir';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get errorLoadFilters => 'Filtreler yüklenirken bir hata oluştu.';

  @override
  String get clientRemovedSuccessfully => 'İstemci kaldırıldı.';

  @override
  String get editRewriteRule => 'Yeniden yazma kuralını düzenle';

  @override
  String get dnsRewriteRuleUpdated => 'DNS yeniden yazma kuralı güncellendi';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'DNS yeniden yazma kuralı güncellenemedi';

  @override
  String get updatingRule => 'Kural güncelleniyor...';

  @override
  String get serverUpdateNeeded => 'Sunucu güncellemesi gerekiyor';

  @override
  String updateYourServer(Object version) {
    return 'Bu özelliği kullanabilmek için AdGuard Home sunucunuzu $version veya daha yeni bir sürüme güncelleyin.';
  }

  @override
  String get january => 'Ocak';

  @override
  String get february => 'Şubat';

  @override
  String get march => 'Mart';

  @override
  String get april => 'Nisan';

  @override
  String get may => 'Mayıs';

  @override
  String get june => 'Haziran';

  @override
  String get july => 'Temmuz';

  @override
  String get august => 'Ağustos';

  @override
  String get september => 'Eylül';

  @override
  String get october => 'Ekim';

  @override
  String get november => 'Kasım';

  @override
  String get december => 'Aralık';

  @override
  String get malwarePhishing => 'Zararlı/oltalama';

  @override
  String get queries => 'Sorgular';

  @override
  String get adultSites => 'Yetişkin siteleri';

  @override
  String get quickFilters => 'Hızlı filtreler';

  @override
  String get searchDomainInternet => 'Alan adını internette ara';

  @override
  String get hideServerAddress => 'Sunucu adresini gizle';

  @override
  String get hideServerAddressDescription =>
      'Ana ekranda sunucu adresini gizler';

  @override
  String get topItemsOrder => 'Öne çıkan öğelerin sırası';

  @override
  String get topItemsOrderDescription =>
      'Ana ekrandaki öne çıkan öğe listelerini sıralayın';

  @override
  String get topItemsReorderInfo =>
      'Sırasını değiştirmek için bir öğeye basılı tutup sürükleyin.';

  @override
  String get discardChanges => 'Değişikliklerden vazgeç';

  @override
  String get discardChangesDescription =>
      'Yaptığınız değişikliklerden vazgeçmek istediğinize emin misiniz?';

  @override
  String get others => 'Diğerleri';

  @override
  String get showChart => 'Grafiği göster';

  @override
  String get hideChart => 'Grafiği gizle';

  @override
  String get showTopItemsChart => 'Öne çıkan öğeler grafiğini göster';

  @override
  String get showTopItemsChartDescription =>
      'Öne çıkan öğeler bölümünde halka grafiğini varsayılan olarak gösterir. Yalnızca mobil görünümü etkiler.';

  @override
  String get openMenu => 'Menüyü aç';

  @override
  String get closeMenu => 'Menüyü kapat';

  @override
  String get openListUrl => 'Liste URL\'sini aç';

  @override
  String get selectionMode => 'Seçim modu';

  @override
  String get enableDisableSelected =>
      'Seçilenleri etkinleştir veya devre dışı bırak';

  @override
  String get deleteSelected => 'Seçilenleri sil';

  @override
  String get deleteSelectedLists => 'Seçilen listeleri sil';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'Seçilen tüm listeler silindi.';

  @override
  String get deletionResult => 'Silme sonucu';

  @override
  String get deletingLists => 'Listeler siliniyor...';

  @override
  String get failedElements => 'Başarısız öğeler';

  @override
  String get processingLists => 'Listeler işleniyor...';

  @override
  String get enableDisableResult => 'Durum değişikliği sonucu';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'Seçilen tüm listelerin durumu güncellendi';

  @override
  String get sslWarning =>
      'Kendinden imzalı sertifikayla HTTPS bağlantısı kullanıyorsanız Ayarlar > Gelişmiş ayarlar altından \"SSL sertifikasını kontrol etme\" seçeneğini açmayı unutmayın.';

  @override
  String get unsupportedServerVersion => 'Desteklenmeyen sunucu sürümü';

  @override
  String get unsupportedServerVersionMessage =>
      'AdGuard Home sunucunuzun sürümü çok eski olduğu için AdGuard Home Manager tarafından desteklenmiyor. Uygulamayı kullanabilmek için sunucunuzu daha yeni bir sürüme yükseltmeniz gerekiyor.';

  @override
  String yourVersion(Object version) {
    return 'Sizin sürümünüz: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Gereken en düşük sürüm: $version';
  }

  @override
  String get topUpstreams => 'Öne çıkan üst DNS\'ler';

  @override
  String get averageUpstreamResponseTime => 'Ortalama üst DNS yanıt süresi';

  @override
  String get dhcpNotAvailable => 'DHCP sunucusu kullanılamıyor.';

  @override
  String get osServerInstalledIncompatible =>
      'Sunucunun kurulu olduğu işletim sistemi bu özelliği desteklemiyor.';

  @override
  String get resetSettings => 'Ayarları sıfırla';

  @override
  String get resetEncryptionSettingsDescription =>
      'Şifreleme ayarlarını varsayılan değerlerine sıfırlamak istediğinize emin misiniz?';

  @override
  String get resettingConfig => 'Yapılandırma sıfırlanıyor...';

  @override
  String get configurationResetSuccessfully => 'Yapılandırma sıfırlandı';

  @override
  String get configurationResetError => 'Yapılandırma sıfırlanamadı';

  @override
  String get testUpstreamDnsServers => 'Üst DNS sunucularını test et';

  @override
  String get errorTestUpstreamDns =>
      'Üst DNS sunucuları test edilirken bir hata oluştu.';

  @override
  String get useCustomIpEdns => 'EDNS için özel IP kullan';

  @override
  String get useCustomIpEdnsDescription =>
      'EDNS için özel IP adresi kullanılmasına izin verir';

  @override
  String get sortingOptions => 'Sıralama seçenekleri';

  @override
  String get fromHighestToLowest => 'En yüksekten en düşüğe';

  @override
  String get fromLowestToHighest => 'En düşükten en yükseğe';

  @override
  String get queryLogsAndStatistics => 'Sorgu günlükleri ve istatistikler';

  @override
  String get ignoreClientQueryLog => 'Bu istemciyi sorgu günlüğünde yoksay';

  @override
  String get ignoreClientStatistics => 'Bu istemciyi istatistiklere dahil etme';

  @override
  String get savingChanges => 'Değişiklikler kaydediliyor...';

  @override
  String get fallbackDnsServers => 'Yedek DNS sunucuları';

  @override
  String get fallbackDnsServersDescription =>
      'Yedek DNS sunucularını yapılandırın';

  @override
  String get fallbackDnsServersInfo =>
      'Üst DNS sunucuları yanıt vermediğinde devreye girecek yedek DNS sunucularının listesidir. Yazım biçimi yukarıdaki ana üst sunucular alanıyla aynıdır.';

  @override
  String get noFallbackDnsAdded => 'Yedek DNS sunucusu eklenmemiş.';

  @override
  String get blockedResponseTtl => 'Engellenen yanıt TTL değeri';

  @override
  String get blockedResponseTtlDescription =>
      'İstemcilerin filtrelenmiş bir yanıtı kaç saniye boyunca önbellekte tutacağını belirler';

  @override
  String get invalidValue => 'Geçersiz değer';

  @override
  String get noDataChart => 'Bu grafiği gösterecek veri henüz yok.';

  @override
  String get noData => 'Veri yok';

  @override
  String get unblockClient => 'İstemci engelini kaldır';

  @override
  String get blockingClient => 'İstemci engelleniyor...';

  @override
  String get unblockingClient => 'İstemci engeli kaldırılıyor...';

  @override
  String get upstreamDnsCacheConfiguration => 'Üst DNS önbellek yapılandırması';

  @override
  String get enableDnsCachingClient =>
      'Bu istemci için DNS önbelleğini etkinleştir';

  @override
  String get dnsCacheSize => 'DNS önbellek boyutu';

  @override
  String get nameInvalid => 'Ad alanı zorunludur';

  @override
  String get oneIdentifierRequired =>
      'En az bir tanımlayıcı girmeniz gerekiyor';

  @override
  String get dnsCacheNumber => 'DNS önbellek boyutu bir sayı olmalıdır';

  @override
  String get errors => 'Hatalar';

  @override
  String get redirectHttpsWarning =>
      'AdGuard Home sunucunuzda \"Otomatik olarak HTTPS\'ye yönlendir\" seçeneği açıksa HTTPS bağlantısını seçip sunucunuzun HTTPS portunu girmelisiniz.';

  @override
  String get logsSettingsDescription => 'Sorgu günlüklerini yapılandırın';

  @override
  String get ignoredDomains => 'Yoksayılan alan adları';

  @override
  String get noIgnoredDomainsAdded => 'Yoksayılacak alan adı eklenmemiş';

  @override
  String get pauseServiceBlocking => 'Hizmet engellemeyi duraklat';

  @override
  String get newSchedule => 'Yeni zamanlama';

  @override
  String get editSchedule => 'Zamanlamayı düzenle';

  @override
  String get timezone => 'Saat dilimi';

  @override
  String get monday => 'Pazartesi';

  @override
  String get tuesday => 'Salı';

  @override
  String get wednesday => 'Çarşamba';

  @override
  String get thursday => 'Perşembe';

  @override
  String get friday => 'Cuma';

  @override
  String get saturday => 'Cumartesi';

  @override
  String get sunday => 'Pazar';

  @override
  String get from => 'Başlangıç';

  @override
  String get to => 'Bitiş';

  @override
  String get selectStartTime => 'Başlangıç saatini seçin';

  @override
  String get selectEndTime => 'Bitiş saatini seçin';

  @override
  String get startTimeBeforeEndTime =>
      'Başlangıç saati bitiş saatinden önce olmalıdır.';

  @override
  String get noBlockingScheduleThisDevice =>
      'Bu cihaz için ayarlanmış bir engelleme zamanlaması yok.';

  @override
  String get selectTimezone => 'Bir saat dilimi seçin';

  @override
  String get selectClientsFiltersInfo =>
      'Görmek istediğiniz istemcileri seçin. Hiçbirini seçmezseniz tümü gösterilir.';

  @override
  String get noDataThisSection => 'Bu bölümde gösterilecek veri yok.';

  @override
  String get statisticsSettings => 'İstatistik ayarları';

  @override
  String get statisticsSettingsDescription =>
      'İstatistikler için veri toplamayı yapılandırın';

  @override
  String get loadingStatisticsSettings => 'İstatistik ayarları yükleniyor...';

  @override
  String get statisticsSettingsLoadError =>
      'İstatistik ayarları yüklenirken bir hata oluştu.';

  @override
  String get statisticsConfigUpdated => 'İstatistik ayarları güncellendi';

  @override
  String get statisticsConfigNotUpdated => 'İstatistik ayarları güncellenemedi';

  @override
  String get customTimeInHours => 'Özel süre (saat)';

  @override
  String get invalidTime => 'Geçersiz süre';

  @override
  String get removeDomain => 'Alan adını kaldır';

  @override
  String get addDomain => 'Alan adı ekle';

  @override
  String get notLess1Hour => 'Süre 1 saatten az olamaz';

  @override
  String get rateLimit => 'Hız sınırı';

  @override
  String get subnetPrefixLengthIpv4 => 'IPv4 alt ağ ön ek uzunluğu';

  @override
  String get subnetPrefixLengthIpv6 => 'IPv6 alt ağ ön ek uzunluğu';

  @override
  String get rateLimitAllowlist => 'Hız sınırı istisna listesi';

  @override
  String get rateLimitAllowlistDescription =>
      'Hız sınırından muaf tutulacak IP adresleri';

  @override
  String get dnsOptions => 'DNS seçenekleri';

  @override
  String get editor => 'Düzenleyici';

  @override
  String get editCustomRules => 'Özel kuralları düzenle';

  @override
  String get savingCustomRules => 'Özel kurallar kaydediliyor...';

  @override
  String get customRulesUpdatedSuccessfully => 'Özel kurallar güncellendi';

  @override
  String get customRulesNotUpdated => 'Özel kurallar güncellenemedi';

  @override
  String get reorder => 'Sırala';

  @override
  String get showHide => 'Göster/gizle';

  @override
  String get noElementsReorderMessage =>
      'Burada sıralayabilmek için önce Göster/gizle sekmesinden birkaç öğeyi görünür yapın.';

  @override
  String get enablePlainDns => 'Düz (şifresiz) DNS\'i etkinleştir';

  @override
  String get enablePlainDnsDescription =>
      'Düz DNS varsayılan olarak etkindir. Tüm cihazları şifreli DNS kullanmaya zorlamak için bunu kapatabilirsiniz; ancak bunun için önce en az bir şifreli DNS protokolünü etkinleştirmeniz gerekir.';

  @override
  String get date => 'Tarih';

  @override
  String get loadingChangelog => 'Sürüm notları yükleniyor...';

  @override
  String get invalidIpOrUrl => 'Geçersiz IP adresi veya URL';

  @override
  String get addPersistentClient => 'Kalıcı istemci olarak ekle';

  @override
  String get blockThisClientOnly => 'Yalnızca bu istemci için engelle';

  @override
  String get unblockThisClientOnly => 'Yalnızca bu istemci için engeli kaldır';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain bu istemci için engellendi';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return 'Bu istemci için $domain engeli kaldırıldı';
  }

  @override
  String get disallowThisClient => 'Bu istemciye izin verme';

  @override
  String get allowThisClient => 'Bu istemciye izin ver';

  @override
  String get clientAllowedSuccessfully => 'İstemciye izin verildi';

  @override
  String get clientDisallowedSuccessfully =>
      'İstemci izin verilmeyenlere eklendi';

  @override
  String get changesNotSaved => 'Değişiklikler kaydedilemedi';

  @override
  String get allowingClient => 'İstemciye izin veriliyor...';

  @override
  String get disallowingClient => 'İstemci izin verilmeyenlere ekleniyor...';

  @override
  String get clientIpCopied => 'İstemci IP\'si panoya kopyalandı';

  @override
  String get clientNameCopied => 'İstemci adı panoya kopyalandı';

  @override
  String get dnsServerAddressCopied => 'DNS sunucu adresi panoya kopyalandı';

  @override
  String get select => 'Seç';

  @override
  String get liveLogs => 'Canlı günlükler';

  @override
  String get hereWillAppearRealtimeLogs =>
      'Canlı günlük akışı burada görünecek.';

  @override
  String get applicationDetails => 'Uygulama ayrıntıları';

  @override
  String get applicationDetailsDescription =>
      'Kaynak kod deposu, uygulama mağazaları ve daha fazlası';

  @override
  String get myOtherApps => 'Diğer uygulamalarım';

  @override
  String get myOtherAppsDescription =>
      'Diğer uygulamalarıma göz atın, bağış yapın, destek alın ve daha fazlasını keşfedin';

  @override
  String get topToBottom => 'Yukarıdan aşağıya';

  @override
  String get bottomToTop => 'Aşağıdan yukarıya';

  @override
  String get upstreamTimeout => 'Üst sunucu zaman aşımı';

  @override
  String get upstreamTimeoutHelper =>
      'Üst sunucudan yanıt beklerken uygulanacak zaman aşımı süresini (saniye) belirler';

  @override
  String get fieldCannotBeEmpty => 'Bu alan boş bırakılamaz';

  @override
  String get enableDnsRewriteRules =>
      'DNS yeniden yazma kurallarını etkinleştir';

  @override
  String get dnsRewriteRuleEnabled =>
      'DNS yeniden yazma kuralı etkinleştirildi';

  @override
  String get dnsRewriteRuleDisabled =>
      'DNS yeniden yazma kuralı devre dışı bırakıldı';

  @override
  String get allDnsRewriteRulesEnabled =>
      'Tüm DNS yeniden yazma kuralları etkinleştirildi';

  @override
  String get allDnsRewriteRulesDisabled =>
      'Tüm DNS yeniden yazma kuralları devre dışı bırakıldı';

  @override
  String get errorEnablingAllDnsRewriteRules =>
      'DNS yeniden yazma kuralları etkinleştirilirken hata oluştu';

  @override
  String get errorDisablingAllDnsRewriteRules =>
      'DNS yeniden yazma kuralları devre dışı bırakılırken hata oluştu';

  @override
  String get enablingDnsRewriteRule =>
      'DNS yeniden yazma kuralları etkinleştiriliyor...';

  @override
  String get disablingDnsRewriteRule =>
      'DNS yeniden yazma kuralları devre dışı bırakılıyor...';

  @override
  String get selectIdToFilter => 'Filtrelemek için bir kimlik seçin';

  @override
  String get clientIds => 'İstemci kimlikleri';

  @override
  String get loginMethod => 'Login method';

  @override
  String get loginMethodDefault => 'Default';

  @override
  String get loginMethodHomeAssistant => 'Home Assistant';

  @override
  String get loginMethodGlinet => 'GL.iNet';

  @override
  String get loginMethodDefaultHelp =>
      'Uses the AdGuard Home username and password.';

  @override
  String get loginMethodHomeAssistantHelp =>
      'Uses the Home Assistant username and password.';

  @override
  String get loginMethodGlinetHelp =>
      'Uses the router\'s admin password. No username is needed.';

  @override
  String get routerAdminPassword => 'Router admin password';

  @override
  String get glinetAddressHint =>
      'Use the router\'s admin address and leave the port empty.';

  @override
  String get glinetDetectedTitle => 'This looks like a GL.iNet router';

  @override
  String get glinetDetectedMessage =>
      'AdGuard on this router uses the GL.iNet admin login. Switch the login method to GL.iNet and leave the port empty.';

  @override
  String get useGlinetLogin => 'Use GL.iNet login';

  @override
  String get glinetNotFound =>
      'No GL.iNet login at this address. Use the router\'s admin address and leave the port empty.';

  @override
  String get glinetSessionRejected =>
      'The router accepted the password, but AdGuard rejected the session.';
}
