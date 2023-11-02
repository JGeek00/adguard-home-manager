import 'package:flutter/material.dart';

final baseTheme = ThemeData(
  useMaterial3: true,
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
);

ThemeData lightTheme(ColorScheme? dynamicColorScheme) => baseTheme.copyWith(
  colorScheme: dynamicColorScheme,
  brightness: Brightness.light,  
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(117, 117, 117, 1),
  ),
);

ThemeData darkTheme(ColorScheme? dynamicColorScheme) => baseTheme.copyWith(
  colorScheme: dynamicColorScheme,
  brightness: Brightness.dark, 
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
    iconColor: dynamicColorScheme != null ? dynamicColorScheme.onSurfaceVariant : const Color.fromRGBO(187, 187, 187, 1),
  ),
);

ThemeData lightThemeOldVersions(MaterialColor primaryColor) => baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(117, 117, 117, 1),
    iconColor: Color.fromRGBO(117, 117, 117, 1),
  ),
  brightness: Brightness.light,
);

ThemeData darkThemeOldVersions(MaterialColor primaryColor) => baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
    textColor: Color.fromRGBO(187, 187, 187, 1),
    iconColor: Color.fromRGBO(187, 187, 187, 1),
  ),
  brightness: Brightness.dark,
);