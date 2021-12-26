


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc/event/home/profile/profile_ui_event.dart';
import 'package:samrt_health/bloc/state/home/profile/profile_ui_state.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import '../../../main.dart';

class ProfileUiBloc extends Bloc<ProfileUiEvent, ProfileUiState>{
  final User user;
  UserModel? userModel;
  final FirebaseRepository _firebaseRepository = FirebaseRepository().instance();
  ProfileUiBloc({required this.user}) : super(ProfileInitial()){
    onEvent(LoadUserEvent());
  }


  @override
  void onChange(Change<ProfileUiState> change) {
    print("EMIN");
    super.onChange(change);
  }

  @override
  Stream<ProfileUiState> mapEventToState(ProfileUiEvent event)async* {
    print("EMIN");
    if(event is LoadUserEvent){
      yield UserDataIsLoading();
      userModel = await userDb.readUser(user.uid);
      if(userModel != null){
        print("UserFomDb -> ${userModel!.name}");
        yield UserDataLoadDone(userModel: userModel!);
      }else{
        try{
          userModel = await _firebaseRepository.getUser(user.uid);
          if(userModel != null){
            yield UserDataLoadDone(userModel: userModel!);
          }
        }catch (e){
          print(e);
          yield UserDataLoadError();
        }
      }
    }
    if(event is OnUsernameEditClick){
      yield OnUsernameEditState();
    }
    if(event is OnUsernameEditedDone){
      yield OnUsernameEditDoneState();
    }
  }
}