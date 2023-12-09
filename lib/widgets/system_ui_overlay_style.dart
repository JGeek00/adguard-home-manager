import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverlayStyle extends StatelessWidget {
  final Widget child;

  const OverlayStyle({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final systemGestureInsets = MediaQuery.of(context).systemGestureInsets;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.light
          : Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
        systemNavigationBarColor: systemGestureInsets.left > 0  // If true gestures navigation
          ? Colors.transparent
          : ElevationOverlay.applySurfaceTint(
              Theme.of(context).colorScheme.surface, 
              Theme.of(context).colorScheme.surfaceTint, 
              3
            ),
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      ),
      child: child,
    );
  }
}