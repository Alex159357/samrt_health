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

class MainNav extends StatelessWidget {
  const MainNav({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (ctx)=> AuthenticationBloc(userRepository: UserRepository()),
    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, authState) {
          context.read<AuthenticationBloc>().add(LoggedOut());
      return BlocProvider(
        create: (context) => MainNavCubit(Pages.INTRO.page),
        child: BlocBuilder<MainNavCubit, Widget>(
          builder: (BuildContext context, page) {
            context.read<AuthenticationBloc>().add(CheckLogin());
            if (authState is Authenticated) {
             return  App();
            }else if (authState is Unauthenticated || authState is SocialLoginInProgress) {
              bool intro = prefs.getBool("intro") ?? false;
              if (!intro) {
                return MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    home: IntroPage());
              }else {
                return MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    home: AuthPage());
              }
            }
            return Material(
              child: page,
            );
          },
        ),
      );
    }));
  }




}

