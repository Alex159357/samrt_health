

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc.dart';

class TextBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  TextBloc(initialState) : super(initialState);


  @override
  Stream<AuthenticationState> mapEventToState(event) async*{
    yield Uninitialized();
  }

}