import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? ThemeData(
            fontFamily: 'Alkatra',
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
                elevation: 0.0,
                color: Colors.black,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Alkatra',
                    fontWeight: FontWeight.w600,
                    color: Colors.white)))
        : ThemeData(
            fontFamily: 'Alkatra',
            primaryColor: Colors.white,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0.0,
                color: Colors.white,
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Alkatra',
                    fontWeight: FontWeight.w600,
                    color: Colors.black)));
  }
}
