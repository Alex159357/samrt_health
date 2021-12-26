import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/bloc/event/home/home/home_ui_event.dart';
import 'package:samrt_health/bloc/state/home/home/home_ui_state.dart';



class HomeMainUiBloc extends Bloc<HomeUiEvent, HomeMainUiState>{
  HomeMainUiBloc() : super(HomeMainUiState());

  @override
  void onChange(Change<HomeMainUiState> change) {

    super.onChange(change);
  }

  @override
  Stream<HomeMainUiState> mapEventToState(HomeUiEvent event) async*{
    if(event is ToggleBSEvent){
      yield state.copyWith(ifActionsOpened: event.ifExpanded);
    }
  }

}