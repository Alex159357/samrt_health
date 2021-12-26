import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samrt_health/data_base/user_db/user_db.dart';
import 'package:samrt_health/bloc/event/user_data/user_data_event.dart';
import 'package:samrt_health/models/app_user_model.dart';
import 'package:samrt_health/repository/firebase_repository.dart';
import 'package:samrt_health/bloc/state/form_submission_status.dart';
import 'package:samrt_health/bloc/state/user_data/user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  FirebaseRepository _repository = FirebaseRepository();
  final User user;
  final UserModel? userModel;
  final UserDb userDb;

  UserDataBloc({required this.user, required this.userDb, this.userModel})
      : super(userModel != null
            ? UserDataState().copy(
                email: userModel.email.isNotEmpty
                    ? userModel.email
                    : user.email ?? "",
                name: userModel.name.isNotEmpty
                    ? userModel.name
                    : user.displayName ?? "",
                avatar: userModel.avatar.isNotEmpty
                    ? userModel.avatar
                    : user.photoURL ?? "",
                uid: user.uid,
                height: userModel.height,
                stepsPerDay: userModel.stepsPerDay,
                gender: userModel.gender,
                isVegan: userModel.isVegan,
                hourSportPerWeek: userModel.hourSportPerWeek,
                alcohol: userModel.alcohol,
                smoke: userModel.smoke,
                birthday: userModel.birthday)
            : UserDataState().copy(
                uid: user.uid,
                email: user.email ?? "",
                name: user.displayName ?? "",
                avatar: user.photoURL ?? "",
              ));

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is OnNameChangeEvent) yield state.copy(name: event.name, ifDataChanged:  userModel != null? event.name != userModel!.name: false);
    if (event is OnEmailChangeEvent) yield state.copy(email: event.email, ifDataChanged:  userModel != null? event.email != userModel!.email: false);
    if (event is OnWeightChangeEvent) yield state.copy(weight: event.weight, ifDataChanged:  userModel != null? event.weight != userModel!.weight: false);
    if (event is OnHeightChangeEvent) yield state.copy(height: event.height, ifDataChanged: userModel != null? event.height != userModel!.height: false);
    if (event is OnStetsChangeEvent) yield state.copy(stepsPerDay: event.steps, ifDataChanged:  userModel != null? event.steps != userModel!.stepsPerDay: false);
    if (event is OnAvatarChangeEvent) yield state.copy(avatar: event.avatar, ifDataChanged:  userModel != null? event.avatar != userModel!.avatar: false);
    if (event is OnGenderChangeEvent) yield state.copy(gender: event.gender, ifDataChanged:  userModel != null? event.gender != userModel!.gender: false);
    if (event is OnVeganChangeEvent) yield state.copy(isVegan: event.ifVegan, ifDataChanged:  userModel != null? event.ifVegan != userModel!.isVegan: false);
    if (event is OnHoursSportChangeEvent) {
      yield state.copy(hourSportPerWeek: event.hourSportPerWeek, ifDataChanged: event.hourSportPerWeek != userModel!.hourSportPerWeek);
    }
    if (event is OnAlcoholChangeEvent) yield state.copy(alcohol: event.alcohol, ifDataChanged: event.alcohol != userModel!.alcohol);
    if (event is OnBirthdayChangeEvent) {
      yield state.copy(birthday: event.birthday, ifDataChanged: event.birthday != userModel!.birthday);
    }
    if (event is OnSmokeChangeEvent) yield state.copy(smoke: event.smoke, ifDataChanged: event.smoke != userModel!.smoke);
    if (event is SetUserId) yield state.copy(uid: event.uid);
    if (event is OnPictureSelected) yield state.copy(imageFile: event.image);
    if (event is UploadData) {
      yield state.copy(formStatus: FormSubmitting());
      try {
        if (state.imageFile != null) {
          var url = (await _repository.uploadImageToFirebase(
              state.imageFile!,
              "users/image/user_avatar/${state.email}_${state.uid}/${state.uid}" +
                  state.uid +
                  ".jpg"))!;
          yield state.copy(avatar: url);
        }
        await _repository.createUser(state.map());
        UserModel user = await _repository.getUser(state.uid);
        await userDb.insertUser(user);
        yield state.copy(formStatus: SubmissionSuccess(), ifDataChanged: false);
      } on Exception catch (e) {
        yield state.copy(formStatus: SubmissionFailed(e), ifDataChanged: false);
      }
    }
  }
}
