import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/auth/registration_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/event/auth/registration_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/registration_state.dart';
import 'package:samrt_health/state/form_submission_status.dart';
import 'package:samrt_health/view/auth_state_less.dart';
import 'package:samrt_health/view/logo_view.dart';

class RegistrationView extends AuthStateLess {
  RegistrationView({Key? key}) : super(key: key);
  UserRepository userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(userRepository: userRepository),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (BuildContext context, state) {},
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
                state.formStatus is FormSubmitting ? Center(child: loadingWhite) : Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              LogoView(),
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
                      ],
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
              prefixIcon: const Icon(
                FontAwesomeIcons.key,
                color: Colors.black12,
              ),
              suffixIcon: state.passwordIsVisible
                  ? InkWell(
                  child: const Icon(FontAwesomeIcons.eyeSlash, color: Colors.black12),
                  onTap: () => context.read<RegistrationBloc>().add(
                      RegistrationEventPasswordVisibility(!state.passwordIsVisible)))
                  : InkWell(
                  child: const Icon(FontAwesomeIcons.eye, color: Colors.black12),
                  onTap: () => context.read<RegistrationBloc>().add(
                      RegistrationEventPasswordVisibility(!state.passwordIsVisible))),
              filled: true,
              fillColor: Colors.white,
              hintText: "password",
            ),
            obscureText: !state.passwordIsVisible,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) => state.isValidPassword ? null : 'email invalid',
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                FontAwesomeIcons.key,
                color: Colors.black12,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "re enter password",
            ),
            obscureText: !state.passwordIsVisible,
            enableSuggestions: false,
            autocorrect: false,
            validator: (value) => state.isPasswordsTheSames ? null : 'passwords are different',
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
                  child: const Text(
                    "sign in",
                    style: TextStyle(color: Colors.black),
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
                child: const Text("sign up"),
              ),

            ],
          );
        });
  }


}
