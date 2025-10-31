// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get connect => 'Connect';

  @override
  String get servers => 'Servers';

  @override
  String get createConnection => 'Create connection';

  @override
  String get editConnection => 'Edit connection';

  @override
  String get name => 'Name';

  @override
  String get ipDomain => 'IP address or domain';

  @override
  String get path => 'Path';

  @override
  String get port => 'Port';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get defaultServer => 'Default server';

  @override
  String get general => 'General';

  @override
  String get connection => 'Connection';

  @override
  String get authentication => 'Authentication';

  @override
  String get other => 'Other';

  @override
  String get invalidPort => 'Invalid port';

  @override
  String get invalidPath => 'Invalid path';

  @override
  String get invalidIpDomain => 'Invalid IP or domain';

  @override
  String get ipDomainNotEmpty => 'IP or domain cannot be empty';

  @override
  String get nameNotEmpty => 'Name cannot be empty';

  @override
  String get invalidUsernamePassword => 'Invalid username or password';

  @override
  String get tooManyAttempts => 'Too many attempts. Try again later.';

  @override
  String get cantReachServer => 'Can\'t reach server. Check connection data.';

  @override
  String get sslError =>
      'Handshake exception. Cannot establish a secure connection with the server. This can be a SSL error. Go to Settings > Advanced settings and enable Override SSL validation.';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get connectionNotCreated => 'Connection couldn\'t be created';

  @override
  String get connecting => 'Connecting...';

  @override
  String get connected => 'Connected';

  @override
  String get selectedDisconnected => 'Selected but disconnected';

  @override
  String get connectionDefaultSuccessfully =>
      'Connection set as default successfully.';

  @override
  String get connectionDefaultFailed =>
      'Connection could not be set as default.';

  @override
  String get noSavedConnections => 'No saved connections';

  @override
  String get cannotConnect => 'Cannot connect to the server';

  @override
  String get connectionRemoved => 'Connection removed successfully';

  @override
  String get connectionCannotBeRemoved => 'Connection cannot be removed.';

  @override
  String get remove => 'Remove';

  @override
  String get removeWarning =>
      'Are you sure you want to remove the connection with this AdGuard Home server?';

  @override
  String get cancel => 'Cancel';

  @override
  String get defaultConnection => 'Default connection';

  @override
  String get setDefault => 'Set default';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get serverStatus => 'Server status';

  @override
  String get connectionNotUpdated => 'Connection not updated';

  @override
  String get ruleFilteringWidget => 'Rule filtering';

  @override
  String get safeBrowsingWidget => 'Safe browsing';

  @override
  String get parentalFilteringWidget => 'Parental filtering';

  @override
  String get safeSearchWidget => 'Safe search';

  @override
  String get ruleFiltering => 'Rule filtering';

  @override
  String get safeBrowsing => 'Safe browsing';

  @override
  String get parentalFiltering => 'Parental filtering';

  @override
  String get safeSearch => 'Safe search';

  @override
  String get serverStatusNotRefreshed => 'Server status could not be refreshed';

  @override
  String get loadingStatus => 'Loading status...';

  @override
  String get errorLoadServerStatus => 'Server status could not be loaded';

  @override
  String get topQueriedDomains => 'Queried domains';

  @override
  String get viewMore => 'View more';

  @override
  String get topClients => 'Clients';

  @override
  String get topBlockedDomains => 'Blocked domains';

  @override
  String get appSettings => 'App settings';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get systemDefined => 'System defined';

  @override
  String get close => 'Close';

  @override
  String get connectedTo => 'Connected to:';

  @override
  String get selectedServer => 'Selected server:';

  @override
  String get noServerSelected => 'No server selected';

  @override
  String get manageServer => 'Manage server';

  @override
  String get allProtections => 'All protections';

  @override
  String get userNotEmpty => 'Username cannot be empty';

  @override
  String get passwordNotEmpty => 'Password cannot be empty';

  @override
  String get examplePath => 'Example: /adguard';

  @override
  String get helperPath => 'If you are using a reverse proxy';

  @override
  String get aboutApp => 'About the application';

  @override
  String get appVersion => 'App version';

  @override
  String get createdBy => 'Created by';

  @override
  String get clients => 'Clients';

  @override
  String get allowed => 'Allowed';

  @override
  String get blocked => 'Blocked';

  @override
  String get noClientsList => 'There are no clients on this list';

  @override
  String get activeClients => 'Active';

  @override
  String get removeClient => 'Remove client';

  @override
  String get removeClientMessage =>
      'Are you sure you want to remove this client from the list?';

  @override
  String get confirm => 'Confirm';

  @override
  String get removingClient => 'Removing client...';

  @override
  String get clientNotRemoved => 'Client could not be removed from the list';

  @override
  String get addClient => 'Add client';

  @override
  String get list => 'List';

  @override
  String get ipAddress => 'IP address';

  @override
  String get ipNotValid => 'IP address not valid';

  @override
  String get clientAddedSuccessfully => 'Client added to the list successfully';

  @override
  String get addingClient => 'Adding client...';

  @override
  String get clientNotAdded => 'Client could not be added to the list';

  @override
  String get clientAnotherList => 'This client is yet in another list';

  @override
  String get noSavedLogs => 'No saved logs';

  @override
  String get logs => 'Logs';

  @override
  String get copyLogsClipboard => 'Copy logs to clipboard';

  @override
  String get logsCopiedClipboard => 'Logs copied to clipboard';

  @override
  String get advancedSettings => 'Advanced settings';

  @override
  String get dontCheckCertificate => 'Don\'t check SSL certificate';

  @override
  String get dontCheckCertificateDescription =>
      'Overrides the server\'s SSL certificate validation';

  @override
  String get advancedSetupDescription => 'Advanced options';

  @override
  String get settingsUpdatedSuccessfully => 'Settings updated successfully.';

  @override
  String get cannotUpdateSettings => 'Settings cannot be updated.';

  @override
  String get restartAppTakeEffect => 'Restart the application';

  @override
  String get loadingLogs => 'Loading logs...';

  @override
  String get logsNotLoaded => 'Logs list could not be loaded';

  @override
  String get processed => 'Processed\nNo list';

  @override
  String get processedRow => 'Processed (no list)';

  @override
  String get blockedBlacklist => 'Blocked\nBlacklist';

  @override
  String get blockedBlacklistRow => 'Blocked (blacklist)';

  @override
  String get blockedSafeBrowsing => 'Blocked\nSafe browsing';

  @override
  String get blockedSafeBrowsingRow => 'Blocked (safe browsing)';

  @override
  String get blockedParental => 'Blocked\nParental filtering';

  @override
  String get blockedParentalRow => 'Blocked (parental filtering)';

  @override
  String get blockedInvalid => 'Blocked\nInvalid';

  @override
  String get blockedInvalidRow => 'Blocked (invalid)';

  @override
  String get blockedSafeSearch => 'Blocked\nSafe search';

  @override
  String get blockedSafeSearchRow => 'Blocked (safe search)';

  @override
  String get blockedService => 'Blocked\nBlocked service';

  @override
  String get blockedServiceRow => 'Blocked (blocked service)';

  @override
  String get processedWhitelist => 'Processed\nWhitelist';

  @override
  String get processedWhitelistRow => 'Processed (whitelist)';

  @override
  String get processedError => 'Processed\nError';

  @override
  String get processedErrorRow => 'Processed (error)';

  @override
  String get rewrite => 'Rewrite';

  @override
  String get status => 'Status';

  @override
  String get result => 'Result';

  @override
  String get time => 'Time';

  @override
  String get blocklist => 'Blocklist';

  @override
  String get request => 'Request';

  @override
  String get domain => 'Domain';

  @override
  String get type => 'Type';

  @override
  String get clas => 'Class';

  @override
  String get response => 'Response';

  @override
  String get dnsServer => 'DNS server';

  @override
  String get elapsedTime => 'Elapsed time';

  @override
  String get responseCode => 'Response code';

  @override
  String get client => 'Client';

  @override
  String get deviceIp => 'IP address';

  @override
  String get deviceName => 'Name';

  @override
  String get logDetails => 'Log details';

  @override
  String get blockingRule => 'Blocking rule';

  @override
  String get blockDomain => 'Block domain';

  @override
  String get couldntGetFilteringStatus => 'Could not get filtering status';

  @override
  String get unblockDomain => 'Unblock domain';

  @override
  String get userFilteringRulesNotUpdated =>
      'User filtering rules could not be updated';

  @override
  String get userFilteringRulesUpdated =>
      'User filtering rules updated successfully';

  @override
  String get savingUserFilters => 'Saving user filters...';

  @override
  String get filters => 'Filters';

  @override
  String get logsOlderThan => 'Logs older than';

  @override
  String get responseStatus => 'Response status';

  @override
  String get selectTime => 'Select time';

  @override
  String get notSelected => 'Not selected';

  @override
  String get resetFilters => 'Reset filters';

  @override
  String get noLogsDisplay => 'No logs to display';

  @override
  String get noLogsThatOld =>
      'It\'s possible that there are no logs saved for that selected time. Try selecting a more recent time.';

  @override
  String get apply => 'Apply';

  @override
  String get selectAll => 'Select all';

  @override
  String get unselectAll => 'Unselect all';

  @override
  String get all => 'All';

  @override
  String get filtered => 'Filtered';

  @override
  String get checkAppLogs => 'Check app logs';

  @override
  String get refresh => 'Refresh';

  @override
  String get search => 'Search';

  @override
  String get dnsQueries => 'DNS queries';

  @override
  String get average => 'Average';

  @override
  String get blockedFilters => 'Blocked by filters';

  @override
  String get malwarePhishingBlocked => 'Blocked malware/phishing';

  @override
  String get blockedAdultWebsites => 'Blocked adult websites';

  @override
  String get generalSettings => 'General settings';

  @override
  String get generalSettingsDescription => 'Various different settings';

  @override
  String get hideZeroValues => 'Hide zero values';

  @override
  String get hideZeroValuesDescription =>
      'On homescreen, hide blocks with zero value';

  @override
  String get webAdminPanel => 'Web admin. panel';

  @override
  String get visitGooglePlay => 'Visit Google Play page';

  @override
  String get gitHub => 'App code available on GitHub';

  @override
  String get blockClient => 'Block client';

  @override
  String get selectTags => 'Select tags';

  @override
  String get noTagsSelected => 'No tags selected';

  @override
  String get tags => 'Tags';

  @override
  String get identifiers => 'Identifiers';

  @override
  String get identifier => 'Identifier';

  @override
  String get identifierHelper => 'IP address, CIDR, MAC address, or ClientID';

  @override
  String get noIdentifiers => 'No identifiers added';

  @override
  String get useGlobalSettings => 'Use global settings';

  @override
  String get enableFiltering => 'Enable filtering';

  @override
  String get enableSafeBrowsing => 'Enable safe browsing';

  @override
  String get enableParentalControl => 'Enable parental control';

  @override
  String get enableSafeSearch => 'Enable safe search';

  @override
  String get blockedServices => 'Blocked services';

  @override
  String get selectBlockedServices => 'Select services to block';

  @override
  String get noBlockedServicesSelected => 'No blocked services';

  @override
  String get services => 'Services';

  @override
  String get servicesBlocked => 'services blocked';

  @override
  String get tagsSelected => 'tags selected';

  @override
  String get upstreamServers => 'Upstream servers';

  @override
  String get serverAddress => 'Server address';

  @override
  String get noUpstreamServers => 'No upstream servers.';

  @override
  String get willBeUsedGeneralServers =>
      'General upstream servers will be used.';

  @override
  String get added => 'Added';

  @override
  String get clientUpdatedSuccessfully => 'Client updated successfully';

  @override
  String get clientNotUpdated => 'Client could not be updated';

  @override
  String get clientDeletedSuccessfully => 'Client removed successfully';

  @override
  String get clientNotDeleted => 'Client could not be deleted';

  @override
  String get options => 'Options';

  @override
  String get loadingFilters => 'Loading filters...';

  @override
  String get filtersNotLoaded => 'Filters couldn\'t be loaded.';

  @override
  String get whitelists => 'Whitelists';

  @override
  String get blacklists => 'Blacklists';

  @override
  String get rules => 'Rules';

  @override
  String get customRules => 'Custom rules';

  @override
  String get enabledRules => 'Enabled rules';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get rule => 'Rule';

  @override
  String get addCustomRule => 'Add custom rule';

  @override
  String get removeCustomRule => 'Remove custom rule';

  @override
  String get removeCustomRuleMessage =>
      'Are you sure you want to remove this custom rule?';

  @override
  String get updatingRules => 'Updating custom rules...';

  @override
  String get ruleRemovedSuccessfully => 'Rule removed successfully';

  @override
  String get ruleNotRemoved => 'Couldn\'t remove the rule';

  @override
  String get ruleAddedSuccessfully => 'Rule added successfully';

  @override
  String get ruleNotAdded => 'Couldn\'t add the rule';

  @override
  String get noCustomFilters => 'No custom filters';

  @override
  String get noBlockedClients => 'No blocked clients';

  @override
  String get noBlackLists => 'No blacklists';

  @override
  String get noWhiteLists => 'No whitelists';

  @override
  String get addWhitelist => 'Add whitelist';

  @override
  String get addBlacklist => 'Add blacklist';

  @override
  String get urlNotValid => 'URL is not valid';

  @override
  String get urlAbsolutePath => 'URL or absolute path';

  @override
  String get addingList => 'Adding list...';

  @override
  String get listAdded => 'List added successfully. Items added:';

  @override
  String get listAlreadyAdded => 'List already added';

  @override
  String get listUrlInvalid => 'List URL invalid';

  @override
  String get listNotAdded => 'List couldn\'t be added';

  @override
  String get listDetails => 'List details';

  @override
  String get listType => 'List type';

  @override
  String get whitelist => 'White list';

  @override
  String get blacklist => 'Black list';

  @override
  String get latestUpdate => 'Latest update';

  @override
  String get disable => 'Disable';

  @override
  String get enable => 'Enable';

  @override
  String get currentStatus => 'Current status';

  @override
  String get listDataUpdated => 'List data updated successfull';

  @override
  String get listDataNotUpdated => 'Couldn\'t update list data';

  @override
  String get updatingListData => 'Updating list data...';

  @override
  String get editWhitelist => 'Edit white list';

  @override
  String get editBlacklist => 'Edit black list';

  @override
  String get deletingList => 'Deleting list...';

  @override
  String get listDeleted => 'List deleted successfully';

  @override
  String get listNotDeleted => 'The list couldn\'t be deleted';

  @override
  String get deleteList => 'Delete list';

  @override
  String get deleteListMessage =>
      'Are you sure you want to delete this list? This action can\'t be reverted.';

  @override
  String get serverSettings => 'Server settings';

  @override
  String get serverInformation => 'Server information';

  @override
  String get serverInformationDescription => 'Server information and status';

  @override
  String get loadingServerInfo => 'Loading server information...';

  @override
  String get serverInfoNotLoaded => 'Server information couldn\'t be loaded.';

  @override
  String get dnsAddresses => 'DNS addresses';

  @override
  String get seeDnsAddresses => 'See DNS addresses';

  @override
  String get dnsPort => 'DNS port';

  @override
  String get httpPort => 'HTTP port';

  @override
  String get protectionEnabled => 'Protection enabled';

  @override
  String get dhcpAvailable => 'DHCP available';

  @override
  String get serverRunning => 'Server running';

  @override
  String get serverVersion => 'Server version';

  @override
  String get serverLanguage => 'Server language';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get allowedClients => 'Allowed clients';

  @override
  String get disallowedClients => 'Disallowed clients';

  @override
  String get disallowedDomains => 'Disallowed domains';

  @override
  String get accessSettings => 'Access settings';

  @override
  String get accessSettingsDescription =>
      'Configure access rules for the server';

  @override
  String get loadingClients => 'Loading clients...';

  @override
  String get clientsNotLoaded => 'Clients couldn\'t be loaded.';

  @override
  String get noAllowedClients => 'No allowed clients';

  @override
  String get allowedClientsDescription =>
      'If this list has entries, AdGuard Home will accept requests only from these clients.';

  @override
  String get blockedClientsDescription =>
      'If this list has entries, AdGuard Home will drop requests from these clients. This field is ignored if there are entries in Allowed clients.';

  @override
  String get disallowedDomainsDescription =>
      'AdGuard Home drops DNS queries matching these domains, and these queries don\'t even appear in the query log.';

  @override
  String get addClientFieldDescription => 'CIDRs, IP address, or ClientID';

  @override
  String get clientIdentifier => 'Client identifier';

  @override
  String get allowClient => 'Allow client';

  @override
  String get disallowClient => 'Disallow client';

  @override
  String get noDisallowedDomains => 'No disallowed domains';

  @override
  String get domainNotAdded => 'The domain couldn\'t be added';

  @override
  String get statusSelected => 'status selected';

  @override
  String get updateLists => 'Update lists';

  @override
  String get checkHostFiltered => 'Check host';

  @override
  String get updatingLists => 'Updating lists...';

  @override
  String get listsUpdated => 'lists updated';

  @override
  String get listsNotUpdated => 'Couldn\'t update lists';

  @override
  String get listsNotLoaded => 'Lists couldn\'t be loaded';

  @override
  String get domainNotValid => 'Domain not valid';

  @override
  String get check => 'Check';

  @override
  String get checkingHost => 'Checking host...';

  @override
  String get errorCheckingHost => 'Host couldn\'t be checked';

  @override
  String get block => 'Block';

  @override
  String get unblock => 'Unblock';

  @override
  String get custom => 'Custom';

  @override
  String get addImportant => 'Add \$important';

  @override
  String get howCreateRules => 'How to create custom rules';

  @override
  String get examples => 'Examples';

  @override
  String get example1 => 'Block access to example.org and all its subdomains.';

  @override
  String get example2 =>
      'Unblocks access to example.org and all its subdomains.';

  @override
  String get example3 => 'Adds a comment.';

  @override
  String get example4 =>
      'Block access to domains matching the specified regular expression.';

  @override
  String get moreInformation => 'More information';

  @override
  String get addingRule => 'Adding rule...';

  @override
  String get deletingRule => 'Deleting rule...';

  @override
  String get enablingList => 'Enabling list...';

  @override
  String get disablingList => 'Disabling list...';

  @override
  String get savingList => 'Saving list...';

  @override
  String get disableFiltering => 'Disable filtering';

  @override
  String get enablingFiltering => 'Enabling filtering...';

  @override
  String get disablingFiltering => 'Disabling filtering...';

  @override
  String get filteringStatusUpdated => 'Filtering status updated successfully';

  @override
  String get filteringStatusNotUpdated =>
      'Filtering status couldn\'t be updated';

  @override
  String get updateFrequency => 'Update frequency';

  @override
  String get never => 'Never';

  @override
  String get hour1 => '1 hour';

  @override
  String get hours12 => '12 hours';

  @override
  String get hours24 => '24 hours';

  @override
  String get days3 => '3 days';

  @override
  String get days7 => '7 days';

  @override
  String get changingUpdateFrequency => 'Changing...';

  @override
  String get updateFrequencyChanged => 'Update frequency changed successfully';

  @override
  String get updateFrequencyNotChanged =>
      'Updare frecuency couldn\'t be changed';

  @override
  String get updating => 'Updating values...';

  @override
  String get blockedServicesUpdated => 'Blocked services updated successfully';

  @override
  String get blockedServicesNotUpdated =>
      'Blocked services couldn\'t be updated';

  @override
  String get insertDomain => 'Insert a domain to check it\'s stauts.';

  @override
  String get dhcpSettings => 'DHCP settings';

  @override
  String get dhcpSettingsDescription => 'Configure the DHCP server';

  @override
  String get dhcpSettingsNotLoaded => 'DHCP settings could not be loaded';

  @override
  String get loadingDhcp => 'Loading DHCP settings...';

  @override
  String get enableDhcpServer => 'Enable DHCP server';

  @override
  String get selectInterface => 'Select interface';

  @override
  String get hardwareAddress => 'Hardware address';

  @override
  String get gatewayIp => 'Gateway IP';

  @override
  String get ipv4addresses => 'IPv4 addresses';

  @override
  String get ipv6addresses => 'IPv6 addresses';

  @override
  String get neededSelectInterface =>
      'You need to select an interface to configure the DHCP server.';

  @override
  String get ipv4settings => 'IPv4 settings';

  @override
  String get startOfRange => 'Start of range';

  @override
  String get endOfRange => 'End of range';

  @override
  String get ipv6settings => 'IPv6 settings';

  @override
  String get subnetMask => 'Subnet mask';

  @override
  String get subnetMaskNotValid => 'Subnet mask not valid';

  @override
  String get gateway => 'Gateway';

  @override
  String get gatewayNotValid => 'Gateway not valid';

  @override
  String get leaseTime => 'Lease time';

  @override
  String seconds(Object time) {
    return '$time seconds';
  }

  @override
  String get leaseTimeNotValid => 'Lease time not valid';

  @override
  String get restoreConfiguration => 'Reset configuration';

  @override
  String get restoreConfigurationMessage =>
      'Are you sure you want to continue? This will reset all the configuration. This action cannot be undone.';

  @override
  String get changeInterface => 'Change interface';

  @override
  String get savingSettings => 'Saving settings...';

  @override
  String get settingsSaved => 'Settings saved successfully';

  @override
  String get settingsNotSaved => 'Settings couldn\'t be saved';

  @override
  String get restoringConfig => 'Restoring configuration...';

  @override
  String get configRestored => 'Configuration reseted successfully';

  @override
  String get configNotRestored => 'The configuration couldn\'t be reseted';

  @override
  String get dhcpStatic => 'DHCP static leases';

  @override
  String get noDhcpStaticLeases => 'No DHCP static leases found';

  @override
  String get deleting => 'Deleting...';

  @override
  String get staticLeaseDeleted => 'DHCP static lease deleted successfully';

  @override
  String get staticLeaseNotDeleted =>
      'The DHCP static lease could not be deleted';

  @override
  String get deleteStaticLease => 'Delete static lease';

  @override
  String get deleteStaticLeaseDescription =>
      'The DHCP static lease will be deleted. This action cannot be reverted.';

  @override
  String get addStaticLease => 'Add static lease';

  @override
  String get macAddress => 'MAC address';

  @override
  String get macAddressNotValid => 'MAC address not valid';

  @override
  String get hostName => 'Host name';

  @override
  String get hostNameError => 'Host name cannot be empty';

  @override
  String get creating => 'Creating...';

  @override
  String get staticLeaseCreated => 'DHCP static lease created successfully';

  @override
  String get staticLeaseNotCreated =>
      'The DHCP static lease couldn\'t be created';

  @override
  String get staticLeaseExists => 'The DHCP static lease already exists';

  @override
  String get serverNotConfigured => 'Server not configured';

  @override
  String get restoreLeases => 'Reset leases';

  @override
  String get restoreLeasesMessage =>
      'Are you sure you want to continue? This will reset all the existing leases. This action cannot be undone.';

  @override
  String get restoringLeases => 'Resetting leases...';

  @override
  String get leasesRestored => 'Leases reseted successfully';

  @override
  String get leasesNotRestored => 'The leases couldn\'t be reseted';

  @override
  String get dhcpLeases => 'DHCP leases';

  @override
  String get noLeases => 'No DHCP leases available';

  @override
  String get dnsRewrites => 'DNS rewrites';

  @override
  String get dnsRewritesDescription => 'Configure custom DNS rules';

  @override
  String get loadingRewriteRules => 'Loading rewrite rules...';

  @override
  String get rewriteRulesNotLoaded => 'DNS rewrite rules could not be loaded.';

  @override
  String get noRewriteRules => 'No DNS rewrite rules';

  @override
  String get answer => 'Answer';

  @override
  String get deleteDnsRewrite => 'Delete DNS rewrite';

  @override
  String get deleteDnsRewriteMessage =>
      'Are you sure you want to delete this DNS rewrite? This action cannot be undone.';

  @override
  String get dnsRewriteRuleDeleted => 'DNS rewrite rule deleted successfully';

  @override
  String get dnsRewriteRuleNotDeleted =>
      'The DNS rewrite rule could not be deleted';

  @override
  String get addDnsRewrite => 'Add DNS rewrite';

  @override
  String get addingRewrite => 'Adding rewrite...';

  @override
  String get dnsRewriteRuleAdded => 'DNS rewrite rule addded successfully';

  @override
  String get dnsRewriteRuleNotAdded => 'DNS rewrite rule could not be added';

  @override
  String get logsSettings => 'Logs settings';

  @override
  String get enableLog => 'Enable log';

  @override
  String get clearLogs => 'Clear logs';

  @override
  String get anonymizeClientIp => 'Anonymize client IP';

  @override
  String get hours6 => '6 hours';

  @override
  String get days30 => '30 days';

  @override
  String get days90 => '90 days';

  @override
  String get retentionTime => 'Retention time';

  @override
  String get selectOneItem => 'Select one item';

  @override
  String get logSettingsNotLoaded => 'Log settings couldn\'t be loaded.';

  @override
  String get updatingSettings => 'Updating settings...';

  @override
  String get logsConfigUpdated => 'Logs settings updated successfully';

  @override
  String get logsConfigNotUpdated => 'Logs settings couldn\'t be updated';

  @override
  String get deletingLogs => 'Clearing logs...';

  @override
  String get logsCleared => 'Logs cleared successfully';

  @override
  String get logsNotCleared => 'Logs could not be cleared';

  @override
  String get runningHomeAssistant => 'Running on Home Assistant';

  @override
  String get serverError => 'Server error';

  @override
  String get noItems => 'No items to show here';

  @override
  String get dnsSettings => 'DNS settings';

  @override
  String get dnsSettingsDescription => 'Configure connection with DNS servers';

  @override
  String get upstreamDns => 'Upstream DNS servers';

  @override
  String get bootstrapDns => 'Bootstrap DNS servers';

  @override
  String get noUpstreamDns => 'No upstream DNS servers added.';

  @override
  String get dnsMode => 'DNS mode';

  @override
  String get noDnsMode => 'No DNS mode selected';

  @override
  String get loadBalancing => 'Load balancing';

  @override
  String get parallelRequests => 'Parallel requests';

  @override
  String get fastestIpAddress => 'Fastest IP address';

  @override
  String get loadBalancingDescription =>
      'Query one upstream server at a time. AdGuard Home uses its weighted random algorithm to pick the server so that the fastest server is used more often.';

  @override
  String get parallelRequestsDescription =>
      'Use parallel queries to speed up resolving by querying all upstream servers simultaneously.';

  @override
  String get fastestIpAddressDescription =>
      'Query all DNS servers and return the fastest IP address among all responses. This slows down DNS queries as AdGuard Home has to wait for responses from all DNS servers, but improves the overall connectivity.';

  @override
  String get noBootstrapDns => 'No bootstrap DNS servers added.';

  @override
  String get bootstrapDnsServersInfo =>
      'Bootstrap DNS servers are used to resolve IP addresses of the DoH/DoT resolvers you specify as upstreams.';

  @override
  String get privateReverseDnsServers => 'Private reverse DNS servers';

  @override
  String get privateReverseDnsServersDescription =>
      'The DNS servers that AdGuard Home uses for local PTR queries. These servers are used to resolve PTR requests for addresses in private IP ranges, for example \"192.168.12.34\", using reverse DNS. If not set, AdGuard Home uses the addresses of the default DNS resolvers of your OS except for the addresses of AdGuard Home itself.';

  @override
  String get reverseDnsDefault =>
      'By default, AdGuard Home uses the following reverse DNS resolvers';

  @override
  String get addItem => 'Add item';

  @override
  String get noServerAddressesAdded => 'No server addresses added.';

  @override
  String get usePrivateReverseDnsResolvers =>
      'Use private reverse DNS resolvers';

  @override
  String get usePrivateReverseDnsResolversDescription =>
      'Perform reverse DNS lookups for locally served addresses using these upstream servers. If disabled, AdGuard Home responds with NXDOMAIN to all such PTR requests except for clients known from DHCP, /etc/hosts, and so on.';

  @override
  String get enableReverseResolving =>
      'Enable reverse resolving of clients\' IP addresses';

  @override
  String get enableReverseResolvingDescription =>
      'Reversely resolve clients\' IP addresses into their hostnames by sending PTR queries to corresponding resolvers (private DNS servers for local clients, upstream servers for clients with public IP addresses).';

  @override
  String get dnsServerSettings => 'AdGuard Home DNS server settings';

  @override
  String get limitRequestsSecond => 'Rate limit per second';

  @override
  String get valueNotNumber => 'Value is not a number';

  @override
  String get enableEdns => 'Enable EDNS client subnet';

  @override
  String get enableEdnsDescription =>
      'Add the EDNS Client Subnet option (ECS) to upstream requests and log the values sent by the clients in the query log.';

  @override
  String get enableDnssec => 'Enable DNSSEC';

  @override
  String get enableDnssecDescription =>
      'Set DNSSEC flag in the outcoming DNS queries and check the result (DNSSEC-enabled resolver is required).';

  @override
  String get disableResolvingIpv6 => 'Disable resolving of IPv6 addresses';

  @override
  String get disableResolvingIpv6Description =>
      'Drop all DNS queries for IPv6 addresses (type AAAA).';

  @override
  String get blockingMode => 'Blocking mode';

  @override
  String get defaultMode => 'Default';

  @override
  String get defaultDescription =>
      'Respond with zero IP address (0.0.0.0 for A; :: for AAAA) when blocked by Adblock-style rule; respond with the IP address specified in the rule when blocked by /etc/hosts-style rule';

  @override
  String get refusedDescription => 'Respond with REFUSED code';

  @override
  String get nxdomainDescription => 'Respond with NXDOMAIN code';

  @override
  String get nullIp => 'Null IP';

  @override
  String get nullIpDescription =>
      'Respond with zero IP address (0.0.0.0 for A; :: for AAAA)';

  @override
  String get customIp => 'Custom IP';

  @override
  String get customIpDescription => 'Respond with a manually set IP address';

  @override
  String get dnsCacheConfig => 'DNS cache configuration';

  @override
  String get cacheSize => 'Cache size';

  @override
  String get inBytes => 'In bytes';

  @override
  String get overrideMinimumTtl => 'Override minimum TTL';

  @override
  String get overrideMinimumTtlDescription =>
      'Extend short time-to-live values (seconds) received from the upstream server when caching DNS responses.';

  @override
  String get overrideMaximumTtl => 'Override maximum TTL';

  @override
  String get overrideMaximumTtlDescription =>
      'Set a maximum time-to-live value (seconds) for entries in the DNS cache.';

  @override
  String get optimisticCaching => 'Optimistic caching';

  @override
  String get optimisticCachingDescription =>
      'Make AdGuard Home respond from the cache even when the entries are expired and also try to refresh them.';

  @override
  String get loadingDnsConfig => 'Loading DNS configuration...';

  @override
  String get dnsConfigNotLoaded => 'DNS config could not be loaded.';

  @override
  String get blockingIpv4 => 'Blocking IPv4';

  @override
  String get blockingIpv4Description =>
      'IP address to be returned for a blocked A request';

  @override
  String get blockingIpv6 => 'Blocking IPv6';

  @override
  String get blockingIpv6Description =>
      'IP address to be returned for a blocked AAAA request';

  @override
  String get invalidIp => 'Invalid IP address';

  @override
  String get dnsConfigSaved => 'DNS server configuration saved successfully';

  @override
  String get dnsConfigNotSaved =>
      'The DNS server configuration could not be saved';

  @override
  String get savingConfig => 'Saving configuration...';

  @override
  String get someValueNotValid => 'Some value is not valid';

  @override
  String get upstreamDnsDescription =>
      'Configure upstream servers and DNS mode';

  @override
  String get bootstrapDnsDescription => 'Configure the bootstrap DNS servers';

  @override
  String get privateReverseDnsDescription =>
      'Configure custom DNS resolvers and enable private reverse DNS resolving';

  @override
  String get dnsServerSettingsDescription =>
      'Configure a rate limit, the blocking mode and more';

  @override
  String get dnsCacheConfigDescription =>
      'Configure how the server should manage the DNS cache';

  @override
  String get comment => 'Comment';

  @override
  String get address => 'Address';

  @override
  String get commentsDescription =>
      'Comments are always preceded by #. You don\'t have to add it, it will be added automatically.';

  @override
  String get encryptionSettings => 'Encryption settings';

  @override
  String get encryptionSettingsDescription =>
      'Encryption (HTTPS/QUIC/TLS) support';

  @override
  String get loadingEncryptionSettings => 'Loading encryption settings...';

  @override
  String get encryptionSettingsNotLoaded =>
      'Encryption settings couldn\'t be loaded.';

  @override
  String get enableEncryption => 'Enable encryption';

  @override
  String get enableEncryptionTypes => 'HTTPS, DNS-over-HTTPS, and DNS-over-TLS';

  @override
  String get enableEncryptionDescription =>
      'If encryption is enabled, AdGuard Home admin interface will work over HTTPS, and the DNS server will listen for requests over DNS-over-HTTPS and DNS-over-TLS.';

  @override
  String get serverConfiguration => 'Server configuration';

  @override
  String get domainName => 'Domain name';

  @override
  String get domainNameDescription =>
      'If set, AdGuard Home detects ClientIDs, responds to DDR queries, and performs additional connection validations. If not set, these features are disabled. Must match one of the DNS Names in the certificate.';

  @override
  String get redirectHttps => 'Redirect to HTTPS automatically';

  @override
  String get httpsPort => 'HTTPS port';

  @override
  String get tlsPort => 'DNS-over-TLS port';

  @override
  String get dnsOverQuicPort => 'DNS-over-QUIC port';

  @override
  String get certificates => 'Certificates';

  @override
  String get certificatesDescription =>
      'In order to use encryption, you need to provide a valid SSL certificates chain for your domain. You can get a free certificate on letsencrypt.org or you can buy it from one of the trusted Certificate Authorities.';

  @override
  String get certificateFilePath => 'Set a certificates file path';

  @override
  String get pasteCertificateContent => 'Paste the certificates contents';

  @override
  String get certificatePath => 'Certificate path';

  @override
  String get certificateContent => 'Certificate content';

  @override
  String get privateKey => 'Private key';

  @override
  String get privateKeyFile => 'Set a private key file';

  @override
  String get pastePrivateKey => 'Paste the private key contents';

  @override
  String get usePreviousKey => 'Use the previously saved key';

  @override
  String get privateKeyPath => 'Private key path';

  @override
  String get invalidCertificate => 'Invalid certificate';

  @override
  String get invalidPrivateKey => 'Invalid private key';

  @override
  String get validatingData => 'Validating data';

  @override
  String get dataValid => 'Data is valid';

  @override
  String get dataNotValid => 'Data not valid';

  @override
  String get encryptionConfigSaved =>
      'Encryption configuration saved successfully';

  @override
  String get encryptionConfigNotSaved =>
      'Encryption configuration could not be saved';

  @override
  String get configError => 'Configuration error';

  @override
  String get enterOnlyCertificate =>
      'Enter only the certificate. Do not input the ---BEGIN--- and ---END--- lines.';

  @override
  String get enterOnlyPrivateKey =>
      'Enter only the key. Do not input the ---BEGIN--- and ---END--- lines.';

  @override
  String get noItemsSearch => 'No items for that search.';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get exitSearch => 'Exit search';

  @override
  String get searchClients => 'Search clients';

  @override
  String get noClientsSearch => 'No clients with that search.';

  @override
  String get customization => 'Customization';

  @override
  String get customizationDescription => 'Customize this application';

  @override
  String get color => 'Color';

  @override
  String get useDynamicTheme => 'Use dynamic theme';

  @override
  String get red => 'Red';

  @override
  String get green => 'Green';

  @override
  String get blue => 'Blue';

  @override
  String get yellow => 'Yellow';

  @override
  String get orange => 'Orange';

  @override
  String get brown => 'Brown';

  @override
  String get cyan => 'Cyan';

  @override
  String get purple => 'Purple';

  @override
  String get pink => 'Pink';

  @override
  String get deepOrange => 'Deep orange';

  @override
  String get indigo => 'Indigo';

  @override
  String get useThemeColorStatus => 'Use theme color for status';

  @override
  String get useThemeColorStatusDescription =>
      'Replaces green and red status colors with theme color and grey';

  @override
  String get invalidCertificateChain => 'Invalid certificate chain';

  @override
  String get validCertificateChain => 'Valid certificate chain';

  @override
  String get subject => 'Subject';

  @override
  String get issuer => 'Issuer';

  @override
  String get expires => 'Expires';

  @override
  String get validPrivateKey => 'Valid private key';

  @override
  String get expirationDate => 'Expiration date';

  @override
  String get keysNotMatch =>
      'Invalid certificate or key: tls: private key does not match public key';

  @override
  String get timeLogs => 'Time on logs';

  @override
  String get timeLogsDescription => 'Show processing time on logs list';

  @override
  String get hostNames => 'Host names';

  @override
  String get keyType => 'Key type';

  @override
  String get updateAvailable => 'Update available';

  @override
  String get installedVersion => 'Installed version';

  @override
  String get newVersion => 'New version';

  @override
  String get source => 'Source';

  @override
  String get downloadUpdate => 'Download update';

  @override
  String get download => 'Download';

  @override
  String get doNotRememberAgainUpdate =>
      'Do not remember again for this version';

  @override
  String get downloadingUpdate => 'Downloading';

  @override
  String get completed => 'completed';

  @override
  String get permissionNotGranted => 'Permission not granted';

  @override
  String get inputSearchTerm => 'Input a search term.';

  @override
  String get answers => 'Answers';

  @override
  String get copyClipboard => 'Copy to clipboard';

  @override
  String get domainCopiedClipboard => 'Domain copied to the clipboard';

  @override
  String get clearDnsCache => 'Clear DNS cache';

  @override
  String get clearDnsCacheMessage =>
      'Are you sure you want to clear the DNS cache?';

  @override
  String get dnsCacheCleared => 'DNS cache cleared successfully';

  @override
  String get clearingDnsCache => 'Clearing cache...';

  @override
  String get dnsCacheNotCleared => 'DNS cache couldn\'t be cleared';

  @override
  String get clientsSelected => 'clients selected';

  @override
  String get invalidDomain => 'Invalid domain';

  @override
  String get loadingBlockedServicesList => 'Loading blocked services list...';

  @override
  String get blockedServicesListNotLoaded =>
      'The blocked services list could not be loaded';

  @override
  String get error => 'Error';

  @override
  String get updates => 'Updates';

  @override
  String get updatesDescription => 'Update the AdGuard Home server';

  @override
  String get updateNow => 'Update now';

  @override
  String get currentVersion => 'Current version';

  @override
  String get requestStartUpdateFailed => 'Request to start update failed';

  @override
  String get requestStartUpdateSuccessful =>
      'Request to start update successfull';

  @override
  String get serverUpdated => 'Server is updated';

  @override
  String get unknownStatus => 'Unknown status';

  @override
  String get checkingUpdates => 'Checking updates...';

  @override
  String get checkUpdates => 'Check updates';

  @override
  String get requestingUpdate => 'Requesting update...';

  @override
  String get autoupdateUnavailable => 'Autoupdate unavailable';

  @override
  String get autoupdateUnavailableDescription =>
      'The autoupdate service is not available for this server. It could be because the server is running on a Docker container. You have to update your server manually.';

  @override
  String minute(Object time) {
    return '$time minute';
  }

  @override
  String minutes(Object time) {
    return '$time minutes';
  }

  @override
  String hour(Object time) {
    return '$time hour';
  }

  @override
  String hours(Object time) {
    return '$time hours';
  }

  @override
  String get remainingTime => 'Remaining time';

  @override
  String get safeSearchSettings => 'Safe search settings';

  @override
  String get loadingSafeSearchSettings => 'Loading safe search settings...';

  @override
  String get safeSearchSettingsNotLoaded =>
      'Error when loading safe search settings.';

  @override
  String get loadingLogsSettings => 'Loading logs settings...';

  @override
  String get selectOptionLeftColumn => 'Select an option of the left column';

  @override
  String get selectClientLeftColumn => 'Select a client of the left column';

  @override
  String get disableList => 'Disable list';

  @override
  String get enableList => 'Enable list';

  @override
  String get screens => 'Screens';

  @override
  String get copiedClipboard => 'Copied to clipboard';

  @override
  String get seeDetails => 'See details';

  @override
  String get listNotAvailable => 'List not available';

  @override
  String get copyListUrl => 'Copy list URL';

  @override
  String get listUrlCopied => 'List URL copied to the clipboard';

  @override
  String get unsupportedVersion => 'Unsupported version';

  @override
  String unsupprtedVersionMessage(Object version) {
    return 'The support for your server version $version is not guaranteed. This application may have some issues working with that server version.\n\nAdGuard Home Manager is designed to work with the stable releases of the AdGuard Home server. It may work with alpha and beta releases, but the compatibility is not guaranteed and the app may have some issues working with that versions.';
  }

  @override
  String get iUnderstand => 'I understand';

  @override
  String get appUpdates => 'Application updates';

  @override
  String get usingLatestVersion => 'You are using the latest version';

  @override
  String get ipLogs => 'IP on logs';

  @override
  String get ipLogsDescription =>
      'Show always IP address on logs instead of client name';

  @override
  String get application => 'Application';

  @override
  String get combinedChart => 'Combined chart';

  @override
  String get combinedChartDescription => 'Combine all charts into one';

  @override
  String get statistics => 'Statistics';

  @override
  String get errorLoadFilters => 'Error when loading filters.';

  @override
  String get clientRemovedSuccessfully => 'Client removed successfully.';

  @override
  String get editRewriteRule => 'Edit rewrite rule';

  @override
  String get dnsRewriteRuleUpdated => 'DNS rewrite rule updated successfully';

  @override
  String get dnsRewriteRuleNotUpdated =>
      'DNS rewrite rule could not be updated';

  @override
  String get updatingRule => 'Updating rule...';

  @override
  String get serverUpdateNeeded => 'Server update needed';

  @override
  String updateYourServer(Object version) {
    return 'Update your AdGuard Home server to $version or greater to use this feature.';
  }

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get malwarePhishing => 'Malware/phishing';

  @override
  String get queries => 'Queries';

  @override
  String get adultSites => 'Adult sites';

  @override
  String get quickFilters => 'Quick filters';

  @override
  String get searchDomainInternet => 'Search domain on the Internet';

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

  @override
  String get dnsRewriteRuleEnabled => 'DNS rewrite rule enabled successfully';

  @override
  String get dnsRewriteRuleDisabled => 'DNS rewrite rule disabled successfully';
}
