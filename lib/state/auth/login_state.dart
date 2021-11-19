import '../form_submission_status.dart';

class LoginState {
  final String email;

  bool get isValidUsername => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  final String password;

  bool get isValidPassword => password.length >= 6;

  final FormSubmissionStatus formStatus;
  final bool passwordIsVisible;

  LoginState({
    this.email = '',
    this.password = '',
    this.passwordIsVisible = false,
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool passwordIsVisible = false,
    FormSubmissionStatus? formStatus,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        passwordIsVisible: passwordIsVisible,
        formStatus: formStatus ?? this.formStatus,
      );
}
