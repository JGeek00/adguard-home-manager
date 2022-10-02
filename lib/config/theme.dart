import 'package:flutter/material.dart';

Map<int, Color> swatch = {
  50: const Color.fromRGBO(25, 180, 119, .1),
  100: const Color.fromRGBO(25, 180, 119, .2),
  200: const Color.fromRGBO(25, 180, 119, .3),
  300: const Color.fromRGBO(25, 180, 119, .4),
  400: const Color.fromRGBO(25, 180, 119, .5),
  500: const Color.fromRGBO(25, 180, 119, .6),
  600: const Color.fromRGBO(25, 180, 119, .7),
  700: const Color.fromRGBO(25, 180, 119, .8),
  800: const Color.fromRGBO(25, 180, 119, .9),
  900: const Color.fromRGBO(25, 180, 119, 1),
};

MaterialColor primaryColor = MaterialColor(0xff19b477, swatch);

ThemeData lightTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme ?? ColorScheme.fromSwatch(primarySwatch: primaryColor),
  primaryColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
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
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
      ),
      overlayColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary.withOpacity(0.1) : primaryColor.withOpacity(0.1)
      ),
    ),
  ),
  dividerColor: Colors.black12,
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.black,
    labelColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
        width: 2
      )
    )
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
    ),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
);

ThemeData darkTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme ?? ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(
    brightness: Brightness.dark
  ),
  primaryColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
  scaffoldBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.background :const Color.fromRGBO(18, 18, 18, 1),
  dialogBackgroundColor: dynamicColorScheme != null ? dynamicColorScheme.background : const Color.fromRGBO(44, 44, 44, 1),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
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
    foregroundColor: Colors.white,
    backgroundColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
      ),
      overlayColor: MaterialStateProperty.all(
        dynamicColorScheme != null ? dynamicColorScheme.primary.withOpacity(0.1) : primaryColor.withOpacity(0.1)
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
    listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.white,
    labelColor: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor,
        width: 2
      )
    )
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(
      dynamicColorScheme != null ? dynamicColorScheme.primary : primaryColor
    ),
  ),
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch
);

ThemeData lightThemeOldVersions() => ThemeData(
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
    tileColor: Colors.transparent
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(primaryColor),
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

ThemeData darkThemeOldVersions() => ThemeData(
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
    listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(Colors.blue),
  ),
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