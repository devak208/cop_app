import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper2 {
  static final _dbName = "comp_save.db";
  static final _dbVersion = 1;
  static final _tablename = "saved_complaint";
  static final column2user_name = 'user_name';
  static final column2email = 'email';
  static final column2date = 'date';
  static final column2address = 'address';
  static final column2phoneNumber = 'phoneNumber';
  static final column2paragraph = 'paragraph';

  DatabaseHelper2._privateConstructor();

  static final DatabaseHelper2 instance = DatabaseHelper2._privateConstructor();

  static Database? _database2;

  Future<Database?> get database async {
    if (_database2 != null) {
      return _database2;
    }
    _database2 = await _initiateDatebase2();
    return _database2;
  }

  _initiateDatebase2() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate2);
  }

  Future _onCreate2(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_tablename( 
      $column2user_name TEXt PRIMARY KEY,
      $column2email TEXT NOT NULL ,
      $column2date TEXT NOT NULL,
      $column2address TEXT NOT NULL,
      $column2phoneNumber TEXT NOT NULL,
      $column2paragraph TEXT NOT NULL )
       ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    if (db != null) {
      return await db.insert(_tablename, row);
    } else {
      throw Exception("Database is not initialized.");
    }
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    if (db != null) {
      return await db.query(_tablename);
    } else {
      throw Exception("Database is not initialized.");
    }
  }

  Future<int> delete(String username) async {
    Database? db = await instance.database;
    if (db != null) {
      return await db.delete(_tablename,
          where: '$column2user_name=?', whereArgs: [username]);
    } else {
      throw Exception("Database is not initialized.");
    }
  }
}
