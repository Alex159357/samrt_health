


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../bloc.dart';

class AuthButtons{

  Widget get googleButton => BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: ((context, state) {
      return SignInButton(
        Buttons.Google,
        onPressed: ()=>context.read<AuthenticationBloc>().add(LoginByGoogle()),
      );
    }),
  );

  Widget get facebookButton => BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, state) {
        return SignInButton(Buttons.FacebookNew, onPressed: (){
          context.read<AuthenticationBloc>().add(LoginByFacebook());
        });
      }
  );


}