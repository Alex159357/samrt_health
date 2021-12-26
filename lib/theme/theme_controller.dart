
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:samrt_health/theme/theme.dart';

import '../main.dart';

enum CurrentTheme { LIGHT, DARK, HALLOWEEN, NEW_YEAR, VALENTINES_DAY, MARCH8 }

extension ThemeTypes on CurrentTheme {
  int get val {
    switch (this) {
      case CurrentTheme.LIGHT:
        return 0;
      case CurrentTheme.DARK:
        return 1;
      case CurrentTheme.HALLOWEEN:
        return 2;
      case CurrentTheme.NEW_YEAR:
        return 3;
      case CurrentTheme.VALENTINES_DAY:
        return 4;
      case CurrentTheme.MARCH8:
        return 5;
    }
  }
}

class ThemeController {

  ThemeData getCurrentTheme() {
    int? themeIndex = prefs.getInt("theme");
    if(themeIndex != null){
      CurrentTheme theme = _byInt(themeIndex);
      return AppTheme().getCurrentTheme(theme);
    }else {
      final isPlatformDark =
          WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
      return isPlatformDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    }
  }

  ThemeData toggleTheme(){
    int? themeIndex = prefs.getInt("theme");
    if(themeIndex != null){
      var itBrightness = SchedulerBinding.instance!.window.platformBrightness;
      bool isDarkMode = itBrightness == Brightness.dark;
      print("IsDark ->$isDarkMode");
      CurrentTheme theme = _byInt(themeIndex == 0?1 :0);
      prefs.setInt("theme", themeIndex == 0?1 :0);
      return AppTheme().getCurrentTheme(theme);
    }else {
      return AppTheme().getCurrentTheme(_byInt(0));
    }
  }


  CurrentTheme _byInt(int i){
    prefs.setInt("theme", i);
    switch(i){
      case 0: return CurrentTheme.LIGHT;
      case 1: return CurrentTheme.DARK;
      case 2: return CurrentTheme.HALLOWEEN;
      case 3: return CurrentTheme.NEW_YEAR;
      case 4: return CurrentTheme.VALENTINES_DAY;
      case 5: return CurrentTheme.MARCH8;
      default: return CurrentTheme.LIGHT;
    }
  }
}