import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/auth/login_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/event/auth/login_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/pages/runner/runner.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/services/notifiation_service.dart';
import 'package:samrt_health/bloc/state/auth/login_state.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/utils/translation.dart';
import 'package:samrt_health/view/auth_state_less.dart';

import '../../../main.dart';

class LoginView extends AuthStateLess {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: UserRepository()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {}
          if (formStatus is SubmissionSuccess) {
            context.read<AuthenticationBloc>().add(CheckLogin());
          }
        },
        child: Container(
            child: _getForm()),
      ),
    );
  }

  Widget _getForm() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        bool ifRestore  = prefs.getBool("ifRestore")?? false;
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
              child: state.formStatus is FormSubmitting
                  ? Center(child: loadingWhite(context))
                  : Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child:
                            Center(
                              child: SingleChildScrollView(
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
                                    ifRestore? Text(tr("reset_hint_on_login"),  style: TextStyle(
                                        color: Colors.redAccent)): Container(),
                                    state.formStatus is SubmissionFailed
                                        ? Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: getTranslatedText(
                                              text: tr("Login_error_try_to_sign_up"),
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                          )
                                        : Container(),
                                    _getLoginButton(),
                                    ElevatedButton(
                                        onPressed: () {
                                          NotificationService
                                              .showNotificationScheduled();
                                        },
                                        child: Text("child")),
                                    googleButton,
                                    facebookButton,
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextButton(
                                        onPressed: () => context
                                            .read<AuthCubit>()
                                            .goTo(AuthPages.RESTORE_PASSWORD),
                                        child: Text(
                                          tr("forgot_password"),
                                          style: const TextStyle(
                                              color: Color(0xff8167e6)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _getUsernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            FontAwesomeIcons.at, color: Theme.of(context).iconTheme.color,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: tr("emailCaption"),
        ),
        validator: (value) => state.isValidUsername
            ? null
            : tr("emailErrorText"),
        onChanged: (value) {
          context
              .read<LoginBloc>()
              .add(LoginEventOnChangedUsername(username: value));

        },
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
          prefixIcon: Icon(
            FontAwesomeIcons.key, color: Theme.of(context).iconTheme.color,
          ),
          suffixIcon: state.passwordIsVisible
              ? InkWell(
                  child:  Icon(FontAwesomeIcons.eyeSlash, color: Theme.of(context).iconTheme.color,),
                  onTap: () => context.read<LoginBloc>().add(
                      LoginEventPasswordVisibility(!state.passwordIsVisible)))
              : InkWell(
                  child:
                      Icon(FontAwesomeIcons.eye, color: Theme.of(context).iconTheme.color,),
                  onTap: () => context.read<LoginBloc>().add(
                      LoginEventPasswordVisibility(!state.passwordIsVisible))),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          hintText: tr("passwordCaption"),
        ),
        obscureText: !state.passwordIsVisible,
        enableSuggestions: false,
        autocorrect: false,
        validator: (value) => state.isValidPassword
            ? null
            : tr("passwordErrorText"),
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginEventOnChangedPassword(password: value)),
      );
    });
  }

  Widget _getLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
      return Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff8167e6),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginEventOnSubmitted());
                  }
                },
                child: Text(tr("signIn")), //getTranslatedText(text: "sign in"),
              ),
              TextButton(
                  onPressed: () =>
                      context.read<AuthCubit>().goTo(AuthPages.REGISTRATION),
                  child: Text(
                  tr("signUp"),
                  ))
            ],
          ),
        ],
      );
    });
  }
}
