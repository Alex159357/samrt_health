import 'package:samrt_health/models/app_user_model.dart';

abstract class FbState {}

class InitialState extends FbState{}

class InitialisedState extends FbState{}

class UserExistsState extends FbState {
  final UserModel userModel;

  UserExistsState(this.userModel);
}

class UserNotFoundState extends FbState{}




