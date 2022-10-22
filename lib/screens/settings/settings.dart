import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/theme_modal.dart';
import 'package:adguard_home_manager/screens/settings/server_info/server_info.dart';
import 'package:adguard_home_manager/screens/settings/encryption/encryption.dart';
import 'package:adguard_home_manager/screens/settings/access_settings/access_settings.dart';
import 'package:adguard_home_manager/screens/settings/dhcp/dhcp.dart';
import 'package:adguard_home_manager/screens/settings/section_label.dart';
import 'package:adguard_home_manager/screens/settings/dns/dns.dart';
import 'package:adguard_home_manager/screens/settings/dns_rewrites/dns_rewrites.dart';
import 'package:adguard_home_manager/screens/settings/appbar.dart';
import 'package:adguard_home_manager/screens/servers/servers.dart';
import 'package:adguard_home_manager/screens/settings/advanced_setings.dart';
import 'package:adguard_home_manager/screens/settings/general_settings.dart';

import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/strings.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final serversProvider = Provider.of<ServersProvider>(context);

    final statusBarHeight = MediaQuery.of(context).viewInsets.top;

    String getThemeString() {
      switch (appConfigProvider.selectedThemeNumber) {
        case 0:
          return AppLocalizations.of(context)!.systemDefined;

        case 1:
          return AppLocalizations.of(context)!.light;

        case 2:
          return AppLocalizations.of(context)!.dark;

        default:
          return "";
      }
    }

    void openThemeModal() {
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => ThemeModal(
          statusBarHeight: statusBarHeight,
          selectedTheme: appConfigProvider.selectedThemeNumber,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    void navigateServers() {
      Future.delayed(const Duration(milliseconds: 0), (() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Servers())
        );
      }));
    }

    void openWeb(String url) {
      FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: const CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: false,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        )
      );
    }    

    return Scaffold(
      appBar: const SettingsAppBar(),
      body: ListView(
        children: [
          if (serversProvider.selectedServer != null) ...[
            SectionLabel(label: AppLocalizations.of(context)!.serverSettings),
            CustomListTile(
              icon: Icons.lock_rounded,
              title: AppLocalizations.of(context)!.accessSettings,
              subtitle: AppLocalizations.of(context)!.accessSettingsDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AccessSettings()
                  )
                )
              },
            ),
            CustomListTile(
              icon: Icons.install_desktop_rounded,
              title: AppLocalizations.of(context)!.dhcpSettings,
              subtitle: AppLocalizations.of(context)!.dhcpSettingsDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Dhcp()
                  )
                )
              },
            ),
            CustomListTile(
              icon: Icons.dns_rounded,
              title: AppLocalizations.of(context)!.dnsSettings,
              subtitle: AppLocalizations.of(context)!.dnsSettingsDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DnsSettings()
                  )
                )
              },
            ),
            CustomListTile(
              icon: Icons.security_rounded,
              title: AppLocalizations.of(context)!.encryptionSettings,
              subtitle: AppLocalizations.of(context)!.encryptionSettingsDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EncryptionSettings()
                  )
                )
              },
            ),
            CustomListTile(
              icon: Icons.route_rounded,
              title: AppLocalizations.of(context)!.dnsRewrites,
              subtitle: AppLocalizations.of(context)!.dnsRewritesDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DnsRewrites()
                  )
                )
              },
            ),
            CustomListTile(
              icon: Icons.info_rounded,
              title: AppLocalizations.of(context)!.serverInformation,
              subtitle: AppLocalizations.of(context)!.serverInformationDescription,
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ServerInformation()
                  )
                )
              },
            ),
          ],
          SectionLabel(label: AppLocalizations.of(context)!.appSettings),
          CustomListTile(
            icon: Icons.light_mode_rounded,
            title: AppLocalizations.of(context)!.theme, 
            subtitle: getThemeString(),
            onTap: openThemeModal,
          ),
          CustomListTile(
            icon: Icons.storage_rounded,
            title: AppLocalizations.of(context)!.servers,
            subtitle: serversProvider.selectedServer != null
              ? serversProvider.serverStatus.data != null
                ? "${AppLocalizations.of(context)!.connectedTo} ${serversProvider.selectedServer!.name}"
                : "${AppLocalizations.of(context)!.selectedServer} ${serversProvider.selectedServer!.name}"
              : AppLocalizations.of(context)!.noServerSelected,
            onTap: navigateServers,
          ),
          CustomListTile(
            icon: Icons.settings,
            title: AppLocalizations.of(context)!.generalSettings,
            subtitle: AppLocalizations.of(context)!.generalSettingsDescription,
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GeneralSettings()
                )
              )
            },
          ),
          CustomListTile(
            icon: Icons.build_outlined,
            title: AppLocalizations.of(context)!.advancedSettings,
            subtitle: AppLocalizations.of(context)!.advancedSetupDescription,
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdvancedSettings()
                )
              )
            },
          ),
          SectionLabel(label: AppLocalizations.of(context)!.aboutApp),
          CustomListTile(
            title: AppLocalizations.of(context)!.appVersion, 
            subtitle: appConfigProvider.getAppInfo!.version,
          ),
          CustomListTile(
            title: AppLocalizations.of(context)!.createdBy, 
            subtitle: Strings.createdBy,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => openWeb(Urls.playStore), 
                  icon: SvgPicture.asset(
                    'assets/resources/google-play.svg',
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: AppLocalizations.of(context)!.visitGooglePlay,
                ),
                IconButton(
                  onPressed: () => openWeb(Urls.gitHub), 
                  icon: SvgPicture.asset(
                    'assets/resources/github.svg',
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: AppLocalizations.of(context)!.gitHub,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}