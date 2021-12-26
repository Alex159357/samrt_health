import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:camera/camera.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:samrt_health/pages/runner/runner.dart';
import 'package:samrt_health/theme/theme_controller.dart';
import 'package:samrt_health/utils/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_base/user_db/user_db.dart';
import 'utils/DataConvertor.dart';

late SharedPreferences prefs;
late FirebaseApp firebaseApp;
late String locale;
late List<CameraDescription> cameras;
Translation translation = Translation();
late UserDb userDb;

bool get ifTablet {
  // final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  // return data.size.shortestSide > 600;
  return Device.get().isIos && Device.get().isTablet;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  locale = (await Devicelocale.currentLocale)!.split("_")[0];
  runApp(
    EasyLocalization(
        supportedLocales: supportedLangs,
        path: 'assets/translations',
        startLocale: const Locale('en'),
        useOnlyLangCode: true,
        fallbackLocale: Locale(locale.split("_")[0]),
        //locale.split("_")[0]
        child: const App()),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Smart Health',
        theme: ThemeController().getCurrentTheme(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localeResolutionCallback: (locale, Iterable<Locale> supportedLocales) {
          return locale;
        },
        home: Runner());
  }
}

final List<String> appLanguages = [
  'af',
  'am',
  'ar',
  'az',
  'be',
  'bg',
  'bn',
  'bs',
  'ca',
  'cs',
  'da',
  'de',
  'el',
  'en',
  'es',
  'et',
  'eu',
  'fa',
  'fi',
  'fil',
  'fr',
  'gl',
  'gu',
  'he',
  'hi',
  'hr',
  'hu',
  'hy',
  'id',
  'is',
  'it',
  'ja',
  'ka',
  'kk',
  'km',
  'kn',
  'ko',
  'ky',
  'lo',
  'lt',
  'lv',
  'mk',
  'ml',
  'mn',
  'mr',
  'ms',
  'my',
  'nb',
  'ne',
  'nl',
  'no',
  'or',
  'pa',
  'pl',
  'ps',
  'pt',
  'ro',
  'ru',
  'si',
  'sk',
  'sl',
  'sq',
  'sr',
  'sv',
  'sw',
  'ta',
  'te',
  'th',
  'tl',
  'tr',
  'uk',
  'ur',
  'uz',
  'vi',
  'zh',
  'zu'
];

final List<Locale> supportedLangs = [
  const Locale('af', ''),
  const Locale('am', ''),
  const Locale('ar', ''),
  const Locale('az', ''),
  const Locale('be', ''),
  const Locale('bg', ''),
  const Locale('bn', ''),
  const Locale('bs', ''),
  const Locale('ca', ''),
  const Locale('cs', ''),
  const Locale('da', ''),
  const Locale('de', ''),
  const Locale('el', ''),
  const Locale('en', ''),
  const Locale('es', ''),
  const Locale('et', ''),
  const Locale('eu', ''),
  const Locale('fa', ''),
  const Locale('fi', ''),
  const Locale('fil', ''),
  const Locale('fr', ''),
  const Locale('gl', ''),
  const Locale('gu', ''),
  const Locale('he', ''),
  const Locale('hi', ''),
  const Locale('hr', ''),
  const Locale('hu', ''),
  const Locale('hy', ''),
  const Locale('id', ''),
  const Locale('is', ''),
  const Locale('it', ''),
  const Locale('ja', ''),
  const Locale('ka', ''),
  const Locale('kk', ''),
  const Locale('km', ''),
  const Locale('kn', ''),
  const Locale('ko', ''),
  const Locale('ky', ''),
  const Locale('lo', ''),
  const Locale('lt', ''),
  const Locale('lv', ''),
  const Locale('mk', ''),
  const Locale('ml', ''),
  const Locale('mn', ''),
  const Locale('mr', ''),
  const Locale('ms', ''),
  const Locale('my', ''),
  const Locale('nb', ''),
  const Locale('ne', ''),
  const Locale('nl', ''),
  const Locale('no', ''),
  const Locale('or', ''),
  const Locale('pa', ''),
  const Locale('pl', ''),
  const Locale('ps', ''),
  const Locale('pt', ''),
  const Locale('ro', ''),
  const Locale('ru', ''),
  const Locale('si', ''),
  const Locale('sk', ''),
  const Locale('sl', ''),
  const Locale('sq', ''),
  const Locale('sr', ''),
  const Locale('sv', ''),
  const Locale('sw', ''),
  const Locale('ta', ''),
  const Locale('te', ''),
  const Locale('th', ''),
  const Locale('tl', ''),
  const Locale('tr', ''),
  const Locale('uk', ''),
  const Locale('ur', ''),
  const Locale('uz', ''),
  const Locale('vi', ''),
  const Locale('zh', ''),
  const Locale('zu', '')
];
