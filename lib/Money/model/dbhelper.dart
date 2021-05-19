import 'dart:io';

import 'package:day12_login/Money/model/mymoney.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
 CREATE TABLE mymoney (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 desc TEXT,
 categoryId INTEGER,
 type TEXT,
 amount INTEGER
 )
 ''');
    await db.execute('''
 CREATE TABLE category (
 categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
 categoryName TEXT
 )
 ''');
  }

//select databases
  Future<List<Map<String, dynamic>>> selectMoney() async {
    Database db = await this.initDb();
    var mapList = await db.query('mymoney', orderBy: 'id');
    return mapList;
  }

//create databases
  Future<int> insertMoney(Mymoney object) async {
    Database db = await this.initDb();
    int count = await db.insert('mymoney', object.toMap());
    return count;
  }

//update databases
  Future<int> updateMoney(Mymoney object) async {
    Database db = await this.initDb();
    int count = await db.update('mymoney', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> deleteMoney(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('mymoney', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Mymoney>> getItemList() async {
    var itemMapList = await selectMoney();
    int count = itemMapList.length;
    List<Mymoney> itemList = List<Mymoney>();
    for (int i = 0; i < count; i++) {
      itemList.add(Mymoney.fromMap(itemMapList[i]));
    }
    return itemList;
  }

 
  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
