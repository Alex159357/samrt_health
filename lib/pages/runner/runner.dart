import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_data/user_data_bloc.dart';
import 'package:samrt_health/bloc/bloc/user_db/user_db_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_root_cubit.dart';
import 'package:samrt_health/data_base/user_db/user_db.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/navigation/runner/runner_cubit.dart';
import 'package:samrt_health/pages/auth/auth_page.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';

import 'package:samrt_health/pages/runner/runner_wrapper.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/services/notifiation_service.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';
import 'package:samrt_health/view/base_state_less.dart';

import '../../main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Runner extends BaseStateLess {
  UserModel? userModel;

  Runner({Key? key}) : super(key: key);

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
        child: BlocListener<RunnerCubit, bool>(
            listener: (context, state) {},
            child: BlocBuilder<RunnerCubit, bool>(
                builder: (BuildContext context, state) {
              _init()
                  .then((value) => context.read<RunnerCubit>().complete(value));
              if (state) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                    create: (context) => UserDbBloc(userDatsBase: userDb)),
                  BlocProvider(
                  create: (ctx) => AuthenticationBloc(
                  userRepository: UserRepository())),
                  ],
                  child: BlocBuilder<AuthenticationBloc,
                              AuthenticationState>(builder: (context, state) {
                            if (state is Authenticated) {
                              return FutureBuilder(
                                future: userDb.readUser(state.user.uid),
                                builder: (BuildContext context,
                                    AsyncSnapshot<UserModel?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      print("Loading from DB");
                                      return RunnerWrapper(page: 1);
                                    } else if (!snapshot.hasData ||
                                        snapshot.hasError) {
                                      return FutureBuilder(
                                        future: FirebaseRepository()
                                            .instance()
                                            .getUser(state.user.uid),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<UserModel?> snapshot) {
                                          int status = 0;
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              status = 1;
                                            } else {
                                              status = 2;
                                            }
                                          }
                                          return  RunnerWrapper(page: status, userModel: snapshot.data,); //0
                                        },
                                      );
                                    }
                                  }
                                  return SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: const RunnerWrapper(page: 0));
                                },
                              );
                            } else {
                              userDb.delete().then((value) {
                                print("All user db was deleted");
                              });
                              return BlocProvider(
                                create: (ctx)=> AuthRootCubit(),
                                child: BlocBuilder<AuthRootCubit, bool>(
                                  builder: (context, st) {
                                    if (st) {
                                      return AuthPage();
                                    }
                                    return IntroPage();
                                  },
                                ),
                              );
                            }
                          }),
                );
              }
              return const MaterialApp(
                  showSemanticsDebugger: false, home: Splash());
            })));
  }

  Future<void> initNotify() async {}

  Future<bool> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();
    await NotificationService.init();

    firebaseApp = await Firebase.initializeApp();
    userDb = await UserDb().instance();
    cameras = await availableCameras();
    return true;
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xffB085F5) : const Color(0xffB085F5),
      body: Center(
          child: lightMode
              ? Image.asset('assets/img/splash.png')
              : Image.asset('assets/img/splash.png')),
    );
  }
}
