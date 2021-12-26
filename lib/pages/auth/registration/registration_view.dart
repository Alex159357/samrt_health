import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/bloc/bloc/auth/authentication_bloc.dart';
import 'package:samrt_health/bloc/bloc/auth/registration_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/event/auth/registration_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/bloc/state/auth/registration_state.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/view/auth_state_less.dart';
import 'package:samrt_health/view/logo_view.dart';

import '../../../main.dart';

class RegistrationView extends AuthStateLess {
  RegistrationView({Key? key}) : super(key: key);
  UserRepository userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(userRepository: userRepository),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (BuildContext context, state) {
          if(state.formStatus is SubmissionSuccess){
            context.read<AuthenticationBloc>().add(CheckLogin());
          }
        },
        child: _getForm(),
      ),
    );
  }

  Widget _getForm() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (BuildContext context, state) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child:
                state.formStatus is FormSubmitting ? Center(child: loadingWhite(context)) : Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child:
                        Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                logoView,
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: _getUsernameField(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: _getPasswordField(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: _getSecondPasswordField(),
                                ),
                                _getLoginButton(),

                              ],
                            ),
                          ),
                        ),
                  ),
                ));
      },
    );
  }

  Widget _getUsernameField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, state) {
          return TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                FontAwesomeIcons.at,
                color: Theme.of(context).iconTheme.color,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: tr("emailCaption"),
            ),
            validator: (value) =>
            state.isValidUsername ? null : tr("emailErrorText"),
            onChanged: (value) => context
                .read<RegistrationBloc>()
                .add(RegistrationEventOnChangedUsername(username: value)),
          );
        });
  }

  Widget _getPasswordField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, state) {
          return TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                FontAwesomeIcons.key,
                color: Theme.of(context).iconTheme.color,
              ),
              suffixIcon: state.passwordIsVisible
                  ? InkWell(
                  child: Icon(FontAwesomeIcons.eyeSlash, color:  Theme.of(context).iconTheme.color),
                  onTap: () => context.read<RegistrationBloc>().add(
                      RegistrationEventPasswordVisibility(!state.passwordIsVisible)))
                  : InkWell(
                  child: Icon(FontAwesomeIcons.eye, color:  Theme.of(context).iconTheme.color),
                  onTap: () => context.read<RegistrationBloc>().add(
                      RegistrationEventPasswordVisibility(!state.passwordIsVisible))),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: tr("passwordCaption"),
            ),
            obscureText: !state.passwordIsVisible,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) => state.isValidPassword ? null : tr("passwordErrorText"),
            onChanged: (value) => context
                .read<RegistrationBloc>()
                .add(RegistrationEventOnChangedPassword(password: value)),
          );
        });
  }

  Widget _getSecondPasswordField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, state) {
          return TextFormField(
            //todo move decoration to separate view class
            decoration:  InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide.none,
              ),
              prefixIcon:  Icon(
                FontAwesomeIcons.key,
                color:  Theme.of(context).iconTheme.color,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: tr("re_enter_password"),
            ),
            obscureText: !state.passwordIsVisible,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) => state.isPasswordsTheSames ? null : tr("passwords_are_different"),
            onChanged: (value) => context
                .read<RegistrationBloc>()
                .add(RegistrationEventOnChangedSecondPassword(secondPassword: value)),
          );
        });
  }

  Widget _getLoginButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (BuildContext context, state) {
          return Row(
            children: [
              TextButton(
                  onPressed: () =>
                      context.read<AuthCubit>().goTo(AuthPages.LOGIN),
                  child:  Text(
                    tr(
                        "signIn"),
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff8167e6),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<RegistrationBloc>().add(RegistrationEventCreateNewUser());
                  }
                },
                child: Text(tr("signUp")),
              ),

            ],
          );
        });
  }


}
