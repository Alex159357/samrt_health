

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class AuthRootCubit extends Cubit<bool>{
  AuthRootCubit() : super(prefs.getBool("intro") ?? false);

  void setIntroDone(bool state){
    prefs.setBool("intro", state);
    return emit(state);
  }

}