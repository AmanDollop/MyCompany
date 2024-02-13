import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_monthly_attendance_data_modal.dart';
import 'package:task/app/modules/attendance_tracker/views/month_view.dart';
import 'package:task/common/calendar_method/calendar_method.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../../../../common/common_methods/cm.dart';

class AttendanceTrackerController extends GetxController {
  final count = 0.obs;
  final menuName = ''.obs;
  List<String> monthNameList = [
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
    (DateFormat('yyyy')
        .format(DateTime.now().subtract(const Duration(days: 365)))),
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

  final cardSubTitleTextList = [];

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
  String? totalHours;

  final apiResValue = false.obs;
  final calendarGridClickValue = false.obs;
  final bottomSheetBreakListValue = false.obs;
  final getMonthlyAttendanceDataModal = Rxn<GetMonthlyAttendanceDataModal>();
  GetMonthlyAttendance? getMonthlyAttendanceData;
  List<MonthlyHistory>? monthlyHistoryList;
  Map<String, dynamic> bodyParamsForMonthlyAttendanceApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      menuName.value = Get.arguments[0];
      currentWeakStartDate.value = CommonCalendarMethods.getPreviousMonday(DateTime.now());
      monthNameValue.value = monthNameList[DateTime.now().month - 1];
      monthNameId.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameValue.value);

