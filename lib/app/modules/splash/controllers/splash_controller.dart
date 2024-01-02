import 'dart:async';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  Database? database;
  String? token;

  @override
   Future<void> onInit()  async {
    super.onInit();
    try{
      dataBaseCalling();
      // await BottomSheetForOTP.callingGetCompanyDetailApi();
      Timer(
        const Duration(seconds: 3),
            () => callingNextScreen(),
      );
    }catch(e){
      Timer(
        const Duration(seconds: 3),
            () => callingNextScreen(),
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;


  Future<void> createDataBaseTables() async {
    await DataBaseHelper().createTableInDataBaseForToken(db: database!);
    await DataBaseHelper().createTableInDataBaseForPersonalInfo(db: database!,);
    await DataBaseHelper().createTableInDataBaseForContactInfo(db: database!);
    await DataBaseHelper().createTableInDataBaseForJobInfo(db: database!);
    await DataBaseHelper().createTableInDataBaseForSocialInfo(db: database!);
    await DataBaseHelper().createTableInDataBaseForCompanyDetail(db: database!);
  }

  Future<void> dataBaseCalling() async {
    database = await DataBaseHelper().openDataBase();
    if (database != null) {
      await createDataBaseTables();
      token = await DataBaseHelper().getParticularData(key: 'token',tableName: DataBaseConstant.tableNameForUserToken);
    }
  }

  Future<void> callingNextScreen() async {
    if (token != 'null' && token!.isNotEmpty) {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } else {
      await dataBaseDeleteMethod();
      await CM.setString(key: AK.baseUrl, value: '');
      Get.offAllNamed(Routes.SEARCH_COMPANY);
    }
  }

  Future<void> dataBaseDeleteMethod() async {
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserToken);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForPersonalInfo);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForContactInfo);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForJobInfo);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForSocialInfo);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForCompanyDetail);
  }

}
