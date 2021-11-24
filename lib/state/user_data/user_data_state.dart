

import 'dart:ffi';

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

  bool get isNameValid => name.length > 3;

  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  UserDataState(
      {this.name = "",
      this.email = "",
      this.age = 0,
      this.weight = 0,
      this.height = 0,
      this.stepsPerDay = 500,
      this.avatar = "",
      this.gender = "",
      this.isVegan = false,
      this.hourSportPerWeek = 0,
      this.alcohol = 0,
      this.smoke = 0,
      this.birthday = 0 });

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
            int? birthday}) =>
      UserDataState(
          name: name ?? this.name,
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
          birthday: birthday ?? this.birthday);
}