      await callingGetMonthlyAttendanceDataApi();
    } catch (e) {
      apiResValue.value = false;
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

  void monthTotalDaysListDataAdd() {
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

  Future<void> monthViewOnRefresh() async {
    apiResValue.value = true;
    onInit();
    currentMonth.value =
        DateTime(int.parse(yearValue.value), int.parse(monthNameId.value));
  }

  Future<void> callingGetMonthlyAttendanceDataApi() async {
    apiResValue.value = true;
    try {
      bodyParamsForMonthlyAttendanceApi = {
        AK.action: ApiEndPointAction.getMonthlyAttendanceHistoryNew,
        AK.month: monthNameId.value,
        AK.year: yearValue.value,
      };
      getMonthlyAttendanceDataModal.value = await CAI.getMonthlyAttendanceDataApi(bodyParams: bodyParamsForMonthlyAttendanceApi);
      if (getMonthlyAttendanceDataModal.value != null) {
        getMonthlyAttendanceData = getMonthlyAttendanceDataModal.value?.getMonthlyAttendance;
        setDataInCard();
        monthlyHistoryList = getMonthlyAttendanceData?.monthlyHistory;
        print('monthlyHistoryList:::: ${monthlyHistoryList?.length}');
        apiResValue.value = false;
      }
    } catch (e) {
      apiResValue.value = false;
      print('e:::: $e');
      CM.error();
    }
  }

  void setDataInCard() {
    cardSubTitleTextList.insert(0, getMonthlyAttendanceData?.totalWorkingDays??'0');
    cardSubTitleTextList.insert(1, getMonthlyAttendanceData?.totalPresent??'0');
    cardSubTitleTextList.insert(2, getMonthlyAttendanceData?.totalAbsent??'0');
    cardSubTitleTextList.insert(3, getMonthlyAttendanceData?.lateIn??'0');
    cardSubTitleTextList.insert(4, getMonthlyAttendanceData?.earlyOut??'0');
    cardSubTitleTextList.insert(5, getMonthlyAttendanceData?.totalExtraDays??'0');
    cardSubTitleTextList.insert(6, getMonthlyAttendanceData?.totalHolidays??'0');
    cardSubTitleTextList.insert(7, getMonthlyAttendanceData?.totalWeekOff??'0');
    cardSubTitleTextList.insert(8, getMonthlyAttendanceData?.isLeave??'0');
    cardSubTitleTextList.insert(9, getMonthlyAttendanceData?.totalPendingAttendance??'0');
    cardSubTitleTextList.insert(10, getMonthlyAttendanceData?.totalRejectedAttendance??'0');
    cardSubTitleTextList.insert(11, getMonthlyAttendanceData?.totalPunchOutMissing??'0');
  }

  String calculateTime({required String startDateTimeString,required String endDateTimeString}){
    DateTime startTime = DateTime.parse(startDateTimeString);
    DateTime endTime = DateTime.parse(endDateTimeString);

    if (endTime.isBefore(startTime)) {
     endTime = endTime.add(const Duration(days: 1)); // Add 24 hours
   }

   Duration difference = endTime.difference(startTime);

   int totalHours = difference.inHours;
   int totalMinutes = (difference.inMinutes % 60);
   int totalSeconds = (difference.inSeconds % 60);

   int formattedHours = totalHours % 12;
   String amPm = totalHours >= 12 ? 'pm' : 'am';
    // return '$formattedHours hr $totalMinutes min $totalSeconds sec $amPm';
    return '${formattedHours}hr ${totalMinutes}min';
  }

  Future<void> clickOnCalendarGrid({required int index, required day}) async {

    DateTime dateTime = DateTime(
      int.parse('${currentMonth.value.year}'),
      int.parse('${currentMonth.value.month}'),
      int.parse('$day'),
    );

    if(monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty
        && monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
        && monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty
        && monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty){
      totalHours = calculateTime(startDateTimeString: '${monthlyHistoryList?[index].punchInDate} ${monthlyHistoryList?[index].punchInTime}',endDateTimeString: '${monthlyHistoryList?[index].punchOutDate} ${monthlyHistoryList?[index].punchOutTime}');
    }else{
      totalHours = 'NIL';
    }

    calendarGridClickValue.value = true;
    await CBS.commonBottomSheet(
      isDismissible: false,
      children: [
        Obx(() {
          count.value;
          return Column(
            children: [
              Text(
                DateFormat('EEEE, d MMM y').format(dateTime),
                style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              if (monthlyHistoryList?[index].present == true)
              SizedBox(height: 16.px),
              if (monthlyHistoryList?[index].present == true)
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.px),
                ),
                color: Col.primary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonCardTimeTextView(title: 'Productive Hours', subTitle: '${1300 ~/ 60}hr ${1300 % 60}min'),
                      commonCardTimeVerticalDividerView(),
                      commonCardTimeTextView(title: 'Total Hours', subTitle: '${2600 ~/ 60}hr ${2600 % 60}min'),
                      commonCardTimeVerticalDividerView(),
                      commonCardTimeTextView(title: 'Extra Hours', subTitle: '${1600 ~/ 60}hr ${1600 % 60}min'),
                    ],
                  ),
                ),
              ),
              if (monthlyHistoryList?[index].present == true)
              SizedBox(height: 16.px),
              if (monthlyHistoryList?[index].present == true)
              if(monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty
                  && monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
                  || monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty
                  && monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty)
                Obx(() {
                  count.value;
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Col.primary,width: .5.px),
                        borderRadius: BorderRadius.circular(6.px)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 12.px),
                    child: Column(
                      children: [
                        if(monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty
                            && monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
                            || monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty
                                && monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTextForCheckInOrCheckOutView(
                                title: 'Punch In',
                                subTitle: monthlyHistoryList?[index].punchInDate != '0000-00-00' && monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty
                                    ? DateFormat('d MMM y').format(DateTime.parse('${monthlyHistoryList?[index].punchInDate}'))
                                    : '0000-00-00',
                                timeText: monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
                                    ? '${monthlyHistoryList?[index].punchInTime}'
                                    : 'NIL',
                              ),
                              commonTextForCheckInOrCheckOutView(
                                title: 'Punch Out',
                                subTitle: monthlyHistoryList?[index].punchOutDate != '0000-00-00' && monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty
                                    ? DateFormat('d MMM y').format(DateTime.parse('${monthlyHistoryList?[index].punchOutDate}'))
                                    : "0000-00-00",
                                timeText: monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty
                                    ? '${monthlyHistoryList?[index].punchOutTime}'
                                    : "NIL",
                              ),
                              commonTextForCheckInOrCheckOutView(title: 'Total Hours', timeText: totalHours ?? 'NIL'),
                            ],
                          ),
                        if(monthlyHistoryList?[index].attendanceBreakHistory != null &&  monthlyHistoryList![index].attendanceBreakHistory!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Dash(
                                  direction: Axis.horizontal,
                                  length: 62.w,
                                  dashLength: 5.px,
                                  dashThickness: .5.px,
                                  dashColor: Col.secondary),
                              CW.commonTextButton(
                                onPressed: (){
                                  bottomSheetBreakListValue.value = !bottomSheetBreakListValue.value;
                                },
                                child: Row(
                                  children: [
                                    Text('Show Break',style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.primary,fontSize: 10.px),),
                                    Icon(bottomSheetBreakListValue.value?Icons.arrow_drop_up:Icons.arrow_drop_down,size: 22.px,color: Col.primary,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        if(monthlyHistoryList?[index].attendanceBreakHistory != null &&  monthlyHistoryList![index].attendanceBreakHistory!.isNotEmpty)
                          AnimatedCrossFade(
                            sizeCurve: Curves.easeInOutCubicEmphasized,
                            firstCurve: Curves.easeInOutCubicEmphasized,
                            reverseDuration: const Duration(microseconds: 0),
                            firstChild: const SizedBox(),
                            secondChild: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: monthlyHistoryList?[index].attendanceBreakHistory?.length,
                              itemBuilder: (context, attendanceBreakHistoryIndex) {
                                List<AttendanceBreakHistory>? attendanceBreakHistory = monthlyHistoryList?[index].attendanceBreakHistory;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakTypeName}',
                                          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          int.parse('${attendanceBreakHistory?[attendanceBreakHistoryIndex].totalBreakTimeMinutes}') ~/ 60 != 0
                                              ? '${int.parse('${attendanceBreakHistory?[attendanceBreakHistoryIndex].totalBreakTimeMinutes}') ~/ 60} hr ${int.parse('${attendanceBreakHistory?[attendanceBreakHistoryIndex].totalBreakTimeMinutes}') % 60} min'
                                              : '${int.parse('${attendanceBreakHistory?[attendanceBreakHistoryIndex].totalBreakTimeMinutes}') % 60} min',
                                          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Col.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.px),
                                    Text(
                                      '${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakStartTime} - ${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakEndTime}',
                                      style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    if(attendanceBreakHistory?.length != attendanceBreakHistoryIndex+1)
                                      SizedBox(height: 10.px),
                                    if(attendanceBreakHistory?.length != attendanceBreakHistoryIndex+1)
                                      Center(
                                        child: Dash(
                                            direction: Axis.horizontal,
                                            length: 86.w,
                                            dashLength: 5.px,
                                            dashThickness: .5.px,
                                            dashColor: Col.secondary),
                                      ),
                                    if(attendanceBreakHistory?.length != attendanceBreakHistoryIndex+1)
                                      SizedBox(height: 10.px),
                                  ],
                                );
                              },
                            ),
                            crossFadeState: bottomSheetBreakListValue.value
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 500),
                            secondCurve: Curves.easeInOutSine,
                          ),
                      ],
                    ),
                  );
                }),
              if (monthlyHistoryList?[index].present == false || monthlyHistoryList?[index].attendnacePending == true || monthlyHistoryList?[index].weekOff == true || monthlyHistoryList?[index].holiday == true)
                SizedBox(height: 16.px),
              Text(
                monthlyHistoryList?[index].attendnacePending ?? false
                    ? 'Attendance Pending'
                    : monthlyHistoryList?[index].weekOff ?? false
                    ? 'Week Off'
                    : monthlyHistoryList?[index].holiday ?? false
                    ? 'Holiday'
                    : '' ,
                  style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: const MonthView().calendarGridTextColorView(index: index)),
                ),
              if (monthlyHistoryList?[index].present == false || monthlyHistoryList?[index].attendnacePending == true || monthlyHistoryList?[index].weekOff == true || monthlyHistoryList?[index].holiday == true)
                SizedBox(height: 20.px),
              if (monthlyHistoryList?[index].present == false || monthlyHistoryList?[index].attendnacePending == true || monthlyHistoryList?[index].weekOff == true || monthlyHistoryList?[index].holiday == true)
              CW.commonElevatedButton(onPressed: () => clickOnRequestForAttendanceButton(index:index),buttonText: 'Request for Attendance')
            ],
          );
        }),
        SizedBox(height: 30.px),
      ],
    ).whenComplete(() {
      bottomSheetBreakListValue.value = false;
      calendarGridClickValue.value = false;
    });
    bottomSheetBreakListValue.value = false;
    calendarGridClickValue.value = false;
  }

  void clickOnRequestForAttendanceButton({required int index}) {}

  Widget commonCardTimeTextView({required String title, required String subTitle}) =>
      Column(
        children: [
          Text(
            title,
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.inverseSecondary, fontSize: 10.px),
          ),
          SizedBox(height: 2.px),
          Text(
            subTitle,
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.inverseSecondary, fontWeight: FontWeight.w600),
          ),
        ],
      );

  Widget commonCardTimeVerticalDividerView() => SizedBox(
        height: 34.px,
        child: VerticalDivider(
          color: Col.inverseSecondary,
          thickness: .5.px,
        ),
      );

  Widget commonTextForCheckInOrCheckOutView({required String title, String? subTitle, required String timeText}) => Column(
        children: [
          Text(
            title,
            style: Theme.of(Get.context!)
                .textTheme
                .labelMedium
                ?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
          ),
          if (subTitle != null) SizedBox(height: 2.px),
          if (subTitle != null)
            Text(
              subTitle,
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 11.px, fontWeight: FontWeight.w500),
            ),
          SizedBox(height: 2.px),
          Text(
            timeText,
            style: Theme.of(Get.context!)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      );

}
