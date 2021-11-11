import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/auth/restore_password_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/event/auth/restore_password_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/state/auth/restore_password_state.dart';
import 'package:samrt_health/state/form_submission_status.dart';
import 'package:samrt_health/view/auth_state_less.dart';
import 'package:samrt_health/view/logo_view.dart';

class RestorePasswordView extends AuthStateLess {
  RestorePasswordView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RestorePasswordBloc(userRepository: UserRepository()),
      child: BlocListener<RestorePasswordBloc, RestorePasswordState>(
        listener: (BuildContext context, state) {
          if (state.formStatus is SubmissionSuccess) {
            context.read<AuthCubit>().goTo(AuthPages.LOGIN);
          }
        },
        child: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
      builder: (BuildContext context, state) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: state.formStatus is FormSubmitting
                ? Center(child: loadingWhite)
                : Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LogoView(),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              child: const Text(
                                  "You will receive email from 'NOREPLY' \n follow the link into description, change password and back here to login 😏")),
                          Container(child: _getEmailField()),
                          state.formStatus is SubmissionFailed
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        "Email not found",
                                        style: TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  )
                                )
                              : Container(),
                          _getButton()
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

  Widget _getEmailField() {
    return BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
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
        validator: (value) => state.isValidEmail ? null : 'email invalid',
        onChanged: (value) => context
            .read<RestorePasswordBloc>()
            .add(RestorePasswordEventOnEmailChanged(email: value)),
      );
    });
  }

  Widget _getButton() {
    return BlocBuilder<RestorePasswordBloc, RestorePasswordState>(
        builder: (BuildContext context, state) {
      return Row(
        children: [
          TextButton(
              onPressed: () => context.read<AuthCubit>().goTo(AuthPages.LOGIN),
              child: Text("sign in", style: TextStyle(color: Colors.black))),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff8167e6),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<RestorePasswordBloc>()
                        .add(RestorePasswordEventOnEmailSubmitted());
                  }
                },
                child: Text("reset")),
          ),
        ],
      );
    });
  }
}
