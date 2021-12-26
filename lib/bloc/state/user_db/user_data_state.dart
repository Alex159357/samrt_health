
import 'package:flutter/material.dart';
import 'package:samrt_health/models/app_user_model.dart';


@immutable
abstract class UserDbState{}

class InitialUserDbState extends UserDbState{}

class InsertInsertedState extends UserDbState{}

class UserExistState extends UserDbState{}
class UserUnExistState extends UserDbState{}

class GetUserState extends UserDbState{
  final UserModel userModel;

  GetUserState({required this.userModel});
}

class DeletedAllState extends UserDbState{}