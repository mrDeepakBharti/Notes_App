import 'dart:io' as io;

import 'package:flutter_notes_app_with_sqflite/loginModel/User.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory docunmentDirectory = await getApplicationCacheDirectory();
    String path = join(docunmentDirectory.path, 'user.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE, password TEXT)
  ''');
  }

  Future<int> insertUser(UserModel userModel) async {
    final db = await database;
    return await db!.insert("user", userModel.toMap());
  }

  Future<UserModel?> getUser(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query("user", where: 'email=?', whereArgs: [email]);
    if (result.isNotEmpty) {
      return UserModel.formap(result.first);
    }
    return null;
  }
}
