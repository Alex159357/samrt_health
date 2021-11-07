import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/navigation/runner/runner_cubit.dart';
import 'package:samrt_health/pages/app/app.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';
import 'package:samrt_health/pages/main_nav/main_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Runner extends StatelessWidget {
  const Runner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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

  Future<bool> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    prefs = await SharedPreferences.getInstance();
    // prefs.setBool("intro", false);
    firebaseApp = await Firebase.initializeApp();
    await Future.delayed(const Duration(milliseconds: 2000));
    return true;
  }
}
