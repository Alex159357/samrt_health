import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/main/main_nav_cubit.dart';
import 'package:samrt_health/navigation/main/pages.dart';
import 'package:samrt_health/pages/app/app.dart';
import 'package:samrt_health/pages/auth/auth_page.dart';
import 'package:samrt_health/pages/intro/intro_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:samrt_health/repository/user_repository.dart';

import '../../bloc.dart';
import '../../main.dart';

class RootNav extends StatelessWidget {
  const RootNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx) => AuthenticationBloc(userRepository: UserRepository()),
        child: BlocProvider(
            create: (context) => MainNavCubit(Pages.INTRO),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  bool intro = prefs.getBool("intro") ?? false;
                  if (intro) {
                    context.read<MainNavCubit>().emit(Pages.AUTH);
                  } else {
                    context.read<MainNavCubit>().emit(Pages.INTRO);
                  }
                }else if (state is Authenticated){
                  context.read<MainNavCubit>().emit(Pages.MAIN);
                }
              },
              child: BlocBuilder<MainNavCubit, Pages>(
                builder: (BuildContext context, page) {
                  context.read<AuthenticationBloc>().add(CheckLogin());
                  if (page == Pages.INTRO) {
                    return MaterialApp(
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        home: IntroPage());
                  } else if (page == Pages.AUTH) {
                    return MaterialApp(
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        home: AuthPage());
                  }
                  return App();

                },
              ),
            )));
  }
}
