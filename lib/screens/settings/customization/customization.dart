import 'package:adguard_home_manager/functions/generate_color_translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adguard_home_manager/screens/settings/customization/color_item.dart';
import 'package:adguard_home_manager/screens/settings/customization/theme_mode_button.dart';

import 'package:adguard_home_manager/widgets/custom_switch_list_tile.dart';
import 'package:adguard_home_manager/widgets/section_label.dart';

import 'package:adguard_home_manager/providers/app_config_provider.dart';
import 'package:adguard_home_manager/constants/colors.dart';

class Customization extends StatelessWidget {
  const Customization({Key? key}) : super(key: key);

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
    Key? key,
    required this.appConfigProvider,
  }) : super(key: key);

  @override
  State<CustomizationWidget> createState() => _CustomizationWidgetState();
}

class _CustomizationWidgetState extends State<CustomizationWidget> {
  int selectedTheme = 0;
  bool dynamicColor = true;
  int selectedColor = 0;
  bool useThemeColorInsteadGreenRed = false;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.customization),
      ),
      body: ListView(
        children: [
          SectionLabel(
            label: AppLocalizations.of(context)!.theme,
            padding: const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 5),
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
            padding: const EdgeInsets.only(top: 45, left: 25, right: 25, bottom: 5),
          ),
          if (appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt! >= 31) CustomSwitchListTile(
            value: dynamicColor, 
            onChanged: (value) {
              setState(() => dynamicColor = value);
              appConfigProvider.setUseDynamicColor(value);
            }, 
            title: AppLocalizations.of(context)!.useDynamicTheme, 
          ),
          if (!(appConfigProvider.androidDeviceInfo != null && appConfigProvider.androidDeviceInfo!.version.sdkInt! >= 31)) const SizedBox(height: 20),
          if (dynamicColor == false) ...[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Row(
                      children: [
                        const SizedBox(width: 15),
                        ColorItem(
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
                  else if (index == colors.length-1) {
                    return Row(
                      children: [
                        ColorItem(
                          color: colors[index], 
                          numericValue: index, 
                          selectedValue: selectedColor,
                          onChanged: (value) {
                            setState(() => selectedColor = value);
                            appConfigProvider.setStaticColor(value);
                          }
                        ),
                        const SizedBox(width: 15)
                      ],
                    );
                  }
                  else {
                    return ColorItem(
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
              padding: const EdgeInsets.only(
                left: 25,
                top: 10
              ),
              child: Text(
                colorTranslation(context, selectedColor),
                style: TextStyle(
                  color: Theme.of(context).listTileTheme.iconColor,
                  fontSize: 16
                ),
              ),
            )
          ],
          CustomSwitchListTile(
            value: useThemeColorInsteadGreenRed, 
            onChanged: (value) {
              setState(() => useThemeColorInsteadGreenRed = value);
              appConfigProvider.setUseThemeColorForStatus(value);
            }, 
            title: AppLocalizations.of(context)!.useThemeColorStatus,
            subtitle: AppLocalizations.of(context)!.useThemeColorStatusDescription,
          )
        ],
      ),
    );
  }
}