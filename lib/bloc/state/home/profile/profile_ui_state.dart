

import 'package:flutter/material.dart';
import 'package:samrt_health/models/app_user_model.dart';

@immutable
abstract class ProfileUiState{}

class ProfileInitial extends ProfileUiState{}

class OnUsernameEditState extends ProfileUiState{}

class OnUsernameEditDoneState extends ProfileUiState{}

class UserDataIsLoading extends ProfileUiState{}

class UserDataLoadDone extends ProfileUiState{
  final UserModel userModel;

  UserDataLoadDone({required this.userModel});
}

class UserDataLoadError extends ProfileUiState{}