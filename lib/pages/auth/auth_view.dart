


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/pages/auth/login/login_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuthCubit, AuthPages>(
      builder: (BuildContext context, state){
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
          child: state == AuthPages.LOGIN? LoginView() : Container(child: Center(child: Text("REGISTRATION"),),),
        );


      },
    );
  }
}
