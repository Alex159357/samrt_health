import 'dart:ffi';

import 'dart:io';

import '../form_submission_status.dart';

class UserDataState {
  final String name;
  final String email;
  final int age;
  final double weight;
  final double height;
  final double stepsPerDay;
  final String avatar;
  final String gender;
  final bool isVegan;
  final double hourSportPerWeek;
  final int alcohol;
  final int smoke;
  final int birthday;
  final File? imageFile;
  final String uid;
  final FormSubmissionStatus formStatus;
  final bool ifDataChanged;

  bool get isNameValid => name.length >= 3;

  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  UserDataState(
      {this.ifDataChanged = false,
      this.name = "",
      this.email = "",
      this.age = 0,
      this.weight = 40,
      this.height = 143,
      this.stepsPerDay = 500,
      this.avatar = "",
      this.gender = "others",
      this.isVegan = false,
      this.hourSportPerWeek = 0,
      this.alcohol = 0,
      this.smoke = 0,
      this.birthday = 600469200000,
      this.imageFile,
      this.uid = "",
      this.formStatus = const InitialFormStatus()});

  UserDataState copy(
          {String? name,
          String? email,
          int? age,
          double? weight,
          double? height,
          double? stepsPerDay,
          String? avatar,
          String? gender,
          bool? isVegan,
          double? hourSportPerWeek,
          int? alcohol,
          int? smoke,
          int? birthday,
          File? imageFile,
          FormSubmissionStatus? formStatus,
            bool? ifDataChanged,
          String? uid}) =>
      UserDataState(
        name: name ?? this.name,
        email: email ?? this.email,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        stepsPerDay: stepsPerDay ?? this.stepsPerDay,
        avatar: avatar ?? this.avatar,
        gender: gender ?? this.gender,
        isVegan: isVegan ?? this.isVegan,
        hourSportPerWeek: hourSportPerWeek ?? this.hourSportPerWeek,
        alcohol: alcohol ?? this.alcohol,
        smoke: smoke ?? this.smoke,
        birthday: birthday ?? this.birthday,
        imageFile: imageFile ?? this.imageFile,
        uid: uid ?? this.uid,
        formStatus: formStatus ?? this.formStatus,
        ifDataChanged: ifDataChanged ?? this.ifDataChanged
      );

  Map<String, dynamic> map() => {
        "uid": uid,
        "name": name,
        "avatar": avatar,
        "email": email,
        "weight": weight,
        "height": height,
        "stepsPerDay": stepsPerDay,
        "gender": gender,
        "isVegan": isVegan,
        "hourSportPerWeek": hourSportPerWeek,
        "isBlocked": false,
        "lastActiveDate": DateTime.now().microsecond,
        "registrationDate": DateTime.now().microsecond,
        "role": "",
        "state": "",
        "alcohol": alcohol,
        "smoke": smoke,
        "birthday": birthday
      };
}
