// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';

/// flutter pub add sqflite For Local Database
import 'package:sqflite/sqflite.dart';

import '../db_constant/db_const.dart';

class DatabaseHelper {
  static Database? db;
  static final DatabaseHelper databaseHelperInstance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return databaseHelperInstance;
  }

  Future<Database?> openDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), DBConst.databaseName),
      onCreate: (db, version) async {
        await createDatabase(db: db);
        await createUserLoginDatabase(db: db);
      },
      version: DBConst.version,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute("DROP TABLE IF EXISTS ${DBConst.tableName}");
          await db
              .execute("DROP TABLE IF EXISTS ${DBConst.tableNameUserLogin}");
          await createDatabase(db: db);
          await createUserLoginDatabase(db: db);
        }
      },
    );
    return db;
  }

  Future<void> closeDB() async {
    db?.close();
  }

  Future<void> createDatabase({required Database? db}) async {
    await db?.execute('''CREATE TABLE IF NOT EXISTS  ${DBConst.tableName}
        (${DBConst.columnId} ${DBConst.idType}
        , ${DBConst.columnName} ${DBConst.textType}
        , ${DBConst.columnEmail} ${DBConst.textType}
        , ${DBConst.columnMobile} ${DBConst.textType}
        )''');
  }

  Future<void> createUserLoginDatabase({required Database? db}) async {
    await db
        ?.execute('''CREATE TABLE IF NOT EXISTS  ${DBConst.tableNameUserLogin}
        (${DBConst.columIsLogIn} ${DBConst.textType})''');
  }

  Future<bool> insert(
      {required Map<String, dynamic> data,
      String tableName = DBConst.tableName}) async {
    int id = await db?.insert(tableName, data) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> update(
      {required Map<String, dynamic> data,
      String tableName = DBConst.tableName}) async {
    await db?.update(tableName, data);
  }

  Future<bool> deleteDatabase({String tableName = DBConst.tableName}) async {
    int id = await db?.delete(tableName) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getParticularData(
      {required String key, String tableName = DBConst.tableName}) async {
    db = await openDB();
    if (await isDatabaseEmpty(tableName: tableName)) {
      return "";
    } else {
      List<Map<String, Object?>> listOfData =
          await db?.rawQuery('SELECT * FROM $tableName') ?? [];
      return listOfData.first[key].toString();
    }
  }

  Future<void> updateParticularData(
      {required String key,
      required String val,
      String tableName = DBConst.tableName}) async {
    db = await openDB();
    Map<String, dynamic> value = {};
    value = {key: val};
    await db?.update(tableName, value,
            where: '${DBConst.columnId} = ?', whereArgs: [1]) ??
        [];
  }

  Future<bool> isDatabaseEmpty({String tableName = DBConst.tableName}) async {
    List<Map<String, Object?>> listOfData =
        await db?.rawQuery('SELECT * FROM $tableName') ?? [];
    if (listOfData.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}
