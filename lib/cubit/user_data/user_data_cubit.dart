

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/pages/user_data/view/enter_user_info_view.dart';
import 'package:samrt_health/pages/user_data/view/enter_user_sport_event.dart';
import 'package:samrt_health/pages/user_data/view/intro_view.dart';

class UserDataCubit extends Cubit<StatelessWidget>{
  UserDataCubit() : super(IntroUserDataView());

  void setView(UserDataView viewTag) => emit(_getUserDataView(viewTag));

  StatelessWidget _getUserDataView(UserDataView view){
    switch(view){
      case UserDataView.INTRO_VIEW: return EnterUserInfoView();
      case UserDataView.SPORT_EVENT: return EnterUserSportEvent();
    }
    return EnterUserInfoView();
  }

}


enum UserDataView{
  INTRO_VIEW, SPORT_EVENT, ENTER_USER_INFO, EUSER_AVATAR
}