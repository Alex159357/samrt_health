
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationState {
}

class Uninitialized extends AuthenticationState {
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);

  static Authenticated copyWith({required User user})=> Authenticated(user);
}

class AuthenticationFailed extends AuthenticationState{}

class Unauthenticated extends AuthenticationState {}