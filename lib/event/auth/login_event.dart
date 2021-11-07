

import 'package:samrt_health/pages/auth/login/login_view.dart';

abstract class LoginEvent{}

class LoginEventOnChangedUsername extends LoginEvent{
  final String username;
  LoginEventOnChangedUsername({required this.username});
}

class LoginEventOnChangedPassword extends LoginEvent{
  final String password;

  LoginEventOnChangedPassword({required this.password});
}

class LoginEventOnSubmitted extends LoginEvent{}

class LoginEventPasswordVisibility extends LoginEvent{
  final bool isVisible;

  LoginEventPasswordVisibility(this.isVisible);

  LoginEventPasswordVisibility copyWith({required isVisible}) => LoginEventPasswordVisibility(isVisible);
}