


abstract class RegistrationEvent {}

class RegistrationEventOnChangedUsername extends RegistrationEvent{
  final String username;
  RegistrationEventOnChangedUsername({required this.username});
}

class RegistrationEventOnChangedPassword extends RegistrationEvent{
  final String password;

  RegistrationEventOnChangedPassword({required this.password});
}
class RegistrationEventOnChangedSecondPassword extends RegistrationEvent{
  final String secondPassword;

  RegistrationEventOnChangedSecondPassword({required this.secondPassword});
}

class RegistrationEventOnSubmitted extends RegistrationEvent{}

class RegistrationEventPasswordVisibility extends RegistrationEvent{
  final bool isVisible;

  RegistrationEventPasswordVisibility(this.isVisible);

  RegistrationEventPasswordVisibility copyWith({required isVisible}) => RegistrationEventPasswordVisibility(isVisible);
}

class RegistrationEventCreateNewUser extends RegistrationEvent{}