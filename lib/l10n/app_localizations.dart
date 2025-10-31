import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pl'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
    Locale('zh', 'CN')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @servers.
  ///
  /// In en, this message translates to:
  /// **'Servers'**
  String get servers;

  /// No description provided for @createConnection.
  ///
  /// In en, this message translates to:
  /// **'Create connection'**
  String get createConnection;

  /// No description provided for @editConnection.
  ///
  /// In en, this message translates to:
  /// **'Edit connection'**
  String get editConnection;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @ipDomain.
  ///
  /// In en, this message translates to:
  /// **'IP address or domain'**
  String get ipDomain;

  /// No description provided for @path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get path;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @defaultServer.
  ///
  /// In en, this message translates to:
  /// **'Default server'**
  String get defaultServer;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authentication;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @invalidPort.
  ///
  /// In en, this message translates to:
  /// **'Invalid port'**
  String get invalidPort;

  /// No description provided for @invalidPath.
  ///
  /// In en, this message translates to:
  /// **'Invalid path'**
  String get invalidPath;

  /// No description provided for @invalidIpDomain.
  ///
  /// In en, this message translates to:
  /// **'Invalid IP or domain'**
  String get invalidIpDomain;

  /// No description provided for @ipDomainNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'IP or domain cannot be empty'**
  String get ipDomainNotEmpty;

  /// No description provided for @nameNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameNotEmpty;

  /// No description provided for @invalidUsernamePassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get invalidUsernamePassword;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get tooManyAttempts;

  /// No description provided for @cantReachServer.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach server. Check connection data.'**
  String get cantReachServer;

  /// No description provided for @sslError.
  ///
  /// In en, this message translates to:
  /// **'Handshake exception. Cannot establish a secure connection with the server. This can be a SSL error. Go to Settings > Advanced settings and enable Override SSL validation.'**
  String get sslError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @connectionNotCreated.
  ///
  /// In en, this message translates to:
  /// **'Connection couldn\'t be created'**
  String get connectionNotCreated;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @selectedDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Selected but disconnected'**
  String get selectedDisconnected;

  /// No description provided for @connectionDefaultSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Connection set as default successfully.'**
  String get connectionDefaultSuccessfully;

  /// No description provided for @connectionDefaultFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection could not be set as default.'**
  String get connectionDefaultFailed;

  /// No description provided for @noSavedConnections.
  ///
  /// In en, this message translates to:
  /// **'No saved connections'**
  String get noSavedConnections;

  /// No description provided for @cannotConnect.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect to the server'**
  String get cannotConnect;

  /// No description provided for @connectionRemoved.
  ///
  /// In en, this message translates to:
  /// **'Connection removed successfully'**
  String get connectionRemoved;

  /// No description provided for @connectionCannotBeRemoved.
  ///
  /// In en, this message translates to:
  /// **'Connection cannot be removed.'**
  String get connectionCannotBeRemoved;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove the connection with this AdGuard Home server?'**
  String get removeWarning;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @defaultConnection.
  ///
  /// In en, this message translates to:
  /// **'Default connection'**
  String get defaultConnection;

  /// No description provided for @setDefault.
  ///
  /// In en, this message translates to:
  /// **'Set default'**
  String get setDefault;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @serverStatus.
  ///
  /// In en, this message translates to:
  /// **'Server status'**
  String get serverStatus;

  /// No description provided for @connectionNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Connection not updated'**
  String get connectionNotUpdated;

  /// No description provided for @ruleFilteringWidget.
  ///
  /// In en, this message translates to:
  /// **'Rule filtering'**
  String get ruleFilteringWidget;

  /// No description provided for @safeBrowsingWidget.
  ///
  /// In en, this message translates to:
  /// **'Safe browsing'**
  String get safeBrowsingWidget;

  /// No description provided for @parentalFilteringWidget.
  ///
  /// In en, this message translates to:
  /// **'Parental filtering'**
  String get parentalFilteringWidget;

  /// No description provided for @safeSearchWidget.
  ///
  /// In en, this message translates to:
  /// **'Safe search'**
  String get safeSearchWidget;

  /// No description provided for @ruleFiltering.
  ///
  /// In en, this message translates to:
  /// **'Rule filtering'**
  String get ruleFiltering;

  /// No description provided for @safeBrowsing.
  ///
  /// In en, this message translates to:
  /// **'Safe browsing'**
  String get safeBrowsing;

  /// No description provided for @parentalFiltering.
  ///
  /// In en, this message translates to:
  /// **'Parental filtering'**
  String get parentalFiltering;

  /// No description provided for @safeSearch.
  ///
  /// In en, this message translates to:
  /// **'Safe search'**
  String get safeSearch;

  /// No description provided for @serverStatusNotRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Server status could not be refreshed'**
  String get serverStatusNotRefreshed;

  /// No description provided for @loadingStatus.
  ///
  /// In en, this message translates to:
  /// **'Loading status...'**
  String get loadingStatus;

  /// No description provided for @errorLoadServerStatus.
  ///
  /// In en, this message translates to:
  /// **'Server status could not be loaded'**
  String get errorLoadServerStatus;

  /// No description provided for @topQueriedDomains.
  ///
  /// In en, this message translates to:
  /// **'Queried domains'**
  String get topQueriedDomains;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get viewMore;

  /// No description provided for @topClients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get topClients;

  /// No description provided for @topBlockedDomains.
  ///
  /// In en, this message translates to:
  /// **'Blocked domains'**
  String get topBlockedDomains;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get appSettings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @systemDefined.
  ///
  /// In en, this message translates to:
  /// **'System defined'**
  String get systemDefined;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @connectedTo.
  ///
  /// In en, this message translates to:
  /// **'Connected to:'**
  String get connectedTo;

  /// No description provided for @selectedServer.
  ///
  /// In en, this message translates to:
  /// **'Selected server:'**
  String get selectedServer;

  /// No description provided for @noServerSelected.
  ///
  /// In en, this message translates to:
  /// **'No server selected'**
  String get noServerSelected;

  /// No description provided for @manageServer.
  ///
  /// In en, this message translates to:
  /// **'Manage server'**
  String get manageServer;

  /// No description provided for @allProtections.
  ///
  /// In en, this message translates to:
  /// **'All protections'**
  String get allProtections;

  /// No description provided for @userNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Username cannot be empty'**
  String get userNotEmpty;

  /// No description provided for @passwordNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordNotEmpty;

  /// No description provided for @examplePath.
  ///
  /// In en, this message translates to:
  /// **'Example: /adguard'**
  String get examplePath;

  /// No description provided for @helperPath.
  ///
  /// In en, this message translates to:
  /// **'If you are using a reverse proxy'**
  String get helperPath;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About the application'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App version'**
  String get appVersion;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get createdBy;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @allowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get allowed;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @noClientsList.
  ///
  /// In en, this message translates to:
  /// **'There are no clients on this list'**
  String get noClientsList;

  /// No description provided for @activeClients.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeClients;

  /// No description provided for @removeClient.
  ///
  /// In en, this message translates to:
  /// **'Remove client'**
  String get removeClient;

  /// No description provided for @removeClientMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this client from the list?'**
  String get removeClientMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @removingClient.
  ///
  /// In en, this message translates to:
  /// **'Removing client...'**
  String get removingClient;

  /// No description provided for @clientNotRemoved.
  ///
  /// In en, this message translates to:
  /// **'Client could not be removed from the list'**
  String get clientNotRemoved;

  /// No description provided for @addClient.
  ///
  /// In en, this message translates to:
  /// **'Add client'**
  String get addClient;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @ipAddress.
  ///
  /// In en, this message translates to:
  /// **'IP address'**
  String get ipAddress;

  /// No description provided for @ipNotValid.
  ///
  /// In en, this message translates to:
  /// **'IP address not valid'**
  String get ipNotValid;

  /// No description provided for @clientAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client added to the list successfully'**
  String get clientAddedSuccessfully;

  /// No description provided for @addingClient.
  ///
  /// In en, this message translates to:
  /// **'Adding client...'**
  String get addingClient;

  /// No description provided for @clientNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Client could not be added to the list'**
  String get clientNotAdded;

  /// No description provided for @clientAnotherList.
  ///
  /// In en, this message translates to:
  /// **'This client is yet in another list'**
  String get clientAnotherList;

  /// No description provided for @noSavedLogs.
  ///
  /// In en, this message translates to:
  /// **'No saved logs'**
  String get noSavedLogs;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @copyLogsClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy logs to clipboard'**
  String get copyLogsClipboard;

  /// No description provided for @logsCopiedClipboard.
  ///
  /// In en, this message translates to:
  /// **'Logs copied to clipboard'**
  String get logsCopiedClipboard;

  /// No description provided for @advancedSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get advancedSettings;

  /// No description provided for @dontCheckCertificate.
  ///
  /// In en, this message translates to:
  /// **'Don\'t check SSL certificate'**
  String get dontCheckCertificate;

  /// No description provided for @dontCheckCertificateDescription.
  ///
  /// In en, this message translates to:
  /// **'Overrides the server\'s SSL certificate validation'**
  String get dontCheckCertificateDescription;

  /// No description provided for @advancedSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Advanced options'**
  String get advancedSetupDescription;

  /// No description provided for @settingsUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Settings updated successfully.'**
  String get settingsUpdatedSuccessfully;

  /// No description provided for @cannotUpdateSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings cannot be updated.'**
  String get cannotUpdateSettings;

  /// No description provided for @restartAppTakeEffect.
  ///
  /// In en, this message translates to:
  /// **'Restart the application'**
  String get restartAppTakeEffect;

  /// No description provided for @loadingLogs.
  ///
  /// In en, this message translates to:
  /// **'Loading logs...'**
  String get loadingLogs;

  /// No description provided for @logsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Logs list could not be loaded'**
  String get logsNotLoaded;

  /// No description provided for @processed.
  ///
  /// In en, this message translates to:
  /// **'Processed\nNo list'**
  String get processed;

  /// No description provided for @processedRow.
  ///
  /// In en, this message translates to:
  /// **'Processed (no list)'**
  String get processedRow;

  /// No description provided for @blockedBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nBlacklist'**
  String get blockedBlacklist;

  /// No description provided for @blockedBlacklistRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (blacklist)'**
  String get blockedBlacklistRow;

  /// No description provided for @blockedSafeBrowsing.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nSafe browsing'**
  String get blockedSafeBrowsing;

  /// No description provided for @blockedSafeBrowsingRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (safe browsing)'**
  String get blockedSafeBrowsingRow;

  /// No description provided for @blockedParental.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nParental filtering'**
  String get blockedParental;

  /// No description provided for @blockedParentalRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (parental filtering)'**
  String get blockedParentalRow;

  /// No description provided for @blockedInvalid.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nInvalid'**
  String get blockedInvalid;

  /// No description provided for @blockedInvalidRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (invalid)'**
  String get blockedInvalidRow;

  /// No description provided for @blockedSafeSearch.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nSafe search'**
  String get blockedSafeSearch;

  /// No description provided for @blockedSafeSearchRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (safe search)'**
  String get blockedSafeSearchRow;

  /// No description provided for @blockedService.
  ///
  /// In en, this message translates to:
  /// **'Blocked\nBlocked service'**
  String get blockedService;

  /// No description provided for @blockedServiceRow.
  ///
  /// In en, this message translates to:
  /// **'Blocked (blocked service)'**
  String get blockedServiceRow;

  /// No description provided for @processedWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Processed\nWhitelist'**
  String get processedWhitelist;

  /// No description provided for @processedWhitelistRow.
  ///
  /// In en, this message translates to:
  /// **'Processed (whitelist)'**
  String get processedWhitelistRow;

  /// No description provided for @processedError.
  ///
  /// In en, this message translates to:
  /// **'Processed\nError'**
  String get processedError;

  /// No description provided for @processedErrorRow.
  ///
  /// In en, this message translates to:
  /// **'Processed (error)'**
  String get processedErrorRow;

  /// No description provided for @rewrite.
  ///
  /// In en, this message translates to:
  /// **'Rewrite'**
  String get rewrite;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @blocklist.
  ///
  /// In en, this message translates to:
  /// **'Blocklist'**
  String get blocklist;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @domain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domain;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @clas.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get clas;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @dnsServer.
  ///
  /// In en, this message translates to:
  /// **'DNS server'**
  String get dnsServer;

  /// No description provided for @elapsedTime.
  ///
  /// In en, this message translates to:
  /// **'Elapsed time'**
  String get elapsedTime;

  /// No description provided for @responseCode.
  ///
  /// In en, this message translates to:
  /// **'Response code'**
  String get responseCode;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @deviceIp.
  ///
  /// In en, this message translates to:
  /// **'IP address'**
  String get deviceIp;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get deviceName;

  /// No description provided for @logDetails.
  ///
  /// In en, this message translates to:
  /// **'Log details'**
  String get logDetails;

  /// No description provided for @blockingRule.
  ///
  /// In en, this message translates to:
  /// **'Blocking rule'**
  String get blockingRule;

  /// No description provided for @blockDomain.
  ///
  /// In en, this message translates to:
  /// **'Block domain'**
  String get blockDomain;

  /// No description provided for @couldntGetFilteringStatus.
  ///
  /// In en, this message translates to:
  /// **'Could not get filtering status'**
  String get couldntGetFilteringStatus;

  /// No description provided for @unblockDomain.
  ///
  /// In en, this message translates to:
  /// **'Unblock domain'**
  String get unblockDomain;

  /// No description provided for @userFilteringRulesNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'User filtering rules could not be updated'**
  String get userFilteringRulesNotUpdated;

  /// No description provided for @userFilteringRulesUpdated.
  ///
  /// In en, this message translates to:
  /// **'User filtering rules updated successfully'**
  String get userFilteringRulesUpdated;

  /// No description provided for @savingUserFilters.
  ///
  /// In en, this message translates to:
  /// **'Saving user filters...'**
  String get savingUserFilters;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @logsOlderThan.
  ///
  /// In en, this message translates to:
  /// **'Logs older than'**
  String get logsOlderThan;

  /// No description provided for @responseStatus.
  ///
  /// In en, this message translates to:
  /// **'Response status'**
  String get responseStatus;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get selectTime;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @resetFilters.
  ///
  /// In en, this message translates to:
  /// **'Reset filters'**
  String get resetFilters;

  /// No description provided for @noLogsDisplay.
  ///
  /// In en, this message translates to:
  /// **'No logs to display'**
  String get noLogsDisplay;

  /// No description provided for @noLogsThatOld.
  ///
  /// In en, this message translates to:
  /// **'It\'s possible that there are no logs saved for that selected time. Try selecting a more recent time.'**
  String get noLogsThatOld;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @unselectAll.
  ///
  /// In en, this message translates to:
  /// **'Unselect all'**
  String get unselectAll;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @filtered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get filtered;

  /// No description provided for @checkAppLogs.
  ///
  /// In en, this message translates to:
  /// **'Check app logs'**
  String get checkAppLogs;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @dnsQueries.
  ///
  /// In en, this message translates to:
  /// **'DNS queries'**
  String get dnsQueries;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @blockedFilters.
  ///
  /// In en, this message translates to:
  /// **'Blocked by filters'**
  String get blockedFilters;

  /// No description provided for @malwarePhishingBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked malware/phishing'**
  String get malwarePhishingBlocked;

  /// No description provided for @blockedAdultWebsites.
  ///
  /// In en, this message translates to:
  /// **'Blocked adult websites'**
  String get blockedAdultWebsites;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General settings'**
  String get generalSettings;

  /// No description provided for @generalSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Various different settings'**
  String get generalSettingsDescription;

  /// No description provided for @hideZeroValues.
  ///
  /// In en, this message translates to:
  /// **'Hide zero values'**
  String get hideZeroValues;

  /// No description provided for @hideZeroValuesDescription.
  ///
  /// In en, this message translates to:
  /// **'On homescreen, hide blocks with zero value'**
  String get hideZeroValuesDescription;

  /// No description provided for @webAdminPanel.
  ///
  /// In en, this message translates to:
  /// **'Web admin. panel'**
  String get webAdminPanel;

  /// No description provided for @visitGooglePlay.
  ///
  /// In en, this message translates to:
  /// **'Visit Google Play page'**
  String get visitGooglePlay;

  /// No description provided for @gitHub.
  ///
  /// In en, this message translates to:
  /// **'App code available on GitHub'**
  String get gitHub;

  /// No description provided for @blockClient.
  ///
  /// In en, this message translates to:
  /// **'Block client'**
  String get blockClient;

  /// No description provided for @selectTags.
  ///
  /// In en, this message translates to:
  /// **'Select tags'**
  String get selectTags;

  /// No description provided for @noTagsSelected.
  ///
  /// In en, this message translates to:
  /// **'No tags selected'**
  String get noTagsSelected;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @identifiers.
  ///
  /// In en, this message translates to:
  /// **'Identifiers'**
  String get identifiers;

  /// No description provided for @identifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get identifier;

  /// No description provided for @identifierHelper.
  ///
  /// In en, this message translates to:
  /// **'IP address, CIDR, MAC address, or ClientID'**
  String get identifierHelper;

  /// No description provided for @noIdentifiers.
  ///
  /// In en, this message translates to:
  /// **'No identifiers added'**
  String get noIdentifiers;

  /// No description provided for @useGlobalSettings.
  ///
  /// In en, this message translates to:
  /// **'Use global settings'**
  String get useGlobalSettings;

  /// No description provided for @enableFiltering.
  ///
  /// In en, this message translates to:
  /// **'Enable filtering'**
  String get enableFiltering;

  /// No description provided for @enableSafeBrowsing.
  ///
  /// In en, this message translates to:
  /// **'Enable safe browsing'**
  String get enableSafeBrowsing;

  /// No description provided for @enableParentalControl.
  ///
  /// In en, this message translates to:
  /// **'Enable parental control'**
  String get enableParentalControl;

  /// No description provided for @enableSafeSearch.
  ///
  /// In en, this message translates to:
  /// **'Enable safe search'**
  String get enableSafeSearch;

  /// No description provided for @blockedServices.
  ///
  /// In en, this message translates to:
  /// **'Blocked services'**
  String get blockedServices;

  /// No description provided for @selectBlockedServices.
  ///
  /// In en, this message translates to:
  /// **'Select services to block'**
  String get selectBlockedServices;

  /// No description provided for @noBlockedServicesSelected.
  ///
  /// In en, this message translates to:
  /// **'No blocked services'**
  String get noBlockedServicesSelected;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @servicesBlocked.
  ///
  /// In en, this message translates to:
  /// **'services blocked'**
  String get servicesBlocked;

  /// No description provided for @tagsSelected.
  ///
  /// In en, this message translates to:
  /// **'tags selected'**
  String get tagsSelected;

  /// No description provided for @upstreamServers.
  ///
  /// In en, this message translates to:
  /// **'Upstream servers'**
  String get upstreamServers;

  /// No description provided for @serverAddress.
  ///
  /// In en, this message translates to:
  /// **'Server address'**
  String get serverAddress;

  /// No description provided for @noUpstreamServers.
  ///
  /// In en, this message translates to:
  /// **'No upstream servers.'**
  String get noUpstreamServers;

  /// No description provided for @willBeUsedGeneralServers.
  ///
  /// In en, this message translates to:
  /// **'General upstream servers will be used.'**
  String get willBeUsedGeneralServers;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @clientUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client updated successfully'**
  String get clientUpdatedSuccessfully;

  /// No description provided for @clientNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Client could not be updated'**
  String get clientNotUpdated;

  /// No description provided for @clientDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client removed successfully'**
  String get clientDeletedSuccessfully;

  /// No description provided for @clientNotDeleted.
  ///
  /// In en, this message translates to:
  /// **'Client could not be deleted'**
  String get clientNotDeleted;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @loadingFilters.
  ///
  /// In en, this message translates to:
  /// **'Loading filters...'**
  String get loadingFilters;

  /// No description provided for @filtersNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Filters couldn\'t be loaded.'**
  String get filtersNotLoaded;

  /// No description provided for @whitelists.
  ///
  /// In en, this message translates to:
  /// **'Whitelists'**
  String get whitelists;

  /// No description provided for @blacklists.
  ///
  /// In en, this message translates to:
  /// **'Blacklists'**
  String get blacklists;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @customRules.
  ///
  /// In en, this message translates to:
  /// **'Custom rules'**
  String get customRules;

  /// No description provided for @enabledRules.
  ///
  /// In en, this message translates to:
  /// **'Enabled rules'**
  String get enabledRules;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @rule.
  ///
  /// In en, this message translates to:
  /// **'Rule'**
  String get rule;

  /// No description provided for @addCustomRule.
  ///
  /// In en, this message translates to:
  /// **'Add custom rule'**
  String get addCustomRule;

  /// No description provided for @removeCustomRule.
  ///
  /// In en, this message translates to:
  /// **'Remove custom rule'**
  String get removeCustomRule;

  /// No description provided for @removeCustomRuleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this custom rule?'**
  String get removeCustomRuleMessage;

  /// No description provided for @updatingRules.
  ///
  /// In en, this message translates to:
  /// **'Updating custom rules...'**
  String get updatingRules;

  /// No description provided for @ruleRemovedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule removed successfully'**
  String get ruleRemovedSuccessfully;

  /// No description provided for @ruleNotRemoved.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t remove the rule'**
  String get ruleNotRemoved;

  /// No description provided for @ruleAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule added successfully'**
  String get ruleAddedSuccessfully;

  /// No description provided for @ruleNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t add the rule'**
  String get ruleNotAdded;

  /// No description provided for @noCustomFilters.
  ///
  /// In en, this message translates to:
  /// **'No custom filters'**
  String get noCustomFilters;

  /// No description provided for @noBlockedClients.
  ///
  /// In en, this message translates to:
  /// **'No blocked clients'**
  String get noBlockedClients;

  /// No description provided for @noBlackLists.
  ///
  /// In en, this message translates to:
  /// **'No blacklists'**
  String get noBlackLists;

  /// No description provided for @noWhiteLists.
  ///
  /// In en, this message translates to:
  /// **'No whitelists'**
  String get noWhiteLists;

  /// No description provided for @addWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Add whitelist'**
  String get addWhitelist;

  /// No description provided for @addBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Add blacklist'**
  String get addBlacklist;

  /// No description provided for @urlNotValid.
  ///
  /// In en, this message translates to:
  /// **'URL is not valid'**
  String get urlNotValid;

  /// No description provided for @urlAbsolutePath.
  ///
  /// In en, this message translates to:
  /// **'URL or absolute path'**
  String get urlAbsolutePath;

  /// No description provided for @addingList.
  ///
  /// In en, this message translates to:
  /// **'Adding list...'**
  String get addingList;

  /// No description provided for @listAdded.
  ///
  /// In en, this message translates to:
  /// **'List added successfully. Items added:'**
  String get listAdded;

  /// No description provided for @listAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'List already added'**
  String get listAlreadyAdded;

  /// No description provided for @listUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'List URL invalid'**
  String get listUrlInvalid;

  /// No description provided for @listNotAdded.
  ///
  /// In en, this message translates to:
  /// **'List couldn\'t be added'**
  String get listNotAdded;

  /// No description provided for @listDetails.
  ///
  /// In en, this message translates to:
  /// **'List details'**
  String get listDetails;

  /// No description provided for @listType.
  ///
  /// In en, this message translates to:
  /// **'List type'**
  String get listType;

  /// No description provided for @whitelist.
  ///
  /// In en, this message translates to:
  /// **'White list'**
  String get whitelist;

  /// No description provided for @blacklist.
  ///
  /// In en, this message translates to:
  /// **'Black list'**
  String get blacklist;

  /// No description provided for @latestUpdate.
  ///
  /// In en, this message translates to:
  /// **'Latest update'**
  String get latestUpdate;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @currentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current status'**
  String get currentStatus;

  /// No description provided for @listDataUpdated.
  ///
  /// In en, this message translates to:
  /// **'List data updated successfull'**
  String get listDataUpdated;

  /// No description provided for @listDataNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update list data'**
  String get listDataNotUpdated;

  /// No description provided for @updatingListData.
  ///
  /// In en, this message translates to:
  /// **'Updating list data...'**
  String get updatingListData;

  /// No description provided for @editWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Edit white list'**
  String get editWhitelist;

  /// No description provided for @editBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Edit black list'**
  String get editBlacklist;

  /// No description provided for @deletingList.
  ///
  /// In en, this message translates to:
  /// **'Deleting list...'**
  String get deletingList;

  /// No description provided for @listDeleted.
  ///
  /// In en, this message translates to:
  /// **'List deleted successfully'**
  String get listDeleted;

  /// No description provided for @listNotDeleted.
  ///
  /// In en, this message translates to:
  /// **'The list couldn\'t be deleted'**
  String get listNotDeleted;

  /// No description provided for @deleteList.
  ///
  /// In en, this message translates to:
  /// **'Delete list'**
  String get deleteList;

  /// No description provided for @deleteListMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this list? This action can\'t be reverted.'**
  String get deleteListMessage;

  /// No description provided for @serverSettings.
  ///
  /// In en, this message translates to:
  /// **'Server settings'**
  String get serverSettings;

  /// No description provided for @serverInformation.
  ///
  /// In en, this message translates to:
  /// **'Server information'**
  String get serverInformation;

  /// No description provided for @serverInformationDescription.
  ///
  /// In en, this message translates to:
  /// **'Server information and status'**
  String get serverInformationDescription;

  /// No description provided for @loadingServerInfo.
  ///
  /// In en, this message translates to:
  /// **'Loading server information...'**
  String get loadingServerInfo;

  /// No description provided for @serverInfoNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Server information couldn\'t be loaded.'**
  String get serverInfoNotLoaded;

  /// No description provided for @dnsAddresses.
  ///
  /// In en, this message translates to:
  /// **'DNS addresses'**
  String get dnsAddresses;

  /// No description provided for @seeDnsAddresses.
  ///
  /// In en, this message translates to:
  /// **'See DNS addresses'**
  String get seeDnsAddresses;

  /// No description provided for @dnsPort.
  ///
  /// In en, this message translates to:
  /// **'DNS port'**
  String get dnsPort;

  /// No description provided for @httpPort.
  ///
  /// In en, this message translates to:
  /// **'HTTP port'**
  String get httpPort;

  /// No description provided for @protectionEnabled.
  ///
  /// In en, this message translates to:
  /// **'Protection enabled'**
  String get protectionEnabled;

  /// No description provided for @dhcpAvailable.
  ///
  /// In en, this message translates to:
  /// **'DHCP available'**
  String get dhcpAvailable;

  /// No description provided for @serverRunning.
  ///
  /// In en, this message translates to:
  /// **'Server running'**
  String get serverRunning;

  /// No description provided for @serverVersion.
  ///
  /// In en, this message translates to:
  /// **'Server version'**
  String get serverVersion;

  /// No description provided for @serverLanguage.
  ///
  /// In en, this message translates to:
  /// **'Server language'**
  String get serverLanguage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @allowedClients.
  ///
  /// In en, this message translates to:
  /// **'Allowed clients'**
  String get allowedClients;

  /// No description provided for @disallowedClients.
  ///
  /// In en, this message translates to:
  /// **'Disallowed clients'**
  String get disallowedClients;

  /// No description provided for @disallowedDomains.
  ///
  /// In en, this message translates to:
  /// **'Disallowed domains'**
  String get disallowedDomains;

  /// No description provided for @accessSettings.
  ///
  /// In en, this message translates to:
  /// **'Access settings'**
  String get accessSettings;

  /// No description provided for @accessSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure access rules for the server'**
  String get accessSettingsDescription;

  /// No description provided for @loadingClients.
  ///
  /// In en, this message translates to:
  /// **'Loading clients...'**
  String get loadingClients;

  /// No description provided for @clientsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Clients couldn\'t be loaded.'**
  String get clientsNotLoaded;

  /// No description provided for @noAllowedClients.
  ///
  /// In en, this message translates to:
  /// **'No allowed clients'**
  String get noAllowedClients;

  /// No description provided for @allowedClientsDescription.
  ///
  /// In en, this message translates to:
  /// **'If this list has entries, AdGuard Home will accept requests only from these clients.'**
  String get allowedClientsDescription;

  /// No description provided for @blockedClientsDescription.
  ///
  /// In en, this message translates to:
  /// **'If this list has entries, AdGuard Home will drop requests from these clients. This field is ignored if there are entries in Allowed clients.'**
  String get blockedClientsDescription;

  /// No description provided for @disallowedDomainsDescription.
  ///
  /// In en, this message translates to:
  /// **'AdGuard Home drops DNS queries matching these domains, and these queries don\'t even appear in the query log.'**
  String get disallowedDomainsDescription;

  /// No description provided for @addClientFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'CIDRs, IP address, or ClientID'**
  String get addClientFieldDescription;

  /// No description provided for @clientIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Client identifier'**
  String get clientIdentifier;

  /// No description provided for @allowClient.
  ///
  /// In en, this message translates to:
  /// **'Allow client'**
  String get allowClient;

  /// No description provided for @disallowClient.
  ///
  /// In en, this message translates to:
  /// **'Disallow client'**
  String get disallowClient;

  /// No description provided for @noDisallowedDomains.
  ///
  /// In en, this message translates to:
  /// **'No disallowed domains'**
  String get noDisallowedDomains;

  /// No description provided for @domainNotAdded.
  ///
  /// In en, this message translates to:
  /// **'The domain couldn\'t be added'**
  String get domainNotAdded;

  /// No description provided for @statusSelected.
  ///
  /// In en, this message translates to:
  /// **'status selected'**
  String get statusSelected;

  /// No description provided for @updateLists.
  ///
  /// In en, this message translates to:
  /// **'Update lists'**
  String get updateLists;

  /// No description provided for @checkHostFiltered.
  ///
  /// In en, this message translates to:
  /// **'Check host'**
  String get checkHostFiltered;

  /// No description provided for @updatingLists.
  ///
  /// In en, this message translates to:
  /// **'Updating lists...'**
  String get updatingLists;

  /// No description provided for @listsUpdated.
  ///
  /// In en, this message translates to:
  /// **'lists updated'**
  String get listsUpdated;

  /// No description provided for @listsNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update lists'**
  String get listsNotUpdated;

  /// No description provided for @listsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Lists couldn\'t be loaded'**
  String get listsNotLoaded;

  /// No description provided for @domainNotValid.
  ///
  /// In en, this message translates to:
  /// **'Domain not valid'**
  String get domainNotValid;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @checkingHost.
  ///
  /// In en, this message translates to:
  /// **'Checking host...'**
  String get checkingHost;

  /// No description provided for @errorCheckingHost.
  ///
  /// In en, this message translates to:
  /// **'Host couldn\'t be checked'**
  String get errorCheckingHost;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @addImportant.
  ///
  /// In en, this message translates to:
  /// **'Add \$important'**
  String get addImportant;

  /// No description provided for @howCreateRules.
  ///
  /// In en, this message translates to:
  /// **'How to create custom rules'**
  String get howCreateRules;

  /// No description provided for @examples.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get examples;

  /// No description provided for @example1.
  ///
  /// In en, this message translates to:
  /// **'Block access to example.org and all its subdomains.'**
  String get example1;

  /// No description provided for @example2.
  ///
  /// In en, this message translates to:
  /// **'Unblocks access to example.org and all its subdomains.'**
  String get example2;

  /// No description provided for @example3.
  ///
  /// In en, this message translates to:
  /// **'Adds a comment.'**
  String get example3;

  /// No description provided for @example4.
  ///
  /// In en, this message translates to:
  /// **'Block access to domains matching the specified regular expression.'**
  String get example4;

  /// No description provided for @moreInformation.
  ///
  /// In en, this message translates to:
  /// **'More information'**
  String get moreInformation;

  /// No description provided for @addingRule.
  ///
  /// In en, this message translates to:
  /// **'Adding rule...'**
  String get addingRule;

  /// No description provided for @deletingRule.
  ///
  /// In en, this message translates to:
  /// **'Deleting rule...'**
  String get deletingRule;

  /// No description provided for @enablingList.
  ///
  /// In en, this message translates to:
  /// **'Enabling list...'**
  String get enablingList;

  /// No description provided for @disablingList.
  ///
  /// In en, this message translates to:
  /// **'Disabling list...'**
  String get disablingList;

  /// No description provided for @savingList.
  ///
  /// In en, this message translates to:
  /// **'Saving list...'**
  String get savingList;

  /// No description provided for @disableFiltering.
  ///
  /// In en, this message translates to:
  /// **'Disable filtering'**
  String get disableFiltering;

  /// No description provided for @enablingFiltering.
  ///
  /// In en, this message translates to:
  /// **'Enabling filtering...'**
  String get enablingFiltering;

  /// No description provided for @disablingFiltering.
  ///
  /// In en, this message translates to:
  /// **'Disabling filtering...'**
  String get disablingFiltering;

  /// No description provided for @filteringStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Filtering status updated successfully'**
  String get filteringStatusUpdated;

  /// No description provided for @filteringStatusNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Filtering status couldn\'t be updated'**
  String get filteringStatusNotUpdated;

  /// No description provided for @updateFrequency.
  ///
  /// In en, this message translates to:
  /// **'Update frequency'**
  String get updateFrequency;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @hour1.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get hour1;

  /// No description provided for @hours12.
  ///
  /// In en, this message translates to:
  /// **'12 hours'**
  String get hours12;

  /// No description provided for @hours24.
  ///
  /// In en, this message translates to:
  /// **'24 hours'**
  String get hours24;

  /// No description provided for @days3.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get days3;

  /// No description provided for @days7.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get days7;

  /// No description provided for @changingUpdateFrequency.
  ///
  /// In en, this message translates to:
  /// **'Changing...'**
  String get changingUpdateFrequency;

  /// No description provided for @updateFrequencyChanged.
  ///
  /// In en, this message translates to:
  /// **'Update frequency changed successfully'**
  String get updateFrequencyChanged;

  /// No description provided for @updateFrequencyNotChanged.
  ///
  /// In en, this message translates to:
  /// **'Updare frecuency couldn\'t be changed'**
  String get updateFrequencyNotChanged;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating values...'**
  String get updating;

  /// No description provided for @blockedServicesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Blocked services updated successfully'**
  String get blockedServicesUpdated;

  /// No description provided for @blockedServicesNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Blocked services couldn\'t be updated'**
  String get blockedServicesNotUpdated;

  /// No description provided for @insertDomain.
  ///
  /// In en, this message translates to:
  /// **'Insert a domain to check it\'s stauts.'**
  String get insertDomain;

  /// No description provided for @dhcpSettings.
  ///
  /// In en, this message translates to:
  /// **'DHCP settings'**
  String get dhcpSettings;

  /// No description provided for @dhcpSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure the DHCP server'**
  String get dhcpSettingsDescription;

  /// No description provided for @dhcpSettingsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'DHCP settings could not be loaded'**
  String get dhcpSettingsNotLoaded;

  /// No description provided for @loadingDhcp.
  ///
  /// In en, this message translates to:
  /// **'Loading DHCP settings...'**
  String get loadingDhcp;

  /// No description provided for @enableDhcpServer.
  ///
  /// In en, this message translates to:
  /// **'Enable DHCP server'**
  String get enableDhcpServer;

  /// No description provided for @selectInterface.
  ///
  /// In en, this message translates to:
  /// **'Select interface'**
  String get selectInterface;

  /// No description provided for @hardwareAddress.
  ///
  /// In en, this message translates to:
  /// **'Hardware address'**
  String get hardwareAddress;

  /// No description provided for @gatewayIp.
  ///
  /// In en, this message translates to:
  /// **'Gateway IP'**
  String get gatewayIp;

  /// No description provided for @ipv4addresses.
  ///
  /// In en, this message translates to:
  /// **'IPv4 addresses'**
  String get ipv4addresses;

  /// No description provided for @ipv6addresses.
  ///
  /// In en, this message translates to:
  /// **'IPv6 addresses'**
  String get ipv6addresses;

  /// No description provided for @neededSelectInterface.
  ///
  /// In en, this message translates to:
  /// **'You need to select an interface to configure the DHCP server.'**
  String get neededSelectInterface;

  /// No description provided for @ipv4settings.
  ///
  /// In en, this message translates to:
  /// **'IPv4 settings'**
  String get ipv4settings;

  /// No description provided for @startOfRange.
  ///
  /// In en, this message translates to:
  /// **'Start of range'**
  String get startOfRange;

  /// No description provided for @endOfRange.
  ///
  /// In en, this message translates to:
  /// **'End of range'**
  String get endOfRange;

  /// No description provided for @ipv6settings.
  ///
  /// In en, this message translates to:
  /// **'IPv6 settings'**
  String get ipv6settings;

  /// No description provided for @subnetMask.
  ///
  /// In en, this message translates to:
  /// **'Subnet mask'**
  String get subnetMask;

  /// No description provided for @subnetMaskNotValid.
  ///
  /// In en, this message translates to:
  /// **'Subnet mask not valid'**
  String get subnetMaskNotValid;

  /// No description provided for @gateway.
  ///
  /// In en, this message translates to:
  /// **'Gateway'**
  String get gateway;

  /// No description provided for @gatewayNotValid.
  ///
  /// In en, this message translates to:
  /// **'Gateway not valid'**
  String get gatewayNotValid;

  /// No description provided for @leaseTime.
  ///
  /// In en, this message translates to:
  /// **'Lease time'**
  String get leaseTime;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'{time} seconds'**
  String seconds(Object time);

  /// No description provided for @leaseTimeNotValid.
  ///
  /// In en, this message translates to:
  /// **'Lease time not valid'**
  String get leaseTimeNotValid;

  /// No description provided for @restoreConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Reset configuration'**
  String get restoreConfiguration;

  /// No description provided for @restoreConfigurationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to continue? This will reset all the configuration. This action cannot be undone.'**
  String get restoreConfigurationMessage;

  /// No description provided for @changeInterface.
  ///
  /// In en, this message translates to:
  /// **'Change interface'**
  String get changeInterface;

  /// No description provided for @savingSettings.
  ///
  /// In en, this message translates to:
  /// **'Saving settings...'**
  String get savingSettings;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSaved;

  /// No description provided for @settingsNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings couldn\'t be saved'**
  String get settingsNotSaved;

  /// No description provided for @restoringConfig.
  ///
  /// In en, this message translates to:
  /// **'Restoring configuration...'**
  String get restoringConfig;

  /// No description provided for @configRestored.
  ///
  /// In en, this message translates to:
  /// **'Configuration reseted successfully'**
  String get configRestored;

  /// No description provided for @configNotRestored.
  ///
  /// In en, this message translates to:
  /// **'The configuration couldn\'t be reseted'**
  String get configNotRestored;

  /// No description provided for @dhcpStatic.
  ///
  /// In en, this message translates to:
  /// **'DHCP static leases'**
  String get dhcpStatic;

  /// No description provided for @noDhcpStaticLeases.
  ///
  /// In en, this message translates to:
  /// **'No DHCP static leases found'**
  String get noDhcpStaticLeases;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get deleting;

  /// No description provided for @staticLeaseDeleted.
  ///
  /// In en, this message translates to:
  /// **'DHCP static lease deleted successfully'**
  String get staticLeaseDeleted;

  /// No description provided for @staticLeaseNotDeleted.
  ///
  /// In en, this message translates to:
  /// **'The DHCP static lease could not be deleted'**
  String get staticLeaseNotDeleted;

  /// No description provided for @deleteStaticLease.
  ///
  /// In en, this message translates to:
  /// **'Delete static lease'**
  String get deleteStaticLease;

  /// No description provided for @deleteStaticLeaseDescription.
  ///
  /// In en, this message translates to:
  /// **'The DHCP static lease will be deleted. This action cannot be reverted.'**
  String get deleteStaticLeaseDescription;

  /// No description provided for @addStaticLease.
  ///
  /// In en, this message translates to:
  /// **'Add static lease'**
  String get addStaticLease;

  /// No description provided for @macAddress.
  ///
  /// In en, this message translates to:
  /// **'MAC address'**
  String get macAddress;

  /// No description provided for @macAddressNotValid.
  ///
  /// In en, this message translates to:
  /// **'MAC address not valid'**
  String get macAddressNotValid;

  /// No description provided for @hostName.
  ///
  /// In en, this message translates to:
  /// **'Host name'**
  String get hostName;

  /// No description provided for @hostNameError.
  ///
  /// In en, this message translates to:
  /// **'Host name cannot be empty'**
  String get hostNameError;

  /// No description provided for @creating.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get creating;

  /// No description provided for @staticLeaseCreated.
  ///
  /// In en, this message translates to:
  /// **'DHCP static lease created successfully'**
  String get staticLeaseCreated;

  /// No description provided for @staticLeaseNotCreated.
  ///
  /// In en, this message translates to:
  /// **'The DHCP static lease couldn\'t be created'**
  String get staticLeaseNotCreated;

  /// No description provided for @staticLeaseExists.
  ///
  /// In en, this message translates to:
  /// **'The DHCP static lease already exists'**
  String get staticLeaseExists;

  /// No description provided for @serverNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Server not configured'**
  String get serverNotConfigured;

  /// No description provided for @restoreLeases.
  ///
  /// In en, this message translates to:
  /// **'Reset leases'**
  String get restoreLeases;

  /// No description provided for @restoreLeasesMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to continue? This will reset all the existing leases. This action cannot be undone.'**
  String get restoreLeasesMessage;

  /// No description provided for @restoringLeases.
  ///
  /// In en, this message translates to:
  /// **'Resetting leases...'**
  String get restoringLeases;

  /// No description provided for @leasesRestored.
  ///
  /// In en, this message translates to:
  /// **'Leases reseted successfully'**
  String get leasesRestored;

  /// No description provided for @leasesNotRestored.
  ///
  /// In en, this message translates to:
  /// **'The leases couldn\'t be reseted'**
  String get leasesNotRestored;

  /// No description provided for @dhcpLeases.
  ///
  /// In en, this message translates to:
  /// **'DHCP leases'**
  String get dhcpLeases;

  /// No description provided for @noLeases.
  ///
  /// In en, this message translates to:
  /// **'No DHCP leases available'**
  String get noLeases;

  /// No description provided for @dnsRewrites.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrites'**
  String get dnsRewrites;

  /// No description provided for @dnsRewritesDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure custom DNS rules'**
  String get dnsRewritesDescription;

  /// No description provided for @loadingRewriteRules.
  ///
  /// In en, this message translates to:
  /// **'Loading rewrite rules...'**
  String get loadingRewriteRules;

  /// No description provided for @rewriteRulesNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rules could not be loaded.'**
  String get rewriteRulesNotLoaded;

  /// No description provided for @noRewriteRules.
  ///
  /// In en, this message translates to:
  /// **'No DNS rewrite rules'**
  String get noRewriteRules;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @deleteDnsRewrite.
  ///
  /// In en, this message translates to:
  /// **'Delete DNS rewrite'**
  String get deleteDnsRewrite;

  /// No description provided for @deleteDnsRewriteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this DNS rewrite? This action cannot be undone.'**
  String get deleteDnsRewriteMessage;

  /// No description provided for @dnsRewriteRuleDeleted.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule deleted successfully'**
  String get dnsRewriteRuleDeleted;

  /// No description provided for @dnsRewriteRuleNotDeleted.
  ///
  /// In en, this message translates to:
  /// **'The DNS rewrite rule could not be deleted'**
  String get dnsRewriteRuleNotDeleted;

  /// No description provided for @addDnsRewrite.
  ///
  /// In en, this message translates to:
  /// **'Add DNS rewrite'**
  String get addDnsRewrite;

  /// No description provided for @addingRewrite.
  ///
  /// In en, this message translates to:
  /// **'Adding rewrite...'**
  String get addingRewrite;

  /// No description provided for @dnsRewriteRuleAdded.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule addded successfully'**
  String get dnsRewriteRuleAdded;

  /// No description provided for @dnsRewriteRuleNotAdded.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule could not be added'**
  String get dnsRewriteRuleNotAdded;

  /// No description provided for @logsSettings.
  ///
  /// In en, this message translates to:
  /// **'Logs settings'**
  String get logsSettings;

  /// No description provided for @enableLog.
  ///
  /// In en, this message translates to:
  /// **'Enable log'**
  String get enableLog;

  /// No description provided for @clearLogs.
  ///
  /// In en, this message translates to:
  /// **'Clear logs'**
  String get clearLogs;

  /// No description provided for @anonymizeClientIp.
  ///
  /// In en, this message translates to:
  /// **'Anonymize client IP'**
  String get anonymizeClientIp;

  /// No description provided for @hours6.
  ///
  /// In en, this message translates to:
  /// **'6 hours'**
  String get hours6;

  /// No description provided for @days30.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get days30;

  /// No description provided for @days90.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get days90;

  /// No description provided for @retentionTime.
  ///
  /// In en, this message translates to:
  /// **'Retention time'**
  String get retentionTime;

  /// No description provided for @selectOneItem.
  ///
  /// In en, this message translates to:
  /// **'Select one item'**
  String get selectOneItem;

  /// No description provided for @logSettingsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Log settings couldn\'t be loaded.'**
  String get logSettingsNotLoaded;

  /// No description provided for @updatingSettings.
  ///
  /// In en, this message translates to:
  /// **'Updating settings...'**
  String get updatingSettings;

  /// No description provided for @logsConfigUpdated.
  ///
  /// In en, this message translates to:
  /// **'Logs settings updated successfully'**
  String get logsConfigUpdated;

  /// No description provided for @logsConfigNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Logs settings couldn\'t be updated'**
  String get logsConfigNotUpdated;

  /// No description provided for @deletingLogs.
  ///
  /// In en, this message translates to:
  /// **'Clearing logs...'**
  String get deletingLogs;

  /// No description provided for @logsCleared.
  ///
  /// In en, this message translates to:
  /// **'Logs cleared successfully'**
  String get logsCleared;

  /// No description provided for @logsNotCleared.
  ///
  /// In en, this message translates to:
  /// **'Logs could not be cleared'**
  String get logsNotCleared;

  /// No description provided for @runningHomeAssistant.
  ///
  /// In en, this message translates to:
  /// **'Running on Home Assistant'**
  String get runningHomeAssistant;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @noItems.
  ///
  /// In en, this message translates to:
  /// **'No items to show here'**
  String get noItems;

  /// No description provided for @dnsSettings.
  ///
  /// In en, this message translates to:
  /// **'DNS settings'**
  String get dnsSettings;

  /// No description provided for @dnsSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure connection with DNS servers'**
  String get dnsSettingsDescription;

  /// No description provided for @upstreamDns.
  ///
  /// In en, this message translates to:
  /// **'Upstream DNS servers'**
  String get upstreamDns;

  /// No description provided for @bootstrapDns.
  ///
  /// In en, this message translates to:
  /// **'Bootstrap DNS servers'**
  String get bootstrapDns;

  /// No description provided for @noUpstreamDns.
  ///
  /// In en, this message translates to:
  /// **'No upstream DNS servers added.'**
  String get noUpstreamDns;

  /// No description provided for @dnsMode.
  ///
  /// In en, this message translates to:
  /// **'DNS mode'**
  String get dnsMode;

  /// No description provided for @noDnsMode.
  ///
  /// In en, this message translates to:
  /// **'No DNS mode selected'**
  String get noDnsMode;

  /// No description provided for @loadBalancing.
  ///
  /// In en, this message translates to:
  /// **'Load balancing'**
  String get loadBalancing;

  /// No description provided for @parallelRequests.
  ///
  /// In en, this message translates to:
  /// **'Parallel requests'**
  String get parallelRequests;

  /// No description provided for @fastestIpAddress.
  ///
  /// In en, this message translates to:
  /// **'Fastest IP address'**
  String get fastestIpAddress;

  /// No description provided for @loadBalancingDescription.
  ///
  /// In en, this message translates to:
  /// **'Query one upstream server at a time. AdGuard Home uses its weighted random algorithm to pick the server so that the fastest server is used more often.'**
  String get loadBalancingDescription;

  /// No description provided for @parallelRequestsDescription.
  ///
  /// In en, this message translates to:
  /// **'Use parallel queries to speed up resolving by querying all upstream servers simultaneously.'**
  String get parallelRequestsDescription;

  /// No description provided for @fastestIpAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'Query all DNS servers and return the fastest IP address among all responses. This slows down DNS queries as AdGuard Home has to wait for responses from all DNS servers, but improves the overall connectivity.'**
  String get fastestIpAddressDescription;

  /// No description provided for @noBootstrapDns.
  ///
  /// In en, this message translates to:
  /// **'No bootstrap DNS servers added.'**
  String get noBootstrapDns;

  /// No description provided for @bootstrapDnsServersInfo.
  ///
  /// In en, this message translates to:
  /// **'Bootstrap DNS servers are used to resolve IP addresses of the DoH/DoT resolvers you specify as upstreams.'**
  String get bootstrapDnsServersInfo;

  /// No description provided for @privateReverseDnsServers.
  ///
  /// In en, this message translates to:
  /// **'Private reverse DNS servers'**
  String get privateReverseDnsServers;

  /// No description provided for @privateReverseDnsServersDescription.
  ///
  /// In en, this message translates to:
  /// **'The DNS servers that AdGuard Home uses for local PTR queries. These servers are used to resolve PTR requests for addresses in private IP ranges, for example \"192.168.12.34\", using reverse DNS. If not set, AdGuard Home uses the addresses of the default DNS resolvers of your OS except for the addresses of AdGuard Home itself.'**
  String get privateReverseDnsServersDescription;

  /// No description provided for @reverseDnsDefault.
  ///
  /// In en, this message translates to:
  /// **'By default, AdGuard Home uses the following reverse DNS resolvers'**
  String get reverseDnsDefault;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItem;

  /// No description provided for @noServerAddressesAdded.
  ///
  /// In en, this message translates to:
  /// **'No server addresses added.'**
  String get noServerAddressesAdded;

  /// No description provided for @usePrivateReverseDnsResolvers.
  ///
  /// In en, this message translates to:
  /// **'Use private reverse DNS resolvers'**
  String get usePrivateReverseDnsResolvers;

  /// No description provided for @usePrivateReverseDnsResolversDescription.
  ///
  /// In en, this message translates to:
  /// **'Perform reverse DNS lookups for locally served addresses using these upstream servers. If disabled, AdGuard Home responds with NXDOMAIN to all such PTR requests except for clients known from DHCP, /etc/hosts, and so on.'**
  String get usePrivateReverseDnsResolversDescription;

  /// No description provided for @enableReverseResolving.
  ///
  /// In en, this message translates to:
  /// **'Enable reverse resolving of clients\' IP addresses'**
  String get enableReverseResolving;

  /// No description provided for @enableReverseResolvingDescription.
  ///
  /// In en, this message translates to:
  /// **'Reversely resolve clients\' IP addresses into their hostnames by sending PTR queries to corresponding resolvers (private DNS servers for local clients, upstream servers for clients with public IP addresses).'**
  String get enableReverseResolvingDescription;

  /// No description provided for @dnsServerSettings.
  ///
  /// In en, this message translates to:
  /// **'AdGuard Home DNS server settings'**
  String get dnsServerSettings;

  /// No description provided for @limitRequestsSecond.
  ///
  /// In en, this message translates to:
  /// **'Rate limit per second'**
  String get limitRequestsSecond;

  /// No description provided for @valueNotNumber.
  ///
  /// In en, this message translates to:
  /// **'Value is not a number'**
  String get valueNotNumber;

  /// No description provided for @enableEdns.
  ///
  /// In en, this message translates to:
  /// **'Enable EDNS client subnet'**
  String get enableEdns;

  /// No description provided for @enableEdnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Add the EDNS Client Subnet option (ECS) to upstream requests and log the values sent by the clients in the query log.'**
  String get enableEdnsDescription;

  /// No description provided for @enableDnssec.
  ///
  /// In en, this message translates to:
  /// **'Enable DNSSEC'**
  String get enableDnssec;

  /// No description provided for @enableDnssecDescription.
  ///
  /// In en, this message translates to:
  /// **'Set DNSSEC flag in the outcoming DNS queries and check the result (DNSSEC-enabled resolver is required).'**
  String get enableDnssecDescription;

  /// No description provided for @disableResolvingIpv6.
  ///
  /// In en, this message translates to:
  /// **'Disable resolving of IPv6 addresses'**
  String get disableResolvingIpv6;

  /// No description provided for @disableResolvingIpv6Description.
  ///
  /// In en, this message translates to:
  /// **'Drop all DNS queries for IPv6 addresses (type AAAA).'**
  String get disableResolvingIpv6Description;

  /// No description provided for @blockingMode.
  ///
  /// In en, this message translates to:
  /// **'Blocking mode'**
  String get blockingMode;

  /// No description provided for @defaultMode.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultMode;

  /// No description provided for @defaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Respond with zero IP address (0.0.0.0 for A; :: for AAAA) when blocked by Adblock-style rule; respond with the IP address specified in the rule when blocked by /etc/hosts-style rule'**
  String get defaultDescription;

  /// No description provided for @refusedDescription.
  ///
  /// In en, this message translates to:
  /// **'Respond with REFUSED code'**
  String get refusedDescription;

  /// No description provided for @nxdomainDescription.
  ///
  /// In en, this message translates to:
  /// **'Respond with NXDOMAIN code'**
  String get nxdomainDescription;

  /// No description provided for @nullIp.
  ///
  /// In en, this message translates to:
  /// **'Null IP'**
  String get nullIp;

  /// No description provided for @nullIpDescription.
  ///
  /// In en, this message translates to:
  /// **'Respond with zero IP address (0.0.0.0 for A; :: for AAAA)'**
  String get nullIpDescription;

  /// No description provided for @customIp.
  ///
  /// In en, this message translates to:
  /// **'Custom IP'**
  String get customIp;

  /// No description provided for @customIpDescription.
  ///
  /// In en, this message translates to:
  /// **'Respond with a manually set IP address'**
  String get customIpDescription;

  /// No description provided for @dnsCacheConfig.
  ///
  /// In en, this message translates to:
  /// **'DNS cache configuration'**
  String get dnsCacheConfig;

  /// No description provided for @cacheSize.
  ///
  /// In en, this message translates to:
  /// **'Cache size'**
  String get cacheSize;

  /// No description provided for @inBytes.
  ///
  /// In en, this message translates to:
  /// **'In bytes'**
  String get inBytes;

  /// No description provided for @overrideMinimumTtl.
  ///
  /// In en, this message translates to:
  /// **'Override minimum TTL'**
  String get overrideMinimumTtl;

  /// No description provided for @overrideMinimumTtlDescription.
  ///
  /// In en, this message translates to:
  /// **'Extend short time-to-live values (seconds) received from the upstream server when caching DNS responses.'**
  String get overrideMinimumTtlDescription;

  /// No description provided for @overrideMaximumTtl.
  ///
  /// In en, this message translates to:
  /// **'Override maximum TTL'**
  String get overrideMaximumTtl;

  /// No description provided for @overrideMaximumTtlDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a maximum time-to-live value (seconds) for entries in the DNS cache.'**
  String get overrideMaximumTtlDescription;

  /// No description provided for @optimisticCaching.
  ///
  /// In en, this message translates to:
  /// **'Optimistic caching'**
  String get optimisticCaching;

  /// No description provided for @optimisticCachingDescription.
  ///
  /// In en, this message translates to:
  /// **'Make AdGuard Home respond from the cache even when the entries are expired and also try to refresh them.'**
  String get optimisticCachingDescription;

  /// No description provided for @loadingDnsConfig.
  ///
  /// In en, this message translates to:
  /// **'Loading DNS configuration...'**
  String get loadingDnsConfig;

  /// No description provided for @dnsConfigNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'DNS config could not be loaded.'**
  String get dnsConfigNotLoaded;

  /// No description provided for @blockingIpv4.
  ///
  /// In en, this message translates to:
  /// **'Blocking IPv4'**
  String get blockingIpv4;

  /// No description provided for @blockingIpv4Description.
  ///
  /// In en, this message translates to:
  /// **'IP address to be returned for a blocked A request'**
  String get blockingIpv4Description;

  /// No description provided for @blockingIpv6.
  ///
  /// In en, this message translates to:
  /// **'Blocking IPv6'**
  String get blockingIpv6;

  /// No description provided for @blockingIpv6Description.
  ///
  /// In en, this message translates to:
  /// **'IP address to be returned for a blocked AAAA request'**
  String get blockingIpv6Description;

  /// No description provided for @invalidIp.
  ///
  /// In en, this message translates to:
  /// **'Invalid IP address'**
  String get invalidIp;

  /// No description provided for @dnsConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'DNS server configuration saved successfully'**
  String get dnsConfigSaved;

  /// No description provided for @dnsConfigNotSaved.
  ///
  /// In en, this message translates to:
  /// **'The DNS server configuration could not be saved'**
  String get dnsConfigNotSaved;

  /// No description provided for @savingConfig.
  ///
  /// In en, this message translates to:
  /// **'Saving configuration...'**
  String get savingConfig;

  /// No description provided for @someValueNotValid.
  ///
  /// In en, this message translates to:
  /// **'Some value is not valid'**
  String get someValueNotValid;

  /// No description provided for @upstreamDnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure upstream servers and DNS mode'**
  String get upstreamDnsDescription;

  /// No description provided for @bootstrapDnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure the bootstrap DNS servers'**
  String get bootstrapDnsDescription;

  /// No description provided for @privateReverseDnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure custom DNS resolvers and enable private reverse DNS resolving'**
  String get privateReverseDnsDescription;

  /// No description provided for @dnsServerSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure a rate limit, the blocking mode and more'**
  String get dnsServerSettingsDescription;

  /// No description provided for @dnsCacheConfigDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure how the server should manage the DNS cache'**
  String get dnsCacheConfigDescription;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @commentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Comments are always preceded by #. You don\'t have to add it, it will be added automatically.'**
  String get commentsDescription;

  /// No description provided for @encryptionSettings.
  ///
  /// In en, this message translates to:
  /// **'Encryption settings'**
  String get encryptionSettings;

  /// No description provided for @encryptionSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Encryption (HTTPS/QUIC/TLS) support'**
  String get encryptionSettingsDescription;

  /// No description provided for @loadingEncryptionSettings.
  ///
  /// In en, this message translates to:
  /// **'Loading encryption settings...'**
  String get loadingEncryptionSettings;

  /// No description provided for @encryptionSettingsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Encryption settings couldn\'t be loaded.'**
  String get encryptionSettingsNotLoaded;

  /// No description provided for @enableEncryption.
  ///
  /// In en, this message translates to:
  /// **'Enable encryption'**
  String get enableEncryption;

  /// No description provided for @enableEncryptionTypes.
  ///
  /// In en, this message translates to:
  /// **'HTTPS, DNS-over-HTTPS, and DNS-over-TLS'**
  String get enableEncryptionTypes;

  /// No description provided for @enableEncryptionDescription.
  ///
  /// In en, this message translates to:
  /// **'If encryption is enabled, AdGuard Home admin interface will work over HTTPS, and the DNS server will listen for requests over DNS-over-HTTPS and DNS-over-TLS.'**
  String get enableEncryptionDescription;

  /// No description provided for @serverConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Server configuration'**
  String get serverConfiguration;

  /// No description provided for @domainName.
  ///
  /// In en, this message translates to:
  /// **'Domain name'**
  String get domainName;

  /// No description provided for @domainNameDescription.
  ///
  /// In en, this message translates to:
  /// **'If set, AdGuard Home detects ClientIDs, responds to DDR queries, and performs additional connection validations. If not set, these features are disabled. Must match one of the DNS Names in the certificate.'**
  String get domainNameDescription;

  /// No description provided for @redirectHttps.
  ///
  /// In en, this message translates to:
  /// **'Redirect to HTTPS automatically'**
  String get redirectHttps;

  /// No description provided for @httpsPort.
  ///
  /// In en, this message translates to:
  /// **'HTTPS port'**
  String get httpsPort;

  /// No description provided for @tlsPort.
  ///
  /// In en, this message translates to:
  /// **'DNS-over-TLS port'**
  String get tlsPort;

  /// No description provided for @dnsOverQuicPort.
  ///
  /// In en, this message translates to:
  /// **'DNS-over-QUIC port'**
  String get dnsOverQuicPort;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @certificatesDescription.
  ///
  /// In en, this message translates to:
  /// **'In order to use encryption, you need to provide a valid SSL certificates chain for your domain. You can get a free certificate on letsencrypt.org or you can buy it from one of the trusted Certificate Authorities.'**
  String get certificatesDescription;

  /// No description provided for @certificateFilePath.
  ///
  /// In en, this message translates to:
  /// **'Set a certificates file path'**
  String get certificateFilePath;

  /// No description provided for @pasteCertificateContent.
  ///
  /// In en, this message translates to:
  /// **'Paste the certificates contents'**
  String get pasteCertificateContent;

  /// No description provided for @certificatePath.
  ///
  /// In en, this message translates to:
  /// **'Certificate path'**
  String get certificatePath;

  /// No description provided for @certificateContent.
  ///
  /// In en, this message translates to:
  /// **'Certificate content'**
  String get certificateContent;

  /// No description provided for @privateKey.
  ///
  /// In en, this message translates to:
  /// **'Private key'**
  String get privateKey;

  /// No description provided for @privateKeyFile.
  ///
  /// In en, this message translates to:
  /// **'Set a private key file'**
  String get privateKeyFile;

  /// No description provided for @pastePrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Paste the private key contents'**
  String get pastePrivateKey;

  /// No description provided for @usePreviousKey.
  ///
  /// In en, this message translates to:
  /// **'Use the previously saved key'**
  String get usePreviousKey;

  /// No description provided for @privateKeyPath.
  ///
  /// In en, this message translates to:
  /// **'Private key path'**
  String get privateKeyPath;

  /// No description provided for @invalidCertificate.
  ///
  /// In en, this message translates to:
  /// **'Invalid certificate'**
  String get invalidCertificate;

  /// No description provided for @invalidPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Invalid private key'**
  String get invalidPrivateKey;

  /// No description provided for @validatingData.
  ///
  /// In en, this message translates to:
  /// **'Validating data'**
  String get validatingData;

  /// No description provided for @dataValid.
  ///
  /// In en, this message translates to:
  /// **'Data is valid'**
  String get dataValid;

  /// No description provided for @dataNotValid.
  ///
  /// In en, this message translates to:
  /// **'Data not valid'**
  String get dataNotValid;

  /// No description provided for @encryptionConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Encryption configuration saved successfully'**
  String get encryptionConfigSaved;

  /// No description provided for @encryptionConfigNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Encryption configuration could not be saved'**
  String get encryptionConfigNotSaved;

  /// No description provided for @configError.
  ///
  /// In en, this message translates to:
  /// **'Configuration error'**
  String get configError;

  /// No description provided for @enterOnlyCertificate.
  ///
  /// In en, this message translates to:
  /// **'Enter only the certificate. Do not input the ---BEGIN--- and ---END--- lines.'**
  String get enterOnlyCertificate;

  /// No description provided for @enterOnlyPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Enter only the key. Do not input the ---BEGIN--- and ---END--- lines.'**
  String get enterOnlyPrivateKey;

  /// No description provided for @noItemsSearch.
  ///
  /// In en, this message translates to:
  /// **'No items for that search.'**
  String get noItemsSearch;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @exitSearch.
  ///
  /// In en, this message translates to:
  /// **'Exit search'**
  String get exitSearch;

  /// No description provided for @searchClients.
  ///
  /// In en, this message translates to:
  /// **'Search clients'**
  String get searchClients;

  /// No description provided for @noClientsSearch.
  ///
  /// In en, this message translates to:
  /// **'No clients with that search.'**
  String get noClientsSearch;

  /// No description provided for @customization.
  ///
  /// In en, this message translates to:
  /// **'Customization'**
  String get customization;

  /// No description provided for @customizationDescription.
  ///
  /// In en, this message translates to:
  /// **'Customize this application'**
  String get customizationDescription;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @useDynamicTheme.
  ///
  /// In en, this message translates to:
  /// **'Use dynamic theme'**
  String get useDynamicTheme;

  /// No description provided for @red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get red;

  /// No description provided for @green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get green;

  /// No description provided for @blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blue;

  /// No description provided for @yellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get yellow;

  /// No description provided for @orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orange;

  /// No description provided for @brown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get brown;

  /// No description provided for @cyan.
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get cyan;

  /// No description provided for @purple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get purple;

  /// No description provided for @pink.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get pink;

  /// No description provided for @deepOrange.
  ///
  /// In en, this message translates to:
  /// **'Deep orange'**
  String get deepOrange;

  /// No description provided for @indigo.
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get indigo;

  /// No description provided for @useThemeColorStatus.
  ///
  /// In en, this message translates to:
  /// **'Use theme color for status'**
  String get useThemeColorStatus;

  /// No description provided for @useThemeColorStatusDescription.
  ///
  /// In en, this message translates to:
  /// **'Replaces green and red status colors with theme color and grey'**
  String get useThemeColorStatusDescription;

  /// No description provided for @invalidCertificateChain.
  ///
  /// In en, this message translates to:
  /// **'Invalid certificate chain'**
  String get invalidCertificateChain;

  /// No description provided for @validCertificateChain.
  ///
  /// In en, this message translates to:
  /// **'Valid certificate chain'**
  String get validCertificateChain;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @issuer.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get issuer;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @validPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Valid private key'**
  String get validPrivateKey;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration date'**
  String get expirationDate;

  /// No description provided for @keysNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Invalid certificate or key: tls: private key does not match public key'**
  String get keysNotMatch;

  /// No description provided for @timeLogs.
  ///
  /// In en, this message translates to:
  /// **'Time on logs'**
  String get timeLogs;

  /// No description provided for @timeLogsDescription.
  ///
  /// In en, this message translates to:
  /// **'Show processing time on logs list'**
  String get timeLogsDescription;

  /// No description provided for @hostNames.
  ///
  /// In en, this message translates to:
  /// **'Host names'**
  String get hostNames;

  /// No description provided for @keyType.
  ///
  /// In en, this message translates to:
  /// **'Key type'**
  String get keyType;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @installedVersion.
  ///
  /// In en, this message translates to:
  /// **'Installed version'**
  String get installedVersion;

  /// No description provided for @newVersion.
  ///
  /// In en, this message translates to:
  /// **'New version'**
  String get newVersion;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @downloadUpdate.
  ///
  /// In en, this message translates to:
  /// **'Download update'**
  String get downloadUpdate;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @doNotRememberAgainUpdate.
  ///
  /// In en, this message translates to:
  /// **'Do not remember again for this version'**
  String get doNotRememberAgainUpdate;

  /// No description provided for @downloadingUpdate.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloadingUpdate;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @permissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission not granted'**
  String get permissionNotGranted;

  /// No description provided for @inputSearchTerm.
  ///
  /// In en, this message translates to:
  /// **'Input a search term.'**
  String get inputSearchTerm;

  /// No description provided for @answers.
  ///
  /// In en, this message translates to:
  /// **'Answers'**
  String get answers;

  /// No description provided for @copyClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyClipboard;

  /// No description provided for @domainCopiedClipboard.
  ///
  /// In en, this message translates to:
  /// **'Domain copied to the clipboard'**
  String get domainCopiedClipboard;

  /// No description provided for @clearDnsCache.
  ///
  /// In en, this message translates to:
  /// **'Clear DNS cache'**
  String get clearDnsCache;

  /// No description provided for @clearDnsCacheMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear the DNS cache?'**
  String get clearDnsCacheMessage;

  /// No description provided for @dnsCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'DNS cache cleared successfully'**
  String get dnsCacheCleared;

  /// No description provided for @clearingDnsCache.
  ///
  /// In en, this message translates to:
  /// **'Clearing cache...'**
  String get clearingDnsCache;

  /// No description provided for @dnsCacheNotCleared.
  ///
  /// In en, this message translates to:
  /// **'DNS cache couldn\'t be cleared'**
  String get dnsCacheNotCleared;

  /// No description provided for @clientsSelected.
  ///
  /// In en, this message translates to:
  /// **'clients selected'**
  String get clientsSelected;

  /// No description provided for @invalidDomain.
  ///
  /// In en, this message translates to:
  /// **'Invalid domain'**
  String get invalidDomain;

  /// No description provided for @loadingBlockedServicesList.
  ///
  /// In en, this message translates to:
  /// **'Loading blocked services list...'**
  String get loadingBlockedServicesList;

  /// No description provided for @blockedServicesListNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'The blocked services list could not be loaded'**
  String get blockedServicesListNotLoaded;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @updatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Update the AdGuard Home server'**
  String get updatesDescription;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @currentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current version'**
  String get currentVersion;

  /// No description provided for @requestStartUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Request to start update failed'**
  String get requestStartUpdateFailed;

  /// No description provided for @requestStartUpdateSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Request to start update successfull'**
  String get requestStartUpdateSuccessful;

  /// No description provided for @serverUpdated.
  ///
  /// In en, this message translates to:
  /// **'Server is updated'**
  String get serverUpdated;

  /// No description provided for @unknownStatus.
  ///
  /// In en, this message translates to:
  /// **'Unknown status'**
  String get unknownStatus;

  /// No description provided for @checkingUpdates.
  ///
  /// In en, this message translates to:
  /// **'Checking updates...'**
  String get checkingUpdates;

  /// No description provided for @checkUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check updates'**
  String get checkUpdates;

  /// No description provided for @requestingUpdate.
  ///
  /// In en, this message translates to:
  /// **'Requesting update...'**
  String get requestingUpdate;

  /// No description provided for @autoupdateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Autoupdate unavailable'**
  String get autoupdateUnavailable;

  /// No description provided for @autoupdateUnavailableDescription.
  ///
  /// In en, this message translates to:
  /// **'The autoupdate service is not available for this server. It could be because the server is running on a Docker container. You have to update your server manually.'**
  String get autoupdateUnavailableDescription;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'{time} minute'**
  String minute(Object time);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{time} minutes'**
  String minutes(Object time);

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'{time} hour'**
  String hour(Object time);

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'{time} hours'**
  String hours(Object time);

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'Remaining time'**
  String get remainingTime;

  /// No description provided for @safeSearchSettings.
  ///
  /// In en, this message translates to:
  /// **'Safe search settings'**
  String get safeSearchSettings;

  /// No description provided for @loadingSafeSearchSettings.
  ///
  /// In en, this message translates to:
  /// **'Loading safe search settings...'**
  String get loadingSafeSearchSettings;

  /// No description provided for @safeSearchSettingsNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Error when loading safe search settings.'**
  String get safeSearchSettingsNotLoaded;

  /// No description provided for @loadingLogsSettings.
  ///
  /// In en, this message translates to:
  /// **'Loading logs settings...'**
  String get loadingLogsSettings;

  /// No description provided for @selectOptionLeftColumn.
  ///
  /// In en, this message translates to:
  /// **'Select an option of the left column'**
  String get selectOptionLeftColumn;

  /// No description provided for @selectClientLeftColumn.
  ///
  /// In en, this message translates to:
  /// **'Select a client of the left column'**
  String get selectClientLeftColumn;

  /// No description provided for @disableList.
  ///
  /// In en, this message translates to:
  /// **'Disable list'**
  String get disableList;

  /// No description provided for @enableList.
  ///
  /// In en, this message translates to:
  /// **'Enable list'**
  String get enableList;

  /// No description provided for @screens.
  ///
  /// In en, this message translates to:
  /// **'Screens'**
  String get screens;

  /// No description provided for @copiedClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedClipboard;

  /// No description provided for @seeDetails.
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get seeDetails;

  /// No description provided for @listNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'List not available'**
  String get listNotAvailable;

  /// No description provided for @copyListUrl.
  ///
  /// In en, this message translates to:
  /// **'Copy list URL'**
  String get copyListUrl;

  /// No description provided for @listUrlCopied.
  ///
  /// In en, this message translates to:
  /// **'List URL copied to the clipboard'**
  String get listUrlCopied;

  /// No description provided for @unsupportedVersion.
  ///
  /// In en, this message translates to:
  /// **'Unsupported version'**
  String get unsupportedVersion;

  /// No description provided for @unsupprtedVersionMessage.
  ///
  /// In en, this message translates to:
  /// **'The support for your server version {version} is not guaranteed. This application may have some issues working with that server version.\n\nAdGuard Home Manager is designed to work with the stable releases of the AdGuard Home server. It may work with alpha and beta releases, but the compatibility is not guaranteed and the app may have some issues working with that versions.'**
  String unsupprtedVersionMessage(Object version);

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get iUnderstand;

  /// No description provided for @appUpdates.
  ///
  /// In en, this message translates to:
  /// **'Application updates'**
  String get appUpdates;

  /// No description provided for @usingLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'You are using the latest version'**
  String get usingLatestVersion;

  /// No description provided for @ipLogs.
  ///
  /// In en, this message translates to:
  /// **'IP on logs'**
  String get ipLogs;

  /// No description provided for @ipLogsDescription.
  ///
  /// In en, this message translates to:
  /// **'Show always IP address on logs instead of client name'**
  String get ipLogsDescription;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @combinedChart.
  ///
  /// In en, this message translates to:
  /// **'Combined chart'**
  String get combinedChart;

  /// No description provided for @combinedChartDescription.
  ///
  /// In en, this message translates to:
  /// **'Combine all charts into one'**
  String get combinedChartDescription;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @errorLoadFilters.
  ///
  /// In en, this message translates to:
  /// **'Error when loading filters.'**
  String get errorLoadFilters;

  /// No description provided for @clientRemovedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client removed successfully.'**
  String get clientRemovedSuccessfully;

  /// No description provided for @editRewriteRule.
  ///
  /// In en, this message translates to:
  /// **'Edit rewrite rule'**
  String get editRewriteRule;

  /// No description provided for @dnsRewriteRuleUpdated.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule updated successfully'**
  String get dnsRewriteRuleUpdated;

  /// No description provided for @dnsRewriteRuleNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule could not be updated'**
  String get dnsRewriteRuleNotUpdated;

  /// No description provided for @updatingRule.
  ///
  /// In en, this message translates to:
  /// **'Updating rule...'**
  String get updatingRule;

  /// No description provided for @serverUpdateNeeded.
  ///
  /// In en, this message translates to:
  /// **'Server update needed'**
  String get serverUpdateNeeded;

  /// No description provided for @updateYourServer.
  ///
  /// In en, this message translates to:
  /// **'Update your AdGuard Home server to {version} or greater to use this feature.'**
  String updateYourServer(Object version);

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @malwarePhishing.
  ///
  /// In en, this message translates to:
  /// **'Malware/phishing'**
  String get malwarePhishing;

  /// No description provided for @queries.
  ///
  /// In en, this message translates to:
  /// **'Queries'**
  String get queries;

  /// No description provided for @adultSites.
  ///
  /// In en, this message translates to:
  /// **'Adult sites'**
  String get adultSites;

  /// No description provided for @quickFilters.
  ///
  /// In en, this message translates to:
  /// **'Quick filters'**
  String get quickFilters;

  /// No description provided for @searchDomainInternet.
  ///
  /// In en, this message translates to:
  /// **'Search domain on the Internet'**
  String get searchDomainInternet;

  /// No description provided for @hideServerAddress.
  ///
  /// In en, this message translates to:
  /// **'Hide server address'**
  String get hideServerAddress;

  /// No description provided for @hideServerAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'Hides the server address on the home screen'**
  String get hideServerAddressDescription;

  /// No description provided for @topItemsOrder.
  ///
  /// In en, this message translates to:
  /// **'Top items order'**
  String get topItemsOrder;

  /// No description provided for @topItemsOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'Order the home screen top items lists'**
  String get topItemsOrderDescription;

  /// No description provided for @topItemsReorderInfo.
  ///
  /// In en, this message translates to:
  /// **'Hold and swipe an item to reorder it.'**
  String get topItemsReorderInfo;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard changes'**
  String get discardChanges;

  /// No description provided for @discardChangesDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to discard the changes?'**
  String get discardChangesDescription;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @showChart.
  ///
  /// In en, this message translates to:
  /// **'Show chart'**
  String get showChart;

  /// No description provided for @hideChart.
  ///
  /// In en, this message translates to:
  /// **'Hide chart'**
  String get hideChart;

  /// No description provided for @showTopItemsChart.
  ///
  /// In en, this message translates to:
  /// **'Show top items chart'**
  String get showTopItemsChart;

  /// No description provided for @showTopItemsChartDescription.
  ///
  /// In en, this message translates to:
  /// **'Shows by default the ring chart on the top items sections. Only affects to the mobile view.'**
  String get showTopItemsChartDescription;

  /// No description provided for @openMenu.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get openMenu;

  /// No description provided for @closeMenu.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get closeMenu;

  /// No description provided for @openListUrl.
  ///
  /// In en, this message translates to:
  /// **'Open list URL'**
  String get openListUrl;

  /// No description provided for @selectionMode.
  ///
  /// In en, this message translates to:
  /// **'Selection mode'**
  String get selectionMode;

  /// No description provided for @enableDisableSelected.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable selected items'**
  String get enableDisableSelected;

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete selected items'**
  String get deleteSelected;

  /// No description provided for @deleteSelectedLists.
  ///
  /// In en, this message translates to:
  /// **'Delete selected lists'**
  String get deleteSelectedLists;

  /// No description provided for @allSelectedListsDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'All selected lists have been deleted successfully.'**
  String get allSelectedListsDeletedSuccessfully;

  /// No description provided for @deletionResult.
  ///
  /// In en, this message translates to:
  /// **'Deletion result'**
  String get deletionResult;

  /// No description provided for @deletingLists.
  ///
  /// In en, this message translates to:
  /// **'Deleting lists...'**
  String get deletingLists;

  /// No description provided for @failedElements.
  ///
  /// In en, this message translates to:
  /// **'Failed elements'**
  String get failedElements;

  /// No description provided for @processingLists.
  ///
  /// In en, this message translates to:
  /// **'Processing lists...'**
  String get processingLists;

  /// No description provided for @enableDisableResult.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable result'**
  String get enableDisableResult;

  /// No description provided for @selectedListsEnabledDisabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'All selected lists have been enabled or disabled successfully'**
  String get selectedListsEnabledDisabledSuccessfully;

  /// No description provided for @sslWarning.
  ///
  /// In en, this message translates to:
  /// **'If you are using an HTTPS connection with a self signed certificate, make sure to enable \"Don\'t check SSL certificate\" at Settings > Advanced settings.'**
  String get sslWarning;

  /// No description provided for @unsupportedServerVersion.
  ///
  /// In en, this message translates to:
  /// **'Unsupported server version'**
  String get unsupportedServerVersion;

  /// No description provided for @unsupportedServerVersionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your AdGuard Home server version is too old and is not supported by AdGuard Home Manager. You will need to upgrade your AdGuard Home server to a newer version to use this application.'**
  String get unsupportedServerVersionMessage;

  /// No description provided for @yourVersion.
  ///
  /// In en, this message translates to:
  /// **'Your version: {version}'**
  String yourVersion(Object version);

  /// No description provided for @minimumRequiredVersion.
  ///
  /// In en, this message translates to:
  /// **'Minimum required version: {version}'**
  String minimumRequiredVersion(Object version);

  /// No description provided for @topUpstreams.
  ///
  /// In en, this message translates to:
  /// **'Top upstreams'**
  String get topUpstreams;

  /// No description provided for @averageUpstreamResponseTime.
  ///
  /// In en, this message translates to:
  /// **'Average upstream response time'**
  String get averageUpstreamResponseTime;

  /// No description provided for @dhcpNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'The DHCP server is not available.'**
  String get dhcpNotAvailable;

  /// No description provided for @osServerInstalledIncompatible.
  ///
  /// In en, this message translates to:
  /// **'The OS where the server is installed is not compatible with this feature.'**
  String get osServerInstalledIncompatible;

  /// No description provided for @resetSettings.
  ///
  /// In en, this message translates to:
  /// **'Reset settings'**
  String get resetSettings;

  /// No description provided for @resetEncryptionSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset to default values the encryption settings?'**
  String get resetEncryptionSettingsDescription;

  /// No description provided for @resettingConfig.
  ///
  /// In en, this message translates to:
  /// **'Resetting configuration...'**
  String get resettingConfig;

  /// No description provided for @configurationResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Configuration resetted successfully'**
  String get configurationResetSuccessfully;

  /// No description provided for @configurationResetError.
  ///
  /// In en, this message translates to:
  /// **'The configuration couldn\'t be resetted'**
  String get configurationResetError;

  /// No description provided for @testUpstreamDnsServers.
  ///
  /// In en, this message translates to:
  /// **'Test upstream DNS servers'**
  String get testUpstreamDnsServers;

  /// No description provided for @errorTestUpstreamDns.
  ///
  /// In en, this message translates to:
  /// **'Error when testing upstream DNS servers.'**
  String get errorTestUpstreamDns;

  /// No description provided for @useCustomIpEdns.
  ///
  /// In en, this message translates to:
  /// **'Use custom IP for EDNS'**
  String get useCustomIpEdns;

  /// No description provided for @useCustomIpEdnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow to use custom IP for EDNS'**
  String get useCustomIpEdnsDescription;

  /// No description provided for @sortingOptions.
  ///
  /// In en, this message translates to:
  /// **'Sorting options'**
  String get sortingOptions;

  /// No description provided for @fromHighestToLowest.
  ///
  /// In en, this message translates to:
  /// **'From highest to lowest'**
  String get fromHighestToLowest;

  /// No description provided for @fromLowestToHighest.
  ///
  /// In en, this message translates to:
  /// **'From lowest to highest'**
  String get fromLowestToHighest;

  /// No description provided for @queryLogsAndStatistics.
  ///
  /// In en, this message translates to:
  /// **'Query logs and statistics'**
  String get queryLogsAndStatistics;

  /// No description provided for @ignoreClientQueryLog.
  ///
  /// In en, this message translates to:
  /// **'Ignore this client in query log'**
  String get ignoreClientQueryLog;

  /// No description provided for @ignoreClientStatistics.
  ///
  /// In en, this message translates to:
  /// **'Ignore this client in statistics'**
  String get ignoreClientStatistics;

  /// No description provided for @savingChanges.
  ///
  /// In en, this message translates to:
  /// **'Saving changes...'**
  String get savingChanges;

  /// No description provided for @fallbackDnsServers.
  ///
  /// In en, this message translates to:
  /// **'Fallback DNS servers'**
  String get fallbackDnsServers;

  /// No description provided for @fallbackDnsServersDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure fallback DNS servers'**
  String get fallbackDnsServersDescription;

  /// No description provided for @fallbackDnsServersInfo.
  ///
  /// In en, this message translates to:
  /// **'List of fallback DNS servers used when upstream DNS servers are not responding. The syntax is the same as in the main upstreams field above.'**
  String get fallbackDnsServersInfo;

  /// No description provided for @noFallbackDnsAdded.
  ///
  /// In en, this message translates to:
  /// **'No fallback DNS servers added.'**
  String get noFallbackDnsAdded;

  /// No description provided for @blockedResponseTtl.
  ///
  /// In en, this message translates to:
  /// **'Blocked response TTL'**
  String get blockedResponseTtl;

  /// No description provided for @blockedResponseTtlDescription.
  ///
  /// In en, this message translates to:
  /// **'Specifies for how many seconds the clients should cache a filtered response'**
  String get blockedResponseTtlDescription;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid value'**
  String get invalidValue;

  /// No description provided for @noDataChart.
  ///
  /// In en, this message translates to:
  /// **'There\'s no data to display this chart.'**
  String get noDataChart;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @unblockClient.
  ///
  /// In en, this message translates to:
  /// **'Unblock client'**
  String get unblockClient;

  /// No description provided for @blockingClient.
  ///
  /// In en, this message translates to:
  /// **'Blocking client...'**
  String get blockingClient;

  /// No description provided for @unblockingClient.
  ///
  /// In en, this message translates to:
  /// **'Unblocking client...'**
  String get unblockingClient;

  /// No description provided for @upstreamDnsCacheConfiguration.
  ///
  /// In en, this message translates to:
  /// **'DNS upstream cache configuration'**
  String get upstreamDnsCacheConfiguration;

  /// No description provided for @enableDnsCachingClient.
  ///
  /// In en, this message translates to:
  /// **'Enable DNS caching for this client'**
  String get enableDnsCachingClient;

  /// No description provided for @dnsCacheSize.
  ///
  /// In en, this message translates to:
  /// **'DNS cache size'**
  String get dnsCacheSize;

  /// No description provided for @nameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameInvalid;

  /// No description provided for @oneIdentifierRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one identifier is required'**
  String get oneIdentifierRequired;

  /// No description provided for @dnsCacheNumber.
  ///
  /// In en, this message translates to:
  /// **'DNS cache size must be a number'**
  String get dnsCacheNumber;

  /// No description provided for @errors.
  ///
  /// In en, this message translates to:
  /// **'Errors'**
  String get errors;

  /// No description provided for @redirectHttpsWarning.
  ///
  /// In en, this message translates to:
  /// **'If you have enabled \"Redirect to HTTPS automatically\" on your AdGuard Home server, you must select an HTTPS connection and use the HTTPS port of your server.'**
  String get redirectHttpsWarning;

  /// No description provided for @logsSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure query logs'**
  String get logsSettingsDescription;

  /// No description provided for @ignoredDomains.
  ///
  /// In en, this message translates to:
  /// **'Ignored domains'**
  String get ignoredDomains;

  /// No description provided for @noIgnoredDomainsAdded.
  ///
  /// In en, this message translates to:
  /// **'No domains to ignore added'**
  String get noIgnoredDomainsAdded;

  /// No description provided for @pauseServiceBlocking.
  ///
  /// In en, this message translates to:
  /// **'Pause service blocking'**
  String get pauseServiceBlocking;

  /// No description provided for @newSchedule.
  ///
  /// In en, this message translates to:
  /// **'New schedule'**
  String get newSchedule;

  /// No description provided for @editSchedule.
  ///
  /// In en, this message translates to:
  /// **'Edit schedule'**
  String get editSchedule;

  /// No description provided for @timezone.
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get timezone;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @selectStartTime.
  ///
  /// In en, this message translates to:
  /// **'Select start time'**
  String get selectStartTime;

  /// No description provided for @selectEndTime.
  ///
  /// In en, this message translates to:
  /// **'Select end time'**
  String get selectEndTime;

  /// No description provided for @startTimeBeforeEndTime.
  ///
  /// In en, this message translates to:
  /// **'Start time must be before end time.'**
  String get startTimeBeforeEndTime;

  /// No description provided for @noBlockingScheduleThisDevice.
  ///
  /// In en, this message translates to:
  /// **'There\'s no blocking schedule for this device.'**
  String get noBlockingScheduleThisDevice;

  /// No description provided for @selectTimezone.
  ///
  /// In en, this message translates to:
  /// **'Select a timezone'**
  String get selectTimezone;

  /// No description provided for @selectClientsFiltersInfo.
  ///
  /// In en, this message translates to:
  /// **'Select the clients you want to display. If no clients are selected, all will be displayed.'**
  String get selectClientsFiltersInfo;

  /// No description provided for @noDataThisSection.
  ///
  /// In en, this message translates to:
  /// **'There\'s no data for this section.'**
  String get noDataThisSection;

  /// No description provided for @statisticsSettings.
  ///
  /// In en, this message translates to:
  /// **'Statistics settings'**
  String get statisticsSettings;

  /// No description provided for @statisticsSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure data collection for statistics'**
  String get statisticsSettingsDescription;

  /// No description provided for @loadingStatisticsSettings.
  ///
  /// In en, this message translates to:
  /// **'Loading statistics settings...'**
  String get loadingStatisticsSettings;

  /// No description provided for @statisticsSettingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occured when loading statistics settings.'**
  String get statisticsSettingsLoadError;

  /// No description provided for @statisticsConfigUpdated.
  ///
  /// In en, this message translates to:
  /// **'Statistics settings updated successfully'**
  String get statisticsConfigUpdated;

  /// No description provided for @statisticsConfigNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Statistics settings couldn\'t be updated'**
  String get statisticsConfigNotUpdated;

  /// No description provided for @customTimeInHours.
  ///
  /// In en, this message translates to:
  /// **'Custom time (in hours)'**
  String get customTimeInHours;

  /// No description provided for @invalidTime.
  ///
  /// In en, this message translates to:
  /// **'Invalid time'**
  String get invalidTime;

  /// No description provided for @removeDomain.
  ///
  /// In en, this message translates to:
  /// **'Remove domain'**
  String get removeDomain;

  /// No description provided for @addDomain.
  ///
  /// In en, this message translates to:
  /// **'Add domain'**
  String get addDomain;

  /// No description provided for @notLess1Hour.
  ///
  /// In en, this message translates to:
  /// **'Time cannot be less than 1 hour'**
  String get notLess1Hour;

  /// No description provided for @rateLimit.
  ///
  /// In en, this message translates to:
  /// **'Rate limit'**
  String get rateLimit;

  /// No description provided for @subnetPrefixLengthIpv4.
  ///
  /// In en, this message translates to:
  /// **'Subnet prefix length for IPv4'**
  String get subnetPrefixLengthIpv4;

  /// No description provided for @subnetPrefixLengthIpv6.
  ///
  /// In en, this message translates to:
  /// **'Subnet prefix length for IPv6'**
  String get subnetPrefixLengthIpv6;

  /// No description provided for @rateLimitAllowlist.
  ///
  /// In en, this message translates to:
  /// **'Rate limit allowlist'**
  String get rateLimitAllowlist;

  /// No description provided for @rateLimitAllowlistDescription.
  ///
  /// In en, this message translates to:
  /// **'IP addresses excluded from rate limiting'**
  String get rateLimitAllowlistDescription;

  /// No description provided for @dnsOptions.
  ///
  /// In en, this message translates to:
  /// **'DNS options'**
  String get dnsOptions;

  /// No description provided for @editor.
  ///
  /// In en, this message translates to:
  /// **'Editor'**
  String get editor;

  /// No description provided for @editCustomRules.
  ///
  /// In en, this message translates to:
  /// **'Edit custom rules'**
  String get editCustomRules;

  /// No description provided for @savingCustomRules.
  ///
  /// In en, this message translates to:
  /// **'Saving custom rules...'**
  String get savingCustomRules;

  /// No description provided for @customRulesUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Custom rules updated successfully'**
  String get customRulesUpdatedSuccessfully;

  /// No description provided for @customRulesNotUpdated.
  ///
  /// In en, this message translates to:
  /// **'Custom rules could not be updated'**
  String get customRulesNotUpdated;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @showHide.
  ///
  /// In en, this message translates to:
  /// **'Show/hide'**
  String get showHide;

  /// No description provided for @noElementsReorderMessage.
  ///
  /// In en, this message translates to:
  /// **'Enable some elements on the show/hide tab to reorder them here.'**
  String get noElementsReorderMessage;

  /// No description provided for @enablePlainDns.
  ///
  /// In en, this message translates to:
  /// **'Enable plain DNS'**
  String get enablePlainDns;

  /// No description provided for @enablePlainDnsDescription.
  ///
  /// In en, this message translates to:
  /// **'Plain DNS is enabled by default. You can disable it to force all devices to use encrypted DNS. To do this, you must enable at least one encrypted DNS protocol.'**
  String get enablePlainDnsDescription;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @loadingChangelog.
  ///
  /// In en, this message translates to:
  /// **'Loading changelog...'**
  String get loadingChangelog;

  /// No description provided for @invalidIpOrUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid IP address or URL'**
  String get invalidIpOrUrl;

  /// No description provided for @addPersistentClient.
  ///
  /// In en, this message translates to:
  /// **'Add as a persistent client'**
  String get addPersistentClient;

  /// No description provided for @blockThisClientOnly.
  ///
  /// In en, this message translates to:
  /// **'Block for this client only'**
  String get blockThisClientOnly;

  /// No description provided for @unblockThisClientOnly.
  ///
  /// In en, this message translates to:
  /// **'Unblock for this client only'**
  String get unblockThisClientOnly;

  /// No description provided for @domainBlockedThisClient.
  ///
  /// In en, this message translates to:
  /// **'{domain} blocked for this client'**
  String domainBlockedThisClient(Object domain);

  /// No description provided for @domainUnblockedThisClient.
  ///
  /// In en, this message translates to:
  /// **'{domain} unblocked for this client'**
  String domainUnblockedThisClient(Object domain);

  /// No description provided for @disallowThisClient.
  ///
  /// In en, this message translates to:
  /// **'Disallow this client'**
  String get disallowThisClient;

  /// No description provided for @allowThisClient.
  ///
  /// In en, this message translates to:
  /// **'Allow this client'**
  String get allowThisClient;

  /// No description provided for @clientAllowedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client allowed successfully'**
  String get clientAllowedSuccessfully;

  /// No description provided for @clientDisallowedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Client disallowed successfully'**
  String get clientDisallowedSuccessfully;

  /// No description provided for @changesNotSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes could not be saved'**
  String get changesNotSaved;

  /// No description provided for @allowingClient.
  ///
  /// In en, this message translates to:
  /// **'Allowing client...'**
  String get allowingClient;

  /// No description provided for @disallowingClient.
  ///
  /// In en, this message translates to:
  /// **'Disallowing client...'**
  String get disallowingClient;

  /// No description provided for @clientIpCopied.
  ///
  /// In en, this message translates to:
  /// **'Client IP copied to the clipboard'**
  String get clientIpCopied;

  /// No description provided for @clientNameCopied.
  ///
  /// In en, this message translates to:
  /// **'Client name copied to the clipboard'**
  String get clientNameCopied;

  /// No description provided for @dnsServerAddressCopied.
  ///
  /// In en, this message translates to:
  /// **'DNS server address copied to the clipboard'**
  String get dnsServerAddressCopied;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @liveLogs.
  ///
  /// In en, this message translates to:
  /// **'Live logs'**
  String get liveLogs;

  /// No description provided for @hereWillAppearRealtimeLogs.
  ///
  /// In en, this message translates to:
  /// **'Here there will appear the logs on realtime.'**
  String get hereWillAppearRealtimeLogs;

  /// No description provided for @applicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Application details'**
  String get applicationDetails;

  /// No description provided for @applicationDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'App repository, stores where it\'s available, and more'**
  String get applicationDetailsDescription;

  /// No description provided for @myOtherApps.
  ///
  /// In en, this message translates to:
  /// **'My other apps'**
  String get myOtherApps;

  /// No description provided for @myOtherAppsDescription.
  ///
  /// In en, this message translates to:
  /// **'Check my other apps, make a donation, contact support, and more'**
  String get myOtherAppsDescription;

  /// No description provided for @topToBottom.
  ///
  /// In en, this message translates to:
  /// **'From top to bottom'**
  String get topToBottom;

  /// No description provided for @bottomToTop.
  ///
  /// In en, this message translates to:
  /// **'From bottom to top'**
  String get bottomToTop;

  /// No description provided for @upstreamTimeout.
  ///
  /// In en, this message translates to:
  /// **'Upstream timeout'**
  String get upstreamTimeout;

  /// No description provided for @upstreamTimeoutHelper.
  ///
  /// In en, this message translates to:
  /// **'Specifies the number of seconds to wait for a response from the upstream server'**
  String get upstreamTimeoutHelper;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @dnsRewriteRuleEnabled.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule enabled successfully'**
  String get dnsRewriteRuleEnabled;

  /// No description provided for @dnsRewriteRuleDisabled.
  ///
  /// In en, this message translates to:
  /// **'DNS rewrite rule disabled successfully'**
  String get dnsRewriteRuleDisabled;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'es',
        'pl',
        'ru',
        'tr',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pl':
      return AppLocalizationsPl();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
