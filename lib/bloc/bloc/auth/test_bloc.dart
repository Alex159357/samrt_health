

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc.dart';
import 'package:samrt_health/bloc/event/auth/authentication_event.dart';
import 'package:samrt_health/bloc/state/auth/authentication_state.dart';

class TextBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  TextBloc(initialState) : super(initialState);


  @override
  Stream<AuthenticationState> mapEventToState(event) async*{
    yield Uninitialized();
  }

}