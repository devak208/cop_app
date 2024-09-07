import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper {
  static final _dbName = "compl.db";
  static final _dbVersion = 1;
  static final _tablename = "myTable";
  static final columnuser_name = 'user_name';
  static final columnemail = 'email';
  static final columndate = 'date';
  static final columnaddress = 'address';
  static final columnphoneNumber = 'phoneNumber';
  static final columnparagraph = 'paragraph';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatebase();
    return _database;
  }

  _initiateDatebase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print('db location: ' + directory.path);

    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_tablename( 
      $columnuser_name TEXt PRIMARY KEY,
      $columnemail TEXT NOT NULL ,
      $columndate TEXT NOT NULL,
      $columnaddress TEXT NOT NULL,
      $columnphoneNumber TEXT NOT NULL,
      $columnparagraph TEXT NOT NULL )
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
          where: '$columnuser_name=?', whereArgs: [username]);
    } else {
      throw Exception("Database is not initialized.");
    }
  }
}
