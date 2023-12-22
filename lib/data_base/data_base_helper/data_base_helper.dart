import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';

class DataBaseHelper {
  static Database? dataBaseHelper;

  static final DataBaseHelper _dataBaseHelper = DataBaseHelper._privetConstructor();

  DataBaseHelper._privetConstructor();

  factory DataBaseHelper() {
    return _dataBaseHelper;
  }

  Future<Database?> openDataBase() async {
    dataBaseHelper = await openDatabase(
      join(await getDatabasesPath(), DataBaseConstant.dataBaseName),
    );
    return dataBaseHelper;
  }

  closeDataBase() async {
    Database? database = await openDataBase();
    database?.close();
  }

  createTableInDataBase(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableName}  
        (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
        , ${DataBaseConstant.userId} ${DataBaseType.textType}
        , ${DataBaseConstant.companyId} ${DataBaseType.textType}
        , ${DataBaseConstant.emailId} ${DataBaseType.textType}
        , ${DataBaseConstant.userToken} ${DataBaseType.textType}
        )''');
  }

  insertInDataBase({required Map<String, dynamic> data}) async {
    int id = await dataBaseHelper?.insert(DataBaseConstant.tableName, data) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }

  upDateDataBase({required Map<String, dynamic> data}) async {
     int id = await dataBaseHelper?.update(DataBaseConstant.tableName, data,where:DataBaseConstant.columnId) ?? -1;
     if (id != -1) {
       return true;
     } else {
       return false;
     }
  }

  Future<int?> deleteDataBase() async {
    return await dataBaseHelper?.delete(DataBaseConstant.tableName);
  }

  Future<String> getParticularData({required String key, }) async {
    dataBaseHelper = await openDataBase();
    if (!await isDatabaseHaveData(db: dataBaseHelper)) {
      List<Map<String, Object?>> listOfData =
          await dataBaseHelper?.rawQuery('SELECT * FROM ${DataBaseConstant.tableName}') ?? [];
      return listOfData.first[key].toString();
    } else {
      return "";
    }
  }

  Future<bool> isDatabaseHaveData({required Database? db}) async {
    List<Map<String, Object?>> listOfData = await db?.rawQuery('SELECT * FROM ${DataBaseConstant.tableName}') ?? [];
    if (listOfData.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}