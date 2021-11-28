import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:samrt_health/const/firebase_fields.dart';
import 'package:samrt_health/models/app_user_model.dart';

import '../main.dart';

class FirebaseRepository {
  late DatabaseReference db;
  final store = FirebaseFirestore.instance;

  FirebaseRepository instance() {
    db = FirebaseDatabase(app: firebaseApp).reference();

    // fb.child('your_db_child').once().then((result) => print('result = $result'));
    return this;
  }

  Future<UserModel?> isUserExists(String uid) async {
    var user = store.collection('users').doc(uid);
    // await user.set({
    //   'full_name': "Name", // John Doe
    //   'company': "company", // Stokes and Sons
    //   'age': "32"
    // });
    // var t = await user.get().then((value) => UserModel.fromMap(value.data()!));
    var raw = await user.get();
    if(raw.exists){
      return UserModel.fromMap(raw.data()!);
    }
    return null;
  }

  Future<UserModel?> createUser(String uid) async {
    var user = store.collection('users').doc(uid);
    await user.set(UserModel(
            alcohol: 0,
            smoke: 0,
            role: "role",
            state: "state",
            isBlocked: false,
            lastActiveDate: "lastActiveDate",
            registrationDate: "registrationDate",
            age: 0,
            gender: "gender",
            isVegan: false,
            hourSportPerWeek: 0,
            uid: "uid",
            name: "name",
            email: "email",
            weight: 0,
            height: 0,
            stepsPerDay: 0,
            avatar: "avatar", birthday: "")
        .map);
    return null;
  }
}
