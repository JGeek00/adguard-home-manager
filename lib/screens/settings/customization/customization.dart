import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/customization/color_item.dart';
import 'package:adguard_home_manager/screens/settings/customization/theme_mode_button.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/functions/generate_color_translation.dart';
import 'package:adguard_home_manager/functions/desktop_mode.dart';
import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/colors.dart';

class Customization extends StatelessWidget {
  const Customization({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    return CustomizationWidget(
      appConfigProvider: appConfigProvider
    );
  }
}

class CustomizationWidget extends StatefulWidget {
  final AppConfigProvider appConfigProvider;

  const CustomizationWidget({
    super.key,
    required this.appConfigProvider,
  });

  @override
  State<CustomizationWidget> createState() => _CustomizationWidgetState();
}

class _CustomizationWidgetState extends State<CustomizationWidget> {
  int selectedTheme = 0;
  bool dynamicColor = true;
  int selectedColor = 0;
  bool useThemeColorInsteadGreenRed = false;

  final _colorsScrollController = ScrollController();

  @override
  void initState() {
    selectedTheme = widget.appConfigProvider.selectedThemeNumber;
    dynamicColor = widget.appConfigProvider.useDynamicColor;
    selectedColor = widget.appConfigProvider.staticColor;
    useThemeColorInsteadGreenRed = widget.appConfigProvider.useThemeColorForStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appConfigProvider = Provider.of<AppConfigProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.customization),
        centerTitle: false,
        surfaceTintColor: isDesktop(width) ? Colors.transparent : null,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SectionLabel(
              label: AppLocalizations.of(context)!.theme,
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
            ),
            Column(
              children: [
                CustomSwitchListTile(
                  value: selectedTheme == 0 ? true : false, 
                  onChanged: (value) {
                    selectedTheme = value == true ? 0 : 1;
                    appConfigProvider.setSelectedTheme(value == true ? 0 : 1);
                  },
                  title: AppLocalizations.of(context)!.systemDefined, 
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThemeModeButton(
                      icon: Icons.light_mode, 
                      value: 1, 
                      selected: selectedTheme, 
                      label: AppLocalizations.of(context)!.light, 
                      onChanged: (value) {
                        selectedTheme = value;
                        appConfigProvider.setSelectedTheme(value);
                      },
                      disabled: selectedTheme == 0 ? true : false,
                    ),
                    ThemeModeButton(
                      icon: Icons.dark_mode, 
                      value: 2, 
                      selected: selectedTheme, 
                      label: AppLocalizations.of(context)!.dark, 
                      onChanged: (value) {
                        selectedTheme = value;
                        appConfigProvider.setSelectedTheme(value);
                      },
                      disabled: selectedTheme == 0 ? true : false,
                    ),
                  ],
                ),
              ],
            ),
            SectionLabel(
              label: AppLocalizations.of(context)!.color,
              padding: const EdgeInsets.only(top: 45, left: 16, right: 16, bottom: 5),
            ),
            if (appConfigProvider.supportsDynamicTheme) CustomSwitchListTile(
              value: dynamicColor, 
              onChanged: (value) {
                setState(() => dynamicColor = value);
                appConfigProvider.setUseDynamicColor(value);
              }, 
              title: AppLocalizations.of(context)!.useDynamicTheme, 
            ),
            if (!(appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt >= 31)) const SizedBox(height: 20),
            if (
              appConfigProvider.supportsDynamicTheme == false || 
              (appConfigProvider.supportsDynamicTheme == true && dynamicColor == false)
            ) Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              child: Scrollbar(
                controller: _colorsScrollController,
                thumbVisibility: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
                interactive: Platform.isMacOS || Platform.isLinux || Platform.isWindows,
                thickness: Platform.isMacOS || Platform.isLinux || Platform.isWindows ? 8 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        child: ListView.builder(
                          controller: _colorsScrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: colors.length,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Row(
                                children: [
                                  ColorItem(
                                    index: index,
                                    total: colors.length,
                                    color: colors[index], 
                                    numericValue: index, 
                                    selectedValue: selectedColor,
                                    onChanged: (value) {
                                      setState(() => selectedColor = value);
                                      appConfigProvider.setStaticColor(value);
                                    }
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    width: 1,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(1)
                                    ),
                                  )
                                ],
                              );
                            }
                            else {
                              return ColorItem(
                                index: index,
                                total: colors.length,
                                color: colors[index], 
                                numericValue: index, 
                                selectedValue: selectedColor,
                                onChanged: (value) {
                                  setState(() => selectedColor = value);
                                  appConfigProvider.setStaticColor(value);
                                }
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          colorTranslation(context, selectedColor),
                          style: TextStyle(
                            color: Theme.of(context).listTileTheme.iconColor,
                            fontSize: 16
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}