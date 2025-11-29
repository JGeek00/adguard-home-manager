// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get home => 'Anasayfa';

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
  String get path => 'Dosya Yolu';

  @override
  String get port => 'Bağlantı noktası';

  @override
  String get username => 'Kullanıcı adı';

  @override
  String get password => 'Şifre';

  @override
  String get defaultServer => 'Varsayılan sunucu olarak ayarla';

  @override
  String get general => 'Genel';

  @override
  String get connection => 'Bağlantı';

  @override
  String get authentication => 'Kimlik doğrulama';

  @override
  String get other => 'Diğer';

  @override
  String get invalidPort => 'Geçersiz bağlantı noktası';

  @override
  String get invalidPath => 'Geçersiz dosya yolu';

  @override
  String get invalidIpDomain => 'Geçersiz IP veya alan adı';

  @override
  String get ipDomainNotEmpty => 'IP veya alan adı boş olamaz';

  @override
  String get nameNotEmpty => 'Ad boş bırakılamaz';

  @override
  String get invalidUsernamePassword => 'Geçersiz kullanıcı adı veya şifre';

  @override
  String get tooManyAttempts =>
      'Çok fazla deneme yapıldı. Daha sonra tekrar deneyin.';

  @override
  String get cantReachServer =>
      'Sunucuya ulaşılamıyor. Bağlantınızı kontrol edin.';

  @override
  String get sslError =>
      'SSL hatası. Ayarlar > Gelişmiş ayarlar bölümüne gidin ve SSL doğrulamasını geçersiz kıl seçeneğini etkinleştirin.';

  @override
  String get unknownError => 'Bilinmeyen hata';

  @override
  String get connectionNotCreated => 'Bağlantı kurulamadı';

  @override
  String get connecting => 'Bağlanılıyor...';

  @override
  String get connected => 'Bağlantı kuruldu';

  @override
  String get selectedDisconnected => 'Seçildi ancak bağlantı kesildi';

  @override
  String get connectionDefaultSuccessfully =>
      'Bağlantı başarıyla varsayılan olarak ayarlandı.';

  @override
  String get connectionDefaultFailed =>
      'Bağlantı varsayılan olarak ayarlanamadı.';

  @override
  String get noSavedConnections => 'Kaydedilmiş bağlantı yok';

  @override
  String get cannotConnect => 'Sunucuya bağlanılamıyor';

  @override
  String get connectionRemoved => 'Bağlantı başarıyla kaldırıldı';

  @override
  String get connectionCannotBeRemoved => 'Bağlantı kaldırılamaz.';

  @override
  String get remove => 'Kaldır';

  @override
  String get removeWarning =>
      'Bu AdGuard Home sunucusuyla olan bağlantıyı kaldırmak istediğinizden emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get defaultConnection => 'Varsayılan bağlantı';

  @override
  String get setDefault => 'Varsayılan sunucu yap';

  @override
  String get edit => 'Düzenle';

  @override
  String get delete => 'Sil';

  @override
  String get save => 'Kaydet';

  @override
  String get serverStatus => 'Sunucu durumu';

  @override
  String get connectionNotUpdated => 'Bağlantı Güncellenmedi';

  @override
  String get ruleFilteringWidget => 'Kural filtreleme';

  @override
  String get safeBrowsingWidget => 'Güvenli gezinme';

  @override
  String get parentalFilteringWidget => 'Ebeveyn filtreleme';

  @override
  String get safeSearchWidget => 'Güvenli arama';

  @override
  String get ruleFiltering => 'Kural filtreleme';

  @override
  String get safeBrowsing => 'Güvenli gezinme';

  @override
  String get parentalFiltering => 'Ebeveyn filtreleme';

  @override
  String get safeSearch => 'Güvenli arama';

  @override
  String get serverStatusNotRefreshed => 'Sunucu durumu yenilenemedi';

  @override
  String get loadingStatus => 'Durum yükleniyor...';

  @override
  String get errorLoadServerStatus => 'Sunucu durumu yüklenemedi';

  @override
  String get topQueriedDomains => 'En çok sorgulananlar';

  @override
  String get viewMore => 'Daha fazla göster';

  @override
  String get topClients => 'Öne çıkan istemciler';

  @override
  String get topBlockedDomains => 'En çok engellenenler';

  @override
  String get appSettings => 'Uygulama ayarları';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get systemDefined => 'Otomatik (Cihazınızın renk düzenine göre)';

  @override
  String get close => 'Kapat';

  @override
  String get connectedTo => 'Bağlandı:';

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
  String get passwordNotEmpty => 'Şifre boş bırakılamaz';

  @override
  String get examplePath => 'Örnek: /adguard';

  @override
  String get helperPath => 'Eğer ters proxy kullanıyorsanız';

  @override
  String get aboutApp => 'Uygulama hakkında';

  @override
  String get appVersion => 'Uygulama sürümü';

  @override
  String get createdBy => 'Geliştirici';

  @override
  String get clients => 'İstemciler';

  @override
  String get allowed => 'İzin verilen';

  @override
  String get blocked => 'Engellenen';

  @override
  String get noClientsList => 'Bu listede hiç istemci yok';

  @override
  String get activeClients => 'Etkin';

  @override
  String get removeClient => 'İstemciyi kaldır';

  @override
  String get removeClientMessage =>
      'Bu istemciyi listeden çıkarmak istediğinize emin misiniz?';

  @override
  String get confirm => 'Onayla';

  @override
  String get removingClient => 'İstemci kaldırılıyor...';

  @override
  String get clientNotRemoved => 'İstemci listeden çıkarılamadı';

  @override
  String get addClient => 'İstemci ekle';

  @override
  String get list => 'Liste';

  @override
  String get ipAddress => 'IP adresi';

  @override
  String get ipNotValid => 'IP adresi geçersiz';

  @override
  String get clientAddedSuccessfully => 'İstemci listeye başarıyla eklendi';

  @override
  String get addingClient => 'İstemci ekleniyor...';

  @override
  String get clientNotAdded => 'İstemci listeye eklenemedi';

  @override
  String get clientAnotherList => 'Bu istemci henüz başka bir listede';

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
      'Sunucunun SSL sertifikası doğrulamasını geçersiz kılar.';

  @override
  String get advancedSetupDescription => 'Gelişmiş seçenekleri yönet';

  @override
  String get settingsUpdatedSuccessfully => 'Ayarlar başarıyla güncellendi.';

  @override
  String get cannotUpdateSettings => 'Ayarlar güncellenemiyor.';

  @override
  String get restartAppTakeEffect => 'Uygulamayı yeniden başlat';

  @override
  String get loadingLogs => 'Günlükler yükleniyor...';

  @override
  String get logsNotLoaded => 'Günlüklerin listesi yüklenemedi';

  @override
  String get processed => 'İşlendi\nListe yok';

  @override
  String get processedRow => 'İşlendi (Liste yok)';

  @override
  String get blockedBlacklist => 'Engellendi\nKara Liste';

  @override
  String get blockedBlacklistRow => 'Engellendi (Kara liste)';

  @override
  String get blockedSafeBrowsing => 'Engellendi\nGüvenli gezinme';

  @override
  String get blockedSafeBrowsingRow => 'Engellendi (Güvenli gezinme)';

  @override
  String get blockedParental => 'Engellendi\nEbeveyn filtreleme';

  @override
  String get blockedParentalRow => 'Engellendi (Ebeveyn filtreleme)';

  @override
  String get blockedInvalid => 'Engellendi\nGeçersiz';

  @override
  String get blockedInvalidRow => 'Engellendi (Geçersiz)';

  @override
  String get blockedSafeSearch => 'Engellendi\nGüvenli arama';

  @override
  String get blockedSafeSearchRow => 'Engellendi (Güvenli arama)';

  @override
  String get blockedService => 'Engellendi\nBelirlenen hizmet';

  @override
  String get blockedServiceRow => 'Engellendi (Belirlenen hizmet)';

  @override
  String get processedWhitelist => 'İşlendi\nBeyaz liste';

  @override
  String get processedWhitelistRow => 'İşlendi (Beyaz liste)';

  @override
  String get processedError => 'İşlendi\nHata';

  @override
  String get processedErrorRow => 'İşlendi (Hata)';

  @override
  String get rewrite => 'Yeniden Yaz';

  @override
  String get status => 'Durum';

  @override
  String get result => 'Sonuç';

  @override
  String get time => 'Saat';

  @override
  String get blocklist => 'Engelleme Listesi';

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
  String get elapsedTime => 'İşlem süresi';

  @override
  String get responseCode => 'Yanıt kodu';

  @override
  String get client => 'İstemci';

  @override
  String get deviceIp => 'IP adresi';

  @override
  String get deviceName => 'İstemci adı';

  @override
  String get logDetails => 'Günlük detayları';

  @override
  String get blockingRule => 'Engelleme kuralı';

  @override
  String get blockDomain => 'Alan adını engelle';

  @override
  String get couldntGetFilteringStatus => 'Filtreleme durumu alınamıyor';

  @override
  String get unblockDomain => 'Alan adı engelini kaldır';

  @override
  String get userFilteringRulesNotUpdated =>
      'Kullanıcı filtreleme kuralları güncellenemedi';

  @override
  String get userFilteringRulesUpdated =>
      'Kullanıcı filtreleme kuralları başarıyla güncellendi';

  @override
  String get savingUserFilters => 'Kullanıcı filtreleri kaydediliyor...';

  @override
  String get filters => 'Filtreler';

  @override
  String get logsOlderThan => 'Daha eski günlükler';

  @override
  String get responseStatus => 'Yanıt durumu';

  @override
  String get selectTime => 'Zaman seç';

  @override
  String get notSelected => 'Seçili değil';

  @override
  String get resetFilters => 'Filtreleri sıfırla';

  @override
  String get noLogsDisplay => 'Gösterilecek günlük yok';

  @override
  String get noLogsThatOld =>
      'Seçilen zaman için kaydedilmiş herhangi bir günlük bulunmuyor olabilir. Daha yakın bir zaman seçmeyi deneyin.';

  @override
  String get apply => 'Uygula';

  @override
  String get selectAll => 'Hepsini seç';

  @override
  String get unselectAll => 'Seçimleri kaldır';

  @override
  String get all => 'Hepsi';

  @override
  String get filtered => 'Filtrelenmiş';

  @override
  String get checkAppLogs => 'Uygulama günlüklerini kontrol edin';

  @override
  String get refresh => 'Yenile';

  @override
  String get search => 'Ara';

  @override
  String get dnsQueries => 'DNS sorguları';

  @override
  String get average => 'Ortalama';

  @override
  String get blockedFilters => 'Engellenen alan adları';

  @override
  String get malwarePhishingBlocked => 'Engellenen zararlı içerikler';

  @override
  String get blockedAdultWebsites => 'Engellenen yetişkin içerikler';

  @override
  String get generalSettings => 'Genel ayarlar';

  @override
  String get generalSettingsDescription => 'Çeşitli farklı ayarları yönet';

  @override
  String get hideZeroValues => 'Sıfır değerlerini gizle';

  @override
  String get hideZeroValuesDescription =>
      'Ana ekranda, değeri sıfır olan blokları gizler.';

  @override
  String get webAdminPanel => 'Web yönetim paneli';

  @override
  String get visitGooglePlay => 'Google Play sayfasını ziyaret et';

  @override
  String get gitHub => 'Kaynak kodlarına GitHub\'dan ulaşabilirsiniz';

  @override
  String get blockClient => 'İstemciyi engelle';

  @override
  String get selectTags => 'Etiketleri seç';

  @override
  String get noTagsSelected => 'Seçili etiket yok';

  @override
  String get tags => 'Etiketler';

  @override
  String get identifiers => 'Tanımlayıcılar';

  @override
  String get identifier => 'Tanımlayıcı';

  @override
  String get identifierHelper => 'IP adresi, CIDR, MAC adresi veya ClientID';

  @override
  String get noIdentifiers => 'Tanımlayıcı eklenmedi';

  @override
  String get useGlobalSettings => 'Küresel ayarları kullan';

  @override
  String get enableFiltering => 'Filtrelemeyi etkinleştir';

  @override
  String get enableSafeBrowsing => 'Güvenli gezinmeyi etkinleştir';

  @override
  String get enableParentalControl => 'Ebeveyn kontrolünü etkinleştir';

  @override
  String get enableSafeSearch => 'Güvenli aramayı etkinleştir';

  @override
  String get blockedServices => 'Engellenen hizmetler';

  @override
  String get selectBlockedServices => 'Engellenen hizmetleri seç';

  @override
  String get noBlockedServicesSelected => 'Engellenen hizmetler seçilmedi';

  @override
  String get services => 'Hizmetler';

  @override
  String get servicesBlocked => 'Hizmetler engellendi';

  @override
  String get tagsSelected => 'Etiket seçildi';

  @override
  String get upstreamServers => 'Üst sunucular';

  @override
  String get serverAddress => 'Sunucu adresi';

  @override
  String get noUpstreamServers => 'Üst sunucu yok.';

  @override
  String get willBeUsedGeneralServers => 'Genel üst sunucular kullanılacak.';

  @override
  String get added => 'Eklenenler';

  @override
  String get clientUpdatedSuccessfully =>
      'İstemci ayarları başarıyla güncellendi';

  @override
  String get clientNotUpdated => 'İstemci güncellenemedi';

  @override
  String get clientDeletedSuccessfully => 'İstemci başarıyla kaldırıldı';

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
  String get enabledRules => 'Etkin kural';

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
      'Bu özel kuralı kaldırmak istediğinizden emin misiniz?';

  @override
  String get updatingRules => 'Özel kurallar güncelleniyor...';

  @override
  String get ruleRemovedSuccessfully => 'Kural başarıyla kaldırıldı';

  @override
  String get ruleNotRemoved => 'Kural kaldırılamadı';

  @override
  String get ruleAddedSuccessfully => 'Kural başarıyla eklendi';

  @override
  String get ruleNotAdded => 'Kural eklenemedi';

  @override
  String get noCustomFilters => 'Özel filtreler yok';

  @override
  String get noBlockedClients => 'Engellenmiş istemci yok';

  @override
  String get noBlackLists => 'Kara listeler yok';

  @override
  String get noWhiteLists => 'Beyaz listeler yok';

  @override
  String get addWhitelist => 'Beyaz liste ekle';

  @override
  String get addBlacklist => 'Kara liste ekle';

  @override
  String get urlNotValid => 'Bağlantı adresi geçerli değil';

  @override
  String get urlAbsolutePath => 'Bağlantı adresi veya dosya yolu';

  @override
  String get addingList => 'Liste ekleniyor...';

  @override
  String get listAdded => 'Liste başarıyla eklendi. Eklenen öğeler:';

  @override
  String get listAlreadyAdded => 'Liste zaten eklenmiş';

  @override
  String get listUrlInvalid => 'Liste bağlantı adresi geçersiz';

  @override
  String get listNotAdded => 'Liste eklenemedi';

  @override
  String get listDetails => 'Liste detayları';

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
  String get currentStatus => 'Mevcut durum';

  @override
  String get listDataUpdated => 'Liste verileri başarıyla güncellendi';

  @override
  String get listDataNotUpdated => 'Liste verileri güncellenemedi';

  @override
  String get updatingListData => 'Liste verileri güncelleniyor...';

  @override
  String get editWhitelist => 'Beyaz listeyi düzenle';

  @override
  String get editBlacklist => 'Kara listeyi düzenle';

  @override
  String get deletingList => 'Liste siliniyor...';

  @override
  String get listDeleted => 'Liste başarıyla silindi';

  @override
  String get listNotDeleted => 'Liste silinemedi';

  @override
  String get deleteList => 'Listeyi sil';

  @override
  String get deleteListMessage =>
      'Bu listeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get serverSettings => 'Sunucu ayarları';

  @override
  String get serverInformation => 'Sunucu bilgisi';

  @override
  String get serverInformationDescription => 'Sunucu bilgisi ve durumunu öğren';

  @override
  String get loadingServerInfo => 'Sunucu bilgisi yükleniyor...';

  @override
  String get serverInfoNotLoaded => 'Sunucu bilgisi yüklenemedi.';

  @override
  String get dnsAddresses => 'DNS adresleri';

  @override
  String get seeDnsAddresses => 'DNS adreslerine göz at';

  @override
  String get dnsPort => 'DNS bağlantı noktası';

  @override
  String get httpPort => 'HTTP bağlantı noktası';

  @override
  String get protectionEnabled => 'Koruma durumu';

  @override
  String get dhcpAvailable => 'DHCP durumu';

  @override
  String get serverRunning => 'Sunucu durumu';

  @override
  String get serverVersion => 'Sunucu sürümü';

  @override
  String get serverLanguage => 'Sunucu dili';

  @override
  String get yes => 'Etkin';

  @override
  String get no => 'Mevcut değil';

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
      'Sunucu için erişim kurallarını yapılandır';

  @override
  String get loadingClients => 'İstemciler yükleniyor...';

  @override
  String get clientsNotLoaded => 'İstemciler yüklenemedi.';

  @override
  String get noAllowedClients => 'İzin verilmiş istemci yok';

  @override
  String get allowedClientsDescription =>
      'Eğer bu liste girdiler içeriyorsa, AdGuard Home yalnızca bu istemcilerden gelen talepleri kabul edecektir.';

  @override
  String get blockedClientsDescription =>
      'Bu liste girdileri içeriyorsa, AdGuard Home bu istemcilerden gelen talepleri reddedecektir. Bu alan adı, İzin Verilen İstemciler\'de girdi varsa görmezden gelinir.';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home, bu alan adlarına uyan DNS sorgularını reddeder ve bu sorgular sorgu günlüğünde bile görünmez.';

  @override
  String get addClientFieldDescription => 'CIDR\'ler, IP adresi veya ClientID';

  @override
  String get clientIdentifier => 'İstemci tanımlayıcısı';

  @override
  String get allowClient => 'İstemciye izin ver';

  @override
  String get disallowClient => 'İstemciyi engelle';

  @override
  String get noDisallowedDomains => 'İzin verilmeyen alan adı yok';

  @override
  String get domainNotAdded => 'Alan adı eklenemedi';

  @override
  String get statusSelected => 'Durum seçildi.';

  @override
  String get updateLists => 'Listeleri güncelle';

  @override
  String get checkHostFiltered => 'Filtrelemeyi kontrol et';

  @override
  String get updatingLists => 'Listeler güncelleniyor...';

  @override
  String get listsUpdated => 'Listeler güncellendi';

  @override
  String get listsNotUpdated => 'Listeler güncellenemedi';

  @override
  String get listsNotLoaded => 'Listeler yüklenemedi';

  @override
  String get domainNotValid => 'Alan adı geçersiz';

  @override
  String get check => 'Kontrol et';

  @override
  String get checkingHost => 'Kontrol ediliyor';

  @override
  String get errorCheckingHost => 'Kontrol etme başarısız';

  @override
  String get block => 'Engelle';

  @override
  String get unblock => 'Engeli kaldır';

  @override
  String get custom => 'Özel';

  @override
  String get addImportant => 'Başına \$important ekle';

  @override
  String get howCreateRules => 'Özel kurallar nasıl oluşturulur?';

  @override
  String get examples => 'Örnekler';

  @override
  String get example1 =>
      'example.org ve tüm alt alan adlarına erişimi engeller.';

  @override
  String get example2 =>
      'example.org ve tüm alt alan adlarına erişimi engellemeyi kaldırır.';

  @override
  String get example3 => 'Yorum ekler.';

  @override
  String get example4 =>
      'Belirtilen düzenli ifadeye uyan alan adlarına erişimi engeller.';

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
  String get filteringStatusUpdated =>
      'Filtreleme durumu başarıyla güncellendi';

  @override
  String get filteringStatusNotUpdated => 'Filtreleme durumu güncellenemedi';

  @override
  String get updateFrequency => 'Güncelleme sıklığı';

  @override
  String get never => 'Asla';

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
  String get updateFrequencyChanged =>
      'Güncelleme sıklığı başarıyla değiştirildi';

  @override
  String get updateFrequencyNotChanged => 'Güncelleme sıklığı değiştirilemedi';

  @override
  String get updating => 'Değerler güncelleniyor...';

  @override
  String get blockedServicesUpdated =>
      'Engellenen hizmetler başarıyla güncellendi';

  @override
  String get blockedServicesNotUpdated => 'Engellenen hizmetler güncellenemedi';

  @override
  String get insertDomain =>
      'Filtreleme durumunu kontrol etmek için bir alan adı ekleyin.';

  @override
  String get dhcpSettings => 'DHCP ayarları';

  @override
  String get dhcpSettingsDescription => 'DHCP sunucusunu yapılandır';

  @override
  String get dhcpSettingsNotLoaded => 'DHCP ayarları yüklenemedi';

  @override
  String get loadingDhcp => 'DHCP ayarları yükleniyor...';

  @override
  String get enableDhcpServer => 'DHCP sunucusunu etkinleştir';

  @override
  String get selectInterface => 'Arayüz seç';

  @override
  String get hardwareAddress => 'Donanım adresi';

  @override
  String get gatewayIp => 'Ağ Geçidi IP\'si';

  @override
  String get ipv4addresses => 'IPv4 adresleri';

  @override
  String get ipv6addresses => 'IPv6 adresleri';

  @override
  String get neededSelectInterface =>
      'DHCP sunucusunu yapılandırmak için bir arayüz seçmeniz gerekir.';

  @override
  String get ipv4settings => 'IPv4 ayarları';

  @override
  String get startOfRange => 'Menzilin başlangıcı';

  @override
  String get endOfRange => 'Menzilin sonu';

  @override
  String get ipv6settings => 'IPv6 ayarları';

  @override
  String get subnetMask => 'Alt ağ maskesi';

  @override
  String get subnetMaskNotValid => 'Alt ağ maskesi geçerli değil';

  @override
  String get gateway => 'Ağ Geçidi';

  @override
  String get gatewayNotValid => 'Ağ geçidi geçerli değil';

  @override
  String get leaseTime => 'Kira süresi';

  @override
  String seconds(Object time) {
    return '$time saniye';
  }

  @override
  String get leaseTimeNotValid => 'Kira süresi geçerli değil';

  @override
  String get restoreConfiguration => 'Yapılandırmayı sıfırla';

  @override
  String get restoreConfigurationMessage =>
      'Devam etmek istediğinizden emin misiniz? Bu, tüm yapılandırmayı sıfırlayacak. Bu işlem geri alınamaz.';

  @override
  String get changeInterface => 'Arayüzü değiştir';

  @override
  String get savingSettings => 'Ayarlar kaydediliyor...';

  @override
  String get settingsSaved => 'Ayarlar başarıyla kaydedildi';

  @override
  String get settingsNotSaved => 'Ayarlar kaydedilemedi';

  @override
  String get restoringConfig => 'Yapılandırma geri yükleniyor...';

  @override
  String get configRestored => 'Yapılandırma başarıyla sıfırlandı';

  @override
  String get configNotRestored => 'Yapılandırma sıfırlanamadı';

  @override
  String get dhcpStatic => 'DHCP statik kiraları';

  @override
  String get noDhcpStaticLeases => 'DHCP statik kirası bulunamadı';

  @override
  String get deleting => 'Siliniyor...';

  @override
  String get staticLeaseDeleted => 'DHCP statik kirası başarıyla silindi';

  @override
  String get staticLeaseNotDeleted => 'DHCP statik kirası silinemedi';

  @override
  String get deleteStaticLease => 'Statik kirasını sil';

  @override
  String get deleteStaticLeaseDescription =>
      'DHCP statik kirası silinecek. Bu işlem geri alınamaz.';

  @override
  String get addStaticLease => 'Statik kira ekleyin';

  @override
  String get macAddress => 'MAC adresi';

  @override
  String get macAddressNotValid => 'MAC adresi geçersiz';

  @override
  String get hostName => 'Ana bilgisayar adı';

  @override
  String get hostNameError => 'Ana bilgisayar adı boş olamaz';

  @override
  String get creating => 'Oluşturuluyor...';

  @override
  String get staticLeaseCreated => 'DHCP statik kirası başarıyla oluşturuldu';

  @override
  String get staticLeaseNotCreated => 'DHCP statik kirası oluşturulamadı';

  @override
  String get staticLeaseExists => 'DHCP statik kirası zaten mevcut';

  @override
  String get serverNotConfigured => 'Sunucu yapılandırılmamış';

  @override
  String get restoreLeases => 'Kiraları sıfırla';

  @override
  String get restoreLeasesMessage =>
      'Devam etmek istediğinizden emin misiniz? Bu, mevcut tüm kiraları sıfırlayacaktır. Bu işlem geri alınamaz.';

  @override
  String get restoringLeases => 'Kiralar sıfırlanıyor...';

  @override
  String get leasesRestored => 'Kiralar başarıyla sıfırlandı';

  @override
  String get leasesNotRestored => 'Kiralar sıfırlanamadı';

  @override
  String get dhcpLeases => 'DHCP kiraları';

  @override
  String get noLeases => 'Kullanılabilir DHCP kiraları yok';

  @override
  String get dnsRewrites => 'DNS yeniden yazımları';

  @override
  String get dnsRewritesDescription => 'Özel DNS kurallarını yapılandır';

  @override
  String get loadingRewriteRules => 'Yeniden yazım kuralları yükleniyor...';

  @override
  String get rewriteRulesNotLoaded =>
      'DNS yeniden yazım kuralları yüklenemedi.';

  @override
  String get noRewriteRules => 'DNS yeniden yazım kuralları yok';

  @override
  String get answer => 'Yanıt';

  @override
  String get deleteDnsRewrite => 'DNS yeniden yazımını sil';

  @override
  String get deleteDnsRewriteMessage =>
      'Bu DNS yeniden yazımını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get dnsRewriteRuleDeleted =>
      'DNS yeniden yazım kuralı başarıyla silindi';

  @override
  String get dnsRewriteRuleNotDeleted => 'DNS yeniden yazım kuralı silinemedi';

  @override
  String get addDnsRewrite => 'DNS yeniden yazımı ekle';

  @override
  String get addingRewrite => 'Yeniden yazım ekleniyor...';

  @override
  String get dnsRewriteRuleAdded =>
      'DNS yeniden yazım kuralı başarıyla eklendi';

  @override
  String get dnsRewriteRuleNotAdded => 'DNS yeniden yazım kuralı eklenemedi';

  @override
  String get logsSettings => 'Günlük ayarları';

  @override
  String get enableLog => 'Günlüğü etkinleştir';

  @override
  String get clearLogs => 'Günlükleri temizle';

  @override
  String get anonymizeClientIp => 'İstemci IP\'sini gizle';

  @override
  String get hours6 => '6 saat';

  @override
  String get days30 => '30 gün';

  @override
  String get days90 => '90 gün';

  @override
  String get retentionTime => 'Saklama süresi';

  @override
  String get selectOneItem => 'Bir öğe seçin';

  @override
  String get logSettingsNotLoaded => 'Günlük ayarları yüklenemedi.';

  @override
  String get updatingSettings => 'Ayarlar güncelleniyor...';

  @override
  String get logsConfigUpdated => 'Günlük ayarları başarıyla güncellendi';

  @override
  String get logsConfigNotUpdated => 'Günlük ayarları güncellenemedi';

  @override
  String get deletingLogs => 'Günlükler temizleniyor...';

  @override
  String get logsCleared => 'Günlükler başarıyla temizlendi';

  @override
  String get logsNotCleared => 'Günlükler temizlenemedi';

  @override
  String get runningHomeAssistant => 'Ev asistanı üzerinde çalıştır';

  @override
  String get serverError => 'Sunucu hatası';

  @override
  String get noItems => 'Burada gösterilecek öğe yok';

  @override
  String get dnsSettings => 'DNS ayarları';

  @override
  String get dnsSettingsDescription =>
      'DNS sunucuları ile bağlantıyı yapılandır';

  @override
  String get upstreamDns => 'Üst DNS sunucuları';

  @override
  String get bootstrapDns => 'Önyükleme DNS sunucuları';

  @override
  String get noUpstreamDns => 'Üst DNS sunucuları eklenmedi.';

  @override
  String get dnsMode => 'DNS modu';

  @override
  String get noDnsMode => 'DNS modu seçili değil';

  @override
  String get loadBalancing => 'Yük dengeleme';

  @override
  String get parallelRequests => 'Paralel istekler';

  @override
  String get fastestIpAddress => 'En hızlı IP adresi';

  @override
  String get loadBalancingDescription =>
      'Her seferinde bir üst sunucuya sorgu yapar. AdGuard Home, sunucuyu seçmek için ağırlıklı rastgele algoritmasını kullanır, böylece en hızlı sunucu daha sık kullanılır.';

  @override
  String get parallelRequestsDescription =>
      'Tüm üst sunucuları aynı anda sorgulayarak çözümlemeyi hızlandırmak için paralel sorgular kullanılır.';

  @override
  String get fastestIpAddressDescription =>
      'Tüm DNS sunucularına sorgu yapın ve tüm yanıtlar arasında en hızlı IP adresini döndürür. Bu, AdGuard Home\'un tüm DNS sunucularından yanıtları beklemesi gerektiği için DNS sorgularını yavaşlatır, ancak genel bağlantıyı iyileştirir.';

  @override
  String get noBootstrapDns => 'Önyükleme DNS sunucuları eklenmedi.';

  @override
  String get bootstrapDnsServersInfo =>
      'Önyükleme ​​DNS sunucuları, üst kaynaklarda belirttiğiniz DoH/DoT çözümleyicilerinin IP adreslerini çözmek için kullanılır.';

  @override
  String get privateReverseDnsServers => 'Özel ters DNS sunucuları';

  @override
  String get privateReverseDnsServersDescription =>
      'AdGuard Home\'un yerel PTR sorguları için kullandığı DNS sunucuları. Bu sunucular, özel IP aralıklarındaki adresler için ters DNS kullanarak PTR isteklerini çözmek için kullanılır, örneğin \'192.168.12.34\' olarak ayarlanmamışsa AdGuard Home, AdGuard Home\'un kendi adresleri dışında, işletim sisteminizin varsayılan DNS çözümleyicilerinin adreslerini kullanır.';

  @override
  String get reverseDnsDefault =>
      'Varsayılan olarak, AdGuard Home aşağıdaki ters DNS çözümleyicilerini kullanır';

  @override
  String get addItem => 'Öğe ekle';

  @override
  String get noServerAddressesAdded => 'Sunucu adresleri eklenmedi.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Özel ters DNS çözümleyicilerini kullan';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Bu üst sunucuları kullanarak yerel olarak sunulan adresler için ters DNS sorguları gerçekleştirin. Devre dışı bırakılırsa, AdGuard Home, DHCP, /etc/hosts vb. kaynaklardan bilinen istemciler dışında tüm PTR isteklerine NXDOMAIN yanıtı verir.';

  @override
  String get enableReverseResolving =>
      'İstemcilerin IP adreslerinin ters çözümlemesini etkinleştir';

  @override
  String get enableReverseResolvingDescription =>
      'Karşılık gelen çözümleyicilere (yerel istemciler için özel DNS sunucuları, genel IP adresleri olan istemciler için üst sunuculara) PTR sorguları göndererek istemcilerin IP adreslerini ana makine adlarının tersine çözer.';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS sunucusu ayarları';

  @override
  String get limitRequestsSecond => 'Sıklık limiti';

  @override
  String get valueNotNumber => 'Değer bir sayı değil';

  @override
  String get enableEdns => 'EDNS istemci alt ağını etkinleştir';

  @override
  String get enableEdnsDescription =>
      'Kaynak yönü isteklerine EDNS İstemci Alt Ağı Seçeneği (ECS) ekler ve istemciler tarafından gönderilen değerleri sorgu günlüğüne kaydeder.';

  @override
  String get enableDnssec => 'DNSSEC\'i etkinleştir';

  @override
  String get enableDnssecDescription =>
      'Giden DNS sorguları için DNSSEC özelliğini etkinleştirir ve sonucu kontrol eder. (DNSSEC etkinleştirilmiş bir çözümleyici gerekli)';

  @override
  String get disableResolvingIpv6 =>
      'IPv6 adreslerinin çözümlenmesini devre dışı bırak';

  @override
  String get disableResolvingIpv6Description =>
      'IPv6 adresleri için tüm DNS sorgularını bırakır (AAAA yazar) ve HTTPS yanıtlarından IPv6 ipuçlarını kaldırır.';

  @override
  String get blockingMode => 'Engelleme modu';

  @override
  String get defaultMode => 'Varsayılan';

  @override
  String get defaultDescription =>
      'Reklam engelleme tarzı bir kural tarafından engellendiğinde sıfır IP adresi ile yanıt verir. (A için 0.0.0.0; :: AAAA için) /etc/hosts tarzı bir kural tarafından engellendiğinde kuralda belirtilen IP adresi ile yanıt verir.';

  @override
  String get refusedDescription => 'REFUSED kodu ile yanıt verir.';

  @override
  String get nxdomainDescription => 'NXDOMAIN kodu ile yanıt verir.';

  @override
  String get nullIp => 'Boş IP';

  @override
  String get nullIpDescription =>
      'Sıfır IP adresi ile yanıt verir. (A için 0.0.0.0; :: AAAA için)';

  @override
  String get customIp => 'Özel IP';

  @override
  String get customIpDescription =>
      'Manuel olarak ayarlanmış bir IP adresi ile yanıt verir.';

  @override
  String get dnsCacheConfig => 'DNS önbellek yapılandırması';

  @override
  String get cacheSize => 'Önbellek boyutu';

  @override
  String get inBytes => 'Alınacak önbelleğin boyutunu ayarla (Bayt olarak)';

  @override
  String get overrideMinimumTtl => 'Minimum kullanım süresini geçersiz kıl';

  @override
  String get overrideMinimumTtlDescription =>
      'DNS yanıtlarını önbelleğe alırken üst sunucudan alınan minimum kullanım süresi değerini (TTL) saniye olarak ayarlayın.';

  @override
  String get overrideMaximumTtl => 'Maksimum kullanım süresini geçersiz kıl';

  @override
  String get overrideMaximumTtlDescription =>
      'DNS yanıtlarını önbelleğe alırken üst sunucudan alınan maksimum kullanım süresi değerini (TTL) saniye olarak ayarlayın.';

  @override
  String get optimisticCaching => 'İyimser önbelleğe alma';

  @override
  String get optimisticCachingDescription =>
      'Girişlerin süresi dolmuş olsa bile Adguard Home\'un önbellekten yanıt vermesini sağlar ve aynı zamanda bunları yenilemeye çalışır.';

  @override
  String get loadingDnsConfig => 'DNS yapılandırması yükleniyor...';

  @override
  String get dnsConfigNotLoaded => 'DNS yapılandırması yüklenemedi.';

  @override
  String get blockingIpv4 => 'IPv4 engelleniyor';

  @override
  String get blockingIpv4Description =>
      'Engellenen bir A isteği için döndürülecek IP adresi';

  @override
  String get blockingIpv6 => 'IPv6 engelleniyor';

  @override
  String get blockingIpv6Description =>
      'Engellenen bir AAAA isteği için döndürülecek IP adresi';

  @override
  String get invalidIp => 'Geçersiz IP adresi';

  @override
  String get dnsConfigSaved =>
      'DNS sunucusu yapılandırması başarıyla kaydedildi';

  @override
  String get dnsConfigNotSaved => 'DNS sunucusu yapılandırması kaydedilemedi';

  @override
  String get savingConfig => 'Yapılandırma kaydediliyor...';

  @override
  String get someValueNotValid => 'Bazı değerler geçerli değil';

  @override
  String get upstreamDnsDescription =>
      'Üst sunucuları ve DNS modunu yapılandır';

  @override
  String get bootstrapDnsDescription => 'Önyükleme DNS sunucularını yapılandır';

  @override
  String get privateReverseDnsDescription =>
      'Özel DNS çözümleyicileri yapılandır ve özel ters DNS çözümlemeyi etkinleştir';

  @override
  String get dnsServerSettingsDescription =>
      'Hız limiti, engelleme modu ve daha fazlasını yapılandır';

  @override
  String get dnsCacheConfigDescription =>
      'Sunucunun DNS önbelleğini nasıl yöneteceğini yapılandır';

  @override
  String get comment => 'Yorum';

  @override
  String get address => 'Adres';

  @override
  String get commentsDescription =>
      'Yorumlar her zaman # işareti ile başlar. Eklemenize gerek yok, otomatik olarak eklenecektir.';

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
      'Eğer şifreleme etkinleştirilmişse, AdGuard Home yönetici arayüzü HTTPS üzerinden çalışacaktır ve DNS sunucusu DNS üzerinden HTTPS ve TLS ile gelen isteklere yanıt verecektir.';

  @override
  String get serverConfiguration => 'Sunucu yapılandırması';

  @override
  String get domainName => 'Alan adı';

  @override
  String get domainNameDescription =>
      'Eğer ayarlanırsa, AdGuard Home istemci kimliklerini tespit eder, DDR sorgularına yanıt verir ve ek bağlantı doğrulamalarını gerçekleştirir. Ayarlanmazsa, bu özellikler devre dışı bırakılır. Sertifikadaki DNS adlarından biriyle eşleşmelidir.';

  @override
  String get redirectHttps => 'Otomatik olarak HTTPS\'e yönlendir';

  @override
  String get httpsPort => 'HTTPS bağlantı noktası';

  @override
  String get tlsPort => 'DNS-over-TLS bağlantı noktası';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC bağlantı noktası';

  @override
  String get certificates => 'Sertifikalar';

  @override
  String get certificatesDescription =>
      'Şifreleme kullanmak için, alan adınız için geçerli bir SSL sertifikası zinciri sağlamanız gereklidir. letsencrypt.org\'dan ücretsiz bir sertifika alabilir veya güvenilir sertifika yetkililerinden satın alabilirsiniz.';

  @override
  String get certificateFilePath => 'Sertifika dosyası belirle';

  @override
  String get pasteCertificateContent => 'Sertifika içeriğini yapıştır';

  @override
  String get certificatePath => 'Sertifikanın dosya yolu';

  @override
  String get certificateContent => 'Sertifika içeriği';

  @override
  String get privateKey => 'Özel anahtarlar';

  @override
  String get privateKeyFile => 'Özel anahtar dosyası belirle';

  @override
  String get pastePrivateKey => 'Özel anahtar içeriğini yapıştır';

  @override
  String get usePreviousKey => 'Önceden kaydedilmiş olan anahtarı kullan';

  @override
  String get privateKeyPath => 'Özel anahtarın dosya yolu';

  @override
  String get invalidCertificate => 'Geçersiz sertifika';

  @override
  String get invalidPrivateKey => 'Geçersiz özel anahtar';

  @override
  String get validatingData => 'Veri doğrulama';

  @override
  String get dataValid => 'Veri geçerli';

  @override
  String get dataNotValid => 'Veri geçersiz';

  @override
  String get encryptionConfigSaved =>
      'Şifreleme yapılandırması başarıyla kaydedildi';

  @override
  String get encryptionConfigNotSaved =>
      'Şifreleme yapılandırması kaydedilemedi';

  @override
  String get configError => 'Yapılandırma hatası';

  @override
  String get enterOnlyCertificate =>
      'Yalnızca sertifikayı girin. ---BEGIN--- ve ---END--- satırlarını girmeyin.';

  @override
  String get enterOnlyPrivateKey =>
      'Yalnızca anahtarı girin. ---BEGIN--- ve ---END--- satırlarını girmeyin.';

  @override
  String get noItemsSearch => 'Bu arama için hiçbir öğe yok.';

  @override
  String get clearSearch => 'Aramayı temizle';

  @override
  String get exitSearch => 'Aramadan çık';

  @override
  String get searchClients => 'İstemcileri ara';

  @override
  String get noClientsSearch =>
      'Bu arama ile ilgili hiçbir istemci bulunamadı.';

  @override
  String get customization => 'Özelleştirme';

  @override
  String get customizationDescription => 'Bu uygulamayı özelleştir';

  @override
  String get color => 'Renk';

  @override
  String get useDynamicTheme => 'Dinamik renk teması kullan';

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
  String get useThemeColorStatus => 'Durum için tema rengini kullan';

  @override
  String get useThemeColorStatusDescription =>
      'Yeşil ve kırmızı durum renklerini tema rengi ve gri ile değiştirir.';

  @override
  String get invalidCertificateChain => 'Geçersiz sertifika zinciri';

  @override
  String get validCertificateChain => 'Geçerli sertifika zinciri';

  @override
  String get subject => 'Konu';

  @override
  String get issuer => 'Veren';

  @override
  String get expires => 'Süresi dolacak';

  @override
  String get validPrivateKey => 'Geçerli özel anahtar';

  @override
  String get expirationDate => 'Son kullanma tarihi';

  @override
  String get keysNotMatch =>
      'Geçersiz bir sertifika veya anahtar: tls: özel anahtar genel anahtarla eşleşmiyor.';

  @override
  String get timeLogs => 'Günlüklerde işlem süresini göster';

  @override
  String get timeLogsDescription =>
      'Günlükler listesinde zaman yerine işlem süresini gösterir.';

  @override
  String get hostNames => 'Ana bilgisayar adları';

  @override
  String get keyType => 'Anahtar türü';

  @override
  String get updateAvailable => 'Güncelleme mevcut';

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
  String get doNotRememberAgainUpdate => 'Bu sürüm için tekrar hatırlama.';

  @override
  String get downloadingUpdate => 'İndiriliyor';

  @override
  String get completed => 'Tamamlandı';

  @override
  String get permissionNotGranted => 'İzin verilmedi';

  @override
  String get inputSearchTerm => 'Bir arama terimi girin.';

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
      'DNS önbelleğini temizlemek istediğinizden emin misiniz?';

  @override
  String get dnsCacheCleared => 'DNS önbelleği başarıyla temizlendi';

  @override
  String get clearingDnsCache => 'Önbellek temizleniyor...';

  @override
  String get dnsCacheNotCleared => 'DNS önbelleği temizlenemedi';

  @override
  String get clientsSelected => 'Seçilmiş istemci';

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
  String get updatesDescription => 'AdGuard Home sunucusunu güncelle';

  @override
  String get updateNow => 'Şimdi güncelle';

  @override
  String get currentVersion => 'Yüklü sürüm';

  @override
  String get requestStartUpdateFailed =>
      'Güncellemeyi başlatma isteği başarısız oldu';

  @override
  String get requestStartUpdateSuccessful =>
      'Güncellemeyi başlatma isteği başarılı';

  @override
  String get serverUpdated => 'Sunucu güncellendi';

  @override
  String get unknownStatus => 'Bilinmeyen durum';

  @override
  String get checkingUpdates => 'Güncellemeler kontrol ediliyor...';

  @override
  String get checkUpdates => 'Güncellemeleri kontrol et';

  @override
  String get requestingUpdate => 'Güncelleme talep ediliyor...';

  @override
  String get autoupdateUnavailable => 'Otomatik güncelleme kullanılamıyor';

  @override
  String get autoupdateUnavailableDescription =>
      'Otomatik güncelleme servisi bu sunucu için kullanılamıyor. Bunun nedeni sunucunun bir Docker konteynerinde çalışıyor olması olabilir. Sunucunuzu manuel olarak güncellemeniz gerekecektir.';

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
      'Güvenli arama ayarları yüklenirken hata oluştu.';

  @override
  String get loadingLogsSettings => 'Günlük ayarları yükleniyor...';

  @override
  String get selectOptionLeftColumn => 'Sol sütundan bir seçenek seçin';

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
  String get seeDetails => 'Detayları gör';

  @override
  String get listNotAvailable => 'Liste mevcut değil';

  @override
  String get copyListUrl => 'Bağlantıyı kopyala';

  @override
  String get listUrlCopied => 'Liste bağlantısı panoya kopyalandı';

  @override
  String get unsupportedVersion => 'Desteklenmeyen sürüm';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'Sunucu sürümünüz $version için destek garantisi verilmiyor. Bu uygulamanın bu sunucu sürümüyle çalışmasında bazı sorunlar olabilir. AdGuard Home Yöneticisi, AdGuard Home sunucunun kararlı sürümleriyle çalışacak şekilde tasarlanmıştır. Alfa ve beta sürümleriyle çalışabilir, ancak uyumluluk garanti edilmez ve uygulama bu sürümlerle çalışırken bazı sorunlar yaşayabilir.';
  }

  @override
  String get iUnderstand => 'Anladım';

  @override
  String get appUpdates => 'Uygulama güncellemeleri';

  @override
  String get usingLatestVersion => 'En son sürümü kullanıyorsunuz';

  @override
  String get ipLogs => 'Günlüklerde IP adresini göster';

  @override
  String get ipLogsDescription =>
      'Günlükler listesinde istemci adı yerine IP adresini gösterir.';

  @override
  String get application => 'Uygulama';

  @override
  String get combinedChart => 'Birleştirilmiş grafik';

  @override
  String get combinedChartDescription => 'Tüm grafikleri bir araya getirir.';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get errorLoadFilters => 'Filtreler yüklenirken hata oluştu.';

  @override
  String get clientRemovedSuccessfully => 'İstemci başarıyla kaldırıldı.';

  @override
  String get editRewriteRule => 'Yeniden yazım kuralını düzenle';

  @override
  String get dnsRewriteRuleUpdated =>
      'DNS yeniden yazım kuralı başarıyla güncellendi';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'DNS yeniden yazım kuralı güncellenemedi';

  @override
  String get updatingRule => 'Kural güncelleniyor...';

  @override
  String get serverUpdateNeeded => 'Sunucu güncellemesi gerekli';

  @override
  String updateYourServer(Object version) {
    return 'Bu özelliği kullanmak için AdGuard Home sunucunuzu $version veya üzeri bir sürüme güncelleyin.';
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
  String get malwarePhishing => 'Zararlı yazılım/oltalama';

  @override
  String get queries => 'Sorgular';

  @override
  String get adultSites => 'Yetişkin içerikler';

  @override
  String get quickFilters => 'Hızlı filtreler';

  @override
  String get searchDomainInternet => 'Alan adını arat';

  @override
  String get hideServerAddress => 'Sunucu adresini gizle';

  @override
  String get hideServerAddressDescription =>
      'Ana ekranda sunucu adresini gizler.';

  @override
  String get topItemsOrder => 'Öne çıkan öğeler sıralaması';

  @override
  String get topItemsOrderDescription =>
      'Ana ekrandaki öne çıkan öğe listelerini sıralayın.';

  @override
  String get topItemsReorderInfo =>
      'Yeniden sıralamak için bir öğeyi basılı tutun ve kaydırın.';

  @override
  String get discardChanges => 'Değişiklikleri iptal et';

  @override
  String get discardChangesDescription =>
      'Değişiklikleri iptal etmek istediğinizden emin misiniz?';

  @override
  String get others => 'Diğerleri';

  @override
  String get showChart => 'Göster';

  @override
  String get hideChart => 'Gizle';

  @override
  String get showTopItemsChart => 'Öne çıkan öğeler grafiği';

  @override
  String get showTopItemsChartDescription =>
      'Varsayılan olarak öne çıkan öğeler bölümünde halka grafiğini gösterir. Sadece mobil görünümü etkiler.';

  @override
  String get openMenu => 'Menüyü genişlet';

  @override
  String get closeMenu => 'Menüyü daralt';

  @override
  String get openListUrl => 'Liste bağlantısını aç';

  @override
  String get selectionMode => 'Seçim modu';

  @override
  String get enableDisableSelected =>
      'Seçili öğeleri etkinleştir veya devre dışı bırak';

  @override
  String get deleteSelected => 'Seçili öğeleri sil';

  @override
  String get deleteSelectedLists => 'Seçili listeleri sil';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'Seçilen tüm listeler başarıyla silindi.';

  @override
  String get deletionResult => 'Silinme sonucu';

  @override
  String get deletingLists => 'Listeler siliniyor...';

  @override
  String get failedElements => 'Başarısız öğeler';

  @override
  String get processingLists => 'Listeler işleniyor...';

  @override
  String get enableDisableResult => 'Sonucu etkinleştir veya devre dışı bırak';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'Seçilen tüm listeler başarıyla etkinleştirildi veya devre dışı bırakıldı';

  @override
  String get sslWarning =>
      'Kendinden imzalı bir sertifika ile HTTPS bağlantısı kullanıyorsanız, Ayarlar > Gelişmiş ayarlar bölümünde \"SSL sertifikasını asla kontrol etme\" seçeneğini etkinleştirdiğinizden emin olun.';

  @override
  String get unsupportedServerVersion => 'Desteklenmeyen sunucu sürümü';

  @override
  String get unsupportedServerVersionMessage =>
      'AdGuard Home sunucu sürümünüz çok eski ve AdGuard Home Manager tarafından desteklenmiyor. Bu uygulamayı kullanmak için AdGuard Home sunucunuzu daha yeni bir sürüme yükseltmeniz gerekecektir.';

  @override
  String yourVersion(Object version) {
    return 'Yüklü sürüm: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Gerekli minimum sürüm: $version';
  }

  @override
  String get topUpstreams => 'Öne çıkan DNS sunucuları';

  @override
  String get averageUpstreamResponseTime => 'DNS sunucuları işlem süresi';

  @override
  String get dhcpNotAvailable => 'DHCP sunucusu kullanılamıyor.';

  @override
  String get osServerInstalledIncompatible =>
      'AdGuard Home, işletim sisteminizde DHCP sunucusu çalıştıramıyor.';

  @override
  String get resetSettings => 'Ayarları sıfırla';

  @override
  String get resetEncryptionSettingsDescription =>
      'Şifreleme ayarlarını sıfırlamak istediğinizden emin misiniz?';

  @override
  String get resettingConfig => 'Yapılandırma sıfırlanıyor...';

  @override
  String get configurationResetSuccessfully =>
      'Yapılandırma başarıyla sıfırlandı';

  @override
  String get configurationResetError => 'Yapılandırma sıfırlanamadı';

  @override
  String get testUpstreamDnsServers => 'DNS sunucusunu test et';

  @override
  String get errorTestUpstreamDns =>
      'DNS sunucularını test ederken hata oluştu.';

  @override
  String get useCustomIpEdns => 'EDNS için özel IP kullan';

  @override
  String get useCustomIpEdnsDescription =>
      'EDNS için özel IP kullanımına izin ver';

  @override
  String get sortingOptions => 'Sıralama seçenekleri';

  @override
  String get fromHighestToLowest => 'Yüksekten düşüğe';

  @override
  String get fromLowestToHighest => 'Düşükten yükseğe';

  @override
  String get queryLogsAndStatistics => 'Sorgu günlüğü ve istatistikler';

  @override
  String get ignoreClientQueryLog => 'Sorgu günlüğünde bu istemciyi yoksay';

  @override
  String get ignoreClientStatistics => 'İstatistiklerde bu istemciyi yoksay';

  @override
  String get savingChanges => 'Değişiklikler kaydediliyor...';

  @override
  String get fallbackDnsServers => 'Yedek DNS sunucuları';

  @override
  String get fallbackDnsServersDescription =>
      'Yedek DNS sunucularını yapılandır';

  @override
  String get fallbackDnsServersInfo =>
      'Üst DNS sunucuları yanıt vermediğinde kullanılan yedek DNS sunucularının listesi. Sözdizimi, yukarıdaki ana üst kaynak alanıyla aynıdır.';

  @override
  String get noFallbackDnsAdded => 'Yedek DNS sunucusu eklenmedi.';

  @override
  String get blockedResponseTtl => 'Engellenen yanıtın kullanım süresi';

  @override
  String get blockedResponseTtlDescription =>
      'İstemcilerin filtrelenmiş bir yanıtı kaç saniye süreyle önbelleğe alması gerektiğini belirtir';

  @override
  String get invalidValue => 'Geçersiz değer';

  @override
  String get noDataChart => 'Bu grafiği görüntüleyecek veri yok.';

  @override
  String get noData => 'Veri yok';

  @override
  String get unblockClient => 'İstemci engelini kaldır';

  @override
  String get blockingClient => 'İstemci engelleniyor...';

  @override
  String get unblockingClient => 'İstemci engeli kaldırılıyor...';

  @override
  String get upstreamDnsCacheConfiguration => 'DNS önbellek yapılandırması';

  @override
  String get enableDnsCachingClient =>
      'Bu istemci için DNS önbelleğe almayı etkinleştir';

  @override
  String get dnsCacheSize => 'DNS önbellek boyutu (Bayt cinsinden)';

  @override
  String get nameInvalid => 'Ad gereklidir';

  @override
  String get oneIdentifierRequired => 'En az bir tanımlayıcı gereklidir';

  @override
  String get dnsCacheNumber => 'DNS önbellek boyutu bir rakam içermelidir';

  @override
  String get errors => 'Hatalar';

  @override
  String get redirectHttpsWarning =>
      'AdGuard Home sunucunuzda \"Otomatik olarak HTTPS\'e yönlendir\" seçeneğini etkinleştirdiyseniz, bir HTTPS bağlantısı seçmeli ve sunucunuzun HTTPS bağlantı noktasını kullanmalısınız.';

  @override
  String get logsSettingsDescription => 'Sorgu günlüklerini yapılandır';

  @override
  String get ignoredDomains => 'Yok sayılan alan adları';

  @override
  String get noIgnoredDomainsAdded => 'Yok sayılacak alan adı eklenmedi';

  @override
  String get pauseServiceBlocking => 'Hizmet engellemeyi duraklat';

  @override
  String get newSchedule => 'Yeni program';

  @override
  String get editSchedule => 'Programı düzenle';

  @override
  String get timezone => 'Zaman dilimi';

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
  String get selectStartTime => 'Başlangıç zamanını seç';

  @override
  String get selectEndTime => 'Bitiş zamanını seç';

  @override
  String get startTimeBeforeEndTime =>
      'Başlangıç zamanı bitiş zamanından önce olmalıdır.';

  @override
  String get noBlockingScheduleThisDevice =>
      'Bu cihaz için herhangi bir engelleme programı bulunmamaktadır.';

  @override
  String get selectTimezone => 'Bir zaman dilimi seç';

  @override
  String get selectClientsFiltersInfo =>
      'Görüntülemek istediğiniz istemcileri seçin. Hiçbir istemci seçilmemişse, hepsi görüntülenecektir.';

  @override
  String get noDataThisSection => 'Bu bölüm için veri yok.';

  @override
  String get statisticsSettings => 'İstatistik ayarları';

  @override
  String get statisticsSettingsDescription =>
      'İstatistikler için veri toplamayı yapılandır';

  @override
  String get loadingStatisticsSettings => 'İstatistik ayarları yükleniyor...';

  @override
  String get statisticsSettingsLoadError =>
      'İstatistik ayarları yüklenirken bir hata oluştu.';

  @override
  String get statisticsConfigUpdated =>
      'İstatistik ayarları başarıyla güncellendi';

  @override
  String get statisticsConfigNotUpdated => 'İstatistik ayarları güncellenemedi';

  @override
  String get customTimeInHours => 'Özel zaman (Saat olarak)';

  @override
  String get invalidTime => 'Geçersiz zaman';

  @override
  String get removeDomain => 'Alan adını kaldır';

  @override
  String get addDomain => 'Alan adı ekle';

  @override
  String get notLess1Hour => 'Zaman 1 saatten az olamaz';

  @override
  String get rateLimit => 'Hız sınırı';

  @override
  String get subnetPrefixLengthIpv4 => 'IPv4 için alt ağ önek uzunluğu';

  @override
  String get subnetPrefixLengthIpv6 => 'IPv6 için alt ağ önek uzunluğu';

  @override
  String get rateLimitAllowlist => 'Hız sınırlama izin listesi';

  @override
  String get rateLimitAllowlistDescription =>
      'Hız sınırlamasından hariç tutulan IP adresleri';

  @override
  String get dnsOptions => 'DNS ayarları';

  @override
  String get editor => 'Editör';

  @override
  String get editCustomRules => 'Özel kuralları düzenle';

  @override
  String get savingCustomRules => 'Özel kurallar kaydediliyor...';

  @override
  String get customRulesUpdatedSuccessfully =>
      'Özel kurallar başarıyla güncellendi';

  @override
  String get customRulesNotUpdated => 'Özel kurallar güncellenemedi';

  @override
  String get reorder => 'Sırala';

  @override
  String get showHide => 'Göster/gizle';

  @override
  String get noElementsReorderMessage =>
      'Burada yeniden sıralamak için göster/gizle sekmesindeki bazı öğeleri etkinleştirin.';

  @override
  String get enablePlainDns => 'Düz DNS\'i etkinleştir';

  @override
  String get enablePlainDnsDescription =>
      'Düz DNS varsayılan olarak etkindir. Tüm aygıtları şifrelenmiş DNS kullanmaya zorlamak için bunu devre dışı bırakabilirsiniz. Bunu yapmak için en az bir şifrelenmiş DNS protokolünü etkinleştirmeniz gerekir.';

  @override
  String get date => 'Tarih';

  @override
  String get loadingChangelog => 'Değişiklikler yükleniyor...';

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
    return 'Bu istemci için $domain engellendi';
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
  String get clientAllowedSuccessfully => 'İstemciye başarıyla izin verildi';

  @override
  String get clientDisallowedSuccessfully => 'İstemci başarıyla reddedildi';

  @override
  String get changesNotSaved => 'Değişiklikler kaydedilemedi';

  @override
  String get allowingClient => 'İstemciye izin veriliyor...';

  @override
  String get disallowingClient => 'İstemci reddediliyor...';

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
      'Burada gerçek zamanlı günlükler görünecek.';

  @override
  String get applicationDetails => 'Uygulama detayları';

  @override
  String get applicationDetailsDescription =>
      'Uygulama deposu, mevcut olduğu mağazalar ve daha fazlası';

  @override
  String get myOtherApps => 'Diğer uygulamalarım';

  @override
  String get myOtherAppsDescription =>
      'Diğer uygulamalarımı kontrol et, bağış yap, destekle iletişime geç ve daha fazlası';

  @override
  String get topToBottom => 'Yukarıdan aşağıya';

  @override
  String get bottomToTop => 'Aşağıdan yukarıya';

  @override
  String get upstreamTimeout => 'Üst sunucu zaman aşımı';

  @override
  String get upstreamTimeoutHelper =>
      'Üst DNS sunucusundan yanıt bekleme süresini saniye cinsinden belirtir';

  @override
  String get fieldCannotBeEmpty => 'Bu alan boş olamaz';

  @override
  String get enableDnsRewriteRules => 'Enable DNS rewrite rules';

  @override
  String get dnsRewriteRuleEnabled => 'DNS rewrite rule enabled successfully';

  @override
  String get dnsRewriteRuleDisabled => 'DNS rewrite rule disabled successfully';

  @override
  String get allDnsRewriteRulesEnabled =>
      'All DNS rewrite rules enabled successfully';

  @override
  String get allDnsRewriteRulesDisabled =>
      'All DNS rewrite rules disabled successfully';

  @override
  String get errorEnablingAllDnsRewriteRules =>
      'Error enabling all DNS rewrite rules';

  @override
  String get errorDisablingAllDnsRewriteRules =>
      'Error disabling all DNS rewrite rules';

  @override
  String get enablingDnsRewriteRule => 'Enabling DNS rewrite rules...';

  @override
  String get disablingDnsRewriteRule => 'Disabling DNS rewrite rules...';

  @override
  String get selectIdToFilter => 'Select an ID to filter';

  @override
  String get clientIds => 'Client IDs';
}
