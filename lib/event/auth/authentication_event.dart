
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationEvent{

}

class AppStarted extends AuthenticationEvent {
}

class LoggedIn extends AuthenticationEvent {
  User? user;

  LoggedIn({required this.user});
}

class LoginByGoogle extends AuthenticationEvent{}

class LoggedOut extends AuthenticationEvent {}