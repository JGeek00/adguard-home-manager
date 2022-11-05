import 'package:flutter/material.dart';

import 'package:adguard_home_manager/constants/adguard_green_color.dart';

ThemeData lightTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme ?? ColorScheme.fromSwatch(primarySwatch: adguardGreenColor),
  primaryColor: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
  scaffoldBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.background : Colors.white,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  brightness: Brightness.light,
  dialogBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.surface : Colors.white,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black54
    ),
    bodyText2: TextStyle(
      color: Colors.black
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: dynamicColorScheme != null ? dynamicColorScheme.secondaryContainer : adguardGreenColor,
    iconTheme: MaterialStateProperty.all(
      IconThemeData(
        color: dynamicColorScheme != null ? dynamicColorScheme.onSecondaryContainer : adguardGreenColor,
      )
    )
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: dynamicColorScheme != null ? dynamicColorScheme.onPrimaryContainer : Colors.white,
    backgroundColor: dynamicColorScheme != null ? dynamicColorScheme.primaryContainer : adguardGreenColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor
      ),
      overlayColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary.withOpacity(0.1) : adguardGreenColor.withOpacity(0.1)
      ),
    ),
  ),
  dividerColor: Colors.black12,
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.black,
    labelColor: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
        width: 2
      )
    )
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor
    ),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
);

ThemeData darkTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme ?? ColorScheme.fromSwatch(primarySwatch: adguardGreenColor).copyWith(
    brightness: Brightness.dark
  ),
  primaryColor: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
  scaffoldBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.background :const Color.fromRGBO(18, 18, 18, 1),
  dialogBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.background : const Color.fromRGBO(44, 44, 44, 1),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: dynamicColorScheme != null ? dynamicColorScheme.secondaryContainer : adguardGreenColor,
    iconTheme: MaterialStateProperty.all(
      IconThemeData(
        color: dynamicColorScheme != null ? dynamicColorScheme.onSecondaryContainer : adguardGreenColor,
      )
    )
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: const TextStyle(
      color: Colors.white
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: dynamicColorScheme != null ? dynamicColorScheme.onPrimaryContainer : Colors.white,
    backgroundColor: dynamicColorScheme != null ? dynamicColorScheme.primaryContainer : adguardGreenColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor
      ),
      overlayColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary.withOpacity(0.1) : adguardGreenColor.withOpacity(0.1)
      ),
    ),
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white70
    ),
    bodyText2: TextStyle(
      color: Colors.white
    ),
  ),
  dividerColor: Colors.white12,
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.onPrimary : Colors.white
    ),
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.onSurface : adguardGreenColor
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.white,
    labelColor: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor,
        width: 2
      )
    )
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : adguardGreenColor
    ),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
);

ThemeData lightThemeOldVersions(MaterialColor primaryColor) => ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    surfaceTintColor: primaryColor
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black54
    ),
    bodyText2: TextStyle(
      color: Colors.black
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.1))
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      surfaceTintColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(primaryColor.shade50),
    )
  ),
  cardTheme: CardTheme(
    surfaceTintColor: primaryColor
  ),
  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: primaryColor,
    indicatorColor: primaryColor
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(
      color: primaryColor
    ),
    iconColor: Colors.grey,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: primaryColor,
        width: 2
      )
    )
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor
  ),
  dividerColor: Colors.black12,
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(117, 117, 117, 1),
    iconColor: Color.fromRGBO(117, 117, 117, 1),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor:  MaterialStateProperty.all(primaryColor),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.black,
    labelColor: primaryColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2
      )
    )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor
  ),
  indicatorColor: primaryColor,
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
);

ThemeData darkThemeOldVersions(MaterialColor primaryColor) => ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: primaryColor,
    surfaceTintColor: primaryColor
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30)
    )
  ),
  appBarTheme: AppBarTheme(
    color: const Color.fromRGBO(18, 18, 18, 1),
    foregroundColor: Colors.white,
    elevation: 0,
    surfaceTintColor: primaryColor
  ),
  dialogBackgroundColor: const Color.fromRGBO(44, 44, 44, 1),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: const TextStyle(
      color: Colors.white
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.1))
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryColor),
      surfaceTintColor: MaterialStateProperty.all(primaryColor),
      overlayColor: MaterialStateProperty.all(primaryColor.shade50),
    )
  ),
  cardTheme: CardTheme(
    surfaceTintColor: primaryColor
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: TextStyle(
      color: primaryColor
    ),
    iconColor: Colors.grey,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: primaryColor,
      )
    )
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(187, 187, 187, 1),
    iconColor: Color.fromRGBO(187, 187, 187, 1),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: primaryColor
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white70
    ),
    bodyText2: TextStyle(
      color: Colors.white
    ),
  ),
  dividerColor: Colors.white12,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.white,
    labelColor: primaryColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2
      )
    )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor
  ),
  indicatorColor: primaryColor,
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
);