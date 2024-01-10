import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/shift_details_modal.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class ShiftDetailController extends GetxController {
  final count = 0.obs;

  String? totalMinutes;
  double totalHoursFormApi = 0.0;
  int totalHoursLocal = 0;

  String? shiftStartTimeString;
  String? shiftEndTimeString;

  String? lunchBreakStartTime;
  String? lunchBreakEndTime;
  int? lunchBreakTime;

  String? lateInRelaxationText;
  String? lateInRelaxationTime;
  String? earlyOutRelaxationText;
  String? earlyOutRelaxationTime;
  String? halfDayAfterTime;
  String? halfDayBeforeTime;
  String? minHalfHours;
  String? minFullDayHours;

  final apiResValue = true.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  final dayValue = ''.obs;

  final shiftDetailsModal = Rxn<ShiftDetailsModal>();

  ShiftDetails? shiftDetails;
  List<ShiftTime>? shiftTimeList;
  ShiftTime? shiftTimeForSingleData;
  Map<String, dynamic> bodyParamsForShiftDetail = {};

  final shiftDetailsFormDataBase = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      accessType.value = Get.arguments[0];
      isChangeable.value = Get.arguments[1];
      profileMenuName.value = Get.arguments[2];
      if (await DataBaseHelper().isDatabaseHaveData(db: DataBaseHelper.dataBaseHelper, tableName: DataBaseConstant.tableNameForShiftDetail)) {
        await callingGetShiftDetailApi();
      } else {
        await setDefaultData();
      }
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
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

  Future<void> setDefaultData() async {
    shiftDetailsFormDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.shiftDetails, tableName: DataBaseConstant.tableNameForShiftDetail);
    shiftDetails = ShiftDetailsModal.fromJson(jsonDecode(shiftDetailsFormDataBase.value)).shiftDetails;
    shiftTimeList = shiftDetails?.shiftTime;
    await callingGetShiftDetailApi();
  }

  void clickOnBack() {
    Get.back();
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

  Future<void> callingGetShiftDetailApi() async {
    bodyParamsForShiftDetail = {AK.action: 'getShiftDetail'};
    shiftDetailsModal.value =
        await CAI.getShiftDetailApi(bodyParams: bodyParamsForShiftDetail);
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
        await DataBaseHelper().insertInDataBase(data: {DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value), DataBaseConstant.shiftTime: shiftTimeForSingleData?.toJson()}, tableName: DataBaseConstant.tableNameForShiftDetail);
      } else {
        await DataBaseHelper().upDateDataBase(data: {DataBaseConstant.shiftDetails: json.encode(shiftDetailsModal.value), DataBaseConstant.shiftTime: shiftTimeForSingleData?.toJson()}, tableName: DataBaseConstant.tableNameForShiftDetail);
      }
    } else {
      apiResValue.value = false;
    }
  }
}
