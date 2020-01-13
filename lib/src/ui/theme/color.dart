
import 'package:flutter/material.dart';

class GlobalColors {

  static const int _primaryColorValue = 0xff002f49;
  static const MaterialColor primaryColor = MaterialColor(
    _secondaryColorValue, 
    <int, Color> {
      50: Color(0xffdbf0ff),
      100: Color(0xffb7d9f4),
	    200: Color(0xff9abddd),
	    300: Color(0xff79a1c4),
	    400: Color(0xff608db2),
	    500: Color(0xff4579a0),
	    600: Color(0xff376a8e),
	    700: Color(0xff275777),
	    800: Color(0xff184461),
	    900: Color(_primaryColorValue),
    }
  );

  static const int _secondaryColorValue = 0xffff715b;
  static const MaterialColor secondaryColor = MaterialColor(
    _secondaryColorValue, 
    <int, Color> {
      50: Color(0xfff9eae9),
      100: Color(0xfffdcdc3),
	    200: Color(0xfffdac9d),
	    300: Color(0xfffe8b77),
	    400: Color(_secondaryColorValue),
	    500: Color(0xffff5742),
	    600: Color(0xfff5513e),
	    700: Color(0xffe74b38),
	    800: Color(0xffd84534),
	    900: Color(0xffbe392b),
    }
  );

  static const Color white38 = Color(0x62FFFFFF);
}



final colorScheme = ColorScheme(

  brightness: Brightness.dark,

  primary: GlobalColors.primaryColor[800],
  primaryVariant: GlobalColors.primaryColor[900],
  
  secondary: GlobalColors.secondaryColor,
  secondaryVariant: GlobalColors.secondaryColor[500],

  background: GlobalColors.primaryColor[900],
  surface: GlobalColors.primaryColor[800],
  error: Colors.redAccent,

  onPrimary: Colors.white,
  onSecondary: Colors.black87,
  onBackground: Colors.white,
  onSurface: Colors.white,
  onError: Colors.black87,
);

