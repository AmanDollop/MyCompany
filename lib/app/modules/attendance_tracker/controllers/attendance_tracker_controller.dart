import 'dart:ui';

import 'package:get/get.dart';

class AttendanceTrackerController extends GetxController {
  final count = 0.obs;

  List<String> monthNameList = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final monthNameValue = 'January'.obs;
  final monthNameId = ''.obs;

  List<String> yearList = <String>[
    '2023',
    '2024',
    '2025',
  ];

  final yearValue = '2024'.obs;

  DateTime selectedDate = DateTime.now();
  final currentMonth = DateTime.now().obs;

  final tabBarValue = 'Month'.obs;

  final cardColorList = [
    const Color(0xffFFF2D8),
    const Color(0xffF2FFF3),
    const Color(0xffFFD9D9),
    const Color(0xffE6E6E6),
    const Color(0xffC7EEF4),
    const Color(0xffFFE9FD),
    const Color(0xffDDE0FB),
    const Color(0xffFFE9DD),
    const Color(0xffE0F1FF),
    const Color(0xffFFE2D3),
    const Color(0xffFFDAE7),
    const Color(0xffFEFFE1),
  ];

  final cardTextColorList = [
    const Color(0xffE09701),
    const Color(0xff02930D),
    const Color(0xffCE1212),
    const Color(0xff616161),
    const Color(0xff006E80),
    const Color(0xffCC08BA),
    const Color(0xff0717AF),
    const Color(0xffAA3B00),
    const Color(0xff249CFF),
    const Color(0xffFF5700),
    const Color(0xffFC327B),
    const Color(0xff707205),
  ];

  final cardTitleTextList = [
    'Working Days',
    'Present Days',
    'Absent Days',
    'Late In',
    'Early Out',
    'Extra Days',
    'Holiday',
    'Week Off',
    'Leaves',
    'Pending Attendance',
    'Rejected Attendance',
    'Punch out Missing',
  ];

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final monthTotalDaysList = [];
  final dayValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
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

  void clickOnMonthTab() {
    tabBarValue.value = 'Month';
  }

  void clickOnWeekTab() {
    tabBarValue.value = 'Week';
  }

  void getMonth() {

    if (monthNameValue.value == 'January') {
      monthNameId.value = '1';
    } else if (monthNameValue.value == 'February') {
      monthNameId.value = '2';
    } else if (monthNameValue.value == 'March') {
      monthNameId.value = '3';
    } else if (monthNameValue.value == 'April') {
      monthNameId.value = '4';
    } else if (monthNameValue.value == 'May') {
      monthNameId.value = '5';
    } else if (monthNameValue.value == 'June') {
      monthNameId.value = '6';
    } else if (monthNameValue.value == 'July') {
      monthNameId.value = '7';
    } else if (monthNameValue.value == 'August') {
      monthNameId.value = '8';
    } else if (monthNameValue.value == 'September') {
      monthNameId.value = '9';
    } else if (monthNameValue.value == 'October') {
      monthNameId.value = '10';
    } else if (monthNameValue.value == 'November') {
      monthNameId.value = '11';
    } else if (monthNameValue.value == 'December') {
      monthNameId.value = '12';
    } else {
      monthNameId.value = '0';
    }
  }

  void monthTotalDaysListDataAdd(){
    monthTotalDaysList.clear();
    for (var i = 1; i <= 31; i++) {
      monthTotalDaysList.add(i);
    }
  }

  void monthDropDownOnChanged({required String value}) {
    monthNameValue.value = value;
    getMonth();
    currentMonth.value = DateTime(int.parse(yearValue.value), int.parse(monthNameId.value));
    monthTotalDaysListDataAdd();
  }

  void yearDropDownOnChanged({required String value}) {
    yearValue.value = value;
    getMonth();
    currentMonth.value = DateTime(int.parse(yearValue.value), int.parse(monthNameId.value));
    monthTotalDaysListDataAdd();
  }

}
