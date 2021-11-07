
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/pages/auth/auth_page.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';
import 'package:samrt_health/pages/main/main_page/main_page.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/theme/theme_controller.dart';

import '../../bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initTheme = ThemeController().getCurrentTheme();
    return ThemeProvider(
        initTheme: initTheme,
        builder: (_, myTheme) {
          return MaterialApp(
            title: 'Smart Health',
            theme: myTheme,
            home: MainPage()
          );
        });
  }
}