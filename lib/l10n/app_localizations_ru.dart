// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get home => 'Главная';

  @override
  String get settings => 'Настройки';

  @override
  String get connect => 'Подключиться';

  @override
  String get servers => 'Серверы';

  @override
  String get createConnection => 'Создать подключение';

  @override
  String get editConnection => 'Edit connection';

  @override
  String get name => 'Имя';

  @override
  String get ipDomain => 'IP-адрес или домен';

  @override
  String get path => 'Путь';

  @override
  String get port => 'Порт';

  @override
  String get username => 'Логин';

  @override
  String get password => 'Пароль';

  @override
  String get defaultServer => 'Сервер по умолчанию';

  @override
  String get general => 'Основное';

  @override
  String get connection => 'Тип подключения';

  @override
  String get authentication => 'Аутентификация';

  @override
  String get other => 'Прочее';

  @override
  String get invalidPort => 'Неверный порт';

  @override
  String get invalidPath => 'Неверный путь';

  @override
  String get invalidIpDomain => 'Неверный IP-адрес или домен';

  @override
  String get ipDomainNotEmpty => 'IP-адрес или домен не могут быть пустыми';

  @override
  String get nameNotEmpty => 'Имя не может быть пустым';

  @override
  String get invalidUsernamePassword => 'Неверный логин или пароль';

  @override
  String get tooManyAttempts => 'Слишком много попыток. Попробуйте позднее.';

  @override
  String get cantReachServer =>
      'Не удаётся установить соединение с сервером. Проверьте настройки подключения.';

  @override
  String get sslError =>
      'Ошибка SSL. Перейдите в «Настройки» > «Дополнительные настройки» и активируйте «Не проверять SSL-сертификат».';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get connectionNotCreated => 'Не удалось создать подключение';

  @override
  String get connecting => 'Подключение...';

  @override
  String get connected => 'Подключено';

  @override
  String get selectedDisconnected => 'Выбран, но отключён';

  @override
  String get connectionDefaultSuccessfully =>
      'Подключение успешно установлено как «подключение по умолчанию».';

  @override
  String get connectionDefaultFailed =>
      'Не удалось установить «подключением по умолчанию».';

  @override
  String get noSavedConnections => 'Нет сохранённых подключений';

  @override
  String get cannotConnect => 'Не удается подключиться к серверу';

  @override
  String get connectionRemoved => 'Подключение удалено успешно';

  @override
  String get connectionCannotBeRemoved => 'Подключение не может быть удалено.';

  @override
  String get remove => 'Удалить';

  @override
  String get removeWarning =>
      'Вы уверены, что хотите удалить соединение с этим сервером AdGuard Home?';

  @override
  String get cancel => 'Отмена';

  @override
  String get defaultConnection => 'Подключение по умолчанию';

  @override
  String get setDefault => 'Подключаться по умолчанию';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get save => 'Сохранить';

  @override
  String get serverStatus => 'Статус сервера';

  @override
  String get connectionNotUpdated => 'Соединение не было обновлено';

  @override
  String get ruleFilteringWidget => 'Правила фильтрации';

  @override
  String get safeBrowsingWidget => 'Безопасная навигация';

  @override
  String get parentalFilteringWidget => 'Родительский контроль';

  @override
  String get safeSearchWidget => 'Безопасный поиск';

  @override
  String get ruleFiltering => 'Правила фильтрации';

  @override
  String get safeBrowsing => 'Безопасная\nнавигация';

  @override
  String get parentalFiltering => 'Родительский\nконтроль';

  @override
  String get safeSearch => 'Безопасный поиск';

  @override
  String get serverStatusNotRefreshed => 'Не удалось обновить статус сервера';

  @override
  String get loadingStatus => 'Загрузка...';

  @override
  String get errorLoadServerStatus => 'Не удалось получить статус сервера';

  @override
  String get topQueriedDomains => 'Часто запрашиваемые\nдомены';

  @override
  String get viewMore => 'Показать больше';

  @override
  String get topClients => 'Частые клиенты';

  @override
  String get topBlockedDomains => 'Часто блокируемые домены';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get theme => 'Тема';

  @override
  String get light => 'Светлая';

  @override
  String get dark => 'Тёмная';

  @override
  String get systemDefined => 'Системная тема';

  @override
  String get close => 'Закрыть';

  @override
  String get connectedTo => 'Подключено к:';

  @override
  String get selectedServer => 'Выбранный сервер:';

  @override
  String get noServerSelected => 'Нет выбранных серверов';

  @override
  String get manageServer => 'Управление сервером';

  @override
  String get allProtections => 'Защита';

  @override
  String get userNotEmpty => 'Логин не может быть пустым';

  @override
  String get passwordNotEmpty => 'Пароль не может быть пустым';

  @override
  String get examplePath => 'Например: /adguard';

  @override
  String get helperPath => 'Если используется реверсивный прокси';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get createdBy => 'Автор';

  @override
  String get clients => 'Клиенты';

  @override
  String get allowed => 'Обработан';

  @override
  String get blocked => 'Заблокировано';

  @override
  String get noClientsList => 'Список клиентов пуст';

  @override
  String get activeClients => 'Активные';

  @override
  String get removeClient => 'Удалить запись';

  @override
  String get removeClientMessage =>
      'Вы уверены, что хотите удалить данную запись из списка?';

  @override
  String get confirm => 'Ок';

  @override
  String get removingClient => 'Удаление клиента...';

  @override
  String get clientNotRemoved => 'Клиент не может быть удалён из списка';

  @override
  String get addClient => 'Добавить клиента';

  @override
  String get list => 'Список';

  @override
  String get ipAddress => 'IP-адреса';

  @override
  String get ipNotValid => 'Недопустимый IP-адрес';

  @override
  String get clientAddedSuccessfully => 'Запись успешно добавлена в список';

  @override
  String get addingClient => 'Добавление клиента...';

  @override
  String get clientNotAdded => 'Клиент не может быть внесён в список';

  @override
  String get clientAnotherList => 'Данный клиент уже занесён в один из списков';

  @override
  String get noSavedLogs => 'Нет сохранённых журналов';

  @override
  String get logs => 'Журнал';

  @override
  String get copyLogsClipboard => 'Скопировать журнал в буфер обмена';

  @override
  String get logsCopiedClipboard => 'Журнал скопирован в буфер обмена';

  @override
  String get advancedSettings => 'Дополнительные настройки';

  @override
  String get dontCheckCertificate => 'Не проверять SSL-сертификат';

  @override
  String get dontCheckCertificateDescription =>
      'Переопределяет проверку SSL-сертификата сервера';

  @override
  String get advancedSetupDescription => 'Расширенные параметры';

  @override
  String get settingsUpdatedSuccessfully => 'Настройки успешно обновлены.';

  @override
  String get cannotUpdateSettings => 'Не удалось обновить настройки.';

  @override
  String get restartAppTakeEffect => 'Перезапустите приложение';

  @override
  String get loadingLogs => 'Загрузка журнала...';

  @override
  String get logsNotLoaded => 'Не удалось загрузить журнал';

  @override
  String get processed => 'Обработан\nБез списка';

  @override
  String get processedRow => 'Обработан';

  @override
  String get blockedBlacklist => 'Заблокирован\nЧёрный список';

  @override
  String get blockedBlacklistRow => 'Заблокирован Чёрным списком';

  @override
  String get blockedSafeBrowsing => 'Заблокирован\nБезопасная навигация';

  @override
  String get blockedSafeBrowsingRow => 'Заблокировано Безопасной навигацией';

  @override
  String get blockedParental => 'Заблокирован\nРодительский контроль';

  @override
  String get blockedParentalRow => 'Заблокировано Родительским контролем';

  @override
  String get blockedInvalid => 'Заблокировано\nНеверный';

  @override
  String get blockedInvalidRow => 'Заблокирован (Неверный)';

  @override
  String get blockedSafeSearch => 'Заблокирован\nБезопасный поиск';

  @override
  String get blockedSafeSearchRow => 'Заблокировано Безопасным поиском';

  @override
  String get blockedService => 'Заблокирован\nЗаблокированный сервис';

  @override
  String get blockedServiceRow => 'Заблокирован (заблокированный сервис)';

  @override
  String get processedWhitelist => 'Разрешён\nБелый список';

  @override
  String get processedWhitelistRow => 'Разрешён Белым списком';

  @override
  String get processedError => 'Обработан\nОшибка';

  @override
  String get processedErrorRow => 'Обработан (ошибка)';

  @override
  String get rewrite => 'Переписан';

  @override
  String get status => 'Статус';

  @override
  String get result => 'Результат';

  @override
  String get time => 'Время';

  @override
  String get blocklist => 'Блок-лист';

  @override
  String get request => 'Запрос';

  @override
  String get domain => 'Хост';

  @override
  String get type => 'Тип';

  @override
  String get clas => 'Класс';

  @override
  String get response => 'Ответ';

  @override
  String get dnsServer => 'DNS-сервер';

  @override
  String get elapsedTime => 'Затрачено';

  @override
  String get responseCode => 'Код ответа';

  @override
  String get client => 'Клиент';

  @override
  String get deviceIp => 'IP-адрес';

  @override
  String get deviceName => 'Имя устройства';

  @override
  String get logDetails => 'Детали запроса';

  @override
  String get blockingRule => 'Правило блокировки';

  @override
  String get blockDomain => 'Заблокировать домен';

  @override
  String get couldntGetFilteringStatus =>
      'Не удалось получить журнал фильтрации';

  @override
  String get unblockDomain => 'Разблокировать домен';

  @override
  String get userFilteringRulesNotUpdated =>
      'Не удалось обновить пользовательские правила фильтрации';

  @override
  String get userFilteringRulesUpdated =>
      'Пользовательские правила фильтрации успешно обновлены';

  @override
  String get savingUserFilters =>
      'Сохранение пользовательских правил фильтрации...';

  @override
  String get filters => 'Фильтры';

  @override
  String get logsOlderThan => 'Записи журнала старше, чем';

  @override
  String get responseStatus => 'Статус ответа';

  @override
  String get selectTime => 'Выберите время';

  @override
  String get notSelected => 'Не выбрано';

  @override
  String get resetFilters => 'Сбросить фильтры';

  @override
  String get noLogsDisplay => 'Нет записей в журнале';

  @override
  String get noLogsThatOld =>
      'Возможно, что за это выбранное время записи журнала не сохранены. Попробуйте выбрать более позднее время.';

  @override
  String get apply => 'Применить';

  @override
  String get selectAll => 'Отметить все';

  @override
  String get unselectAll => 'Отменить выбор всех';

  @override
  String get all => 'Все';

  @override
  String get filtered => 'Отфильтрованные';

  @override
  String get checkAppLogs => 'Проверьте журналы приложения';

  @override
  String get refresh => 'Обновить';

  @override
  String get search => 'Поиск';

  @override
  String get dnsQueries => 'DNS-запросы';

  @override
  String get average => 'Среднее';

  @override
  String get blockedFilters => 'Заблокировано\nфильтрами';

  @override
  String get malwarePhishingBlocked =>
      'Заблокированные\nвредоносные и\nфишинговые сайты';

  @override
  String get blockedAdultWebsites => 'Заблокированные\n«взрослые» сайты';

  @override
  String get generalSettings => 'Основные настройки';

  @override
  String get generalSettingsDescription => 'Различные настройки';

  @override
  String get hideZeroValues => 'Скрывать нулевые значения';

  @override
  String get hideZeroValuesDescription =>
      'Скрывать блоки с нулевыми значениями на домашнем экране';

  @override
  String get webAdminPanel => 'Веб-панель администрирования';

  @override
  String get visitGooglePlay => 'Посетить страницу в Google Play';

  @override
  String get gitHub => 'Исходный код приложения доступен на GitHub';

  @override
  String get blockClient => 'Заблокировать клиента';

  @override
  String get selectTags => 'Выбрать теги клиента';

  @override
  String get noTagsSelected => 'Нет выбранных тегов';

  @override
  String get tags => 'Теги';

  @override
  String get identifiers => 'Идентификаторы';

  @override
  String get identifier => 'Идентификатор';

  @override
  String get identifierHelper => 'IP-адрес, CIDR, MAC или ClientID';

  @override
  String get noIdentifiers => 'Идентификаторы не добавлены';

  @override
  String get useGlobalSettings => 'Глобальные настройки';

  @override
  String get enableFiltering => 'Включить фильтрацию';

  @override
  String get enableSafeBrowsing => 'Безопасная навигация';

  @override
  String get enableParentalControl => 'Родительский контроль';

  @override
  String get enableSafeSearch => 'Безопасный поиск';

  @override
  String get blockedServices => 'Заблокированные сервисы';

  @override
  String get selectBlockedServices => 'Заблокированные сервисы';

  @override
  String get noBlockedServicesSelected => 'Нет заблокированных сервисов';

  @override
  String get services => 'Сервисы';

  @override
  String get servicesBlocked => 'в блокировке';

  @override
  String get tagsSelected => 'выбрано';

  @override
  String get upstreamServers => 'Upstream DNS-серверы';

  @override
  String get serverAddress => 'Адрес сервера';

  @override
  String get noUpstreamServers => 'Нет upstream DNS-серверов.';

  @override
  String get willBeUsedGeneralServers =>
      'Будут использоваться общие upstream DNS-сервера.';

  @override
  String get added => 'Сохранённые';

  @override
  String get clientUpdatedSuccessfully => 'Настройки клиента успешно обновлены';

  @override
  String get clientNotUpdated => 'Не удалось обновить настройки клиента';

  @override
  String get clientDeletedSuccessfully => 'Клиент успешно удалён';

  @override
  String get clientNotDeleted => 'Не удалось удалить клиента';

  @override
  String get options => 'Параметры';

  @override
  String get loadingFilters => 'Загрузка фильтров...';

  @override
  String get filtersNotLoaded => 'Не удалось загрузить фильтры.';

  @override
  String get whitelists => 'Белые списки DNS';

  @override
  String get blacklists => 'Чёрные списки DNS';

  @override
  String get rules => 'Количество правил';

  @override
  String get customRules => 'Пользовательские правила фильтрации';

  @override
  String get enabledRules => 'Активных правил';

  @override
  String get enabled => 'Включён';

  @override
  String get disabled => 'Отключён';

  @override
  String get rule => 'Правило';

  @override
  String get addCustomRule => 'Добавить пользовательское правило фильтрации';

  @override
  String get removeCustomRule => 'Удалить пользовательское правило фильтрации';

  @override
  String get removeCustomRuleMessage =>
      'Вы уверены, что хотите удалить данное пользовательское правило фильтрации?';

  @override
  String get updatingRules =>
      'Обновление пользовательских правил фильтрации...';

  @override
  String get ruleRemovedSuccessfully => 'Правило успешно удалено';

  @override
  String get ruleNotRemoved => 'Не удаётся удалить данное правило';

  @override
  String get ruleAddedSuccessfully => 'Правило успешно добавлено';

  @override
  String get ruleNotAdded => 'Не удаётся добавить правило';

  @override
  String get noCustomFilters => 'Нет пользовательских правил фильтрации';

  @override
  String get noBlockedClients => 'Нет запрещённых клиентов';

  @override
  String get noBlackLists => 'Нет чёрных списков';

  @override
  String get noWhiteLists => 'Нет белых списков';

  @override
  String get addWhitelist => 'Добавить белый список';

  @override
  String get addBlacklist => 'Добавить чёрный список';

  @override
  String get urlNotValid => 'Неверный URL или абсолютный путь';

  @override
  String get urlAbsolutePath => 'URL-адрес или абсолютный путь';

  @override
  String get addingList => 'Добавление списка...';

  @override
  String get listAdded => 'Список успешно добавлен. Добавлены:';

  @override
  String get listAlreadyAdded => 'Список уже был добавлен';

  @override
  String get listUrlInvalid => 'Неверный URL-адрес списка';

  @override
  String get listNotAdded => 'Не удаётся добавить список';

  @override
  String get listDetails => 'Параметры списка';

  @override
  String get listType => 'Тип';

  @override
  String get whitelist => 'Белый список';

  @override
  String get blacklist => 'Чёрный список';

  @override
  String get latestUpdate => 'Последнее обновление';

  @override
  String get disable => 'Отключить';

  @override
  String get enable => 'Включить';

  @override
  String get currentStatus => 'Текущий статус';

  @override
  String get listDataUpdated => 'Параметры списка успешно обновлены';

  @override
  String get listDataNotUpdated => 'Не удалось обновить параметры списка';

  @override
  String get updatingListData => 'Обновление параметров списка...';

  @override
  String get editWhitelist => 'Редактировать белый список';

  @override
  String get editBlacklist => 'Редактировать чёрный список';

  @override
  String get deletingList => 'Удаление списка...';

  @override
  String get listDeleted => 'Список успешно удалён';

  @override
  String get listNotDeleted => 'Не удалось удалить список';

  @override
  String get deleteList => 'Удалить список';

  @override
  String get deleteListMessage =>
      'Вы уверены, что хотите удалить этот список? Это действие нельзя отменить.';

  @override
  String get serverSettings => 'Настройки сервера';

  @override
  String get serverInformation => 'Информация о сервере';

  @override
  String get serverInformationDescription =>
      'Информация о сервере и текущий статус';

  @override
  String get loadingServerInfo => 'Загрузка информации о сервере...';

  @override
  String get serverInfoNotLoaded =>
      'Не удалось загрузить информацию о сервере.';

  @override
  String get dnsAddresses => 'DNS-адреса';

  @override
  String get seeDnsAddresses => 'Посмотреть DNS-адреса';

  @override
  String get dnsPort => 'DNS-порт';

  @override
  String get httpPort => 'HTTP-порт';

  @override
  String get protectionEnabled => 'Защита активна';

  @override
  String get dhcpAvailable => 'DHCP доступен';

  @override
  String get serverRunning => 'Сервер запущен';

  @override
  String get serverVersion => 'Версия сервера';

  @override
  String get serverLanguage => 'Язык сервера';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get allowedClients => 'Разрешённые клиенты';

  @override
  String get disallowedClients => 'Запрещённые клиенты';

  @override
  String get disallowedDomains => 'Неразрешённые домены';

  @override
  String get accessSettings => 'Настройки доступа';

  @override
  String get accessSettingsDescription => 'Настройка правил доступа к серверу';

  @override
  String get loadingClients => 'Загрузка клиентов...';

  @override
  String get clientsNotLoaded => 'Не удалось загрузить список клиентов.';

  @override
  String get noAllowedClients => 'Нет разрешённых клиентов';

  @override
  String get allowedClientsDescription =>
      'Если в списке есть записи, AdGuard Home будет принимать запросы только от этих клиентов.';

  @override
  String get blockedClientsDescription =>
      'Если в списке есть записи, AdGuard Home будет игнорировать запросы от этих клиентов. Это поле игнорируется, если список разрешённых клиентов содержит записи.';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home будет игнорировать DNS-запросы с этими доменами. Такие DNS-запросы не будут отображаться в журнале.';

  @override
  String get addClientFieldDescription => 'CIDR, IP-адрес или ClientID';

  @override
  String get clientIdentifier => 'Идентификатор клиента';

  @override
  String get allowClient => 'Разрешить клиент';

  @override
  String get disallowClient => 'Запретить клиента';

  @override
  String get noDisallowedDomains => 'Нет запрещенных доменов';

  @override
  String get domainNotAdded => 'Не удалось добавить домен';

  @override
  String get statusSelected => 'выбран статус';

  @override
  String get updateLists => 'Проверить обновления';

  @override
  String get checkHostFiltered => 'Проверить хост';

  @override
  String get updatingLists => 'Обновление списков...';

  @override
  String get listsUpdated => 'списки обновлены';

  @override
  String get listsNotUpdated => 'Не удалось обновить списки';

  @override
  String get listsNotLoaded => 'Не удалось загрузить списки';

  @override
  String get domainNotValid => 'Недействительный домен';

  @override
  String get check => 'Проверить';

  @override
  String get checkingHost => 'Проверка хоста...';

  @override
  String get errorCheckingHost => 'Не удалось проверить хост';

  @override
  String get block => 'Запретить';

  @override
  String get unblock => 'Разрешить';

  @override
  String get custom => 'Своё правило';

  @override
  String get addImportant => 'Добавить \$important';

  @override
  String get howCreateRules => 'Как создать пользовательские правила';

  @override
  String get examples => 'Примеры';

  @override
  String get example1 =>
      'Заблокировать доступ к домену example.org и всем его поддоменам.';

  @override
  String get example2 =>
      'Разблокировать доступ к домену example.org и всем его поддоменам.';

  @override
  String get example3 => 'Добавлять комментарий.';

  @override
  String get example4 =>
      'Блокировать доступ к доменам, соответствующим заданному регулярному выражению.';

  @override
  String get moreInformation => 'Больше информации';

  @override
  String get addingRule => 'Добавление правила...';

  @override
  String get deletingRule => 'Удаление правила...';

  @override
  String get enablingList => 'Включение списка...';

  @override
  String get disablingList => 'Отключение списка...';

  @override
  String get savingList => 'Сохранение списка...';

  @override
  String get disableFiltering => 'Отключить фильтрацию';

  @override
  String get enablingFiltering => 'Включение фильтрации...';

  @override
  String get disablingFiltering => 'Отключение фильтрации...';

  @override
  String get filteringStatusUpdated => 'Статус фильтрации успешно обновлен';

  @override
  String get filteringStatusNotUpdated =>
      'Не удалось обновить статус фильтрации';

  @override
  String get updateFrequency => 'Частота обновления';

  @override
  String get never => 'Никогда';

  @override
  String get hour1 => '1 час';

  @override
  String get hours12 => '12 часов';

  @override
  String get hours24 => '24 часа';

  @override
  String get days3 => '3 дня';

  @override
  String get days7 => '7 дней';

  @override
  String get changingUpdateFrequency => 'Обновление...';

  @override
  String get updateFrequencyChanged => 'Частота обновления успешно изменена';

  @override
  String get updateFrequencyNotChanged =>
      'Не удаётся изменить частоту обновления';

  @override
  String get updating => 'Обновление значений...';

  @override
  String get blockedServicesUpdated =>
      'Заблокированные сервисы успешно обновлены';

  @override
  String get blockedServicesNotUpdated =>
      'Не удаётся обновить заблокированные сервисы';

  @override
  String get insertDomain => 'Проверить фильтрацию имени хоста.';

  @override
  String get dhcpSettings => 'Настройки DHCP';

  @override
  String get dhcpSettingsDescription => 'Настройка DHCP-сервера';

  @override
  String get dhcpSettingsNotLoaded => 'Не удалось загрузить настройки DHCP';

  @override
  String get loadingDhcp => 'Загрузка настроек DHCP...';

  @override
  String get enableDhcpServer => 'Включить DHCP-сервер';

  @override
  String get selectInterface => 'Выбрать интерфейс DHCP';

  @override
  String get hardwareAddress => 'MAC-адрес';

  @override
  String get gatewayIp => 'IP-адрес шлюза';

  @override
  String get ipv4addresses => 'Адрес IPv4';

  @override
  String get ipv6addresses => 'Адрес IPv6';

  @override
  String get neededSelectInterface =>
      'Необходимо выбрать интерфейс для настройки DHCP-сервера.';

  @override
  String get ipv4settings => 'Настройки IPv4';

  @override
  String get startOfRange => 'Начало диапазона';

  @override
  String get endOfRange => 'Конец диапазона';

  @override
  String get ipv6settings => 'Настройки IPv6';

  @override
  String get subnetMask => 'Маска подсети';

  @override
  String get subnetMaskNotValid => 'Недопустимая маска подсети';

  @override
  String get gateway => 'Шлюз';

  @override
  String get gatewayNotValid => 'Недопустимый шлюз';

  @override
  String get leaseTime => 'Время аренды';

  @override
  String seconds(Object time) {
    return '$time секунд';
  }

  @override
  String get leaseTimeNotValid => 'Недопустимый срок аренды';

  @override
  String get restoreConfiguration => 'Сбросить конфигурацию';

  @override
  String get restoreConfigurationMessage =>
      'Вы уверены, что хотите продолжить? Это приведет к сбросу всей конфигурации. Данное действие не может быть отменено.';

  @override
  String get changeInterface => 'Изменить интерфейс';

  @override
  String get savingSettings => 'Сохранение настроек...';

  @override
  String get settingsSaved => 'Настройки успешно сохранены';

  @override
  String get settingsNotSaved => 'Не удалось сохранить настройки';

  @override
  String get restoringConfig => 'Восстановление конфигурации...';

  @override
  String get configRestored => 'Конфигурация успешно сброшена';

  @override
  String get configNotRestored => 'Не удалось произвести сброс конфигурации';

  @override
  String get dhcpStatic => 'Статические аренды DHCP';

  @override
  String get noDhcpStaticLeases => 'Не найдено статических аренд DHCP';

  @override
  String get deleting => 'Удаление...';

  @override
  String get staticLeaseDeleted => 'Статическая аренда DHCP успешно удалена';

  @override
  String get staticLeaseNotDeleted =>
      'Не удалось удалить статическую аренду DHCP';

  @override
  String get deleteStaticLease => 'Удалить статическую аренду';

  @override
  String get deleteStaticLeaseDescription =>
      'Статическая аренда DHCP будет удалена. Данное действие не может быть отменено.';

  @override
  String get addStaticLease => 'Добавить статическую аренду';

  @override
  String get macAddress => 'MAC-адрес';

  @override
  String get macAddressNotValid => 'Недопустимый MAC-адрес';

  @override
  String get hostName => 'Имя хоста';

  @override
  String get hostNameError => 'Имя хоста не может быть пустым';

  @override
  String get creating => 'Создание...';

  @override
  String get staticLeaseCreated => 'Статическая аренда DHCP успешно создана';

  @override
  String get staticLeaseNotCreated =>
      'Не удалось создать статическую аренду DHCP';

  @override
  String get staticLeaseExists => 'Статическая аренда DHCP уже существует';

  @override
  String get serverNotConfigured => 'Сервер не настроен';

  @override
  String get restoreLeases => 'Сбросить аренды DHCP';

  @override
  String get restoreLeasesMessage =>
      'Вы уверены, что хотите продолжить? Это приведет к сбросу всех существующих аренд DHCP. Данное действие не может быть отменено.';

  @override
  String get restoringLeases => 'Сброс аренд DHCP...';

  @override
  String get leasesRestored => 'Аренды DHCP успешно сброшены';

  @override
  String get leasesNotRestored => 'Не удалось сбросить аренды DHCP';

  @override
  String get dhcpLeases => 'Аренды DHCP';

  @override
  String get noLeases => 'Не найдено аренд DHCP';

  @override
  String get dnsRewrites => 'Перезапись DNS-запросов';

  @override
  String get dnsRewritesDescription => 'Настройка пользовательских правил DNS';

  @override
  String get loadingRewriteRules => 'Загрузка правил перезаписи...';

  @override
  String get rewriteRulesNotLoaded =>
      'Не удалось загрузить правила перезаписи DNS.';

  @override
  String get noRewriteRules => 'Нет правил перезаписи DNS';

  @override
  String get answer => 'Ответ';

  @override
  String get deleteDnsRewrite => 'Удалить правило перезаписи DNS-запросов';

  @override
  String get deleteDnsRewriteMessage =>
      'Вы уверены, что хотите удалить это правило перезаписи DNS? Данное действие не может быть отменено.';

  @override
  String get dnsRewriteRuleDeleted => 'Правило перезаписи DNS успешно удалено';

  @override
  String get dnsRewriteRuleNotDeleted =>
      'Не удалось удалить правило перезаписи DNS';

  @override
  String get addDnsRewrite => 'Добавить правило';

  @override
  String get addingRewrite => 'Добавление правила перезаписи DNS-запросов...';

  @override
  String get dnsRewriteRuleAdded => 'Правило перезаписи DNS успешно добавлено';

  @override
  String get dnsRewriteRuleNotAdded =>
      'Не удалось добавить правило перезаписи DNS';

  @override
  String get logsSettings => 'Настройки журнала';

  @override
  String get enableLog => 'Включить журнал';

  @override
  String get clearLogs => 'Очистить журнал';

  @override
  String get anonymizeClientIp => 'Анонимизировать клиента';

  @override
  String get hours6 => '6 часов';

  @override
  String get days30 => '30 дней';

  @override
  String get days90 => '90 дней';

  @override
  String get retentionTime => 'Частота ротации журнала запросов';

  @override
  String get selectOneItem => 'Выберите один элемент';

  @override
  String get logSettingsNotLoaded => 'Не удалось загрузить настройки журнала.';

  @override
  String get updatingSettings => 'Обновление настроек...';

  @override
  String get logsConfigUpdated => 'Настройки журнала успешно обновлены';

  @override
  String get logsConfigNotUpdated => 'Не удалось обновить настройки журнала';

  @override
  String get deletingLogs => 'Очистка журнала...';

  @override
  String get logsCleared => 'Журнал успешно очищен';

  @override
  String get logsNotCleared => 'Не удалось очистить журнал';

  @override
  String get runningHomeAssistant => 'Запускается на Home Assistant';

  @override
  String get serverError => 'Ошибка сервера';

  @override
  String get noItems => 'Здесь нет предметов для показа';

  @override
  String get dnsSettings => 'Настройки DNS';

  @override
  String get dnsSettingsDescription => 'Настройка подключения к DNS-серверам';

  @override
  String get upstreamDns => 'Upstream DNS-серверы';

  @override
  String get bootstrapDns => 'Bootstrap DNS-серверы';

  @override
  String get noUpstreamDns => 'Не добавлены upstream DNS-серверы.';

  @override
  String get dnsMode => 'Режим DNS';

  @override
  String get noDnsMode => 'Не выбран режим DNS';

  @override
  String get loadBalancing => 'Распределение нагрузки';

  @override
  String get parallelRequests => 'Параллельные запросы';

  @override
  String get fastestIpAddress => 'Самый быстрый IP-адрес';

  @override
  String get loadBalancingDescription =>
      'Запрашивать по одному серверу за раз. AdGuard Home использует алгоритм взвешенного случайного выбора сервера, так что самый быстрый сервер используется чаще.';

  @override
  String get parallelRequestsDescription =>
      'Использовать параллельные запросы ко всем серверам одновременно для ускорения обработки запроса.';

  @override
  String get fastestIpAddressDescription =>
      'Опросить все DNS-серверы и вернуть самый быстрый IP-адрес из полученных ответов. Это замедлит DNS-запросы, так как нужно будет дождаться ответов со всех DNS-серверов, но улучшит соединение.';

  @override
  String get noBootstrapDns => 'Не добавлены bootstrap DNS-серверы.';

  @override
  String get bootstrapDnsServersInfo =>
      'Bootstrap DNS-сервера используются для поиска IP-адресов DoH/DoT upstream-серверов, которые вы указали.';

  @override
  String get privateReverseDnsServers => 'Приватные серверы для обратного DNS';

  @override
  String get privateReverseDnsServersDescription =>
      'DNS-серверы, которые AdGuard Home использует для локальных PTR-запросов. Эти серверы используются, чтобы получить доменные имена клиентов с приватными IP-адресами, например «192.168.12.34», с помощью обратного DNS. Если список пуст, AdGuard Home использует DNS-серверы по умолчанию вашей ОС.';

  @override
  String get reverseDnsDefault =>
      'По умолчанию AdGuard Home использует следующие обратные DNS-серверы';

  @override
  String get addItem => 'Добавить сервер';

  @override
  String get noServerAddressesAdded => 'Адреса серверов не указаны.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Использовать приватные обратные DNS-резолверы';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Посылать обратные DNS-запросы для локально обслуживаемых адресов на указанные серверы. Если отключено, AdGuard Home будет отвечать NXDOMAIN на все подобные PTR-запросы, кроме запросов о клиентах, уже известных по DHCP, /etc/hosts и так далее.';

  @override
  String get enableReverseResolving =>
      'Включить запрашивание доменных имён для IP-адресов клиентов';

  @override
  String get enableReverseResolvingDescription =>
      'Определять доменные имена клиентов через PTR-запросы к соответствующим серверам (приватные DNS-серверы для локальных клиентов, upstream-серверы для клиентов с публичным IP-адресом).';

  @override
  String get dnsServerSettings => 'Настройки DNS-сервера';

  @override
  String get limitRequestsSecond => 'Лимит запросов в секунду';

  @override
  String get valueNotNumber => 'Значение - не число';

  @override
  String get enableEdns => 'Включить отправку EDNS Client Subnet';

  @override
  String get enableEdnsDescription =>
      'Добавлять опцию EDNS Client Subnet (ECS) к запросам к upstream-серверам, а также записывать присланные клиентами значения в журнал.';

  @override
  String get enableDnssec => 'Включить DNSSEC';

  @override
  String get enableDnssecDescription =>
      'Установите флаг DNSSEC в исходящих DNS-запросах и проверьте результат (требуется резолвер с поддержкой DNSSEC).';

  @override
  String get disableResolvingIpv6 => 'Отключить обработку IPv6-адресов';

  @override
  String get disableResolvingIpv6Description =>
      'Игнорировать все DNS-запросы адресов IPv6 (тип AAAA) и удалять IPv6-данные из ответов типа HTTPS.';

  @override
  String get blockingMode => 'Режим блокировки';

  @override
  String get defaultMode => 'Стандартный';

  @override
  String get defaultDescription =>
      'Отвечает с нулевым IP-адресом, (0.0.0.0 для A; :: для AAAA) когда заблокировано правилом в стиле Adblock; отвечает с IP-адресом, указанным в правиле, когда заблокировано правилом в стиле файлов hosts';

  @override
  String get refusedDescription => 'Отвечает с кодом REFUSED';

  @override
  String get nxdomainDescription => 'Отвечает с кодом NXDOMAIN';

  @override
  String get nullIp => 'Нулевой IP';

  @override
  String get nullIpDescription =>
      'Отвечает с нулевым IP-адресом (0.0.0.0 для A; :: для AAAA)';

  @override
  String get customIp => 'Пользовательский IP';

  @override
  String get customIpDescription => 'Отвечает с вручную настроенным IP-адресом';

  @override
  String get dnsCacheConfig => 'Настройка кеша DNS';

  @override
  String get cacheSize => 'Размер кеша';

  @override
  String get inBytes => 'В байтах';

  @override
  String get overrideMinimumTtl => 'Переопределить минимальный TTL';

  @override
  String get overrideMinimumTtlDescription =>
      'Расширить короткие TTL-значения (в секундах), полученные с upstream-сервера при кешировании DNS-ответов.';

  @override
  String get overrideMaximumTtl => 'Переопределить максимальный TTL';

  @override
  String get overrideMaximumTtlDescription =>
      'Установить максимальное TTL-значение (в секундах) для записей в DNS-кеше.';

  @override
  String get optimisticCaching => 'Оптимистическое кеширование';

  @override
  String get optimisticCachingDescription =>
      'AdGuard Home будет отвечать из кеша, даже если ответы в нём неактуальны, и попытается обновить их.';

  @override
  String get loadingDnsConfig => 'Загрузка конфигурации DNS...';

  @override
  String get dnsConfigNotLoaded => 'Не удалось загрузить конфигурацию DNS.';

  @override
  String get blockingIpv4 => 'Блокируется IPv4';

  @override
  String get blockingIpv4Description =>
      'IP-адрес, который будет возвращен для заблокированного запроса А';

  @override
  String get blockingIpv6 => 'Блокируется IPv6';

  @override
  String get blockingIpv6Description =>
      'IP-адрес, который будет возвращен для заблокированного запроса AAAA';

  @override
  String get invalidIp => 'Недопустимый IP-адрес';

  @override
  String get dnsConfigSaved => 'Конфигурация DNS-сервера сохранена успешно';

  @override
  String get dnsConfigNotSaved =>
      'Не удалось сохранить конфигурацию DNS-сервера';

  @override
  String get savingConfig => 'Сохранение конфигурации...';

  @override
  String get someValueNotValid => 'Некоторое значение недопустимо';

  @override
  String get upstreamDnsDescription =>
      'Настройка upstream DNS-серверов и режима DNS';

  @override
  String get bootstrapDnsDescription => 'Настройка bootstrap DNS-серверов';

  @override
  String get privateReverseDnsDescription =>
      'Настройка пользовательских DNS-серверов и приватных серверы для обратного DNS';

  @override
  String get dnsServerSettingsDescription =>
      'Настройка ограничения на количество запросов, режима блокировки и многое другое';

  @override
  String get dnsCacheConfigDescription =>
      'Настройка, как сервер должен управлять кэшем DNS';

  @override
  String get comment => 'Комментарий';

  @override
  String get address => 'Адрес';

  @override
  String get commentsDescription =>
      'Комментариям всегда предшествует #. Вам не обязательно добавлять его, он будет добавлен автоматически.';

  @override
  String get encryptionSettings => 'Настройки шифрования';

  @override
  String get encryptionSettingsDescription =>
      'Поддержка шифрования (HTTPS/QUIC/TLS)';

  @override
  String get loadingEncryptionSettings => 'Загрузка настроек шифрования...';

  @override
  String get encryptionSettingsNotLoaded =>
      'Не удалось загрузить настройки шифрования.';

  @override
  String get enableEncryption => 'Включить шифрование';

  @override
  String get enableEncryptionTypes => 'HTTPS, DNS-over-HTTPS и DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      'Если порт HTTPS настроен, веб-интерфейс администрирования AdGuard Home будет доступен через HTTPS, а также DNS-over-HTTPS сервер будет доступен по пути \'/dns-query\'.';

  @override
  String get serverConfiguration => 'Конфигурация сервера';

  @override
  String get domainName => 'Доменное имя';

  @override
  String get domainNameDescription =>
      'Если задано, AdGuard Home распознаёт ClientID, отвечает на DDR-запросы, и дополнительно проверяет соединения. Если не задано, этот функционал отключён. Должно соответствовать одному из параметров DNS Names в сертификате.';

  @override
  String get redirectHttps => 'Автоматически перенаправлять на HTTPS';

  @override
  String get httpsPort => 'Порт HTTPS';

  @override
  String get tlsPort => 'Порт DNS-over-TLS';

  @override
  String get dnsOverQuicPort => 'Порт DNS-over-QUIC';

  @override
  String get certificates => 'Сертификаты';

  @override
  String get certificatesDescription =>
      'Для использования шифрования вам необходимо предоставить корректную цепочку SSL-сертификатов для вашего домена. Вы можете получить бесплатный сертификат на letsencrypt.org или вы можете купить его у одного из доверенных Центров Сертификации.';

  @override
  String get certificateFilePath => 'Указать путь к файлу сертификатов';

  @override
  String get pasteCertificateContent => 'Вставить содержимое сертификатов';

  @override
  String get certificatePath => 'Путь к сертификату';

  @override
  String get certificateContent => 'Содержимое сертификата';

  @override
  String get privateKey => 'Закрытый ключ';

  @override
  String get privateKeyFile => 'Указать файл закрытого ключа';

  @override
  String get pastePrivateKey => 'Вставить содержимое закрытого ключа';

  @override
  String get usePreviousKey => 'Использовать сохранённый ранее ключ';

  @override
  String get privateKeyPath => 'Путь к закрытому ключу';

  @override
  String get invalidCertificate => 'Цепочка сертификатов не прошла проверку';

  @override
  String get invalidPrivateKey => 'Некорректный приватный ключ';

  @override
  String get validatingData => 'Проверка данных';

  @override
  String get dataValid => 'Данные действительны';

  @override
  String get dataNotValid => 'Недопустимые данные';

  @override
  String get encryptionConfigSaved => 'Настройки шифрования успешно сохранены';

  @override
  String get encryptionConfigNotSaved =>
      'Не удаётся сохранить настройки шифрования';

  @override
  String get configError => 'Ошибка конфигурации';

  @override
  String get enterOnlyCertificate =>
      'Введите только сертификат. Не вводите строки ---BEGIN--- и ---END---.';

  @override
  String get enterOnlyPrivateKey =>
      'Введите только ключ. Не вводите строки ---BEGIN--- и ---END---.';

  @override
  String get noItemsSearch => 'Ничего не найдено по данному запросу.';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String get exitSearch => 'Покинуть поиск';

  @override
  String get searchClients => 'Поиск клиентов';

  @override
  String get noClientsSearch => 'Не найдено клиентов по данному запросу.';

  @override
  String get customization => 'Персонализация';

  @override
  String get customizationDescription => 'Настройте внешний вид приложения';

  @override
  String get color => 'Цветовая тема';

  @override
  String get useDynamicTheme => 'Использовать динамическую тему';

  @override
  String get red => 'Красный';

  @override
  String get green => 'Зелёный';

  @override
  String get blue => 'Синий';

  @override
  String get yellow => 'Жёлтый';

  @override
  String get orange => 'Оранжевый';

  @override
  String get brown => 'Коричневый';

  @override
  String get cyan => 'Бирюзовый';

  @override
  String get purple => 'Пурпурный';

  @override
  String get pink => 'Розовый';

  @override
  String get deepOrange => 'Темно-оранжевый';

  @override
  String get indigo => 'Индиго';

  @override
  String get useThemeColorStatus =>
      'Использовать цвет темы для обозначения статуса';

  @override
  String get useThemeColorStatusDescription =>
      'Заменяет зеленый и красный цвета статуса цветом темы и серым';

  @override
  String get invalidCertificateChain =>
      'Цепочка сертификатов не прошла проверку';

  @override
  String get validCertificateChain => 'Действительная цепочка сертификатов';

  @override
  String get subject => 'Субъект';

  @override
  String get issuer => 'Издатель';

  @override
  String get expires => 'Истекает';

  @override
  String get validPrivateKey => 'Действительный закрытый ключ';

  @override
  String get expirationDate => 'Истекает';

  @override
  String get keysNotMatch =>
      'Недействительный сертификат или ключ: tls: закрытый ключ не соответствует открытому ключу';

  @override
  String get timeLogs => 'Время в записях журнала';

  @override
  String get timeLogsDescription => 'Показывать время обработки в журнале';

  @override
  String get hostNames => 'Имена хостов';

  @override
  String get keyType => 'Тип ключа';

  @override
  String get updateAvailable => 'Доступно обновление';

  @override
  String get installedVersion => 'Установленная версия';

  @override
  String get newVersion => 'Новая версия';

  @override
  String get source => 'Источник';

  @override
  String get downloadUpdate => 'Загрузить обновление';

  @override
  String get download => 'Скачать';

  @override
  String get doNotRememberAgainUpdate => 'Не запоминать снова для этой версии';

  @override
  String get downloadingUpdate => 'Скачивание';

  @override
  String get completed => 'завершено';

  @override
  String get permissionNotGranted => 'Разрешение не предоставлено';

  @override
  String get inputSearchTerm => 'Введите поисковый запрос.';

  @override
  String get answers => 'Ответы';

  @override
  String get copyClipboard => 'Скопировать в буфер обмена';

  @override
  String get domainCopiedClipboard => 'Домен скопирован в буфер обмена';

  @override
  String get clearDnsCache => 'Очистить кэш DNS';

  @override
  String get clearDnsCacheMessage => 'Вы уверены, что хотите очистить кэш DNS?';

  @override
  String get dnsCacheCleared => 'Кэш DNS очищен успешно';

  @override
  String get clearingDnsCache => 'Очистка кэша...';

  @override
  String get dnsCacheNotCleared => 'Не удалось очистить кэш DNS';

  @override
  String get clientsSelected => 'выбранные клиенты';

  @override
  String get invalidDomain => 'Недопустимый домен';

  @override
  String get loadingBlockedServicesList =>
      'Загрузка списка заблокированных сервисов...';

  @override
  String get blockedServicesListNotLoaded =>
      'Не удалось загрузить список заблокированных служб';

  @override
  String get error => 'Ошибка';

  @override
  String get updates => 'Обновления';

  @override
  String get updatesDescription => 'Обновить AdGuard Home server';

  @override
  String get updateNow => 'Обновить сейчас';

  @override
  String get currentVersion => 'Текущая версия';

  @override
  String get requestStartUpdateFailed =>
      'Не удалось выполнить запрос на запуск обновления';

  @override
  String get requestStartUpdateSuccessful =>
      'Запрос на запуск обновления успешен';

  @override
  String get serverUpdated => 'Сервер обновлён';

  @override
  String get unknownStatus => 'Неизвестный статус';

  @override
  String get checkingUpdates => 'Проверка обновлений..';

  @override
  String get checkUpdates => 'Проверить обновления';

  @override
  String get requestingUpdate => 'Запрос обновления...';

  @override
  String get autoupdateUnavailable => 'Автообновление недоступно';

  @override
  String get autoupdateUnavailableDescription =>
      'Служба автоматического обновления недоступна для этого сервера. Это может быть связано с тем, что сервер запущен в контейнере Docker. Вам необходимо обновить свой сервер вручную.';

  @override
  String minute(Object time) {
    return '$time минута';
  }

  @override
  String minutes(Object time) {
    return '$time минут';
  }

  @override
  String hour(Object time) {
    return '$time час';
  }

  @override
  String hours(Object time) {
    return '$time часов';
  }

  @override
  String get remainingTime => 'Оставшееся время';

  @override
  String get safeSearchSettings => 'Настройки безопасного поиска';

  @override
  String get loadingSafeSearchSettings =>
      'Загрузка настроек безопасного поиска...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Ошибка при загрузке настроек безопасного поиска.';

  @override
  String get loadingLogsSettings => 'Загрузка настроек журнала...';

  @override
  String get selectOptionLeftColumn => 'Выберите опцию в левой колонке';

  @override
  String get selectClientLeftColumn => 'Выберите клиента в левой колонке';

  @override
  String get disableList => 'Отключить список';

  @override
  String get enableList => 'Включить список';

  @override
  String get screens => 'Экраны';

  @override
  String get copiedClipboard => 'Скопировано в буфер обмена';

  @override
  String get seeDetails => 'Смотрите подробности';

  @override
  String get listNotAvailable => 'Список недоступен';

  @override
  String get copyListUrl => 'Скопировать URL';

  @override
  String get listUrlCopied => 'URL списка сохранён в буфер обмена';

  @override
  String get unsupportedVersion => 'Неподдерживаемая версия';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'Поддержка AdGuard Home версии $version не гарантируется. Приложение может работать нестабильно с данной версией сервера.\n\nПриложение AdGuard Home Manager предназначено для работы со стабильными версиями AdGuard Home. Приложение может работать с альфа и бета версиями сервера, но совместимость и стабильность не гарантируются.';
  }

  @override
  String get iUnderstand => 'Продолжить';

  @override
  String get appUpdates => 'Обновления приложений';

  @override
  String get usingLatestVersion => 'Вы используете последнюю версию';

  @override
  String get ipLogs => 'IP-адреса в записях журнала';

  @override
  String get ipLogsDescription =>
      'Всегда показывать IP-адрес в записях журнала вместо имени клиента';

  @override
  String get application => 'Приложение';

  @override
  String get combinedChart => 'Объединять графики';

  @override
  String get combinedChartDescription => 'Комбинирует все графики в один';

  @override
  String get statistics => 'Статистика';

  @override
  String get errorLoadFilters => 'Ошибка при загрузке фильтров.';

  @override
  String get clientRemovedSuccessfully => 'Запись успешно удалена.';

  @override
  String get editRewriteRule => 'Редактировать правило';

  @override
  String get dnsRewriteRuleUpdated =>
      'Правило перезаписи DNS успешно обновлено';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'Не удалось обновить правило перезаписи DNS';

  @override
  String get updatingRule => 'Обновление правила...';

  @override
  String get serverUpdateNeeded => 'Требуется обновление сервера';

  @override
  String updateYourServer(Object version) {
    return 'Обновите сервер AdGuard Home до версии $version или выше, чтобы использовать эту функцию.';
  }

  @override
  String get january => 'Январь';

  @override
  String get february => 'Февраль';

  @override
  String get march => 'Март';

  @override
  String get april => 'Апрель';

  @override
  String get may => 'Май';

  @override
  String get june => 'Июнь';

  @override
  String get july => 'Июль';

  @override
  String get august => 'Август';

  @override
  String get september => 'Сентябрь';

  @override
  String get october => 'Октябрь';

  @override
  String get november => 'Ноябрь';

  @override
  String get december => 'Декабрь';

  @override
  String get malwarePhishing => 'Malware/phishing';

  @override
  String get queries => 'Запросы';

  @override
  String get adultSites => '«Взрослые» сайты';

  @override
  String get quickFilters => 'Быстрые фильтры';

  @override
  String get searchDomainInternet => 'Поиск домена в Интернете';

  @override
  String get hideServerAddress => 'Скрывать адрес сервера';

  @override
  String get hideServerAddressDescription =>
      'Скрывает адрес сервера на главном экране';

  @override
  String get topItemsOrder => 'Расположение блоков на главном экране';

  @override
  String get topItemsOrderDescription =>
      'Упорядочьте расположение блоков на главном экране';

  @override
  String get topItemsReorderInfo =>
      'Чтобы менять порядок элементов, удерживая элемент, перетащите его на новое место.';

  @override
  String get discardChanges => 'Отменить изменения';

  @override
  String get discardChangesDescription =>
      'Вы уверены, что хотите отменить изменения?';

  @override
  String get others => 'Прочее';

  @override
  String get showChart => 'Показать график';

  @override
  String get hideChart => 'Скрыть график';

  @override
  String get showTopItemsChart => 'Показывать ТОП-графики на главной странице';

  @override
  String get showTopItemsChartDescription =>
      'По умолчанию на главной странице отображаются круговые диаграммы для часто запрашиваемых доменов, частых клиентов и прочего. Влияет только на просмотр с мобильного устройства';

  @override
  String get openMenu => 'Открыть меню';

  @override
  String get closeMenu => 'Закрыть меню';

  @override
  String get openListUrl => 'Открыть URL списка';

  @override
  String get selectionMode => 'Режим выбора';

  @override
  String get enableDisableSelected =>
      'Включить или выключить выбранные элементы';

  @override
  String get deleteSelected => 'Удалить выбранные элементы';

  @override
  String get deleteSelectedLists => 'Удалить выбранные списки';

  @override
  String get allSelectedListsDeletedSuccessfully =>
      'Все выбранные списки успешно удалены.';

  @override
  String get deletionResult => 'Результат удаления';

  @override
  String get deletingLists => 'Удаление списков...';

  @override
  String get failedElements => 'Неудачные элементы';

  @override
  String get processingLists => 'Обработка списков...';

  @override
  String get enableDisableResult => 'Включить или выключить результат';

  @override
  String get selectedListsEnabledDisabledSuccessfully =>
      'Все выбранные списки были включены или выключены успешно';

  @override
  String get sslWarning =>
      'Если используется HTTPS-соединение с самоподписанным сертификатом, то должна быть активирована опция «Не проверять SSL-сертификат» в разделе «Настройки» > «Дополнительные настройки».';

  @override
  String get unsupportedServerVersion => 'Неподдерживаемая версия сервера';

  @override
  String get unsupportedServerVersionMessage =>
      'Данная версия AdGuard Home устарела и не поддерживается AdGuard Home Manager. Чтобы использовать данное приложение, необходимо выполнить обновление AdGuard Home до актуальной версии.';

  @override
  String yourVersion(Object version) {
    return 'Ваша версия: $version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return 'Минимальная требуемая версия: $version';
  }

  @override
  String get topUpstreams => 'Часто запрашиваемые\nupstream-серверы';

  @override
  String get averageUpstreamResponseTime =>
      'Среднее время отклика\nupstream-сервера';

  @override
  String get dhcpNotAvailable => 'DHCP сервер не доступен.';

  @override
  String get osServerInstalledIncompatible =>
      ' Операционная система, в которой установлен сервер, несовместима с этой функцией.';

  @override
  String get resetSettings => 'Сбросить настройки';

  @override
  String get resetEncryptionSettingsDescription =>
      'Вы уверены, что хотите сбросить настройки шифрования к значениям по умолчанию?';

  @override
  String get resettingConfig => 'Сброс конфигурации...';

  @override
  String get configurationResetSuccessfully => 'Конфигурация успешно сброшена';

  @override
  String get configurationResetError => 'Не удалось сбросить конфигурацию';

  @override
  String get testUpstreamDnsServers => 'Тест upstream DNS-серверов';

  @override
  String get errorTestUpstreamDns =>
      'Ошибка при тестировании upstream DNS-серверов.';

  @override
  String get useCustomIpEdns => 'Use custom IP for EDNS';

  @override
  String get useCustomIpEdnsDescription =>
      'Использовать собственный IP-адрес для EDNS';

  @override
  String get sortingOptions => 'Параметры сортировки';

  @override
  String get fromHighestToLowest => 'От большего к меньшему';

  @override
  String get fromLowestToHighest => 'От меньшего к большему';

  @override
  String get queryLogsAndStatistics => 'Журналы запросов и статистика';

  @override
  String get ignoreClientQueryLog =>
      'Игнорировать этого клиента в журнале запросов';

  @override
  String get ignoreClientStatistics =>
      'Игнорировать этого клиента в статистике';

  @override
  String get savingChanges => 'Сохранение изменений...';

  @override
  String get fallbackDnsServers => 'Резервные DNS-серверы';

  @override
  String get fallbackDnsServersDescription => 'Настроить резервные DNS-серверы';

  @override
  String get fallbackDnsServersInfo =>
      'Список резервных DNS-серверов, используемых в тех случаях, когда вышестоящие DNS-серверы недоступны. Синтаксис такой же, как и в поле Upstream DNS-серверы выше.';

  @override
  String get noFallbackDnsAdded => 'Резервные DNS-серверы не добавлены.';

  @override
  String get blockedResponseTtl => 'TTL заблокированного ответа';

  @override
  String get blockedResponseTtlDescription =>
      'Указывает, в течение скольких секунд клиенты должны кешировать отфильтрованный ответ';

  @override
  String get invalidValue => 'Недопустимое значение';

  @override
  String get noDataChart => 'Нет данных для отображения графика.';

  @override
  String get noData => 'Нет данных';

  @override
  String get unblockClient => 'Разблокировать клиента';

  @override
  String get blockingClient => 'Блокировка клиента...';

  @override
  String get unblockingClient => 'Снятие блокироваки с клиента...';

  @override
  String get upstreamDnsCacheConfiguration =>
      'Конфигурация кеша upstream DNS-серверов';

  @override
  String get enableDnsCachingClient =>
      'Включить кеширование для пользовательской конфигурации upstream-серверов этого клиента';

  @override
  String get dnsCacheSize => 'Размер DNS-кеша';

  @override
  String get nameInvalid => 'Требуется имя';

  @override
  String get oneIdentifierRequired =>
      'Требуется по крайней мере один идентификатор';

  @override
  String get dnsCacheNumber => 'Размер кэша DNS должен быть числом';

  @override
  String get errors => 'Ошибки';

  @override
  String get redirectHttpsWarning =>
      'Если в AdGuard Home активирована опция «Автоматически перенаправлять на HTTPS», то необходимо использовать HTTPS-соединение и HTTPS-порт.';

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
}
