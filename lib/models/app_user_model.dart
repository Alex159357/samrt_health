import 'package:samrt_health/utils/extensions.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final double weight;
  final double height;
  final double stepsPerDay;
  final String avatar;
  final String gender;
  final bool isVegan;
  final double hourSportPerWeek;
  final bool isBlocked;
  final int lastActiveDate;
  final int registrationDate;
  final String role;
  final String state;
  final int alcohol;
  final int smoke;
  final int birthday;

  factory UserModel.fromDb(Map<String, dynamic> map) => UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      weight: double.parse(map["weight"]),
      height: double.parse(map["height"]),
      stepsPerDay: double.parse(map["stepsPerDay"].toString()),
      gender: map["gender"],
      isVegan: map["isVegan"].toString().parseBool(),
      hourSportPerWeek: double.parse(map["hourSportPerWeek"]),
      isBlocked: map["isBlocked"].toString().parseBool(),
      lastActiveDate: map["lastActiveDate"],
      registrationDate: map["registrationDate"],
      role: map["role"].toString().isNotEmpty? map["role"]: "none",
      state: map["state"].toString().isNotEmpty? map["state"]: "none",
      alcohol: (map["alcohol"] as double).parseInt(),
      smoke: (map["smoke"] as double).parseInt(),
      avatar: map["avatar"],
      birthday: int.parse(map["birthday"])
  );

  static int calc_ranks(ranks) {
    double multiplier = .5;
    return (multiplier * ranks).round();
  }

  UserModel(
      {required this.alcohol,
      required this.smoke,
      required this.role,
      required this.state,
      required this.isBlocked,
      required this.lastActiveDate,
      required this.registrationDate,
      required this.gender,
      required this.isVegan,
      required this.hourSportPerWeek,
      required this.uid,
      required this.name,
      required this.email,
      required this.weight,
      required this.height,
      required this.stepsPerDay,
      required this.avatar,
      required this.birthday});

  Map<String, dynamic> get map => {
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
        "isBlocked": isBlocked,
        "lastActiveDate": lastActiveDate,
        "registrationDate": registrationDate,
        "role": role,
        "state": state,
        "alcohol": alcohol,
        "smoke": smoke,
        "birthday": birthday
      };

  Map<String, dynamic> get dbMap => {
    "uid": uid,
    "name": name,
    "avatar": avatar,
    "email": email,
    "weight": weight,
    "height": height,
    "stepsPerDay": stepsPerDay,
    "gender": gender,
    "isVegan": isVegan.toString(),
    "hourSportPerWeek": hourSportPerWeek,
    "isBlocked": isBlocked.toString(),
    "lastActiveDate": lastActiveDate,
    "registrationDate": registrationDate,
    "role": role,
    "state": state,
    "alcohol": alcohol,
    "smoke": smoke,
    "birthday": birthday
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      weight: map["weight"],
      height: map["height"],
      stepsPerDay: double.parse(map["stepsPerDay"].toString()),
      gender: map["gender"],
      isVegan: map["isVegan"],
      hourSportPerWeek: map["hourSportPerWeek"],
      isBlocked: map["isBlocked"],
      lastActiveDate: map["lastActiveDate"],
      registrationDate: map["registrationDate"],
      role: map["role"],
      state: map["state"],
      alcohol: map["alcohol"],
      smoke: map["smoke"],
      avatar: map["avatar"],
      birthday: map["birthday"]);





}

