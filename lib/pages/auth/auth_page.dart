

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';

import '../../bloc.dart';
import 'auth_view.dart';
import 'login/login_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, state) {
          if (state is Authenticated) {
            if (state.user != null) {
            //todo check if user exists and show screen that user is already exists
            }
          }
        },
        child: _getBody(context));
  }

  Widget _getBody(BuildContext context) => Material(
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFFf2f9fc),
      child: SizedBox(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider(create: (context)=> AuthCubit(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AuthView(),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

}
