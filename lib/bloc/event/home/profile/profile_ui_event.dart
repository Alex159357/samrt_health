

import 'package:flutter/material.dart';

@immutable
abstract class ProfileUiEvent{}

class OnUsernameEditClick extends ProfileUiEvent{}


class OnUsernameEditedDone extends ProfileUiEvent{
  final String username;

  OnUsernameEditedDone(this.username);
}

class LoadUserEvent extends ProfileUiEvent{}
