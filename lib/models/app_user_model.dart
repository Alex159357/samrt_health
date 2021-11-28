class UserModel {
  final String uid;
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
  final bool isBlocked;
  final String lastActiveDate;
  final String registrationDate;
  final String role;
  final String state;
  final int alcohol;
  final int smoke;
  final String birthday;

  UserModel(
      {required this.alcohol,
      required this.smoke,
      required this.role,
      required this.state,
      required this.isBlocked,
      required this.lastActiveDate,
      required this.registrationDate,
      required this.age,
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
        "age": age,
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
    "birthday":birthday
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      age: map["age"],
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
      birthday: map["birthday"]
  );
}
