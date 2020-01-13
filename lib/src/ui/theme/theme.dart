import 'package:flutter/material.dart';
import 'package:jobber/src/ui/theme/color.dart';
import 'package:jobber/src/ui/theme/text.dart';

ThemeData buildTheme() {

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: colorScheme.primary,
    accentColor: colorScheme.secondary,
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: buildTextTheme(),
  );
  
}
