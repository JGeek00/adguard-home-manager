import 'package:flutter/material.dart';

ThemeData lightTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  brightness: Brightness.light,  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
  ),
  popupMenuTheme: PopupMenuThemeData(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  cardTheme: CardTheme(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  dialogTheme: DialogTheme(
    backgroundColor: dynamicColorScheme?.surfaceContainerHigh
  ),
  // DISABLE PREDICTIVE BACK GESTURE
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder()
  //   }
  // )
);

ThemeData darkTheme(ColorScheme? dynamicColorScheme) => ThemeData(
  useMaterial3: true,
  colorScheme: dynamicColorScheme,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  brightness: Brightness.dark, 
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
  ),
  popupMenuTheme: PopupMenuThemeData(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  navigationBarTheme: NavigationBarThemeData(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  cardTheme: CardTheme(
    surfaceTintColor: dynamicColorScheme?.surfaceTint
  ),
  dialogTheme: DialogTheme(
    backgroundColor: dynamicColorScheme?.surfaceContainerHigh
  ),
  // DISABLE PREDICTIVE BACK GESTURE
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder()
  //   }
  // )
);

ThemeData lightThemeOldVersions(MaterialColor primaryColor) => ThemeData(
  useMaterial3: true,
  colorSchemeSeed: primaryColor,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    elevation: 4,
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(117, 117, 117, 1),
    iconColor: Color.fromRGBO(117, 117, 117, 1),
  ),
  brightness: Brightness.light,
  // DISABLE PREDICTIVE BACK GESTURE
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder()
  //   }
  // )
);

ThemeData darkThemeOldVersions(MaterialColor primaryColor) => ThemeData(
  useMaterial3: true,
  colorSchemeSeed: primaryColor,
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
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(187, 187, 187, 1),
    iconColor: Color.fromRGBO(187, 187, 187, 1),
  ),
  brightness: Brightness.dark,
  // DISABLE PREDICTIVE BACK GESTURE
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder()
  //   }
  // )
);