import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';

class AddLeaveController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;
  final pageName = ''.obs;

  final applyLeaveButtonValue = false.obs;

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final monthTotalDaysList = [];
  final currentMonth = DateTime.now().obs;

  final dateAddForLeaveList = [];
  List<String> formattedDateListForApi = [];

  final leaveTypeController = TextEditingController();
  final reasonController = TextEditingController();

  final fullAndHalfDayText = ['Full Day', 'Half Day'];
  final fullAndHalfDayIndexValue = '-1'.obs;
  final fullAndHalfDayType = ''.obs;

  final firstAndSecondHalfText = ['First Half', 'Second Half'];
  final firstAndSecondHalfIndexValue = '-1'.obs;
  final firstAndSecondHalfType = ''.obs;

  final paidAndUnPaidText = ['Paid', 'UnPaid'];
  final paidAndUnPaidIndexValue = '-1'.obs;
  final paidAndUnPaidType = ''.obs;


  @override
  void onInit() {
    super.onInit();
    pageName.value = Get.arguments[0];
    print('pageName.value::::: ${pageName.value}');
    print('year:::: ${currentMonth.value.year}  month:::: ${currentMonth.value.month}');
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

  void clickOnBackButton() {
    Get.back();
  }

  void monthTotalDaysListDataAdd() {
    monthTotalDaysList.clear();
    for (var i = 1; i <= 31; i++) {
      monthTotalDaysList.add(i);
    }
  }

  void clickOnReverseIconButton({required index}) {
    CM.unFocusKeyBoard();
    currentMonth.value = CMForDateTime.subtractMonths(date: currentMonth.value,months: 1);
    print('year:::: ${currentMonth.value.year}  month:::: ${currentMonth.value.month}');
  }

  void clickOnForwardIconButton({required index}) {
    CM.unFocusKeyBoard();
    currentMonth.value = CMForDateTime.addMonths(date: currentMonth.value,months: 1);
    print('year:::: ${currentMonth.value.year}  month:::: ${currentMonth.value.month}');
  }

  void clickOnAttachmentButton() {
    CM.unFocusKeyBoard();
  }

  void clickOnApplyLeaveButton() {}



}
