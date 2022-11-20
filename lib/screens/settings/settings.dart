import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/custom_settings_tile.dart';

import 'package:adguard_home_manager/widgets/section_label.dart';
import 'package:adguard_home_manager/widgets/custom_list_tile.dart';

import 'package:adguard_home_manager/constants/strings.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/constants/settings_screens.dart';
import 'package:adguard_home_manager/providers/servers_provider.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int? selectedScreen;

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);
    final serversProvider = Provider.of<ServersProvider>(context);

    final width = MediaQuery.of(context).size.width;

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

    void navigateScreen(int screen) {
      if (width < 700) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => settingsScreens[screen]
          )
        );
      }
      else {
        setState(() => selectedScreen = screen);
      }
    }

    Widget body = ListView(
      padding: const EdgeInsets.only(top: 0),
      children: [
        if (serversProvider.selectedServer != null) ...[
          SectionLabel(label: AppLocalizations.of(context)!.serverSettings),
          CustomSettingsTile(
            icon: Icons.lock_rounded,
            title: AppLocalizations.of(context)!.accessSettings,
            subtitle: AppLocalizations.of(context)!.accessSettingsDescription,
            onTap: () => navigateScreen(0),
            thisItem: 0,
            selectedItem: selectedScreen,
          ),
          CustomSettingsTile(
            icon: Icons.install_desktop_rounded,
            title: AppLocalizations.of(context)!.dhcpSettings,
            subtitle: AppLocalizations.of(context)!.dhcpSettingsDescription,
            onTap: () => navigateScreen(1),
            thisItem: 1,
            selectedItem: selectedScreen,
          ),
          CustomSettingsTile(
            icon: Icons.dns_rounded,
            title: AppLocalizations.of(context)!.dnsSettings,
            subtitle: AppLocalizations.of(context)!.dnsSettingsDescription,
            onTap: () => navigateScreen(2),
            thisItem: 2,
            selectedItem: selectedScreen,
          ),
          CustomSettingsTile(
            icon: Icons.security_rounded,
            title: AppLocalizations.of(context)!.encryptionSettings,
            subtitle: AppLocalizations.of(context)!.encryptionSettingsDescription,
            onTap: () => navigateScreen(3),
            thisItem: 3,
            selectedItem: selectedScreen,
          ),
          CustomSettingsTile(
            icon: Icons.route_rounded,
            title: AppLocalizations.of(context)!.dnsRewrites,
            subtitle: AppLocalizations.of(context)!.dnsRewritesDescription,
            onTap: () => navigateScreen(4),
            thisItem: 4,
            selectedItem: selectedScreen,
          ),
          CustomSettingsTile(
            icon: Icons.info_rounded,
            title: AppLocalizations.of(context)!.serverInformation,
            subtitle: AppLocalizations.of(context)!.serverInformationDescription,
            onTap: () => navigateScreen(5),
            thisItem: 5,
            selectedItem: selectedScreen,
          ),
        ],
        SectionLabel(label: AppLocalizations.of(context)!.appSettings),
        CustomSettingsTile(
          icon: Icons.palette_rounded,
          title: AppLocalizations.of(context)!.customization, 
          subtitle: AppLocalizations.of(context)!.customizationDescription,
          onTap: () => navigateScreen(6),
          thisItem: 6,
          selectedItem: selectedScreen,
        ),
        CustomSettingsTile(
          icon: Icons.storage_rounded,
          title: AppLocalizations.of(context)!.servers,
          subtitle: serversProvider.selectedServer != null
            ? serversProvider.serverStatus.data != null
              ? "${AppLocalizations.of(context)!.connectedTo} ${serversProvider.selectedServer!.name}"
              : "${AppLocalizations.of(context)!.selectedServer} ${serversProvider.selectedServer!.name}"
            : AppLocalizations.of(context)!.noServerSelected,
          onTap: () => navigateScreen(7),
          thisItem: 7,
          selectedItem: selectedScreen,
        ),
        CustomSettingsTile(
          icon: Icons.settings,
          title: AppLocalizations.of(context)!.generalSettings,
          subtitle: AppLocalizations.of(context)!.generalSettingsDescription,
          onTap: () => navigateScreen(8),
          thisItem: 8,
          selectedItem: selectedScreen,
        ),
        CustomSettingsTile(
          icon: Icons.build_outlined,
          title: AppLocalizations.of(context)!.advancedSettings,
          subtitle: AppLocalizations.of(context)!.advancedSetupDescription,
          onTap: () => navigateScreen(9),
          thisItem: 9,
          selectedItem: selectedScreen,
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
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  width: 30,
                  height: 30,
                ),
                tooltip: AppLocalizations.of(context)!.visitGooglePlay,
              ),
              IconButton(
                onPressed: () => openWeb(Urls.gitHub), 
                icon: SvgPicture.asset(
                  'assets/resources/github.svg',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  width: 30,
                  height: 30,
                ),
                tooltip: AppLocalizations.of(context)!.gitHub,
              ),
            ],
          ),
        )
      ],
    );

    if (width < 700) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar.large(
              title: Text(AppLocalizations.of(context)!.settings),
            ),
          ],
          body: body,
        ),
      );
    }
    else {
      return Material(
        color: Theme.of(context).colorScheme.background,
        child:  Row(
          children: [
            SizedBox(
              width: width*0.4,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverSafeArea(
                      top: false,
                      sliver: SliverAppBar.large(
                        title: Text(AppLocalizations.of(context)!.settings),
                      )
                    ),
                  )
                ],
                body: body,
              ),
            ),
            Container(
              width: (width*0.6)-3,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).dividerColor
                  )
                )
              ),
              child: selectedScreen != null
                ? settingsScreens[selectedScreen!]
                : null
            )
          ],
        )
      );
    }  
  }
}