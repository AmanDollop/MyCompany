import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  Database? database;
  final userDataFromLocalDataBaseValue = false.obs;
  final userDataFromLocalDataBase = ''.obs;
  final fcmId = ''.obs;

  UserDetails? userData;

  @override
   Future<void> onInit()  async {
    super.onInit();
    try{
      fcmId.value = await FirebaseMessaging.instance.getToken() ?? '';
      print('fcmId.value::::: ${fcmId.value}');
      dataBaseCalling();
      await BottomSheetForOTP.callingGetCompanyDetailApi();
      // await BottomSheetForOTP.callingGetShiftDetailApi();
      Timer(
        const Duration(seconds: 3),
        () => callingNextScreen(),
      );
    }catch(e){
      Timer(
        const Duration(seconds: 3), () => callingNextScreen(),
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
    await DataBaseHelper().createTableInDataBaseForUserDetail(db: database!);
    await DataBaseHelper().createTableInDataBaseForCompanyDetail(db: database!);
    await DataBaseHelper().createTableInDataBaseForProfileMenu(db: database!);
    await DataBaseHelper().createTableInDataBaseForShiftDetail(db: database!);
    await DataBaseHelper().createTableInDataBaseForAppMenu(db: database!);
  }

  Future<void> dataBaseCalling() async {
    database = await DataBaseHelper().openDataBase();
    if (database != null) {
      await createDataBaseTables();
      userDataFromLocalDataBaseValue.value = await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForUserDetail);
      if (!userDataFromLocalDataBaseValue.value) {
       userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);
       userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;
     }
    }
  }

  Future<void> callingNextScreen() async {
    if (userData?.token != null && userData!.token!.isNotEmpty) {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } else {
      await dataBaseDeleteMethod();
      await CM.setString(key: AK.baseUrl, value: '');
      Get.offAllNamed(Routes.SEARCH_COMPANY);
    }
  }

  Future<void> dataBaseDeleteMethod() async {
    // await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForCompanyDetail);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserDetail);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForProfileMenu);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForShiftDetail);
    await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForAppMenu);
  }


}
