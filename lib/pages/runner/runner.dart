import 'dart:io';

import 'package:devicelocale/devicelocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samrt_health/navigation/runner/runner_cubit.dart';
import 'package:samrt_health/pages/app/app.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';
import 'package:samrt_health/pages/main_nav/main_nav.dart';
import 'package:samrt_health/services/notifiation_service.dart';
import 'package:samrt_health/utils/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../test_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class Runner extends StatelessWidget {
  const Runner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    NotificationService.onNotifications.listen((value) {
      debugPrint("Notification clicked $value");
    });
    return BlocProvider(
        create: (context) => RunnerCubit(),
        child: BlocBuilder<RunnerCubit, bool>(
            builder: (BuildContext context, state) {
          _init().then((value) => context.read<RunnerCubit>().complete(value));
          if (state) {
           return const MainNav();
          }
          return const MaterialApp(
            home: Center(
              child: Text("SPLASH SCREEN"),
            ),
          );
        }));
  }

  Future<void> initNotify()async{

  }

  Future<bool> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    await NotificationService.init();

    locale = (await Devicelocale.currentLocale)!.split("_")[0];
    prefs = await SharedPreferences.getInstance();
    await translation.instance();
    prefs.setBool("intro", false);
    firebaseApp = await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 2000));
    return true;
  }
}
