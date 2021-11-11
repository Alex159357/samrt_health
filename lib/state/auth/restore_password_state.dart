import '../form_submission_status.dart';

enum RestoreStep{
  ENTER_EMAIL,
  ENTER_CODE,
  ENTER_NEW_PASSWORD
}

class RestorePasswordState {
  final String email;
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  final String code;
  bool get isValidCode => code.length >= 6;

  final String newPassword;
  bool get isValidPassword => newPassword.length >= 6;

  final FormSubmissionStatus formStatus;

  RestoreStep restoreStep;

  RestorePasswordState({
    this.email = "",
    this.code = "",
    this.newPassword = "",
    this.restoreStep = RestoreStep.ENTER_EMAIL,
    this.formStatus = const InitialFormStatus(),
  });

  RestorePasswordState copyWith(
          {String? email,
          String? code,
            String? newPassword,
            RestoreStep? restoreStep,
          FormSubmissionStatus? formStatus}) =>
      RestorePasswordState(
          email: email ?? this.email,
          code: code ?? this.code,
          newPassword: newPassword?? this.newPassword,
          restoreStep: restoreStep?? this.restoreStep,
          formStatus: formStatus ?? this.formStatus);
}


