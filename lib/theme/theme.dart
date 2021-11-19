

import 'package:flutter/material.dart';
import 'package:samrt_health/theme/theme_controller.dart';

class AppTheme {
  ThemeData _darkTheme = ThemeData.dark().copyWith();

  final ThemeData _lightTheme = ThemeData(
      brightness: Brightness.light,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
      primarySwatch: const MaterialColor(
        0xFFF5E0C3,
        <int, Color>{
          50: Color(0x1a5D4524),
          100: Color(0xa15D4524),
          200: Color(0xaa5D4524),
          300: Color(0xaf5D4524),
          400: Color(0x1a483112),
          500: Color(0xa1483112),
          600: Color(0xaa483112),
          700: Color(0xff483112),
          800: Color(0xaf2F1E06),
          900: Color(0xff2F1E06)
        },
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor:  Color(0xff457BE0)
      ),
      primaryColor: const Color(0xff5D4524),
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: const Color(0x1a311F06),
      primaryColorDark: const Color(0xff0a46cd),
      canvasColor: const Color(0xff457BE0),
      accentColor: const Color(0xff457BE0),
      accentColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xffcccccc),
      backgroundColor: const Color(0xfff4f8fe),
      bottomAppBarColor: const Color(0xffcfd8dc),
      cardColor: const Color(0xaa311F06),
      dividerColor: const Color(0x1f6D42CE),
      focusColor: const Color(0x1a311F06),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xffcfd8dc)
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: const Color(0xff0a46cd)),
      )
  );

  final ThemeData _pinkTheme = ThemeData(
      brightness: Brightness.dark,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
      primarySwatch: const MaterialColor(
        0xFFF5E0C3,
        <int, Color>{
          50: Color(0x1a5D4524),
          100: Color(0xa15D4524),
          200: Color(0xaa5D4524),
          300: Color(0xaf5D4524),
          400: Color(0x1a483112),
          500: Color(0xa1483112),
          600: Color(0xaa483112),
          700: Color(0xff483112),
          800: Color(0xaf2F1E06),
          900: Color(0xff2F1E06)
        },
      ),
      primaryColor: const Color(0xff5D4524),
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: const Color(0x1a311F06),
      primaryColorDark: const Color(0xff936F3E),
      canvasColor: const Color(0xffE09E45),
      accentColor: const Color(0xff457BE0),
      accentColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff303f9f),
      bottomAppBarColor: const Color(0xff6D42CE),
      cardColor: const Color(0xaa311F06),
      dividerColor: const Color(0x1f6D42CE),
      focusColor: const Color(0x1a311F06)
  );

  final ThemeData _darkBlueTheme = ThemeData(
      brightness: Brightness.light,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
      primarySwatch: const MaterialColor(
        0xFFF5E0C3,
        <int, Color>{
          50: Color(0x1a5D4524),
          100: Color(0xa15D4524),
          200: Color(0xaa5D4524),
          300: Color(0xaf5D4524),
          400: Color(0x1a483112),
          500: Color(0xa1483112),
          600: Color(0xaa483112),
          700: Color(0xff483112),
          800: Color(0xaf2F1E06),
          900: Color(0xff2F1E06)
        },
      ),
      primaryColor: const Color(0xff5D4524),
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: const Color(0x1a311F06),
      primaryColorDark: const Color(0xff936F3E),
      canvasColor: const Color(0xffE09E45),
      accentColor: const Color(0xff457BE0),
      accentColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xffcccccc),
      bottomAppBarColor: const Color(0xff6D42CE),
      cardColor: const Color(0xaa311F06),
      dividerColor: const Color(0x1f6D42CE),
      focusColor: const Color(0x1a311F06)
  );

  final ThemeData _halloweenTheme = ThemeData(
      brightness: Brightness.dark,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
      primarySwatch: const MaterialColor(
        0xFFF5E0C3,
        <int, Color>{
          50: Color(0x1a5D4524),
          100: Color(0xa15D4524),
          200: Color(0xaa5D4524),
          300: Color(0xaf5D4524),
          400: Color(0x1a483112),
          500: Color(0xa1483112),
          600: Color(0xaa483112),
          700: Color(0xff483112),
          800: Color(0xaf2F1E06),
          900: Color(0xff2F1E06)
        },
      ),
      primaryColor: const Color(0xff5D4524),
      primaryColorBrightness: Brightness.dark,
      primaryColorLight: const Color(0x1a311F06),
      primaryColorDark: const Color(0xff936F3E),
      canvasColor: const Color(0xff0672f6),
      accentColor: const Color(0xff4CD964),
      accentColorBrightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xfff0f),
      bottomAppBarColor: const Color(0xffcfd8dc),
      cardColor: const Color(0xaa311F06),
      dividerColor: const Color(0x1f6D42CE),
      focusColor: const Color(0x1a311F06)
  );

  static get darkTheme => AppTheme()._darkTheme;

  static get lightTheme => AppTheme()._lightTheme;

  static get pinkTheme => AppTheme()._pinkTheme;

  static get darkBlueTheme => AppTheme()._darkBlueTheme;

  static get halloweenTheme => AppTheme()._halloweenTheme;


  ThemeData getCurrentTheme(CurrentTheme theme){
    switch(theme){
      case CurrentTheme.LIGHT:
        return _lightTheme;
      case CurrentTheme.DARK:
        return _darkTheme;
      case CurrentTheme.HALLOWEEN:
        return _halloweenTheme;
      case CurrentTheme.NEW_YEAR:
        return _pinkTheme;
      case CurrentTheme.VALENTINES_DAY:
        return _pinkTheme;
      case CurrentTheme.MARCH8:
        return _pinkTheme;
    }
  }

}
