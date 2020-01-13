import 'package:flutter/material.dart';

class GlobalTextStyle {
  static const h1 = TextStyle(
    color: Colors.black,
    fontSize: 96,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
  );

  static const h2 = TextStyle(
    color: Colors.white,
    fontSize: 60,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
  );
  static const h3 = TextStyle(
    color: Colors.white,
    fontSize: 48,
    fontFamily: 'Roboto',
  );
  static const h4 = TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontFamily: 'Roboto',
  );
  static const h5 = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Roboto',
  );
  static const h6 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const body1 = TextStyle(
    color: Color(0xb2ffffff),
    fontSize: 18,
    fontFamily: 'Roboto',
  );

  static const body2 = TextStyle(
    color: Color(0xb2ffffff),
    fontFamily: 'Roboto',
  );

  static const subtitle1 = TextStyle(
    color: Color(0xb2ffffff),
    fontSize: 16,
    fontFamily: 'Roboto',
  );

  static const subtitle2 = TextStyle(
    color: Color(0xb2ffffff),
    fontFamily: 'Roboto',
  );

  static const button = TextStyle(
    color: Color(0xff6202ee),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const smallButton = TextStyle(
    color: Color(0xff6202ee),
    fontSize: 10,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const caption = TextStyle(
    color: Color(0xb2ffffff),
    fontSize: 12,
    fontFamily: 'Roboto',
  );

  static const overline = TextStyle(
    color: Color(0xb2ffffff),
    fontSize: 10,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
}


TextTheme buildTextTheme() {
  return TextTheme(
    display4: GlobalTextStyle.h1,
    display3: GlobalTextStyle.h2,
    display2: GlobalTextStyle.h3,
    display1: GlobalTextStyle.h4,
    headline: GlobalTextStyle.h5,
    title: GlobalTextStyle.h6,
    subhead: GlobalTextStyle.subtitle1,
    body2: GlobalTextStyle.body1,
    body1: GlobalTextStyle.body2,
    caption: GlobalTextStyle.caption,
    button: GlobalTextStyle.button,
    subtitle: GlobalTextStyle.subtitle2,
    overline: GlobalTextStyle.overline,
  );
}
