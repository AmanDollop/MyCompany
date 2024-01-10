// ignore_for_file: depend_on_referenced_packages

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

  createTableInDataBaseForCompanyDetail({required Database db}) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForCompanyDetail}  
        (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
        , ${DataBaseConstant.companyDetail} ${DataBaseType.textType}
        )''');
  }

  createTableInDataBaseForUserDetail({required Database db}) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForUserDetail}  
        (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
        , ${DataBaseConstant.userDetail} ${DataBaseType.textType}
        )''');
  }

  // createTableInDataBaseForToken({required Database db}) async {
  //   await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForUserToken}
  //       (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
  //       , ${DataBaseConstant.userToken} ${DataBaseType.textType}
  //       )''');
  // }
  //
  // createTableInDataBaseForPersonalInfo({required Database db}) async {
  //   await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForPersonalInfo}
  //       (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
  //       , ${DataBaseConstant.companyId} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userFirstName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userMiddleName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userLastName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userFullName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.gender} ${DataBaseType.textType}
  //       , ${DataBaseConstant.bloodGroup} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userProfilePic} ${DataBaseType.textType}
  //       , ${DataBaseConstant.memberDatePOfBirth} ${DataBaseType.textType}
  //       , ${DataBaseConstant.hobbiesAndInterest} ${DataBaseType.textType}
  //       , ${DataBaseConstant.skills} ${DataBaseType.textType}
  //       , ${DataBaseConstant.languageKnown} ${DataBaseType.textType}
  //       , ${DataBaseConstant.shortName} ${DataBaseType.textType}
  //       )''');
  // }
  //
  // createTableInDataBaseForContactInfo({required Database db}) async {
  //   await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForContactInfo}
  //       (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
  //       , ${DataBaseConstant.countryCode} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userMobile} ${DataBaseType.textType}
  //       , ${DataBaseConstant.whatsappCountryCode} ${DataBaseType.textType}
  //       , ${DataBaseConstant.whatsappNumber} ${DataBaseType.textType}
  //       , ${DataBaseConstant.personalEmail} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userEmail} ${DataBaseType.textType}
  //       , ${DataBaseConstant.currentAddress} ${DataBaseType.textType}
  //       , ${DataBaseConstant.permanentAddress} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userMobilePrivacy} ${DataBaseType.textType}
  //       , ${DataBaseConstant.whatsappNumberPrivacy} ${DataBaseType.textType}
  //       , ${DataBaseConstant.userEmailPrivacy} ${DataBaseType.textType}
  //       , ${DataBaseConstant.personalEmailPrivacy} ${DataBaseType.textType}
  //       , ${DataBaseConstant.currentAddressPrivacy} ${DataBaseType.textType}
  //       , ${DataBaseConstant.permanentAddressPrivacy} ${DataBaseType.textType}
  //       )''');
  // }
  //
  // createTableInDataBaseForJobInfo({required Database db}) async {
  //   await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForJobInfo}
  //       (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
  //       , ${DataBaseConstant.userDesignation} ${DataBaseType.textType}
  //       , ${DataBaseConstant.dateOfJoining} ${DataBaseType.textType}
  //       , ${DataBaseConstant.employeeId} ${DataBaseType.textType}
  //       , ${DataBaseConstant.employeeType} ${DataBaseType.textType}
  //       , ${DataBaseConstant.employeeTypeView} ${DataBaseType.textType}
  //       , ${DataBaseConstant.branchName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.departmentName} ${DataBaseType.textType}
  //       , ${DataBaseConstant.branchId} ${DataBaseType.textType}
  //       , ${DataBaseConstant.departmentId} ${DataBaseType.textType}
  //       )''');
  // }
  //
  // createTableInDataBaseForSocialInfo({required Database db}) async {
  //   await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForSocialInfo}
  //       (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
  //       , ${DataBaseConstant.twitter} ${DataBaseType.textType}
  //       , ${DataBaseConstant.linkedin} ${DataBaseType.textType}
  //       , ${DataBaseConstant.instagram} ${DataBaseType.textType}
  //       , ${DataBaseConstant.facebook} ${DataBaseType.textType}
  //       , ${DataBaseConstant.socialLinksPrivacy} ${DataBaseType.textType}
  //       )''');
  // }

  createTableInDataBaseForProfileMenu({required Database db}) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForProfileMenu}  
        (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
        , ${DataBaseConstant.profileMenuDetails} ${DataBaseType.textType}
        )''');
  }

  createTableInDataBaseForShiftDetail({required Database db}) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${DataBaseConstant.tableNameForShiftDetail}  
        (${DataBaseConstant.columnId} ${DataBaseType.autoIncrementUserId}
        , ${DataBaseConstant.shiftDetails} ${DataBaseType.textType}
        , ${DataBaseConstant.shiftTime} ${DataBaseType.textType}
        )''');
  }

  insertInDataBase({required Map<String, dynamic> data,required String tableName}) async {
    int id = await dataBaseHelper?.insert(tableName, data) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }

  upDateDataBase({required Map<String, dynamic> data,required String tableName}) async {
     int id = await dataBaseHelper?.update(tableName, data,where:DataBaseConstant.columnId) ?? -1;
     if (id != -1) {
       return true;
     } else {
       return false;
     }
  }

  Future<int?> deleteDataBase({required String tableName}) async {
    return await dataBaseHelper?.delete(tableName);
  }

  Future<String> getParticularData({required String key, required String tableName}) async {
    dataBaseHelper = await openDataBase();
    if (!await isDatabaseHaveData(db: dataBaseHelper,tableName: tableName)) {
      List<Map<String, Object?>> listOfData = await dataBaseHelper?.rawQuery('SELECT * FROM $tableName') ?? [];
      return listOfData.first[key].toString();
    } else {
      return "";
    }
  }

  Future<bool> isDatabaseHaveData({required Database? db,required String tableName}) async {
    List<Map<String, Object?>> listOfData = await db?.rawQuery('SELECT * FROM ${tableName}') ?? [];
    if (listOfData.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}