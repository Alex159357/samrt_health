import 'package:flutter/material.dart';
import 'package:samrt_health/models/app_user_model.dart';

@immutable
abstract class UserDbEvent{}

class CheckUserInDbEvent extends UserDbEvent{
  final String uid;

  CheckUserInDbEvent({required this.uid});
}

class InsertUserEvent extends UserDbEvent{
  final UserModel userModel;

  InsertUserEvent(this.userModel);
}

class GetUserEvent extends UserDbEvent{
  final String uid;

  GetUserEvent({required this.uid});
}

class DeleteAllEvent extends UserDbEvent{}

