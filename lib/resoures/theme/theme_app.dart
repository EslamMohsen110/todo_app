import 'package:flutter/material.dart';

import '../color/color_app.dart';

class ThemeApp {
  static final ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: ColorApp.cPrimaryLightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        sizeConstraints: BoxConstraints.tight(const Size.fromRadius(33))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorApp.cPrimaryColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedIconTheme: IconThemeData(size: 25),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorApp.cPrimaryColor,
      titleTextStyle: TextStyle(
        color: ColorApp.cWhiteColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: ColorApp.cBlackColor,
        fontSize: 22,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: ColorApp.cPrimaryColor,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        color: ColorApp.cBlackColor,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
          color: ColorApp.cBlackColor, fontSize: 18, fontFamily: 'Inter'),
      titleSmall: TextStyle(
        color: ColorApp.cBlackColor,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
          color: ColorApp.cBlackColor, fontSize: 18, fontFamily: 'Inter'),
    ),
  );

  static final ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: ColorApp.cPrimaryLightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        sizeConstraints: BoxConstraints.tight(const Size.fromRadius(33))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorApp.cPrimaryColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 30),
      unselectedIconTheme: IconThemeData(size: 25),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorApp.cPrimaryColor,
      titleTextStyle: TextStyle(
        color: ColorApp.cWhiteColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: ColorApp.cWhiteColor,
        fontSize: 22,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: ColorApp.cPrimaryColor,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        color: ColorApp.cWhiteColor,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
          color: ColorApp.cWhiteColor, fontSize: 18, fontFamily: 'Inter'),
      titleSmall: TextStyle(
        color: ColorApp.cWhiteColor,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
          color: ColorApp.cWhiteColor, fontSize: 18, fontFamily: 'Inter'),
    ),
  );
}
