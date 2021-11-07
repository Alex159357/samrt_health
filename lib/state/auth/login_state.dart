

import '../form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username);

  final String password;
  bool get isValidPassword => password.length >= 6;

  final FormSubmissionStatus formStatus;
  final bool passwordIsVisible;

  LoginState({
    this.username = '',
    this.password = '',
    this.passwordIsVisible = false,
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool passwordIsVisible = false,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      passwordIsVisible: passwordIsVisible,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}