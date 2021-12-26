import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samrt_health/bloc/bloc/auth/restore_password_bloc.dart';
import 'package:samrt_health/cubit/auth/auth_cubit.dart';
import 'package:samrt_health/bloc/event/auth/restore_password_event.dart';
import 'package:samrt_health/navigation/auth/auth_pages.dart';
import 'package:samrt_health/repository/user_repository.dart';
import 'package:samrt_health/bloc/state/auth/restore_password_state.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/view/auth_state_less.dart';
import 'package:samrt_health/view/logo_view.dart';

import '../../../main.dart';

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
            prefs.setBool("ifRestore", true);
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
                ? Center(child: loadingWhite(context))
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
                                color:  Theme.of(context).cardColor,
                              ),
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              child: getTranslatedText(
                                  text: "You will receive email from 'NOREPLY' follow the link into description, change password and back here to login 😏")),
                          Container(child: _getEmailField()),
                          state.formStatus is SubmissionFailed
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:  Theme.of(context).cardColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        tr("email_not_found"),
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
          fillColor:  Theme.of(context).cardColor,
          hintText: tr("emailCaption"),
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
              child: Text(tr("signIn"))),
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
                child: Text(tr("reset"))),
          ),
        ],
      );
    });
  }
}
