import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle systemUiOverlayStyleConfig(BuildContext context) => SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Theme.of(context).brightness == Brightness.light
    ? Brightness.light
    : Brightness.dark,
  statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
    ? Brightness.dark
    : Brightness.light,
  systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
  systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light
    ? Brightness.dark
    : Brightness.light,
);