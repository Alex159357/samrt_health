


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';

import '../bloc.dart';

class AuthButtons{

  Widget get googleButton => BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: ((context, state) {
      return SignInButton(
        Buttons.Google,
        text: tr("login_by_google"),
        onPressed: ()=>context.read<AuthenticationBloc>().add(LoginByGoogle()),
      );
    }),
  );

  Widget get facebookButton => BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, state) {
        return SignInButton(Buttons.FacebookNew, text: tr("login_by_facebook"), onPressed: (){
          context.read<AuthenticationBloc>().add(LoginByFacebook());
        });
      }
  );


}