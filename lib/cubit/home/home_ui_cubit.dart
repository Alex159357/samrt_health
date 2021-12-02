

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/const/ui_state.dart';

class HomeUiCubit extends Cubit<HomeUiState>{
  HomeUiCubit(HomeUiState initialState) : super(initialState);

  void action(HomeUiState action)=> emit(action);

}