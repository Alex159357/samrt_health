
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AuthenticationState {
}

class Uninitialized extends AuthenticationState {
}

class Authenticated extends AuthenticationState {
  final User? user;

  Authenticated({required this.user});
}

class Unauthenticated extends AuthenticationState {
}