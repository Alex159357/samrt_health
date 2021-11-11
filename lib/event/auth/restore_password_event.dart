abstract class RestorePasswordEvent {}

class RestorePasswordEventOnEmailChanged extends RestorePasswordEvent {
  final String email;

  RestorePasswordEventOnEmailChanged({required this.email});
}

class RestorePasswordEventOnCodeChanged extends RestorePasswordEvent {
  final String code;

  RestorePasswordEventOnCodeChanged({required this.code});
}

class RestorePasswordOnSubmitted extends RestorePasswordEvent{}

class RestorePasswordEventOnNewPasswordEnter extends RestorePasswordEvent{
  final String newPassword;

  RestorePasswordEventOnNewPasswordEnter({required this.newPassword});
}

class RestorePasswordEventOnEmailSubmitted extends RestorePasswordEvent{}

class RestorePasswordEventOnCodeSubmitted extends RestorePasswordEvent{}

