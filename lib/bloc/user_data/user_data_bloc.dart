import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/event/user_data/user_data_event.dart';
import 'package:samrt_health/state/user_data/user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataState());

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is OnNameChangeEvent) yield state.copy(name: event.name);
    if (event is OnEmailChangeEvent) yield state.copy(email: event.email);
    if (event is OnEgeChangeEvent) yield state.copy(age: event.age);
    if (event is OnWeightChangeEvent) yield state.copy(weight: event.weight);
    if (event is OnHeightChangeEvent) yield state.copy(height: event.height);
    if (event is OnStetsChangeEvent) yield state.copy(stepsPerDay: event.steps);
    if (event is OnAvatarChangeEvent) yield state.copy(avatar: event.avatar);
    if (event is OnGenderChangeEvent) yield state.copy(gender: event.gender);
    if (event is OnVeganChangeEvent) yield state.copy(isVegan: event.ifVegan);
    if (event is OnHoursSportChangeEvent) yield state.copy(hourSportPerWeek: event.hourSportPerWeek);
    if (event is OnAlcoholChangeEvent) yield state.copy(alcohol: event.alcohol);
    if(event is OnBirthdayChangeEvent) yield state.copy(birthday: event.birthday);
    if(event is OnSmokeChangeEvent) yield state.copy(smoke: event.smoke);
  }
}
