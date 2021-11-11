

import '../form_submission_status.dart';

class RegistrationState {
  final String username;
  bool get isValidUsername => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username);

  final String password;
  bool get isValidPassword => password.length >= 6;

  final String secondPassword;
  bool get isPasswordsTheSames => password == secondPassword;

  final FormSubmissionStatus formStatus;
  final bool passwordIsVisible;

  RegistrationState({
    this.username = '',
    this.password = '',
    this.secondPassword = '',
    this.passwordIsVisible = false,
    this.formStatus = const InitialFormStatus(),
  });

  RegistrationState copyWith({
    String? username,
    String? password,
    String? secondPassword,
    bool passwordIsVisible = false,
    FormSubmissionStatus? formStatus,
  }) {
    return RegistrationState(
      username: username ?? this.username,
      password: password ?? this.password,
      secondPassword: secondPassword ?? this.secondPassword,
      passwordIsVisible: passwordIsVisible,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}