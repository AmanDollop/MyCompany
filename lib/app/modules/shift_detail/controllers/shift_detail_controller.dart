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
      await setDefaultData();
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
  }

  void clickOnBack() {
    Get.back();
  }




}
