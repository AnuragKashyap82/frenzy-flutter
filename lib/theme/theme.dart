import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(color: Colors.blue,),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Colors.blue,

      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    fontFamily: "SegSemiBold",
    floatingActionButtonTheme:
    FloatingActionButtonThemeData (backgroundColor: Colors.blue,focusColor: Colors.blueAccent , splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),

  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    backgroundColor: Colors.black54,
    fontFamily: "SegSemiBold",
    textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.grey),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}