
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationEvent{}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoginByGoogle extends AuthenticationEvent{}

class LoginByFacebook extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent{}

class CheckLogin extends AuthenticationEvent{}