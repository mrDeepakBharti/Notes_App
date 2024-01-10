import 'dart:io' as io;

import 'package:flutter_notes_app_with_sqflite/notes.dart/Notes.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBNotes {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    io.Directory docunmentDirectory = await getApplicationCacheDirectory();
    String path = join(docunmentDirectory.path, "notes.db");
    var db = openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    return db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY,title TEXT,description TEXT)");
  }

  Future<Notes> insertData(
    Notes notes,
  ) async {
    var dbClient = await db;
    dbClient!.insert("notes", notes.tomap());
    return notes;
  }

  Future<List<Notes>> getData() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient!.query("notes");
    return result.map((e) => Notes.fromMap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return dbClient!.delete("notes", where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateData(Notes no) async {
    var dbClient = await db;
    return dbClient!
        .update("notes", no.tomap(), where: 'id=?', whereArgs: [no.id]);
  }
}
