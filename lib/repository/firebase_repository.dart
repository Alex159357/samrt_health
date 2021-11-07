

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../main.dart';

class FirebaseRepository{
  late DatabaseReference db;
  FirebaseRepository instance(){
    db = FirebaseDatabase(app: firebaseApp).reference();
    db.child('your_db_child').once().then((result) => print('result = $result'));
    return this;
  }

}