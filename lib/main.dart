import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samrt_health/pages/runner/runner.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late FirebaseApp firebaseApp;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Runner(),
  );
}
