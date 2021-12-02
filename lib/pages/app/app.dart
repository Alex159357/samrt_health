// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:easy_localization/src/public_ext.dart';
// import 'package:flutter/material.dart';
// import 'package:samrt_health/pages/main/main_wrapper/home_navigator.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:samrt_health/theme/theme_controller.dart';
//
// import '../../bloc.dart';
//
// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     final initTheme = ThemeController().getCurrentTheme();
//     return ThemeProvider(
//         initTheme: initTheme,
//         builder: (_, myTheme) {
//           return MaterialApp(
//               title: 'Smart Health',
//               theme: myTheme,
//               debugShowCheckedModeBanner: false,
//               localizationsDelegates: context.localizationDelegates,
//               supportedLocales: context.supportedLocales,
//               locale: context.locale,
//               localeResolutionCallback:
//                   (locale, Iterable<Locale> supportedLocales) {
//                 return locale;
//               },
//               home: ThemeSwitchingArea(
//               child:MainNavigator()));
//         });
//   }
// }
