import 'package:samrt_health/models/app_user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

class UserDb {
  late Database _database;
  late String _path;
  final String _tableName = "user";

  Future<UserDb> instance() async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, 'current_user_data.db');
    await createDb();
    return this;
  }

  Future<void> createDb() async {
    _database = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS $_tableName (uid t PRIMARY KEY, name TEXT, avatar TEXT, email TEXT, weight r, height r, stepsPerDay r, gender t, isVegan t, hourSportPerWeek r, isBlocked t, lastActiveDate i, registrationDate i, role t, state t, alcohol i, smoke i, birthday r)');
    });
  }

  Future<UserModel> insertUser(UserModel userModel) async {
    await createDb();
    try {
      print("TODB -> ${userModel.map}");
      await _database.insert(_tableName, userModel.dbMap,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("ERROR INSERT");
      print(e);
      rethrow;
    } finally {
      if (_database.isOpen) {
        await _database.close();
      }
    }
    return userModel;
  }

  Future<UserModel?> readUser(String uid) async {
    print("READ DB");
    try {
      List<Map<String, Object?>> records = await _database.query(_tableName);
      // print("DB -> ${records.first}");
      if (_database.isOpen) {
        await _database.close();
      }
      print("UserFormDb");
      print("${records.first}");
      return UserModel.fromDb(records[0]);
    } catch (e) {
      print("ERROR READ");
      print(e);
      return null;
    }
  }

  Future<void> delete() async {
    await _database.delete(_tableName);
  }
}
