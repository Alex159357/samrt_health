import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:samrt_health/bloc/auth/login_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/event/auth/login_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/login_state.dart';
import 'package:samrt_health/state/form_submission_status.dart';

import '../../../bloc.dart';

class LoginView extends StatelessWidget {

  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository:  UserRepository()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {

          }
          if (formStatus is SubmissionSuccess) {

          }
        },
        child: _getForm(),
      ),
    );
  }

  Widget _getForm() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return  AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: state.formStatus is FormSubmitting
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: Lottie.asset('assets/animation/loading_white.json'))
                : SizedBox(
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _getUsernameField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _getPasswordField(),
                          ),
                          state.formStatus is SubmissionFailed? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Login error, try to sign up", style: TextStyle(color: Colors.redAccent),),
                          ): Container(),
                          _getLoginButton(),
                          _getGoogleButton()

                        ],
                      ),
                    )),
          );
        },
      );
  }

  Widget _getUsernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            FontAwesomeIcons.at,
            color: Colors.black12,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "email",
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginEventOnChangedUsername(username: value)),
      );
    });
  }

  Widget _getPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            FontAwesomeIcons.key,
            color: Colors.black12,
          ),
          suffixIcon: state.passwordIsVisible
              ? InkWell(
                  child: const Icon(FontAwesomeIcons.eyeSlash, color: Colors.black12),
                  onTap: () => context.read<LoginBloc>().add(
                      LoginEventPasswordVisibility(!state.passwordIsVisible)))
              : InkWell(
                  child: const Icon(FontAwesomeIcons.eye, color: Colors.black12),
                  onTap: () => context.read<LoginBloc>().add(
                      LoginEventPasswordVisibility(!state.passwordIsVisible))),
          filled: true,
          fillColor: Colors.white,
          hintText: "password",
        ),
        obscureText: !state.passwordIsVisible,
        enableSuggestions: false,
        autocorrect: false,
        validator: (value) => state.isValidPassword ? null : 'email invalid',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginEventOnChangedPassword(password: value)),
      );
    });
  }

  Widget _getLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginEventOnSubmitted());
              }
            },
            child: const Text("sign in"),
          ),
          TextButton(
              onPressed: () =>
                  context.read<AuthCubit>().goTo(AuthPages.REGISTRATION),
              child: const Text(
                "sign up",
                style: TextStyle(color: Colors.black),
              ))
        ],
      );
    });
  }

  Widget _getGoogleButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) {
        return Container(
          width: 150,
          color: Colors.black,
          child: GestureDetector(
            onTap: () {
              context.read<AuthenticationBloc>().add(LoginByGoogle());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "sign in with",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 16,
                      child: SvgPicture.asset("assets/img/gmail.svg")),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
