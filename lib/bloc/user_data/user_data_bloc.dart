import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/data_base/user_db/user_db.dart';
import 'package:samrt_health/event/user_data/user_data_event.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/state/form_submission_status.dart';
import 'package:samrt_health/state/user_data/user_data_state.dart';

import '../../main.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState>{
  FirebaseRepository _repository = FirebaseRepository();
  final User user;
  final UserDb userDb;

  UserDataBloc({required this.user, required this.userDb})
      : super(UserDataState(
            email: user.email ?? "",
            name: user.displayName ?? "",
            avatar: user.photoURL ?? "", uid: user.uid));

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is OnNameChangeEvent) yield state.copy(name: event.name);
    if (event is OnEmailChangeEvent) yield state.copy(email: event.email);
    if (event is OnWeightChangeEvent) yield state.copy(weight: event.weight);
    if (event is OnHeightChangeEvent) yield state.copy(height: event.height);
    if (event is OnStetsChangeEvent) yield state.copy(stepsPerDay: event.steps);
    if (event is OnAvatarChangeEvent) yield state.copy(avatar: event.avatar);
    if (event is OnGenderChangeEvent) yield state.copy(gender: event.gender);
    if (event is OnVeganChangeEvent) yield state.copy(isVegan: event.ifVegan);
    if (event is OnHoursSportChangeEvent) {
      yield state.copy(hourSportPerWeek: event.hourSportPerWeek);
    }
    if (event is OnAlcoholChangeEvent) yield state.copy(alcohol: event.alcohol);
    if (event is OnBirthdayChangeEvent) {
      yield state.copy(birthday: event.birthday);
    }
    if (event is OnSmokeChangeEvent) yield state.copy(smoke: event.smoke);
    if (event is SetUserId) yield state.copy(uid: event.uid);
    if (event is OnPictureSelected) yield state.copy(imageFile: event.image);
    if (event is UploadData) {
      yield state.copy(formStatus: FormSubmitting());
      try {
        if (state.imageFile != null) {
          var url = (await _repository.uploadImageToFirebase(state.imageFile!,
              "users/image/user_avatar/${state.email}_${state.uid}/${state.uid}" + state.uid + ".jpg"))!;
          yield state.copy(avatar: url);
        }
        await _repository.createUser(state.map());
        UserModel user = await _repository.getUser(state.uid);
        await userDb.insertUser(user);
        yield state.copy(formStatus: SubmissionSuccess());
      } on Exception catch (e) {
        yield state.copy(formStatus: SubmissionFailed(e));
      }
    }
  }
}
