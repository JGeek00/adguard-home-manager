// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get home => '主页';

  @override
  String get settings => '设置';

  @override
  String get connect => '连接';

  @override
  String get servers => '服务器';

  @override
  String get createConnection => '创建连接';

  @override
  String get editConnection => 'Edit connection';

  @override
  String get name => '名称';

  @override
  String get ipDomain => 'IP地址或域名';

  @override
  String get path => '路径';

  @override
  String get port => '端口';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get defaultServer => '默认服务器';

  @override
  String get general => '常规';

  @override
  String get connection => '连接';

  @override
  String get authentication => '身份验证';

  @override
  String get other => '其它';

  @override
  String get invalidPort => '端口无效';

  @override
  String get invalidPath => '路径无效';

  @override
  String get invalidIpDomain => 'IP 地址或域名无效';

  @override
  String get ipDomainNotEmpty => 'IP 地址或域名不能为空';

  @override
  String get nameNotEmpty => '名称不能为空';

  @override
  String get invalidUsernamePassword => '用户名或密码错误';

  @override
  String get tooManyAttempts => '尝试次数过多，请稍后再试';

  @override
  String get cantReachServer => '无法连接服务器，请检查连接信息是否正确';

  @override
  String get sslError => 'SSL 错误 转到 设置 > 高级设置 并启用 不检查 SSL 证书';

  @override
  String get unknownError => '未知错误';

  @override
  String get connectionNotCreated => '连接无法创建';

  @override
  String get connecting => '正在连接...';

  @override
  String get connected => '已连接';

  @override
  String get selectedDisconnected => '已选择但未连接';

  @override
  String get connectionDefaultSuccessfully => '成功将连接设为默认';

  @override
  String get connectionDefaultFailed => '无法将连接设为默认';

  @override
  String get noSavedConnections => '连接为空';

  @override
  String get cannotConnect => '无法连接到服务器';

  @override
  String get connectionRemoved => '连接删除成功';

  @override
  String get connectionCannotBeRemoved => '无法删除连接';

  @override
  String get remove => '移除';

  @override
  String get removeWarning => '您确定要删除与此 AdGuard Home 服务器的连接吗?';

  @override
  String get cancel => '取消';

  @override
  String get defaultConnection => '默认连接';

  @override
  String get setDefault => '设为默认';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get serverStatus => '服务器状态';

  @override
  String get connectionNotUpdated => '没有更新连接配置';

  @override
  String get ruleFilteringWidget => '规则过滤';

  @override
  String get safeBrowsingWidget => '安全浏览';

  @override
  String get parentalFilteringWidget => '家长过滤';

  @override
  String get safeSearchWidget => '安全搜索';

  @override
  String get ruleFiltering => '规则过滤';

  @override
  String get safeBrowsing => '安全浏览';

  @override
  String get parentalFiltering => '家长过滤';

  @override
  String get safeSearch => '安全搜索';

  @override
  String get serverStatusNotRefreshed => '无法更新服务器状态';

  @override
  String get loadingStatus => '加载服务器状态...';

  @override
  String get errorLoadServerStatus => '无法加载服务器状态';

  @override
  String get topQueriedDomains => '请求域名排行';

  @override
  String get viewMore => '查看更多';

  @override
  String get topClients => '客户端排行';

  @override
  String get topBlockedDomains => '被拦截域名排行';

  @override
  String get appSettings => 'App 设置';

  @override
  String get theme => '主题';

  @override
  String get light => '明亮';

  @override
  String get dark => '暗夜';

  @override
  String get systemDefined => '跟随系统';

  @override
  String get close => '关闭';

  @override
  String get connectedTo => '连接到 :';

  @override
  String get selectedServer => '选择的服务器 :';

  @override
  String get noServerSelected => '未选择服务器';

  @override
  String get manageServer => '管理服务器';

  @override
  String get allProtections => '所有保护';

  @override
  String get userNotEmpty => '用户名不能为空';

  @override
  String get passwordNotEmpty => '密码不能为空';

  @override
  String get examplePath => '例如: /adguard';

  @override
  String get helperPath => '如果使用反向代理，可填写路径';

  @override
  String get aboutApp => '关于本应用';

  @override
  String get appVersion => 'App 版本';

  @override
  String get createdBy => '作者';

  @override
  String get clients => '客户端';

  @override
  String get allowed => '允许';

  @override
  String get blocked => '拦截';

  @override
  String get noClientsList => '列表中没有客户端';

  @override
  String get activeClients => '活跃';

  @override
  String get removeClient => '删除客户端';

  @override
  String get removeClientMessage => '您确定要从列表中删除此客户端吗 ?';

  @override
  String get confirm => '确定';

  @override
  String get removingClient => '正在删除客户端...';

  @override
  String get clientNotRemoved => '无法从列表中删除客户端';

  @override
  String get addClient => '添加客户端';

  @override
  String get list => '列表';

  @override
  String get ipAddress => 'IP 地址';

  @override
  String get ipNotValid => 'IP 地址无效';

  @override
  String get clientAddedSuccessfully => '成功将客户端添加到列表';

  @override
  String get addingClient => '正在添加客户端...';

  @override
  String get clientNotAdded => '无法将客户端添加到列表';

  @override
  String get clientAnotherList => '其它列表里已经有这个客户端了';

  @override
  String get noSavedLogs => '没有日志';

  @override
  String get logs => '日志';

  @override
  String get copyLogsClipboard => '将日志复制到剪贴板';

  @override
  String get logsCopiedClipboard => '日志已复制到剪贴板';

  @override
  String get advancedSettings => '高级设置';

  @override
  String get dontCheckCertificate => '不检查 SSL 证书';

  @override
  String get dontCheckCertificateDescription => '忽略服务器的 SSL 证书验证';

  @override
  String get advancedSetupDescription => '高级选项';

  @override
  String get settingsUpdatedSuccessfully => '设置更新成功';

  @override
  String get cannotUpdateSettings => '无法更新设置';

  @override
  String get restartAppTakeEffect => '重新启动应用程序';

  @override
  String get loadingLogs => '正在加载日志...';

  @override
  String get logsNotLoaded => '无法加载日志列表';

  @override
  String get processed => '已处理\n无拦截';

  @override
  String get processedRow => '已处理（无拦截）';

  @override
  String get blockedBlacklist => '已拦截\n黑名单';

  @override
  String get blockedBlacklistRow => '已拦截（黑名单）';

  @override
  String get blockedSafeBrowsing => '已拦截\n安全浏览';

  @override
  String get blockedSafeBrowsingRow => '已拦截（安全浏览）';

  @override
  String get blockedParental => '已拦截\n家长过滤';

  @override
  String get blockedParentalRow => '已拦截（家长过滤）';

  @override
  String get blockedInvalid => '已拦截\n无效';

  @override
  String get blockedInvalidRow => '已拦截（无效）';

  @override
  String get blockedSafeSearch => '已拦截\n安全搜索';

  @override
  String get blockedSafeSearchRow => '已拦截（安全搜索）';

  @override
  String get blockedService => '已拦截\n已拦截的服务';

  @override
  String get blockedServiceRow => '已拦截（已拦截的服务）';

  @override
  String get processedWhitelist => '已处理\n白名单';

  @override
  String get processedWhitelistRow => '已处理（白名单）';

  @override
  String get processedError => '已处理\n错误';

  @override
  String get processedErrorRow => '已处理（错误）';

  @override
  String get rewrite => '重写';

  @override
  String get status => '状态';

  @override
  String get result => '结果';

  @override
  String get time => '时间';

  @override
  String get blocklist => '黑名单列表';

  @override
  String get request => '请求';

  @override
  String get domain => '域名';

  @override
  String get type => '类型';

  @override
  String get clas => '类别';

  @override
  String get response => '响应';

  @override
  String get dnsServer => 'DNS 服务器';

  @override
  String get elapsedTime => '处理时间';

  @override
  String get responseCode => '响应代码';

  @override
  String get client => '客户端';

  @override
  String get deviceIp => 'IP 地址';

  @override
  String get deviceName => '名称';

  @override
  String get logDetails => '日志详情';

  @override
  String get blockingRule => '拦截规则';

  @override
  String get blockDomain => '拦截域名';

  @override
  String get couldntGetFilteringStatus => '无法获取过滤状态';

  @override
  String get unblockDomain => '放行域名';

  @override
  String get userFilteringRulesNotUpdated => '无法更新用户过滤规则';

  @override
  String get userFilteringRulesUpdated => '成功更新用户过滤规则';

  @override
  String get savingUserFilters => '正在保存用户过滤器...';

  @override
  String get filters => '过滤器';

  @override
  String get logsOlderThan => '日志早于';

  @override
  String get responseStatus => '响应状态';

  @override
  String get selectTime => '选择时间';

  @override
  String get notSelected => '未选择';

  @override
  String get resetFilters => '重置过滤器';

  @override
  String get noLogsDisplay => '无日志可显示';

  @override
  String get noLogsThatOld => '选择的时间段可能没有日志 请尝试选择近期时间 ';

  @override
  String get apply => '应用';

  @override
  String get selectAll => '全选';

  @override
  String get unselectAll => '取消全选';

  @override
  String get all => '全部';

  @override
  String get filtered => '已筛选';

  @override
  String get checkAppLogs => '检查应用日志';

  @override
  String get refresh => '刷新';

  @override
  String get search => '搜索';

  @override
  String get dnsQueries => 'DNS 查询';

  @override
  String get average => '平均值';

  @override
  String get blockedFilters => '被过滤器拦截';

  @override
  String get malwarePhishingBlocked => '被拦截的恶意/钓鱼网站';

  @override
  String get blockedAdultWebsites => '被拦截的成人网站';

  @override
  String get generalSettings => '常规设置';

  @override
  String get generalSettingsDescription => '各种不同的设置';

  @override
  String get hideZeroValues => '隐藏零值';

  @override
  String get hideZeroValuesDescription => '在主屏幕上隐藏零值块';

  @override
  String get webAdminPanel => 'Web 管理面板';

  @override
  String get visitGooglePlay => '访问 Google Play 页面';

  @override
  String get gitHub => '开源代码可在 GitHub 上获得';

  @override
  String get blockClient => '拦截客户端';

  @override
  String get selectTags => '选择标签';

  @override
  String get noTagsSelected => '未选择标签';

  @override
  String get tags => '标签';

  @override
  String get identifiers => '标识符';

  @override
  String get identifier => '标识符';

  @override
  String get identifierHelper => 'IP 地址、CIDR、MAC 地址或客户端 ID';

  @override
  String get noIdentifiers => '未添加标识符';

  @override
  String get useGlobalSettings => '使用全局设置';

  @override
  String get enableFiltering => '启用过滤';

  @override
  String get enableSafeBrowsing => '启用安全浏览';

  @override
  String get enableParentalControl => '启用家长控制';

  @override
  String get enableSafeSearch => '启用安全搜索';

  @override
  String get blockedServices => '被拦截的服务';

  @override
  String get selectBlockedServices => '选择要拦截的服务';

  @override
  String get noBlockedServicesSelected => '未选择被拦截的服务';

  @override
  String get services => '服务';

  @override
  String get servicesBlocked => '被拦截的服务';

  @override
  String get tagsSelected => '已选择标签';

  @override
  String get upstreamServers => '上游服务器';

  @override
  String get serverAddress => '服务器地址';

  @override
  String get noUpstreamServers => '无上游服务器';

  @override
  String get willBeUsedGeneralServers => '将使用常规上游服务器';

  @override
  String get added => '已添加';

  @override
  String get clientUpdatedSuccessfully => '客户端更新成功';

  @override
  String get clientNotUpdated => '无法更新客户端';

  @override
  String get clientDeletedSuccessfully => '客户端删除成功';

  @override
  String get clientNotDeleted => '无法删除客户端';

  @override
  String get options => '选项';

  @override
  String get loadingFilters => '正在加载过滤器...';

  @override
  String get filtersNotLoaded => '无法加载过滤器';

  @override
  String get whitelists => '白名单';

  @override
  String get blacklists => '黑名单';

  @override
  String get rules => '规则';

  @override
  String get customRules => '自定义规则';

  @override
  String get enabledRules => '条规则已应用';

  @override
  String get enabled => '已启用';

  @override
  String get disabled => '已禁用';

  @override
  String get rule => '规则';

  @override
  String get addCustomRule => '添加自定义规则';

  @override
  String get removeCustomRule => '删除自定义规则';

  @override
  String get removeCustomRuleMessage => '您确定要删除此自定义规则吗？';

  @override
  String get updatingRules => '正在更新自定义规则...';

  @override
  String get ruleRemovedSuccessfully => '规则删除成功';

  @override
  String get ruleNotRemoved => '无法删除规则';

  @override
  String get ruleAddedSuccessfully => '规则添加成功';

  @override
  String get ruleNotAdded => '无法添加规则';

  @override
  String get noCustomFilters => '无自定义过滤器';

  @override
  String get noBlockedClients => '无已拦截的客户端';

  @override
  String get noBlackLists => '无黑名单';

  @override
  String get noWhiteLists => '无白名单';

  @override
  String get addWhitelist => '添加白名单';

  @override
  String get addBlacklist => '添加黑名单';

  @override
  String get urlNotValid => 'URL 无效';

  @override
  String get urlAbsolutePath => 'URL 或绝对路径';

  @override
  String get addingList => '正在添加订阅规则...';

  @override
  String get listAdded => '订阅规则添加成功  已添加项目：';

  @override
  String get listAlreadyAdded => '订阅规则已被添加';

  @override
  String get listUrlInvalid => '订阅规则 URL 无效';

  @override
  String get listNotAdded => '无法添加订阅规则';

  @override
  String get listDetails => '订阅规则详细信息';

  @override
  String get listType => '订阅规则类型';

  @override
  String get whitelist => '白名单';

  @override
  String get blacklist => '黑名单';

  @override
  String get latestUpdate => '最近更新';

  @override
  String get disable => '禁用';

  @override
  String get enable => '启用';

  @override
  String get currentStatus => '当前状态';

  @override
  String get listDataUpdated => '订阅规则更新成功';

  @override
  String get listDataNotUpdated => '无法更新订阅规则';

  @override
  String get updatingListData => '正在更新订阅规则...';

  @override
  String get editWhitelist => '编辑白名单';

  @override
  String get editBlacklist => '编辑黑名单';

  @override
  String get deletingList => '正在删除订阅规则...';

  @override
  String get listDeleted => '订阅规则删除成功';

  @override
  String get listNotDeleted => '无法删除订阅规则';

  @override
  String get deleteList => '删除订阅规则';

  @override
  String get deleteListMessage => '您确定要删除此订阅规则吗？此操作无法撤消';

  @override
  String get serverSettings => '服务器设置';

  @override
  String get serverInformation => '服务器信息';

  @override
  String get serverInformationDescription => '服务器信息和状态';

  @override
  String get loadingServerInfo => '正在加载服务器信息...';

  @override
  String get serverInfoNotLoaded => '无法加载服务器信息';

  @override
  String get dnsAddresses => 'DNS 地址';

  @override
  String get seeDnsAddresses => '查看 DNS 地址';

  @override
  String get dnsPort => 'DNS 端口';

  @override
  String get httpPort => 'HTTP 端口';

  @override
  String get protectionEnabled => '已启用保护';

  @override
  String get dhcpAvailable => '可用 DHCP';

  @override
  String get serverRunning => '服务器运行中';

  @override
  String get serverVersion => '服务器版本';

  @override
  String get serverLanguage => '服务器语言';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get allowedClients => '已允许的客户端';

  @override
  String get disallowedClients => '已禁止的客户端';

  @override
  String get disallowedDomains => '已禁止的域名';

  @override
  String get accessSettings => '访问设置';

  @override
  String get accessSettingsDescription => '为服务器配置访问规则';

  @override
  String get loadingClients => '正在加载客户端...';

  @override
  String get clientsNotLoaded => '无法加载客户端';

  @override
  String get noAllowedClients => '没有已允许的客户端';

  @override
  String get allowedClientsDescription =>
      '如果此列表中有条目，AdGuard Home 将仅接受来自这些客户端的请求';

  @override
  String get blockedClientsDescription =>
      '如果此列表中有条目，AdGuard Home 将拒绝来自这些客户端的请求 如果已允许客户端中有条目，则会忽略此字段';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home 会丢弃与这些域名匹配的 DNS 查询，这些查询甚至不会出现在查询日志中';

  @override
  String get addClientFieldDescription => 'CIDR、IP 地址或客户端 ID';

  @override
  String get clientIdentifier => '客户端标识符';

  @override
  String get allowClient => '允许客户端';

  @override
  String get disallowClient => '禁止客户端';

  @override
  String get noDisallowedDomains => '无已禁止的域名';

  @override
  String get domainNotAdded => '无法添加域名';

  @override
  String get statusSelected => '已选择状态';

  @override
  String get updateLists => '更新订阅规则';

  @override
  String get checkHostFiltered => '检查域名';

  @override
  String get updatingLists => '正在更新订阅规则...';

  @override
  String get listsUpdated => '已更新订阅规则';

  @override
  String get listsNotUpdated => '无法更新订阅规则';

  @override
  String get listsNotLoaded => '无法加载订阅规则';

  @override
  String get domainNotValid => '域名无效';

  @override
  String get check => '检查';

  @override
  String get checkingHost => '正在检查域名...';

  @override
  String get errorCheckingHost => '无法检查域名';

  @override
  String get block => '拦截';

  @override
  String get unblock => '放行';

  @override
  String get custom => '自定义';

  @override
  String get addImportant => '添加 \$important';

  @override
  String get howCreateRules => '如何创建自定义规则';

  @override
  String get examples => '示例';

  @override
  String get example1 => '拦截访问 example.org 及其所有子域';

  @override
  String get example2 => '解除对 example.org 及其所有子域的访问限制';

  @override
  String get example3 => '添加注释';

  @override
  String get example4 => '拦截与指定正则表达式匹配的域';

  @override
  String get moreInformation => '更多信息';

  @override
  String get addingRule => '正在添加规则...';

  @override
  String get deletingRule => '正在删除规则...';

  @override
  String get enablingList => '正在启用订阅规则...';

  @override
  String get disablingList => '正在禁用订阅规则...';

  @override
  String get savingList => 'Saving list...';

  @override
  String get disableFiltering => '禁用过滤';

  @override
  String get enablingFiltering => '正在启用过滤...';

  @override
  String get disablingFiltering => '正在禁用过滤...';

  @override
  String get filteringStatusUpdated => '过滤状态更新成功';

  @override
  String get filteringStatusNotUpdated => '无法更新过滤状态';

  @override
  String get updateFrequency => '更新频率';

  @override
  String get never => '从不';

  @override
  String get hour1 => '1 小时';

  @override
  String get hours12 => '12 小时';

  @override
  String get hours24 => '24 小时';

  @override
  String get days3 => '3 天';

  @override
  String get days7 => '7 天';

  @override
  String get changingUpdateFrequency => '正在更改...';

  @override
  String get updateFrequencyChanged => '更新频率已成功更改';

  @override
  String get updateFrequencyNotChanged => '无法更改更新频率';

  @override
  String get updating => '正在更新值...';

  @override
  String get blockedServicesUpdated => '被拦截的服务更新成功';

  @override
  String get blockedServicesNotUpdated => '无法更新被拦截的服务';

  @override
  String get insertDomain => '输入要检查的域名以查看其状态';

  @override
  String get dhcpSettings => 'DHCP 设置';

  @override
  String get dhcpSettingsDescription => '配置 DHCP 服务器';

  @override
  String get dhcpSettingsNotLoaded => '无法加载 DHCP 设置';

  @override
  String get loadingDhcp => '正在加载 DHCP 设置...';

  @override
  String get enableDhcpServer => '启用 DHCP 服务器';

  @override
  String get selectInterface => '选择接口';

  @override
  String get hardwareAddress => '硬件地址';

  @override
  String get gatewayIp => '网关 IP';

  @override
  String get ipv4addresses => 'IPv4 地址';

  @override
  String get ipv6addresses => 'IPv6 地址';

  @override
  String get neededSelectInterface => '您需要选择一个接口来配置 DHCP 服务器';

  @override
  String get ipv4settings => 'IPv4 设置';

  @override
  String get startOfRange => '起始范围';

  @override
  String get endOfRange => '结束范围';

  @override
  String get ipv6settings => 'IPv6 设置';

  @override
  String get subnetMask => '子网掩码';

  @override
  String get subnetMaskNotValid => '子网掩码无效';

  @override
  String get gateway => '网关';

  @override
  String get gatewayNotValid => '网关无效';

  @override
  String get leaseTime => '租期';

  @override
  String seconds(Object time) {
    return '$time 秒';
  }

  @override
  String get leaseTimeNotValid => '租期无效';

  @override
  String get restoreConfiguration => '重置配置';

  @override
  String get restoreConfigurationMessage => '您确定要继续吗？这将重置所有配置 此操作无法撤消';

  @override
  String get changeInterface => '更改接口';

  @override
  String get savingSettings => '正在保存设置...';

  @override
  String get settingsSaved => '设置保存成功';

  @override
  String get settingsNotSaved => '无法保存设置';

  @override
  String get restoringConfig => '正在还原配置...';

  @override
  String get configRestored => '配置还原成功';

  @override
  String get configNotRestored => '无法还原配置';

  @override
  String get dhcpStatic => 'DHCP 静态租用';

  @override
  String get noDhcpStaticLeases => '未找到 DHCP 静态租用';

  @override
  String get deleting => '正在删除...';

  @override
  String get staticLeaseDeleted => 'DHCP 静态租用删除成功';

  @override
  String get staticLeaseNotDeleted => '无法删除 DHCP 静态租用';

  @override
  String get deleteStaticLease => '删除静态租用';

  @override
  String get deleteStaticLeaseDescription => 'DHCP 静态租用将被删除 此操作无法撤消';

  @override
  String get addStaticLease => '添加静态租用';

  @override
  String get macAddress => 'MAC 地址';

  @override
  String get macAddressNotValid => 'MAC 地址无效';

  @override
  String get hostName => '主机名';

  @override
  String get hostNameError => '主机名不能为空';

  @override
  String get creating => '正在创建...';

  @override
  String get staticLeaseCreated => 'DHCP 静态租用创建成功';

  @override
  String get staticLeaseNotCreated => '无法创建 DHCP 静态租用';

  @override
  String get staticLeaseExists => 'DHCP 静态租用已存在';

  @override
  String get serverNotConfigured => '未配置服务器';

  @override
  String get restoreLeases => '重置租用';

  @override
  String get restoreLeasesMessage => '您确定要继续吗？这将重置所有现有租用 此操作无法撤消';

  @override
  String get restoringLeases => '正在重置租用...';

  @override
  String get leasesRestored => '租用重置成功';

  @override
  String get leasesNotRestored => '无法重置租用';

  @override
  String get dhcpLeases => 'DHCP 租用';

  @override
  String get noLeases => '无可用的 DHCP 租用';

  @override
  String get dnsRewrites => 'DNS 重写';

  @override
  String get dnsRewritesDescription => '配置自定义 DNS 规则';

  @override
  String get loadingRewriteRules => '正在加载重写规则...';

  @override
  String get rewriteRulesNotLoaded => '无法加载 DNS 重写规则';

  @override
  String get noRewriteRules => '无 DNS 重写规则';

  @override
  String get answer => '响应';

  @override
  String get deleteDnsRewrite => '删除 DNS 重写';

  @override
  String get deleteDnsRewriteMessage => '您确定要删除此 DNS 重写吗？此操作无法撤消';

  @override
  String get dnsRewriteRuleDeleted => 'DNS 重写规则删除成功';

  @override
  String get dnsRewriteRuleNotDeleted => '无法删除 DNS 重写规则';

  @override
  String get addDnsRewrite => '添加 DNS 重写';

  @override
  String get addingRewrite => '正在添加重写...';

  @override
  String get dnsRewriteRuleAdded => 'DNS 重写规则添加成功';

  @override
  String get dnsRewriteRuleNotAdded => '无法添加 DNS 重写规则';

  @override
  String get logsSettings => '日志设置';

  @override
  String get enableLog => '启用日志';

  @override
  String get clearLogs => '清除日志';

  @override
  String get anonymizeClientIp => '匿名化客户端 IP';

  @override
  String get hours6 => '6 小时';

  @override
  String get days30 => '30 天';

  @override
  String get days90 => '90 天';

  @override
  String get retentionTime => '保留时间';

  @override
  String get selectOneItem => '选择一项';

  @override
  String get logSettingsNotLoaded => '无法加载日志设置';

  @override
  String get updatingSettings => '正在更新设置...';

  @override
  String get logsConfigUpdated => '日志设置更新成功';

  @override
  String get logsConfigNotUpdated => '无法更新日志设置';

  @override
  String get deletingLogs => '正在清除日志...';

  @override
  String get logsCleared => '日志清除成功';

  @override
  String get logsNotCleared => '无法清除日志';

  @override
  String get runningHomeAssistant => '在 Home Assistant 上运行';

  @override
  String get serverError => '服务器错误';

  @override
  String get noItems => '这里没有要显示的项目';

  @override
  String get dnsSettings => 'DNS 设置';

  @override
  String get dnsSettingsDescription => '配置与 DNS 服务器的连接';

  @override
  String get upstreamDns => '上游 DNS 服务器';

  @override
  String get bootstrapDns => '引导 DNS 服务器';

  @override
  String get noUpstreamDns => '未添加上游 DNS 服务器 ';

  @override
  String get dnsMode => 'DNS 模式';

  @override
  String get noDnsMode => '未选择 DNS 模式';

  @override
  String get loadBalancing => '负载均衡';

  @override
  String get parallelRequests => '并行请求';

  @override
  String get fastestIpAddress => '最快的 IP 地址';

  @override
  String get loadBalancingDescription =>
      '每次查询一个上游服务器 AdGuard Home 使用其加权随机算法选择服务器，以便更频繁地使用最快的服务器';

  @override
  String get parallelRequestsDescription => '使用并行查询同时加速解析，同时查询所有上游服务器';

  @override
  String get fastestIpAddressDescription =>
      '查询所有 DNS 服务器并返回所有响应中最快的 IP 地址 这会减慢 DNS 查询，因为 AdGuard Home 必须等待所有 DNS 服务器的响应，但可以改善整体连接性';

  @override
  String get noBootstrapDns => '未添加引导 DNS 服务器 ';

  @override
  String get bootstrapDnsServersInfo =>
      '引导 DNS 服务器用于解析您指定的上游 DoH/DoT 解析器的 IP 地址 ';

  @override
  String get privateReverseDnsServers => '私有反向 DNS 服务器';

  @override
  String get privateReverseDnsServersDescription =>
      'AdGuard Home 用于本地 PTR 查询的 DNS 服务器 这些服务器用于解析私有 IP 范围内的地址的 PTR 请求，例如 \"192.168.12.34\" 如果未设置，AdGuard Home 将使用操作系统的默认 DNS 解析器地址，但不包括 AdGuard Home 本身的地址 ';

  @override
  String get reverseDnsDefault => '默认情况下，AdGuard Home 使用以下默认反向 DNS 解析器';

  @override
  String get addItem => '添加项目';

  @override
  String get noServerAddressesAdded => '未添加服务器地址';

  @override
  String get usePrivateReverseDnsResolvers => '使用私有反向 DNS 解析器';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      '使用这些上游服务器执行本地提供的地址的反向 DNS 查询 如果禁用，AdGuard Home 会对所有此类 PTR 请求（除了来自 DHCP、/etc/hosts 等已知客户端）响应 NXDOMAIN';

  @override
  String get enableReverseResolving => '启用客户端 IP 地址的反向解析';

  @override
  String get enableReverseResolvingDescription =>
      '通过向相应的解析器发送 PTR 查询，将客户端 IP 地址进行反向解析为主机名（对于本地客户端使用私有 DNS 服务器，对于具有公共 IP 地址的客户端使用上游服务器）';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS 服务器设置';

  @override
  String get limitRequestsSecond => '每秒速率限制';

  @override
  String get valueNotNumber => '值不是数字';

  @override
  String get enableEdns => '启用 EDNS 客户子网';

  @override
  String get enableEdnsDescription =>
      '在上游请求中添加 EDNS 客户子网选项（ECS），并在查询日志中记录客户端发送的值';

  @override
  String get enableDnssec => '启用 DNSSEC';

  @override
  String get enableDnssecDescription =>
      '在传出的 DNS 查询中设置 DNSSEC 标志并检查结果（需要启用 DNSSEC 的解析器）';

  @override
  String get disableResolvingIpv6 => '禁用 IPv6 地址解析';

  @override
  String get disableResolvingIpv6Description =>
      '丢弃所有用于 IPv6 地址（AAAA 记录）的 DNS 查询';

  @override
  String get blockingMode => '拦截模式';

  @override
  String get defaultMode => '默认';

  @override
  String get defaultDescription =>
      '当按照 Adblock 样式规则被拦截时，返回零 IP 地址（0.0.0.0 对应 A；:: 对应 AAAA）；当按照 /etc/hosts 样式规则被拦截时，返回规则中指定的 IP 地址';

  @override
  String get refusedDescription => '返回 REFUSED 代码';

  @override
  String get nxdomainDescription => '返回 NXDOMAIN 代码';

  @override
  String get nullIp => '空 IP';

  @override
  String get nullIpDescription => '返回空 IP 地址（0.0.0.0 对应 A；:: 对应 AAAA）';

  @override
  String get customIp => '自定义 IP';

  @override
  String get customIpDescription => '返回手动设置的 IP 地址';

  @override
  String get dnsCacheConfig => 'DNS 缓存配置';

  @override
  String get cacheSize => '缓存大小';

  @override
  String get inBytes => '字节';

  @override
  String get overrideMinimumTtl => '覆盖最小 TTL';

  @override
  String get overrideMinimumTtlDescription =>
      '在缓存 DNS 响应时，从上游服务器接收到的最短的存活时间值（秒）';

  @override
  String get overrideMaximumTtl => '覆盖最大 TTL';

  @override
  String get overrideMaximumTtlDescription => '为 DNS 缓存条目设置最大存活时间值（秒）';

  @override
  String get optimisticCaching => '乐观缓存';

  @override
  String get optimisticCachingDescription =>
      '即使条目已过期，AdGuard Home 也将从缓存中响应，并尝试刷新它们';

  @override
  String get loadingDnsConfig => '正在加载 DNS 配置...';

  @override
  String get dnsConfigNotLoaded => '无法加载 DNS 配置';

  @override
  String get blockingIpv4 => '拦截 IPv4';

  @override
  String get blockingIpv4Description => '拦截包含 A 记录的请求时返回的 IP 地址';

  @override
  String get blockingIpv6 => '拦截 IPv6';

  @override
  String get blockingIpv6Description => '拦截包含 AAAA 记录的请求时返回的 IP 地址';

  @override
  String get invalidIp => '无效的 IP 地址';

  @override
  String get dnsConfigSaved => 'DNS 服务器配置保存成功';

  @override
  String get dnsConfigNotSaved => 'DNS 服务器配置无法保存';

  @override
  String get savingConfig => '正在保存配置...';

  @override
  String get someValueNotValid => '某些值无效';

  @override
  String get upstreamDnsDescription => '配置上游服务器和 DNS 模式';

  @override
  String get bootstrapDnsDescription => '配置引导 DNS 服务器';

  @override
  String get privateReverseDnsDescription => '配置自定义 DNS 解析器并启用私有反向 DNS 解析';

  @override
  String get dnsServerSettingsDescription => '配置速率限制、拦截模式等';

  @override
  String get dnsCacheConfigDescription => '配置服务器如何管理 DNS 缓存';

  @override
  String get comment => '注释';

  @override
  String get address => '地址';

  @override
  String get commentsDescription => '注释始终以 # 开头 您无需添加它，系统将自动添加';

  @override
  String get encryptionSettings => '加密设置';

  @override
  String get encryptionSettingsDescription => '加密（HTTPS/QUIC/TLS）支持';

  @override
  String get loadingEncryptionSettings => '正在加载加密设置...';

  @override
  String get encryptionSettingsNotLoaded => '无法加载加密设置';

  @override
  String get enableEncryption => '启用加密';

  @override
  String get enableEncryptionTypes => 'HTTPS、DNS-over-HTTPS 和 DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      '如果启用加密，AdGuard Home 管理界面将通过 HTTPS 运行，并且 DNS 服务器将监听 DNS-over-HTTPS 和 DNS-over-TLS 请求';

  @override
  String get serverConfiguration => '服务器配置';

  @override
  String get domainName => '域名';

  @override
  String get domainNameDescription =>
      '如果设置，AdGuard Home 将检测 ClientID、响应 DDR 查询并执行其他连接验证 如果未设置，这些功能将被禁用 必须与证书中的 DNS 名称之一匹配';

  @override
  String get redirectHttps => '自动重定向到 HTTPS';

  @override
  String get httpsPort => 'HTTPS 端口';

  @override
  String get tlsPort => 'DNS-over-TLS 端口';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC 端口';

  @override
  String get certificates => '证书';

  @override
  String get certificatesDescription =>
      '为了使用加密，您需要为您的域提供有效的 SSL 证书链 您可以在 letsencrypt.org 上获得免费证书，也可以从受信任的证书颁发机构购买';

  @override
  String get certificateFilePath => '设置证书文件路径';

  @override
  String get pasteCertificateContent => '粘贴证书内容';

  @override
  String get certificatePath => '证书路径';

  @override
  String get certificateContent => '证书内容';

  @override
  String get privateKey => '私钥';

  @override
  String get privateKeyFile => '设置私钥文件';

  @override
  String get pastePrivateKey => '粘贴私钥内容';

  @override
  String get usePreviousKey => '使用先前保存的密钥';

  @override
  String get privateKeyPath => '私钥路径';

  @override
  String get invalidCertificate => '无效的证书';

  @override
  String get invalidPrivateKey => '无效的私钥';

  @override
  String get validatingData => '正在验证数据';

  @override
  String get dataValid => '数据有效';

  @override
  String get dataNotValid => '数据无效';

  @override
  String get encryptionConfigSaved => '加密配置已成功保存';

  @override
  String get encryptionConfigNotSaved => '无法保存加密配置';

  @override
  String get configError => '配置错误';

  @override
  String get enterOnlyCertificate => '只输入证书 不要输入 ---BEGIN--- 和 ---END--- 行 ';

  @override
  String get enterOnlyPrivateKey => '只输入密钥 不要输入 ---BEGIN--- 和 ---END--- 行 ';

  @override
  String get noItemsSearch => '没有匹配的项目';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get exitSearch => '退出搜索';

  @override
  String get searchClients => '搜索客户端';

  @override
  String get noClientsSearch => '没有匹配的客户端 ';

  @override
  String get customization => '定制';

  @override
  String get customizationDescription => '自定义此应用程序';

  @override
  String get color => '颜色';

  @override
  String get useDynamicTheme => '使用动态主题';

  @override
  String get red => '红色';

  @override
  String get green => '绿色';

  @override
  String get blue => '蓝色';

  @override
  String get yellow => '黄色';

  @override
  String get orange => '橙色';

  @override
  String get brown => '棕色';

  @override
  String get cyan => '青色';

  @override
  String get purple => '紫色';

  @override
  String get pink => '粉色';

  @override
  String get deepOrange => '深橙色';

  @override
  String get indigo => '靛蓝色';

  @override
  String get useThemeColorStatus => '使用主题颜色来表示状态';

  @override
  String get useThemeColorStatusDescription => '用主题颜色和灰色替换绿色和红色状态颜色';

  @override
  String get invalidCertificateChain => '无效的证书链';

  @override
  String get validCertificateChain => '有效的证书链';

  @override
  String get subject => '主题';

  @override
  String get issuer => '发行人';

  @override
  String get expires => '过期';

  @override
  String get validPrivateKey => '有效的私钥';

  @override
  String get expirationDate => '到期日期';

  @override
  String get keysNotMatch => '无效的证书或密钥：tls: 私钥与公钥不匹配';

  @override
  String get timeLogs => '显示处理时间';

  @override
  String get timeLogsDescription => '在日志列表中显示处理时间';

  @override
  String get hostNames => '主机名';

  @override
  String get keyType => '密钥类型';

  @override
  String get updateAvailable => '可用更新';

  @override
  String get installedVersion => '已安装版本';

  @override
  String get newVersion => '新版本';

  @override
  String get source => '来源';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get download => '下载';

  @override
  String get doNotRememberAgainUpdate => '不要再次提醒此版本';

  @override
  String get downloadingUpdate => '正在下载';

  @override
  String get completed => '已完成';

  @override
  String get permissionNotGranted => '未授予权限';

  @override
  String get inputSearchTerm => '输入搜索词';

  @override
  String get answers => '响应';

  @override
  String get copyClipboard => '复制到剪贴板';

  @override
  String get domainCopiedClipboard => '域名已复制到剪贴板';

  @override
  String get clearDnsCache => '清除 DNS 缓存';

  @override
  String get clearDnsCacheMessage => '您确定要清除 DNS 缓存吗？';

  @override
  String get dnsCacheCleared => 'DNS 缓存清除成功';

  @override
  String get clearingDnsCache => '正在清除缓存...';

  @override
  String get dnsCacheNotCleared => '无法清除 DNS 缓存';

  @override
  String get clientsSelected => '已选择客户端';

  @override
  String get invalidDomain => '无效的域名';

  @override
  String get loadingBlockedServicesList => '正在加载已拦截的服务列表...';

  @override
  String get blockedServicesListNotLoaded => '无法加载已拦截的服务列表';

  @override
  String get error => '错误';

  @override
  String get updates => '更新';

  @override
  String get updatesDescription => '更新 AdGuard Home ';

  @override
  String get updateNow => '立即更新';

  @override
  String get currentVersion => '当前版本';

  @override
  String get requestStartUpdateFailed => '请求启动更新失败';

  @override
  String get requestStartUpdateSuccessful => '请求启动更新成功';

  @override
  String get serverUpdated => 'AdGuard Home 已是最新版';

  @override
  String get unknownStatus => '未知状态';

  @override
  String get checkingUpdates => '正在检查更新...';

  @override
  String get checkUpdates => '检查更新';

  @override
  String get requestingUpdate => '正在请求更新...';

  @override
  String get autoupdateUnavailable => '自动更新不可用';

  @override
  String get autoupdateUnavailableDescription =>
      '此服务器不支持自动更新服务 这可能是因为服务器正在 Docker 容器中运行 您需要手动更新服务器';

  @override
  String minute(Object time) {
    return '$time 分钟';
  }

  @override
  String minutes(Object time) {
    return '$time 分钟';
  }

  @override
  String hour(Object time) {
    return '$time 小时';
  }

  @override
  String hours(Object time) {
    return '$time 小时';
  }

  @override
  String get remainingTime => '剩余时间';

  @override
  String get safeSearchSettings => '安全搜索设置';

  @override
  String get loadingSafeSearchSettings => '正在加载安全搜索设置...';

  @override
  String get safeSearchSettingsNotLoaded => '加载安全搜索设置时出错 ';

  @override
  String get loadingLogsSettings => '正在加载日志设置...';

  @override
  String get selectOptionLeftColumn => '在左侧栏中选择一个选项';

  @override
  String get selectClientLeftColumn => '在左侧栏中选择一个客户端';

  @override
  String get disableList => '禁用订阅规则';

  @override
  String get enableList => '启用订阅规则';

  @override
  String get screens => '屏幕';

  @override
  String get copiedClipboard => '已复制到剪贴板';

  @override
  String get seeDetails => '查看详细信息';

  @override
  String get listNotAvailable => '订阅规则不可用';

  @override
  String get copyListUrl => '复制订阅规则 URL';

  @override
  String get listUrlCopied => '订阅规则 URL 已复制到剪贴板';

  @override
  String get unsupportedVersion => '不支持的版本';

  @override
  String unsupprtedVersionMessage(Object version) {
    return '您的服务器版本 $version 不在支持范围，配合使用可能会存在问题\n\nAdGuard Home Manager 只适配了 AdGuard Home 服务器的稳定版本 alpha 和 beta 版本也许能用，但不保证兼容性，同时使用时可能会存在问题';
  }

  @override
  String get iUnderstand => '我了解';

  @override
  String get appUpdates => '应用程序更新';

  @override
  String get usingLatestVersion => '您正在使用最新版本';

  @override
  String get ipLogs => '显示客户端 IP';

  @override
  String get ipLogsDescription => '始终在日志中显示 IP 地址，而不是客户端名称';

  @override
  String get application => '应用程序';

  @override
  String get combinedChart => '合并图表';

  @override
  String get combinedChartDescription => '将所有图表合并为一个';

  @override
  String get statistics => '统计';

  @override
  String get errorLoadFilters => '加载过滤器时出错';

  @override
  String get clientRemovedSuccessfully => '客户端删除成功';

  @override
  String get editRewriteRule => '编辑重写规则';

  @override
  String get dnsRewriteRuleUpdated => 'DNS 重写规则更新成功';

  @override
  String get dnsRewriteRuleNotUpdated => '无法更新 DNS 重写规则';

  @override
  String get updatingRule => '正在更新规则...';

  @override
  String get serverUpdateNeeded => '需要更新服务器';

  @override
  String updateYourServer(Object version) {
    return '将 AdGuard Home 服务器更新到 $version 或更高版本以使用此功能';
  }

  @override
  String get january => '1月';

  @override
  String get february => '2月';

  @override
  String get march => '3月';

  @override
  String get april => '4月';

  @override
  String get may => '5月';

  @override
  String get june => '6月';

  @override
  String get july => '7月';

  @override
  String get august => '8月';

  @override
  String get september => '9月';

  @override
  String get october => '10月';

  @override
  String get november => '11月';

  @override
  String get december => '12月';

  @override
  String get malwarePhishing => '恶意/钓鱼网站';

  @override
  String get queries => '查询';

  @override
  String get adultSites => '成人网站';

  @override
  String get quickFilters => '状态过滤器';

  @override
  String get searchDomainInternet => '在互联网上搜索该域名';

  @override
  String get hideServerAddress => '隐藏服务器地址';

  @override
  String get hideServerAddressDescription => '在主页上隐藏服务器地址';

  @override
  String get topItemsOrder => '顶部项目顺序';

  @override
  String get topItemsOrderDescription => '排列主页顶部项目列表';

  @override
  String get topItemsReorderInfo => '按住并滑动一个项目以重新排序 ';

  @override
  String get discardChanges => '放弃更改';

  @override
  String get discardChangesDescription => '您确定要放弃更改吗？';

  @override
  String get others => '其他';

  @override
  String get showChart => '显示图表';

  @override
  String get hideChart => '隐藏图表';

  @override
  String get showTopItemsChart => '显示顶部项目图表';

  @override
  String get showTopItemsChartDescription => '默认情况下在移动视图中显示顶部项目部分的环形图 ';

  @override
  String get openMenu => '打开菜单';

  @override
  String get closeMenu => '关闭菜单';

  @override
  String get openListUrl => '打开列表URL';

  @override
  String get selectionMode => '选择模式';

  @override
  String get enableDisableSelected => '启用或禁用选定项目';

  @override
  String get deleteSelected => '删除选定项目';

  @override
  String get deleteSelectedLists => '删除选定列表';

  @override
  String get allSelectedListsDeletedSuccessfully => '所有选定列表已成功删除 ';

  @override
  String get deletionResult => '删除结果';

  @override
  String get deletingLists => '正在删除列表...';

  @override
  String get failedElements => '失败元素';

  @override
  String get processingLists => '正在处理列表...';

  @override
  String get enableDisableResult => '启用或禁用结果';

  @override
  String get selectedListsEnabledDisabledSuccessfully => '所有选定列表已成功启用或禁用';

  @override
  String get sslWarning =>
      '如果您正在使用带有自签名证书的 HTTPS 连接，请确保在设置 > 高级设置中启用 \'不检查 SSL 证书\' ';

  @override
  String get unsupportedServerVersion => '不支持的服务器版本';

  @override
  String get unsupportedServerVersionMessage =>
      '您的 AdGuard Home 服务器版本过旧，不受 AdGuard Home Manager 支持 您需要将 AdGuard Home 服务器升级到更新的版本才能使用此应用程序 ';

  @override
  String yourVersion(Object version) {
    return '您的版本：$version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return '最低要求版本：$version';
  }

  @override
  String get topUpstreams => '主要上游';

  @override
  String get averageUpstreamResponseTime => '平均上游响应时间';

  @override
  String get dhcpNotAvailable => 'DHCP 服务器不可用 ';

  @override
  String get osServerInstalledIncompatible => '服务器安装的操作系统与此功能不兼容 ';

  @override
  String get resetSettings => '重置设置';

  @override
  String get resetEncryptionSettingsDescription => '您确定要将加密设置重置为默认值吗？';

  @override
  String get resettingConfig => '正在重置配置...';

  @override
  String get configurationResetSuccessfully => '配置已成功重置';

  @override
  String get configurationResetError => '配置无法重置';

  @override
  String get testUpstreamDnsServers => '测试上游 DNS 服务器';

  @override
  String get errorTestUpstreamDns => '测试上游 DNS 服务器时出错 ';

  @override
  String get useCustomIpEdns => '使用 EDNS 的自定义 IP';

  @override
  String get useCustomIpEdnsDescription => '允许使用 EDNS 的自定义 IP';

  @override
  String get sortingOptions => '排序选项';

  @override
  String get fromHighestToLowest => '从高到低';

  @override
  String get fromLowestToHighest => '从低到高';

  @override
  String get queryLogsAndStatistics => '查询日志和统计';

  @override
  String get ignoreClientQueryLog => '在查询日志中忽略此客户端';

  @override
  String get ignoreClientStatistics => '在统计中忽略此客户端';

  @override
  String get savingChanges => '正在保存更改...';

  @override
  String get fallbackDnsServers => '备用 DNS 服务器';

  @override
  String get fallbackDnsServersDescription => '配置备用 DNS 服务器';

  @override
  String get fallbackDnsServersInfo =>
      '当上游 DNS 服务器无响应时使用的备用 DNS 服务器列表 语法与上面的主上游字段相同 ';

  @override
  String get noFallbackDnsAdded => '未添加备用 DNS 服务器 ';

  @override
  String get blockedResponseTtl => '被阻止的响应 TTL';

  @override
  String get blockedResponseTtlDescription => '指定客户端应缓存过滤响应的秒数';

  @override
  String get invalidValue => '无效值';

  @override
  String get noDataChart => '没有数据显示此图表 ';

  @override
  String get noData => '无数据';

  @override
  String get unblockClient => '解除客户端封锁';

  @override
  String get blockingClient => '正在封锁客户端...';

  @override
  String get unblockingClient => '正在解除客户端封锁...';

  @override
  String get upstreamDnsCacheConfiguration => 'DNS 上游缓存配置';

  @override
  String get enableDnsCachingClient => '为此客户端启用 DNS 缓存';

  @override
  String get dnsCacheSize => 'DNS 缓存大小';

  @override
  String get nameInvalid => '名称是必需的';

  @override
  String get oneIdentifierRequired => '至少需要一个标识符';

  @override
  String get dnsCacheNumber => 'DNS 缓存大小必须是一个数字';

  @override
  String get errors => '错误';

  @override
  String get redirectHttpsWarning =>
      '如果您在 AdGuard Home 服务器上启用了 \'自动重定向到 HTTPS\'，则必须选择 HTTPS 连接并使用服务器的 HTTPS 端口 ';

  @override
  String get logsSettingsDescription => '配置查询日志';

  @override
  String get ignoredDomains => '忽略的域名';

  @override
  String get noIgnoredDomainsAdded => '未添加忽略的域名';

  @override
  String get pauseServiceBlocking => '暂停服务阻止';

  @override
  String get newSchedule => '新计划';

  @override
  String get editSchedule => '编辑计划';

  @override
  String get timezone => '时区';

  @override
  String get monday => '星期一';

  @override
  String get tuesday => '星期二';

  @override
  String get wednesday => '星期三';

  @override
  String get thursday => '星期四';

  @override
  String get friday => '星期五';

  @override
  String get saturday => '星期六';

  @override
  String get sunday => '星期日';

  @override
  String get from => '从';

  @override
  String get to => '到';

  @override
  String get selectStartTime => '选择开始时间';

  @override
  String get selectEndTime => '选择结束时间';

  @override
  String get startTimeBeforeEndTime => '开始时间必须在结束时间之前 ';

  @override
  String get noBlockingScheduleThisDevice => '此设备没有阻止计划 ';

  @override
  String get selectTimezone => '选择时区';

  @override
  String get selectClientsFiltersInfo => '选择您想要显示的客户端 如果没有选择任何客户端，将显示所有客户端 ';

  @override
  String get noDataThisSection => '本节没有数据 ';

  @override
  String get statisticsSettings => '统计设置';

  @override
  String get statisticsSettingsDescription => '配置统计数据收集';

  @override
  String get loadingStatisticsSettings => '正在加载统计设置...';

  @override
  String get statisticsSettingsLoadError => '加载统计设置时发生错误 ';

  @override
  String get statisticsConfigUpdated => '统计设置成功更新';

  @override
  String get statisticsConfigNotUpdated => '统计设置无法更新';

  @override
  String get customTimeInHours => '自定义时间（以小时为单位）';

  @override
  String get invalidTime => '无效时间';

  @override
  String get removeDomain => '移除域名';

  @override
  String get addDomain => '添加域名';

  @override
  String get notLess1Hour => '时间不能少于 1 小时';

  @override
  String get rateLimit => '速率限制';

  @override
  String get subnetPrefixLengthIpv4 => 'IPv4 的子网前缀长度';

  @override
  String get subnetPrefixLengthIpv6 => 'IPv6 的子网前缀长度';

  @override
  String get rateLimitAllowlist => '速率限制白名单';

  @override
  String get rateLimitAllowlistDescription => '从速率限制中排除的 IP 地址';

  @override
  String get dnsOptions => 'DNS 选项';

  @override
  String get editor => '编辑器';

  @override
  String get editCustomRules => '编辑自定义规则';

  @override
  String get savingCustomRules => '正在保存自定义规则...';

  @override
  String get customRulesUpdatedSuccessfully => '自定义规则成功更新';

  @override
  String get customRulesNotUpdated => '自定义规则无法更新';

  @override
  String get reorder => '重新排序';

  @override
  String get showHide => '显示/隐藏';

  @override
  String get noElementsReorderMessage => '在显示/隐藏标签页上启用一些元素，然后在这里重新排序 ';

  @override
  String get enablePlainDns => '启用普通 DNS';

  @override
  String get enablePlainDnsDescription =>
      '默认启用普通 DNS 您可以禁用它，强制所有设备使用加密 DNS 要做到这一点，您必须至少启用一个加密 DNS 协议 ';

  @override
  String get date => '日期';

  @override
  String get loadingChangelog => '正在加载更新日志...';

  @override
  String get invalidIpOrUrl => '无效的 IP 地址或 URL';

  @override
  String get addPersistentClient => '添加为持久客户端';

  @override
  String get blockThisClientOnly => '仅为此客户端封锁';

  @override
  String get unblockThisClientOnly => '仅为此客户端解封';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain 已为此客户端封锁';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return '$domain 已为此客户端解封';
  }

  @override
  String get disallowThisClient => '禁止此客户端';

  @override
  String get allowThisClient => '允许此客户端';

  @override
  String get clientAllowedSuccessfully => '客户端成功允许';

  @override
  String get clientDisallowedSuccessfully => '客户端成功禁止';

  @override
  String get changesNotSaved => '更改无法保存';

  @override
  String get allowingClient => '正在允许客户端...';

  @override
  String get disallowingClient => '正在禁止客户端...';

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

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get home => '主页';

  @override
  String get settings => '设置';

  @override
  String get connect => '连接';

  @override
  String get servers => '服务器';

  @override
  String get createConnection => '创建连接';

  @override
  String get name => '名称';

  @override
  String get ipDomain => 'IP地址或域名';

  @override
  String get path => '路径';

  @override
  String get port => '端口';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get defaultServer => '默认服务器';

  @override
  String get general => '常规';

  @override
  String get connection => '连接';

  @override
  String get authentication => '身份验证';

  @override
  String get other => '其它';

  @override
  String get invalidPort => '端口无效';

  @override
  String get invalidPath => '路径无效';

  @override
  String get invalidIpDomain => 'IP 地址或域名无效';

  @override
  String get ipDomainNotEmpty => 'IP 地址或域名不能为空';

  @override
  String get nameNotEmpty => '名称不能为空';

  @override
  String get invalidUsernamePassword => '用户名或密码错误';

  @override
  String get tooManyAttempts => '尝试次数过多，请稍后再试';

  @override
  String get cantReachServer => '无法连接服务器，请检查连接信息是否正确';

  @override
  String get sslError => 'SSL 错误 转到 设置 > 高级设置 并启用 不检查 SSL 证书';

  @override
  String get unknownError => '未知错误';

  @override
  String get connectionNotCreated => '连接无法创建';

  @override
  String get connecting => '正在连接...';

  @override
  String get connected => '已连接';

  @override
  String get selectedDisconnected => '已选择但未连接';

  @override
  String get connectionDefaultSuccessfully => '成功将连接设为默认';

  @override
  String get connectionDefaultFailed => '无法将连接设为默认';

  @override
  String get noSavedConnections => '连接为空';

  @override
  String get cannotConnect => '无法连接到服务器';

  @override
  String get connectionRemoved => '连接删除成功';

  @override
  String get connectionCannotBeRemoved => '无法删除连接';

  @override
  String get remove => '移除';

  @override
  String get removeWarning => '您确定要删除与此 AdGuard Home 服务器的连接吗?';

  @override
  String get cancel => '取消';

  @override
  String get defaultConnection => '默认连接';

  @override
  String get setDefault => '设为默认';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get serverStatus => '服务器状态';

  @override
  String get connectionNotUpdated => '没有更新连接配置';

  @override
  String get ruleFilteringWidget => '规则过滤';

  @override
  String get safeBrowsingWidget => '安全浏览';

  @override
  String get parentalFilteringWidget => '家长过滤';

  @override
  String get safeSearchWidget => '安全搜索';

  @override
  String get ruleFiltering => '规则过滤';

  @override
  String get safeBrowsing => '安全浏览';

  @override
  String get parentalFiltering => '家长过滤';

  @override
  String get safeSearch => '安全搜索';

  @override
  String get serverStatusNotRefreshed => '无法更新服务器状态';

  @override
  String get loadingStatus => '加载服务器状态...';

  @override
  String get errorLoadServerStatus => '无法加载服务器状态';

  @override
  String get topQueriedDomains => '请求域名排行';

  @override
  String get viewMore => '查看更多';

  @override
  String get topClients => '客户端排行';

  @override
  String get topBlockedDomains => '被拦截域名排行';

  @override
  String get appSettings => 'App 设置';

  @override
  String get theme => '主题';

  @override
  String get light => '明亮';

  @override
  String get dark => '暗夜';

  @override
  String get systemDefined => '跟随系统';

  @override
  String get close => '关闭';

  @override
  String get connectedTo => '连接到 :';

  @override
  String get selectedServer => '选择的服务器 :';

  @override
  String get noServerSelected => '未选择服务器';

  @override
  String get manageServer => '管理服务器';

  @override
  String get allProtections => '所有保护';

  @override
  String get userNotEmpty => '用户名不能为空';

  @override
  String get passwordNotEmpty => '密码不能为空';

  @override
  String get examplePath => '例如: /adguard';

  @override
  String get helperPath => '如果使用反向代理，可填写路径';

  @override
  String get aboutApp => '关于本应用';

  @override
  String get appVersion => 'App 版本';

  @override
  String get createdBy => '作者';

  @override
  String get clients => '客户端';

  @override
  String get allowed => '允许';

  @override
  String get blocked => '拦截';

  @override
  String get noClientsList => '列表中没有客户端';

  @override
  String get activeClients => '活跃';

  @override
  String get removeClient => '删除客户端';

  @override
  String get removeClientMessage => '您确定要从列表中删除此客户端吗 ?';

  @override
  String get confirm => '确定';

  @override
  String get removingClient => '正在删除客户端...';

  @override
  String get clientNotRemoved => '无法从列表中删除客户端';

  @override
  String get addClient => '添加客户端';

  @override
  String get list => '列表';

  @override
  String get ipAddress => 'IP 地址';

  @override
  String get ipNotValid => 'IP 地址无效';

  @override
  String get clientAddedSuccessfully => '成功将客户端添加到列表';

  @override
  String get addingClient => '正在添加客户端...';

  @override
  String get clientNotAdded => '无法将客户端添加到列表';

  @override
  String get clientAnotherList => '其它列表里已经有这个客户端了';

  @override
  String get noSavedLogs => '没有日志';

  @override
  String get logs => '日志';

  @override
  String get copyLogsClipboard => '将日志复制到剪贴板';

  @override
  String get logsCopiedClipboard => '日志已复制到剪贴板';

  @override
  String get advancedSettings => '高级设置';

  @override
  String get dontCheckCertificate => '不检查 SSL 证书';

  @override
  String get dontCheckCertificateDescription => '忽略服务器的 SSL 证书验证';

  @override
  String get advancedSetupDescription => '高级选项';

  @override
  String get settingsUpdatedSuccessfully => '设置更新成功';

  @override
  String get cannotUpdateSettings => '无法更新设置';

  @override
  String get restartAppTakeEffect => '重新启动应用程序';

  @override
  String get loadingLogs => '正在加载日志...';

  @override
  String get logsNotLoaded => '无法加载日志列表';

  @override
  String get processed => '已处理\n无拦截';

  @override
  String get processedRow => '已处理（无拦截）';

  @override
  String get blockedBlacklist => '已拦截\n黑名单';

  @override
  String get blockedBlacklistRow => '已拦截（黑名单）';

  @override
  String get blockedSafeBrowsing => '已拦截\n安全浏览';

  @override
  String get blockedSafeBrowsingRow => '已拦截（安全浏览）';

  @override
  String get blockedParental => '已拦截\n家长过滤';

  @override
  String get blockedParentalRow => '已拦截（家长过滤）';

  @override
  String get blockedInvalid => '已拦截\n无效';

  @override
  String get blockedInvalidRow => '已拦截（无效）';

  @override
  String get blockedSafeSearch => '已拦截\n安全搜索';

  @override
  String get blockedSafeSearchRow => '已拦截（安全搜索）';

  @override
  String get blockedService => '已拦截\n已拦截的服务';

  @override
  String get blockedServiceRow => '已拦截（已拦截的服务）';

  @override
  String get processedWhitelist => '已处理\n白名单';

  @override
  String get processedWhitelistRow => '已处理（白名单）';

  @override
  String get processedError => '已处理\n错误';

  @override
  String get processedErrorRow => '已处理（错误）';

  @override
  String get rewrite => '重写';

  @override
  String get status => '状态';

  @override
  String get result => '结果';

  @override
  String get time => '时间';

  @override
  String get blocklist => '黑名单列表';

  @override
  String get request => '请求';

  @override
  String get domain => '域名';

  @override
  String get type => '类型';

  @override
  String get clas => '类别';

  @override
  String get response => '响应';

  @override
  String get dnsServer => 'DNS 服务器';

  @override
  String get elapsedTime => '处理时间';

  @override
  String get responseCode => '响应代码';

  @override
  String get client => '客户端';

  @override
  String get deviceIp => 'IP 地址';

  @override
  String get deviceName => '名称';

  @override
  String get logDetails => '日志详情';

  @override
  String get blockingRule => '拦截规则';

  @override
  String get blockDomain => '拦截域名';

  @override
  String get couldntGetFilteringStatus => '无法获取过滤状态';

  @override
  String get unblockDomain => '放行域名';

  @override
  String get userFilteringRulesNotUpdated => '无法更新用户过滤规则';

  @override
  String get userFilteringRulesUpdated => '成功更新用户过滤规则';

  @override
  String get savingUserFilters => '正在保存用户过滤器...';

  @override
  String get filters => '过滤器';

  @override
  String get logsOlderThan => '日志早于';

  @override
  String get responseStatus => '响应状态';

  @override
  String get selectTime => '选择时间';

  @override
  String get notSelected => '未选择';

  @override
  String get resetFilters => '重置过滤器';

  @override
  String get noLogsDisplay => '无日志可显示';

  @override
  String get noLogsThatOld => '选择的时间段可能没有日志 请尝试选择近期时间 ';

  @override
  String get apply => '应用';

  @override
  String get selectAll => '全选';

  @override
  String get unselectAll => '取消全选';

  @override
  String get all => '全部';

  @override
  String get filtered => '已筛选';

  @override
  String get checkAppLogs => '检查应用日志';

  @override
  String get refresh => '刷新';

  @override
  String get search => '搜索';

  @override
  String get dnsQueries => 'DNS 查询';

  @override
  String get average => '平均值';

  @override
  String get blockedFilters => '被过滤器拦截';

  @override
  String get malwarePhishingBlocked => '被拦截的恶意/钓鱼网站';

  @override
  String get blockedAdultWebsites => '被拦截的成人网站';

  @override
  String get generalSettings => '常规设置';

  @override
  String get generalSettingsDescription => '各种不同的设置';

  @override
  String get hideZeroValues => '隐藏零值';

  @override
  String get hideZeroValuesDescription => '在主屏幕上隐藏零值块';

  @override
  String get webAdminPanel => 'Web 管理面板';

  @override
  String get visitGooglePlay => '访问 Google Play 页面';

  @override
  String get gitHub => '开源代码可在 GitHub 上获得';

  @override
  String get blockClient => '拦截客户端';

  @override
  String get selectTags => '选择标签';

  @override
  String get noTagsSelected => '未选择标签';

  @override
  String get tags => '标签';

  @override
  String get identifiers => '标识符';

  @override
  String get identifier => '标识符';

  @override
  String get identifierHelper => 'IP 地址、CIDR、MAC 地址或客户端 ID';

  @override
  String get noIdentifiers => '未添加标识符';

  @override
  String get useGlobalSettings => '使用全局设置';

  @override
  String get enableFiltering => '启用过滤';

  @override
  String get enableSafeBrowsing => '启用安全浏览';

  @override
  String get enableParentalControl => '启用家长控制';

  @override
  String get enableSafeSearch => '启用安全搜索';

  @override
  String get blockedServices => '被拦截的服务';

  @override
  String get selectBlockedServices => '选择要拦截的服务';

  @override
  String get noBlockedServicesSelected => '未选择被拦截的服务';

  @override
  String get services => '服务';

  @override
  String get servicesBlocked => '被拦截的服务';

  @override
  String get tagsSelected => '已选择标签';

  @override
  String get upstreamServers => '上游服务器';

  @override
  String get serverAddress => '服务器地址';

  @override
  String get noUpstreamServers => '无上游服务器';

  @override
  String get willBeUsedGeneralServers => '将使用常规上游服务器';

  @override
  String get added => '已添加';

  @override
  String get clientUpdatedSuccessfully => '客户端更新成功';

  @override
  String get clientNotUpdated => '无法更新客户端';

  @override
  String get clientDeletedSuccessfully => '客户端删除成功';

  @override
  String get clientNotDeleted => '无法删除客户端';

  @override
  String get options => '选项';

  @override
  String get loadingFilters => '正在加载过滤器...';

  @override
  String get filtersNotLoaded => '无法加载过滤器';

  @override
  String get whitelists => '白名单';

  @override
  String get blacklists => '黑名单';

  @override
  String get rules => '规则';

  @override
  String get customRules => '自定义规则';

  @override
  String get enabledRules => '条规则已应用';

  @override
  String get enabled => '已启用';

  @override
  String get disabled => '已禁用';

  @override
  String get rule => '规则';

  @override
  String get addCustomRule => '添加自定义规则';

  @override
  String get removeCustomRule => '删除自定义规则';

  @override
  String get removeCustomRuleMessage => '您确定要删除此自定义规则吗？';

  @override
  String get updatingRules => '正在更新自定义规则...';

  @override
  String get ruleRemovedSuccessfully => '规则删除成功';

  @override
  String get ruleNotRemoved => '无法删除规则';

  @override
  String get ruleAddedSuccessfully => '规则添加成功';

  @override
  String get ruleNotAdded => '无法添加规则';

  @override
  String get noCustomFilters => '无自定义过滤器';

  @override
  String get noBlockedClients => '无已拦截的客户端';

  @override
  String get noBlackLists => '无黑名单';

  @override
  String get noWhiteLists => '无白名单';

  @override
  String get addWhitelist => '添加白名单';

  @override
  String get addBlacklist => '添加黑名单';

  @override
  String get urlNotValid => 'URL 无效';

  @override
  String get urlAbsolutePath => 'URL 或绝对路径';

  @override
  String get addingList => '正在添加订阅规则...';

  @override
  String get listAdded => '订阅规则添加成功  已添加项目：';

  @override
  String get listAlreadyAdded => '订阅规则已被添加';

  @override
  String get listUrlInvalid => '订阅规则 URL 无效';

  @override
  String get listNotAdded => '无法添加订阅规则';

  @override
  String get listDetails => '订阅规则详细信息';

  @override
  String get listType => '订阅规则类型';

  @override
  String get whitelist => '白名单';

  @override
  String get blacklist => '黑名单';

  @override
  String get latestUpdate => '最近更新';

  @override
  String get disable => '禁用';

  @override
  String get enable => '启用';

  @override
  String get currentStatus => '当前状态';

  @override
  String get listDataUpdated => '订阅规则更新成功';

  @override
  String get listDataNotUpdated => '无法更新订阅规则';

  @override
  String get updatingListData => '正在更新订阅规则...';

  @override
  String get editWhitelist => '编辑白名单';

  @override
  String get editBlacklist => '编辑黑名单';

  @override
  String get deletingList => '正在删除订阅规则...';

  @override
  String get listDeleted => '订阅规则删除成功';

  @override
  String get listNotDeleted => '无法删除订阅规则';

  @override
  String get deleteList => '删除订阅规则';

  @override
  String get deleteListMessage => '您确定要删除此订阅规则吗？此操作无法撤消';

  @override
  String get serverSettings => '服务器设置';

  @override
  String get serverInformation => '服务器信息';

  @override
  String get serverInformationDescription => '服务器信息和状态';

  @override
  String get loadingServerInfo => '正在加载服务器信息...';

  @override
  String get serverInfoNotLoaded => '无法加载服务器信息';

  @override
  String get dnsAddresses => 'DNS 地址';

  @override
  String get seeDnsAddresses => '查看 DNS 地址';

  @override
  String get dnsPort => 'DNS 端口';

  @override
  String get httpPort => 'HTTP 端口';

  @override
  String get protectionEnabled => '已启用保护';

  @override
  String get dhcpAvailable => '可用 DHCP';

  @override
  String get serverRunning => '服务器运行中';

  @override
  String get serverVersion => '服务器版本';

  @override
  String get serverLanguage => '服务器语言';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get allowedClients => '已允许的客户端';

  @override
  String get disallowedClients => '已禁止的客户端';

  @override
  String get disallowedDomains => '已禁止的域名';

  @override
  String get accessSettings => '访问设置';

  @override
  String get accessSettingsDescription => '为服务器配置访问规则';

  @override
  String get loadingClients => '正在加载客户端...';

  @override
  String get clientsNotLoaded => '无法加载客户端';

  @override
  String get noAllowedClients => '没有已允许的客户端';

  @override
  String get allowedClientsDescription =>
      '如果此列表中有条目，AdGuard Home 将仅接受来自这些客户端的请求';

  @override
  String get blockedClientsDescription =>
      '如果此列表中有条目，AdGuard Home 将拒绝来自这些客户端的请求 如果已允许客户端中有条目，则会忽略此字段';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home 会丢弃与这些域名匹配的 DNS 查询，这些查询甚至不会出现在查询日志中';

  @override
  String get addClientFieldDescription => 'CIDR、IP 地址或客户端 ID';

  @override
  String get clientIdentifier => '客户端标识符';

  @override
  String get allowClient => '允许客户端';

  @override
  String get disallowClient => '禁止客户端';

  @override
  String get noDisallowedDomains => '无已禁止的域名';

  @override
  String get domainNotAdded => '无法添加域名';

  @override
  String get statusSelected => '已选择状态';

  @override
  String get updateLists => '更新订阅规则';

  @override
  String get checkHostFiltered => '检查域名';

  @override
  String get updatingLists => '正在更新订阅规则...';

  @override
  String get listsUpdated => '已更新订阅规则';

  @override
  String get listsNotUpdated => '无法更新订阅规则';

  @override
  String get listsNotLoaded => '无法加载订阅规则';

  @override
  String get domainNotValid => '域名无效';

  @override
  String get check => '检查';

  @override
  String get checkingHost => '正在检查域名...';

  @override
  String get errorCheckingHost => '无法检查域名';

  @override
  String get block => '拦截';

  @override
  String get unblock => '放行';

  @override
  String get custom => '自定义';

  @override
  String get addImportant => '添加 \$important';

  @override
  String get howCreateRules => '如何创建自定义规则';

  @override
  String get examples => '示例';

  @override
  String get example1 => '拦截访问 example.org 及其所有子域';

  @override
  String get example2 => '解除对 example.org 及其所有子域的访问限制';

  @override
  String get example3 => '添加注释';

  @override
  String get example4 => '拦截与指定正则表达式匹配的域';

  @override
  String get moreInformation => '更多信息';

  @override
  String get addingRule => '正在添加规则...';

  @override
  String get deletingRule => '正在删除规则...';

  @override
  String get enablingList => '正在启用订阅规则...';

  @override
  String get disablingList => '正在禁用订阅规则...';

  @override
  String get disableFiltering => '禁用过滤';

  @override
  String get enablingFiltering => '正在启用过滤...';

  @override
  String get disablingFiltering => '正在禁用过滤...';

  @override
  String get filteringStatusUpdated => '过滤状态更新成功';

  @override
  String get filteringStatusNotUpdated => '无法更新过滤状态';

  @override
  String get updateFrequency => '更新频率';

  @override
  String get never => '从不';

  @override
  String get hour1 => '1 小时';

  @override
  String get hours12 => '12 小时';

  @override
  String get hours24 => '24 小时';

  @override
  String get days3 => '3 天';

  @override
  String get days7 => '7 天';

  @override
  String get changingUpdateFrequency => '正在更改...';

  @override
  String get updateFrequencyChanged => '更新频率已成功更改';

  @override
  String get updateFrequencyNotChanged => '无法更改更新频率';

  @override
  String get updating => '正在更新值...';

  @override
  String get blockedServicesUpdated => '被拦截的服务更新成功';

  @override
  String get blockedServicesNotUpdated => '无法更新被拦截的服务';

  @override
  String get insertDomain => '输入要检查的域名以查看其状态';

  @override
  String get dhcpSettings => 'DHCP 设置';

  @override
  String get dhcpSettingsDescription => '配置 DHCP 服务器';

  @override
  String get dhcpSettingsNotLoaded => '无法加载 DHCP 设置';

  @override
  String get loadingDhcp => '正在加载 DHCP 设置...';

  @override
  String get enableDhcpServer => '启用 DHCP 服务器';

  @override
  String get selectInterface => '选择接口';

  @override
  String get hardwareAddress => '硬件地址';

  @override
  String get gatewayIp => '网关 IP';

  @override
  String get ipv4addresses => 'IPv4 地址';

  @override
  String get ipv6addresses => 'IPv6 地址';

  @override
  String get neededSelectInterface => '您需要选择一个接口来配置 DHCP 服务器';

  @override
  String get ipv4settings => 'IPv4 设置';

  @override
  String get startOfRange => '起始范围';

  @override
  String get endOfRange => '结束范围';

  @override
  String get ipv6settings => 'IPv6 设置';

  @override
  String get subnetMask => '子网掩码';

  @override
  String get subnetMaskNotValid => '子网掩码无效';

  @override
  String get gateway => '网关';

  @override
  String get gatewayNotValid => '网关无效';

  @override
  String get leaseTime => '租期';

  @override
  String seconds(Object time) {
    return '$time 秒';
  }

  @override
  String get leaseTimeNotValid => '租期无效';

  @override
  String get restoreConfiguration => '重置配置';

  @override
  String get restoreConfigurationMessage => '您确定要继续吗？这将重置所有配置 此操作无法撤消';

  @override
  String get changeInterface => '更改接口';

  @override
  String get savingSettings => '正在保存设置...';

  @override
  String get settingsSaved => '设置保存成功';

  @override
  String get settingsNotSaved => '无法保存设置';

  @override
  String get restoringConfig => '正在还原配置...';

  @override
  String get configRestored => '配置还原成功';

  @override
  String get configNotRestored => '无法还原配置';

  @override
  String get dhcpStatic => 'DHCP 静态租用';

  @override
  String get noDhcpStaticLeases => '未找到 DHCP 静态租用';

  @override
  String get deleting => '正在删除...';

  @override
  String get staticLeaseDeleted => 'DHCP 静态租用删除成功';

  @override
  String get staticLeaseNotDeleted => '无法删除 DHCP 静态租用';

  @override
  String get deleteStaticLease => '删除静态租用';

  @override
  String get deleteStaticLeaseDescription => 'DHCP 静态租用将被删除 此操作无法撤消';

  @override
  String get addStaticLease => '添加静态租用';

  @override
  String get macAddress => 'MAC 地址';

  @override
  String get macAddressNotValid => 'MAC 地址无效';

  @override
  String get hostName => '主机名';

  @override
  String get hostNameError => '主机名不能为空';

  @override
  String get creating => '正在创建...';

  @override
  String get staticLeaseCreated => 'DHCP 静态租用创建成功';

  @override
  String get staticLeaseNotCreated => '无法创建 DHCP 静态租用';

  @override
  String get staticLeaseExists => 'DHCP 静态租用已存在';

  @override
  String get serverNotConfigured => '未配置服务器';

  @override
  String get restoreLeases => '重置租用';

  @override
  String get restoreLeasesMessage => '您确定要继续吗？这将重置所有现有租用 此操作无法撤消';

  @override
  String get restoringLeases => '正在重置租用...';

  @override
  String get leasesRestored => '租用重置成功';

  @override
  String get leasesNotRestored => '无法重置租用';

  @override
  String get dhcpLeases => 'DHCP 租用';

  @override
  String get noLeases => '无可用的 DHCP 租用';

  @override
  String get dnsRewrites => 'DNS 重写';

  @override
  String get dnsRewritesDescription => '配置自定义 DNS 规则';

  @override
  String get loadingRewriteRules => '正在加载重写规则...';

  @override
  String get rewriteRulesNotLoaded => '无法加载 DNS 重写规则';

  @override
  String get noRewriteRules => '无 DNS 重写规则';

  @override
  String get answer => '响应';

  @override
  String get deleteDnsRewrite => '删除 DNS 重写';

  @override
  String get deleteDnsRewriteMessage => '您确定要删除此 DNS 重写吗？此操作无法撤消';

  @override
  String get dnsRewriteRuleDeleted => 'DNS 重写规则删除成功';

  @override
  String get dnsRewriteRuleNotDeleted => '无法删除 DNS 重写规则';

  @override
  String get addDnsRewrite => '添加 DNS 重写';

  @override
  String get addingRewrite => '正在添加重写...';

  @override
  String get dnsRewriteRuleAdded => 'DNS 重写规则添加成功';

  @override
  String get dnsRewriteRuleNotAdded => '无法添加 DNS 重写规则';

  @override
  String get logsSettings => '日志设置';

  @override
  String get enableLog => '启用日志';

  @override
  String get clearLogs => '清除日志';

  @override
  String get anonymizeClientIp => '匿名化客户端 IP';

  @override
  String get hours6 => '6 小时';

  @override
  String get days30 => '30 天';

  @override
  String get days90 => '90 天';

  @override
  String get retentionTime => '保留时间';

  @override
  String get selectOneItem => '选择一项';

  @override
  String get logSettingsNotLoaded => '无法加载日志设置';

  @override
  String get updatingSettings => '正在更新设置...';

  @override
  String get logsConfigUpdated => '日志设置更新成功';

  @override
  String get logsConfigNotUpdated => '无法更新日志设置';

  @override
  String get deletingLogs => '正在清除日志...';

  @override
  String get logsCleared => '日志清除成功';

  @override
  String get logsNotCleared => '无法清除日志';

  @override
  String get runningHomeAssistant => '在 Home Assistant 上运行';

  @override
  String get serverError => '服务器错误';

  @override
  String get noItems => '这里没有要显示的项目';

  @override
  String get dnsSettings => 'DNS 设置';

  @override
  String get dnsSettingsDescription => '配置与 DNS 服务器的连接';

  @override
  String get upstreamDns => '上游 DNS 服务器';

  @override
  String get bootstrapDns => '引导 DNS 服务器';

  @override
  String get noUpstreamDns => '未添加上游 DNS 服务器 ';

  @override
  String get dnsMode => 'DNS 模式';

  @override
  String get noDnsMode => '未选择 DNS 模式';

  @override
  String get loadBalancing => '负载均衡';

  @override
  String get parallelRequests => '并行请求';

  @override
  String get fastestIpAddress => '最快的 IP 地址';

  @override
  String get loadBalancingDescription =>
      '每次查询一个上游服务器 AdGuard Home 使用其加权随机算法选择服务器，以便更频繁地使用最快的服务器';

  @override
  String get parallelRequestsDescription => '使用并行查询同时加速解析，同时查询所有上游服务器';

  @override
  String get fastestIpAddressDescription =>
      '查询所有 DNS 服务器并返回所有响应中最快的 IP 地址 这会减慢 DNS 查询，因为 AdGuard Home 必须等待所有 DNS 服务器的响应，但可以改善整体连接性';

  @override
  String get noBootstrapDns => '未添加引导 DNS 服务器 ';

  @override
  String get bootstrapDnsServersInfo =>
      '引导 DNS 服务器用于解析您指定的上游 DoH/DoT 解析器的 IP 地址 ';

  @override
  String get privateReverseDnsServers => '私有反向 DNS 服务器';

  @override
  String get privateReverseDnsServersDescription =>
      'AdGuard Home 用于本地 PTR 查询的 DNS 服务器 这些服务器用于解析私有 IP 范围内的地址的 PTR 请求，例如 \"192.168.12.34\" 如果未设置，AdGuard Home 将使用操作系统的默认 DNS 解析器地址，但不包括 AdGuard Home 本身的地址 ';

  @override
  String get reverseDnsDefault => '默认情况下，AdGuard Home 使用以下默认反向 DNS 解析器';

  @override
  String get addItem => '添加项目';

  @override
  String get noServerAddressesAdded => '未添加服务器地址';

  @override
  String get usePrivateReverseDnsResolvers => '使用私有反向 DNS 解析器';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      '使用这些上游服务器执行本地提供的地址的反向 DNS 查询 如果禁用，AdGuard Home 会对所有此类 PTR 请求（除了来自 DHCP、/etc/hosts 等已知客户端）响应 NXDOMAIN';

  @override
  String get enableReverseResolving => '启用客户端 IP 地址的反向解析';

  @override
  String get enableReverseResolvingDescription =>
      '通过向相应的解析器发送 PTR 查询，将客户端 IP 地址进行反向解析为主机名（对于本地客户端使用私有 DNS 服务器，对于具有公共 IP 地址的客户端使用上游服务器）';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS 服务器设置';

  @override
  String get limitRequestsSecond => '每秒速率限制';

  @override
  String get valueNotNumber => '值不是数字';

  @override
  String get enableEdns => '启用 EDNS 客户子网';

  @override
  String get enableEdnsDescription =>
      '在上游请求中添加 EDNS 客户子网选项（ECS），并在查询日志中记录客户端发送的值';

  @override
  String get enableDnssec => '启用 DNSSEC';

  @override
  String get enableDnssecDescription =>
      '在传出的 DNS 查询中设置 DNSSEC 标志并检查结果（需要启用 DNSSEC 的解析器）';

  @override
  String get disableResolvingIpv6 => '禁用 IPv6 地址解析';

  @override
  String get disableResolvingIpv6Description =>
      '丢弃所有用于 IPv6 地址（AAAA 记录）的 DNS 查询';

  @override
  String get blockingMode => '拦截模式';

  @override
  String get defaultMode => '默认';

  @override
  String get defaultDescription =>
      '当按照 Adblock 样式规则被拦截时，返回零 IP 地址（0.0.0.0 对应 A；:: 对应 AAAA）；当按照 /etc/hosts 样式规则被拦截时，返回规则中指定的 IP 地址';

  @override
  String get refusedDescription => '返回 REFUSED 代码';

  @override
  String get nxdomainDescription => '返回 NXDOMAIN 代码';

  @override
  String get nullIp => '空 IP';

  @override
  String get nullIpDescription => '返回空 IP 地址（0.0.0.0 对应 A；:: 对应 AAAA）';

  @override
  String get customIp => '自定义 IP';

  @override
  String get customIpDescription => '返回手动设置的 IP 地址';

  @override
  String get dnsCacheConfig => 'DNS 缓存配置';

  @override
  String get cacheSize => '缓存大小';

  @override
  String get inBytes => '字节';

  @override
  String get overrideMinimumTtl => '覆盖最小 TTL';

  @override
  String get overrideMinimumTtlDescription =>
      '在缓存 DNS 响应时，从上游服务器接收到的最短的存活时间值（秒）';

  @override
  String get overrideMaximumTtl => '覆盖最大 TTL';

  @override
  String get overrideMaximumTtlDescription => '为 DNS 缓存条目设置最大存活时间值（秒）';

  @override
  String get optimisticCaching => '乐观缓存';

  @override
  String get optimisticCachingDescription =>
      '即使条目已过期，AdGuard Home 也将从缓存中响应，并尝试刷新它们';

  @override
  String get loadingDnsConfig => '正在加载 DNS 配置...';

  @override
  String get dnsConfigNotLoaded => '无法加载 DNS 配置';

  @override
  String get blockingIpv4 => '拦截 IPv4';

  @override
  String get blockingIpv4Description => '拦截包含 A 记录的请求时返回的 IP 地址';

  @override
  String get blockingIpv6 => '拦截 IPv6';

  @override
  String get blockingIpv6Description => '拦截包含 AAAA 记录的请求时返回的 IP 地址';

  @override
  String get invalidIp => '无效的 IP 地址';

  @override
  String get dnsConfigSaved => 'DNS 服务器配置保存成功';

  @override
  String get dnsConfigNotSaved => 'DNS 服务器配置无法保存';

  @override
  String get savingConfig => '正在保存配置...';

  @override
  String get someValueNotValid => '某些值无效';

  @override
  String get upstreamDnsDescription => '配置上游服务器和 DNS 模式';

  @override
  String get bootstrapDnsDescription => '配置引导 DNS 服务器';

  @override
  String get privateReverseDnsDescription => '配置自定义 DNS 解析器并启用私有反向 DNS 解析';

  @override
  String get dnsServerSettingsDescription => '配置速率限制、拦截模式等';

  @override
  String get dnsCacheConfigDescription => '配置服务器如何管理 DNS 缓存';

  @override
  String get comment => '注释';

  @override
  String get address => '地址';

  @override
  String get commentsDescription => '注释始终以 # 开头 您无需添加它，系统将自动添加';

  @override
  String get encryptionSettings => '加密设置';

  @override
  String get encryptionSettingsDescription => '加密（HTTPS/QUIC/TLS）支持';

  @override
  String get loadingEncryptionSettings => '正在加载加密设置...';

  @override
  String get encryptionSettingsNotLoaded => '无法加载加密设置';

  @override
  String get enableEncryption => '启用加密';

  @override
  String get enableEncryptionTypes => 'HTTPS、DNS-over-HTTPS 和 DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      '如果启用加密，AdGuard Home 管理界面将通过 HTTPS 运行，并且 DNS 服务器将监听 DNS-over-HTTPS 和 DNS-over-TLS 请求';

  @override
  String get serverConfiguration => '服务器配置';

  @override
  String get domainName => '域名';

  @override
  String get domainNameDescription =>
      '如果设置，AdGuard Home 将检测 ClientID、响应 DDR 查询并执行其他连接验证 如果未设置，这些功能将被禁用 必须与证书中的 DNS 名称之一匹配';

  @override
  String get redirectHttps => '自动重定向到 HTTPS';

  @override
  String get httpsPort => 'HTTPS 端口';

  @override
  String get tlsPort => 'DNS-over-TLS 端口';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC 端口';

  @override
  String get certificates => '证书';

  @override
  String get certificatesDescription =>
      '为了使用加密，您需要为您的域提供有效的 SSL 证书链 您可以在 letsencrypt.org 上获得免费证书，也可以从受信任的证书颁发机构购买';

  @override
  String get certificateFilePath => '设置证书文件路径';

  @override
  String get pasteCertificateContent => '粘贴证书内容';

  @override
  String get certificatePath => '证书路径';

  @override
  String get certificateContent => '证书内容';

  @override
  String get privateKey => '私钥';

  @override
  String get privateKeyFile => '设置私钥文件';

  @override
  String get pastePrivateKey => '粘贴私钥内容';

  @override
  String get usePreviousKey => '使用先前保存的密钥';

  @override
  String get privateKeyPath => '私钥路径';

  @override
  String get invalidCertificate => '无效的证书';

  @override
  String get invalidPrivateKey => '无效的私钥';

  @override
  String get validatingData => '正在验证数据';

  @override
  String get dataValid => '数据有效';

  @override
  String get dataNotValid => '数据无效';

  @override
  String get encryptionConfigSaved => '加密配置已成功保存';

  @override
  String get encryptionConfigNotSaved => '无法保存加密配置';

  @override
  String get configError => '配置错误';

  @override
  String get enterOnlyCertificate => '只输入证书 不要输入 ---BEGIN--- 和 ---END--- 行 ';

  @override
  String get enterOnlyPrivateKey => '只输入密钥 不要输入 ---BEGIN--- 和 ---END--- 行 ';

  @override
  String get noItemsSearch => '没有匹配的项目';

  @override
  String get clearSearch => '清除搜索';

  @override
  String get exitSearch => '退出搜索';

  @override
  String get searchClients => '搜索客户端';

  @override
  String get noClientsSearch => '没有匹配的客户端 ';

  @override
  String get customization => '定制';

  @override
  String get customizationDescription => '自定义此应用程序';

  @override
  String get color => '颜色';

  @override
  String get useDynamicTheme => '使用动态主题';

  @override
  String get red => '红色';

  @override
  String get green => '绿色';

  @override
  String get blue => '蓝色';

  @override
  String get yellow => '黄色';

  @override
  String get orange => '橙色';

  @override
  String get brown => '棕色';

  @override
  String get cyan => '青色';

  @override
  String get purple => '紫色';

  @override
  String get pink => '粉色';

  @override
  String get deepOrange => '深橙色';

  @override
  String get indigo => '靛蓝色';

  @override
  String get useThemeColorStatus => '使用主题颜色来表示状态';

  @override
  String get useThemeColorStatusDescription => '用主题颜色和灰色替换绿色和红色状态颜色';

  @override
  String get invalidCertificateChain => '无效的证书链';

  @override
  String get validCertificateChain => '有效的证书链';

  @override
  String get subject => '主题';

  @override
  String get issuer => '发行人';

  @override
  String get expires => '过期';

  @override
  String get validPrivateKey => '有效的私钥';

  @override
  String get expirationDate => '到期日期';

  @override
  String get keysNotMatch => '无效的证书或密钥：tls: 私钥与公钥不匹配';

  @override
  String get timeLogs => '显示处理时间';

  @override
  String get timeLogsDescription => '在日志列表中显示处理时间';

  @override
  String get hostNames => '主机名';

  @override
  String get keyType => '密钥类型';

  @override
  String get updateAvailable => '可用更新';

  @override
  String get installedVersion => '已安装版本';

  @override
  String get newVersion => '新版本';

  @override
  String get source => '来源';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get download => '下载';

  @override
  String get doNotRememberAgainUpdate => '不要再次提醒此版本';

  @override
  String get downloadingUpdate => '正在下载';

  @override
  String get completed => '已完成';

  @override
  String get permissionNotGranted => '未授予权限';

  @override
  String get inputSearchTerm => '输入搜索词';

  @override
  String get answers => '响应';

  @override
  String get copyClipboard => '复制到剪贴板';

  @override
  String get domainCopiedClipboard => '域名已复制到剪贴板';

  @override
  String get clearDnsCache => '清除 DNS 缓存';

  @override
  String get clearDnsCacheMessage => '您确定要清除 DNS 缓存吗？';

  @override
  String get dnsCacheCleared => 'DNS 缓存清除成功';

  @override
  String get clearingDnsCache => '正在清除缓存...';

  @override
  String get dnsCacheNotCleared => '无法清除 DNS 缓存';

  @override
  String get clientsSelected => '已选择客户端';

  @override
  String get invalidDomain => '无效的域名';

  @override
  String get loadingBlockedServicesList => '正在加载已拦截的服务列表...';

  @override
  String get blockedServicesListNotLoaded => '无法加载已拦截的服务列表';

  @override
  String get error => '错误';

  @override
  String get updates => '更新';

  @override
  String get updatesDescription => '更新 AdGuard Home ';

  @override
  String get updateNow => '立即更新';

  @override
  String get currentVersion => '当前版本';

  @override
  String get requestStartUpdateFailed => '请求启动更新失败';

  @override
  String get requestStartUpdateSuccessful => '请求启动更新成功';

  @override
  String get serverUpdated => 'AdGuard Home 已是最新版';

  @override
  String get unknownStatus => '未知状态';

  @override
  String get checkingUpdates => '正在检查更新...';

  @override
  String get checkUpdates => '检查更新';

  @override
  String get requestingUpdate => '正在请求更新...';

  @override
  String get autoupdateUnavailable => '自动更新不可用';

  @override
  String get autoupdateUnavailableDescription =>
      '此服务器不支持自动更新服务 这可能是因为服务器正在 Docker 容器中运行 您需要手动更新服务器';

  @override
  String minute(Object time) {
    return '$time 分钟';
  }

  @override
  String minutes(Object time) {
    return '$time 分钟';
  }

  @override
  String hour(Object time) {
    return '$time 小时';
  }

  @override
  String hours(Object time) {
    return '$time 小时';
  }

  @override
  String get remainingTime => '剩余时间';

  @override
  String get safeSearchSettings => '安全搜索设置';

  @override
  String get loadingSafeSearchSettings => '正在加载安全搜索设置...';

  @override
  String get safeSearchSettingsNotLoaded => '加载安全搜索设置时出错 ';

  @override
  String get loadingLogsSettings => '正在加载日志设置...';

  @override
  String get selectOptionLeftColumn => '在左侧栏中选择一个选项';

  @override
  String get selectClientLeftColumn => '在左侧栏中选择一个客户端';

  @override
  String get disableList => '禁用订阅规则';

  @override
  String get enableList => '启用订阅规则';

  @override
  String get screens => '屏幕';

  @override
  String get copiedClipboard => '已复制到剪贴板';

  @override
  String get seeDetails => '查看详细信息';

  @override
  String get listNotAvailable => '订阅规则不可用';

  @override
  String get copyListUrl => '复制订阅规则 URL';

  @override
  String get listUrlCopied => '订阅规则 URL 已复制到剪贴板';

  @override
  String get unsupportedVersion => '不支持的版本';

  @override
  String unsupprtedVersionMessage(Object version) {
    return '您的服务器版本 $version 不在支持范围，配合使用可能会存在问题\n\nAdGuard Home Manager 只适配了 AdGuard Home 服务器的稳定版本 alpha 和 beta 版本也许能用，但不保证兼容性，同时使用时可能会存在问题';
  }

  @override
  String get iUnderstand => '我了解';

  @override
  String get appUpdates => '应用程序更新';

  @override
  String get usingLatestVersion => '您正在使用最新版本';

  @override
  String get ipLogs => '显示客户端 IP';

  @override
  String get ipLogsDescription => '始终在日志中显示 IP 地址，而不是客户端名称';

  @override
  String get application => '应用程序';

  @override
  String get combinedChart => '合并图表';

  @override
  String get combinedChartDescription => '将所有图表合并为一个';

  @override
  String get statistics => '统计';

  @override
  String get errorLoadFilters => '加载过滤器时出错';

  @override
  String get clientRemovedSuccessfully => '客户端删除成功';

  @override
  String get editRewriteRule => '编辑重写规则';

  @override
  String get dnsRewriteRuleUpdated => 'DNS 重写规则更新成功';

  @override
  String get dnsRewriteRuleNotUpdated => '无法更新 DNS 重写规则';

  @override
  String get updatingRule => '正在更新规则...';

  @override
  String get serverUpdateNeeded => '需要更新服务器';

  @override
  String updateYourServer(Object version) {
    return '将 AdGuard Home 服务器更新到 $version 或更高版本以使用此功能';
  }

  @override
  String get january => '1月';

  @override
  String get february => '2月';

  @override
  String get march => '3月';

  @override
  String get april => '4月';

  @override
  String get may => '5月';

  @override
  String get june => '6月';

  @override
  String get july => '7月';

  @override
  String get august => '8月';

  @override
  String get september => '9月';

  @override
  String get october => '10月';

  @override
  String get november => '11月';

  @override
  String get december => '12月';

  @override
  String get malwarePhishing => '恶意/钓鱼网站';

  @override
  String get queries => '查询';

  @override
  String get adultSites => '成人网站';

  @override
  String get quickFilters => '状态过滤器';

  @override
  String get searchDomainInternet => '在互联网上搜索该域名';

  @override
  String get hideServerAddress => '隐藏服务器地址';

  @override
  String get hideServerAddressDescription => '在主页上隐藏服务器地址';

  @override
  String get topItemsOrder => '顶部项目顺序';

  @override
  String get topItemsOrderDescription => '排列主页顶部项目列表';

  @override
  String get topItemsReorderInfo => '按住并滑动一个项目以重新排序 ';

  @override
  String get discardChanges => '放弃更改';

  @override
  String get discardChangesDescription => '您确定要放弃更改吗？';

  @override
  String get others => '其他';

  @override
  String get showChart => '显示图表';

  @override
  String get hideChart => '隐藏图表';

  @override
  String get showTopItemsChart => '显示顶部项目图表';

  @override
  String get showTopItemsChartDescription => '默认情况下在移动视图中显示顶部项目部分的环形图 ';

  @override
  String get openMenu => '打开菜单';

  @override
  String get closeMenu => '关闭菜单';

  @override
  String get openListUrl => '打开列表URL';

  @override
  String get selectionMode => '选择模式';

  @override
  String get enableDisableSelected => '启用或禁用选定项目';

  @override
  String get deleteSelected => '删除选定项目';

  @override
  String get deleteSelectedLists => '删除选定列表';

  @override
  String get allSelectedListsDeletedSuccessfully => '所有选定列表已成功删除 ';

  @override
  String get deletionResult => '删除结果';

  @override
  String get deletingLists => '正在删除列表...';

  @override
  String get failedElements => '失败元素';

  @override
  String get processingLists => '正在处理列表...';

  @override
  String get enableDisableResult => '启用或禁用结果';

  @override
  String get selectedListsEnabledDisabledSuccessfully => '所有选定列表已成功启用或禁用';

  @override
  String get sslWarning =>
      '如果您正在使用带有自签名证书的 HTTPS 连接，请确保在设置 > 高级设置中启用 \'不检查 SSL 证书\' ';

  @override
  String get unsupportedServerVersion => '不支持的服务器版本';

  @override
  String get unsupportedServerVersionMessage =>
      '您的 AdGuard Home 服务器版本过旧，不受 AdGuard Home Manager 支持 您需要将 AdGuard Home 服务器升级到更新的版本才能使用此应用程序 ';

  @override
  String yourVersion(Object version) {
    return '您的版本：$version';
  }

  @override
  String minimumRequiredVersion(Object version) {
    return '最低要求版本：$version';
  }

  @override
  String get topUpstreams => '主要上游';

  @override
  String get averageUpstreamResponseTime => '平均上游响应时间';

  @override
  String get dhcpNotAvailable => 'DHCP 服务器不可用 ';

  @override
  String get osServerInstalledIncompatible => '服务器安装的操作系统与此功能不兼容 ';

  @override
  String get resetSettings => '重置设置';

  @override
  String get resetEncryptionSettingsDescription => '您确定要将加密设置重置为默认值吗？';

  @override
  String get resettingConfig => '正在重置配置...';

  @override
  String get configurationResetSuccessfully => '配置已成功重置';

  @override
  String get configurationResetError => '配置无法重置';

  @override
  String get testUpstreamDnsServers => '测试上游 DNS 服务器';

  @override
  String get errorTestUpstreamDns => '测试上游 DNS 服务器时出错 ';

  @override
  String get useCustomIpEdns => '使用 EDNS 的自定义 IP';

  @override
  String get useCustomIpEdnsDescription => '允许使用 EDNS 的自定义 IP';

  @override
  String get sortingOptions => '排序选项';

  @override
  String get fromHighestToLowest => '从高到低';

  @override
  String get fromLowestToHighest => '从低到高';

  @override
  String get queryLogsAndStatistics => '查询日志和统计';

  @override
  String get ignoreClientQueryLog => '在查询日志中忽略此客户端';

  @override
  String get ignoreClientStatistics => '在统计中忽略此客户端';

  @override
  String get savingChanges => '正在保存更改...';

  @override
  String get fallbackDnsServers => '备用 DNS 服务器';

  @override
  String get fallbackDnsServersDescription => '配置备用 DNS 服务器';

  @override
  String get fallbackDnsServersInfo =>
      '当上游 DNS 服务器无响应时使用的备用 DNS 服务器列表 语法与上面的主上游字段相同 ';

  @override
  String get noFallbackDnsAdded => '未添加备用 DNS 服务器 ';

  @override
  String get blockedResponseTtl => '被阻止的响应 TTL';

  @override
  String get blockedResponseTtlDescription => '指定客户端应缓存过滤响应的秒数';

  @override
  String get invalidValue => '无效值';

  @override
  String get noDataChart => '没有数据显示此图表 ';

  @override
  String get noData => '无数据';

  @override
  String get unblockClient => '解除客户端封锁';

  @override
  String get blockingClient => '正在封锁客户端...';

  @override
  String get unblockingClient => '正在解除客户端封锁...';

  @override
  String get upstreamDnsCacheConfiguration => 'DNS 上游缓存配置';

  @override
  String get enableDnsCachingClient => '为此客户端启用 DNS 缓存';

  @override
  String get dnsCacheSize => 'DNS 缓存大小';

  @override
  String get nameInvalid => '名称是必需的';

  @override
  String get oneIdentifierRequired => '至少需要一个标识符';

  @override
  String get dnsCacheNumber => 'DNS 缓存大小必须是一个数字';

  @override
  String get errors => '错误';

  @override
  String get redirectHttpsWarning =>
      '如果您在 AdGuard Home 服务器上启用了 \'自动重定向到 HTTPS\'，则必须选择 HTTPS 连接并使用服务器的 HTTPS 端口 ';

  @override
  String get logsSettingsDescription => '配置查询日志';

  @override
  String get ignoredDomains => '忽略的域名';

  @override
  String get noIgnoredDomainsAdded => '未添加忽略的域名';

  @override
  String get pauseServiceBlocking => '暂停服务阻止';

  @override
  String get newSchedule => '新计划';

  @override
  String get editSchedule => '编辑计划';

  @override
  String get timezone => '时区';

  @override
  String get monday => '星期一';

  @override
  String get tuesday => '星期二';

  @override
  String get wednesday => '星期三';

  @override
  String get thursday => '星期四';

  @override
  String get friday => '星期五';

  @override
  String get saturday => '星期六';

  @override
  String get sunday => '星期日';

  @override
  String get from => '从';

  @override
  String get to => '到';

  @override
  String get selectStartTime => '选择开始时间';

  @override
  String get selectEndTime => '选择结束时间';

  @override
  String get startTimeBeforeEndTime => '开始时间必须在结束时间之前 ';

  @override
  String get noBlockingScheduleThisDevice => '此设备没有阻止计划 ';

  @override
  String get selectTimezone => '选择时区';

  @override
  String get selectClientsFiltersInfo => '选择您想要显示的客户端 如果没有选择任何客户端，将显示所有客户端 ';

  @override
  String get noDataThisSection => '本节没有数据 ';

  @override
  String get statisticsSettings => '统计设置';

  @override
  String get statisticsSettingsDescription => '配置统计数据收集';

  @override
  String get loadingStatisticsSettings => '正在加载统计设置...';

  @override
  String get statisticsSettingsLoadError => '加载统计设置时发生错误 ';

  @override
  String get statisticsConfigUpdated => '统计设置成功更新';

  @override
  String get statisticsConfigNotUpdated => '统计设置无法更新';

  @override
  String get customTimeInHours => '自定义时间（以小时为单位）';

  @override
  String get invalidTime => '无效时间';

  @override
  String get removeDomain => '移除域名';

  @override
  String get addDomain => '添加域名';

  @override
  String get notLess1Hour => '时间不能少于 1 小时';

  @override
  String get rateLimit => '速率限制';

  @override
  String get subnetPrefixLengthIpv4 => 'IPv4 的子网前缀长度';

  @override
  String get subnetPrefixLengthIpv6 => 'IPv6 的子网前缀长度';

  @override
  String get rateLimitAllowlist => '速率限制白名单';

  @override
  String get rateLimitAllowlistDescription => '从速率限制中排除的 IP 地址';

  @override
  String get dnsOptions => 'DNS 选项';

  @override
  String get editor => '编辑器';

  @override
  String get editCustomRules => '编辑自定义规则';

  @override
  String get savingCustomRules => '正在保存自定义规则...';

  @override
  String get customRulesUpdatedSuccessfully => '自定义规则成功更新';

  @override
  String get customRulesNotUpdated => '自定义规则无法更新';

  @override
  String get reorder => '重新排序';

  @override
  String get showHide => '显示/隐藏';

  @override
  String get noElementsReorderMessage => '在显示/隐藏标签页上启用一些元素，然后在这里重新排序 ';

  @override
  String get enablePlainDns => '启用普通 DNS';

  @override
  String get enablePlainDnsDescription =>
      '默认启用普通 DNS 您可以禁用它，强制所有设备使用加密 DNS 要做到这一点，您必须至少启用一个加密 DNS 协议 ';

  @override
  String get date => '日期';

  @override
  String get loadingChangelog => '正在加载更新日志...';

  @override
  String get invalidIpOrUrl => '无效的 IP 地址或 URL';

  @override
  String get addPersistentClient => '添加为持久客户端';

  @override
  String get blockThisClientOnly => '仅为此客户端封锁';

  @override
  String get unblockThisClientOnly => '仅为此客户端解封';

  @override
  String domainBlockedThisClient(Object domain) {
    return '$domain 已为此客户端封锁';
  }

  @override
  String domainUnblockedThisClient(Object domain) {
    return '$domain 已为此客户端解封';
  }

  @override
  String get disallowThisClient => '禁止此客户端';

  @override
  String get allowThisClient => '允许此客户端';

  @override
  String get clientAllowedSuccessfully => '客户端成功允许';

  @override
  String get clientDisallowedSuccessfully => '客户端成功禁止';

  @override
  String get changesNotSaved => '更改无法保存';

  @override
  String get allowingClient => '正在允许客户端...';

  @override
  String get disallowingClient => '正在禁止客户端...';
}
