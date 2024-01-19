import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
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
  final userDataFromLocalDataBase =''.obs;

  UserDetails? userData;

  final dayValue = ''.obs;

  final shiftDetailsModal = Rxn<ShiftDetailsModal>();

  ShiftDetails? shiftDetails;
  List<ShiftTime>? shiftTimeList;
  ShiftTime? shiftTimeForSingleData;
  Map<String, dynamic> bodyParamsForShiftDetail = {};

  @override
   Future<void> onInit()  async {
    super.onInit();
    try{
      dataBaseCalling();
      await BottomSheetForOTP.callingGetCompanyDetailApi();
      await callingGetShiftDetailApi();
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

  Future<void> callingGetShiftDetailApi() async {
    bodyParamsForShiftDetail = {AK.action: 'getShiftDetail'};
    shiftDetailsModal.value = await CAI.getShiftDetailApi(bodyParams: bodyParamsForShiftDetail);
    if (shiftDetailsModal.value != null) {
      shiftDetails = shiftDetailsModal.value?.shiftDetails;
      shiftTimeList = shiftDetails?.shiftTime;
      day();
      shiftTimeList?.forEach((element) {
        if (dayValue.value == element.shiftDay) {
          shiftTimeForSingleData = element;
        }
      });
      if (await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForShiftDetail)) {
        await DataBaseHelper().insertInDataBase(data: {DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value), DataBaseConstant.shiftTime: json.encode(shiftTimeForSingleData)}, tableName: DataBaseConstant.tableNameForShiftDetail);
      } else {
        await DataBaseHelper().upDateDataBase(data: {DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value), DataBaseConstant.shiftTime: json.encode(shiftTimeForSingleData)}, tableName: DataBaseConstant.tableNameForShiftDetail);
      }
    }
  }

  void day() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;

    switch (currentDay) {
      case DateTime.monday:
        dayValue.value = '1';
        print('::::::::::::::::Today is Monday ::::::  $dayValue');
        break;
      case DateTime.tuesday:
        dayValue.value = '2';
        print('::::::::::::::::Today is Tuesday ::::::  $dayValue');
        break;
      case DateTime.wednesday:
        dayValue.value = '3';
        print('::::::::::::::::Today is Wednesday ::::::  $dayValue');
        break;
      case DateTime.thursday:
        dayValue.value = '4';
        print('::::::::::::::::Today is Thursday ::::::  $dayValue');
        break;
      case DateTime.friday:
        dayValue.value = '5';
        print('::::::::::::::::Today is Friday ::::::  $dayValue');
        break;
      case DateTime.saturday:
        dayValue.value = '6';
        print('::::::::::::::::Today is Saturday ::::::  $dayValue');
        break;
      case DateTime.sunday:
        dayValue.value = '0';
        print('::::::::::::::::Today is Sunday ::::::  $dayValue');
        break;
      default:
        print('Failed to determine the current day');
        break;
    }
  }

}
