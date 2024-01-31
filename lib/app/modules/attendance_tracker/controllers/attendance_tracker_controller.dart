import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_monthly_attendance_data_modal.dart';
import 'package:task/common/calendar_method/calendar_method.dart';

import '../../../../common/common_methods/cm.dart';

class AttendanceTrackerController extends GetxController {
  final count = 0.obs;
  final menuName = ''.obs;
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
  final monthNameId = '1'.obs;

  List<String> yearList = <String>[
    (DateFormat('yyyy').format(DateTime.now().subtract(const Duration(days: 365)))),
    (DateFormat('yyyy').format(DateTime.now())),
    (DateFormat('yyyy').format(DateTime.now().add(const Duration(days: 365)))),
  ];

  final yearValue = '2024'.obs;

  DateTime selectedDate = DateTime.now();
  final currentMonth = DateTime.now().obs;

  final currentWeakStartDate = DateTime.now().obs;
  final currentWeakEndDate = DateTime.now().obs;

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
    const Color(0xffE4E1ED),
    const Color(0xffEEEED1),
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
    const Color(0xff4C426C),
    const Color(0xff6F7106),
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

  final cardIconsList = [
    'assets/icons/working_days_icon.png',
    'assets/icons/present_days_icon.png',
    'assets/icons/absent_days_icon.png',
    'assets/icons/late_in_icon.png',
    'assets/icons/early_out_icon.png',
    'assets/icons/extra_days_icon.png',
    'assets/icons/holiday_icon.png',
    'assets/icons/week_off_icon.png',
    'assets/icons/leaves_icon.png',
    'assets/icons/pending_attendance_icon.png',
    'assets/icons/rejected_attendance_icon.png',
    'assets/icons/punch_out_missing_icon.png',
  ];

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final monthTotalDaysList = [];
  final dayValue = ''.obs;

  final apiResValue = false.obs;
  final getMonthlyAttendanceDataModal = Rxn<GetMonthlyAttendanceDataModal>();
  GetMonthlyAttendance? getMonthlyAttendanceData;
  Map<String, dynamic> bodyParamsForMonthlyAttendanceApi={};

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      menuName.value = Get.arguments[0];
      currentWeakStartDate.value = CommonCalendarMethods.getPreviousMonday(DateTime.now());
      monthNameId.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameValue.value);
      print('monthNameId:::::  ${monthNameId.value}');
      await callingGetMonthlyAttendanceDataApi();
    }catch(e){
      apiResValue.value=false;
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


  void clickOnBackButton() {
    Get.back();
  }

  void clickOnMonthTab() {
    tabBarValue.value = 'Month';
  }

  void clickOnWeekTab() {
    tabBarValue.value = 'Week';
  }


  void monthTotalDaysListDataAdd(){
    monthTotalDaysList.clear();
    for (var i = 1; i <= 31; i++) {
      monthTotalDaysList.add(i);
    }
  }

  Future<void> monthDropDownOnChanged({required String value}) async {
    monthNameValue.value = value;
    monthNameId.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameValue.value);
    currentMonth.value = DateTime(int.parse(yearValue.value), int.parse(monthNameId.value));
    monthTotalDaysListDataAdd();
    await callingGetMonthlyAttendanceDataApi();
  }

  Future<void> yearDropDownOnChanged({required String value}) async {

    yearValue.value = value;
    monthNameId.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameValue.value);
    currentMonth.value = DateTime(int.parse(yearValue.value), int.parse(monthNameId.value));
    monthTotalDaysListDataAdd();
    await callingGetMonthlyAttendanceDataApi();
  }

  Future<void> callingGetMonthlyAttendanceDataApi() async {

    apiResValue.value = true;
    try{
      bodyParamsForMonthlyAttendanceApi = {
        AK.action : ApiEndPointAction.getMonthlyAttendanceHistoryNew,
        AK.month : monthNameId.value,
        AK.year : yearValue.value,
      };
      getMonthlyAttendanceDataModal.value = await CAI.getMonthlyAttendanceDataApi(bodyParams: bodyParamsForMonthlyAttendanceApi);
      print('getMonthlyAttendanceDataModal::::  ${getMonthlyAttendanceDataModal.value}');
      if(getMonthlyAttendanceDataModal.value != null){
        getMonthlyAttendanceData = getMonthlyAttendanceDataModal.value?.getMonthlyAttendance;
        print('getMonthlyAttendanceData:::: ${getMonthlyAttendanceData?.totalWorkingMinutes}');

        apiResValue.value=false;
      }
    }catch(e){
      apiResValue.value=false;
      print('e:::: $e');
      CM.error();
    }

  }



}
