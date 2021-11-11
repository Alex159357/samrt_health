import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/pages/auth/login/login_view.dart';
import 'package:samrt_health/pages/auth/registration/registration_view.dart';
import 'package:samrt_health/pages/auth/restore_password/restore_password_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthPages>(
      builder: (BuildContext context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: state == AuthPages.RESTORE_PASSWORD
              ? RestorePasswordView()
              : state == AuthPages.REGISTRATION
                  ? RegistrationView()
                  : LoginView(),
          // switchInCurve: Curves.easeInBack,
          // switchOutCurve: Curves.easeInBack.flipped,
        );
      },
    );
  }
}
