import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/view/auth_state_less.dart';
import 'package:samrt_health/view/base_state_less.dart';
import 'package:samrt_health/view/test.dart';
import 'package:samrt_health/view/test2.dart';

import '../../bloc.dart';
import 'auth_view.dart';

class AuthPage extends AuthStateLess {
  AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, state) {
          if (state is Authenticated) {}
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: _getBody(context)));
  }
//TODO create password restore
  Widget _getBody(BuildContext context) => Material(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child:
          Stack(
            children: [
            Opacity(
            opacity: 0.1,
            child:CustomPaint(
                size: Size(900, (600*0.8666666666666666).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              )),
              Positioned(
                  left: 280,
                  right: -300,
                  bottom: -300,
                  child: Opacity(
                    opacity: 0.1,
                    child: CustomPaint(
                      painter: RPSCustomPainter2(),
                      size: Size(900, (500*0.8666666666666666).toDouble()),
                    ),
                  )),
              Container(
                child: SizedBox(
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (BuildContext context, state) {
                    if (state is SocialLoginInProgress) {
                      print("login_social");
                      return Center(child: loadingWhite(context));
                    } else {
                      return  BlocProvider(
                          create: (context) => AuthCubit(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AuthView(),
                          ),
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      );
}
