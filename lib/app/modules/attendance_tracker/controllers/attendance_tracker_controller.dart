import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_monthly_attendance_data_modal.dart';
import 'package:task/api/api_model/get_weekly_attendance_data_modal.dart';
import 'package:task/app/modules/attendance_tracker/views/month_view.dart';
import 'package:task/common/calendar_method/calendar_method.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import 'package:task/validator/v.dart';
import '../../../../common/common_methods/cm.dart';
import 'package:http/http.dart' as http;


class AttendanceTrackerController extends GetxController {
  final count = 0.obs;
  final menuName = ''.obs;
  List<String> monthNameForMonthViewList = [
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
  final monthNameForMonthViewValue = 'January'.obs;
  final yearForMonthViewValue = DateFormat('yyyy').format(DateTime.now()).obs;

  final monthNameIdForMonthView = '1'.obs;

  List<String> yearForMonthViewList = <String>[
    DateFormat('yyyy').format(DateTime.now().subtract(const Duration(days: 365))),
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.now().add(const Duration(days: 365))),
  ];


  final monthNameForWeekViewValue = 'January'.obs;
  final yearForWeekViewValue = DateFormat('yyyy').format(DateTime.now()).obs;
  final monthNameIdForWeekView = '1'.obs;

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

  final apiResValue = false.obs;
  final calendarGridClickValue = false.obs;
  final bottomSheetBreakListValue = false.obs;
  final getMonthlyAttendanceDataModal = Rxn<GetMonthlyAttendanceDataModal>();
  GetMonthlyAttendance? getMonthlyAttendanceData;
  List<MonthlyHistory>? monthlyHistoryList;
  Map<String, dynamic> bodyParamsForMonthlyAttendanceApi = {};

  final keyForBottomSheet = GlobalKey<FormState>();
  final checkInDateController = TextEditingController();
  final checkInTimeController = TextEditingController();
  final checkOutDateController = TextEditingController();
  final checkOutTimeController = TextEditingController();
  final descriptionController = TextEditingController();
  final sendRequestButtonValue = false.obs;
  Map<String, dynamic> bodyParamsForAddAttendanceApi = {};


  final getWeeklyAttendanceDataModal = Rxn<GetWeeklyAttendanceDataModal>();
  List<WeeklyHistory>? weeklyHistoryList;
  List<History>? weekDayHistoryList;
  Map<String, dynamic> bodyParamsForWeeklyAttendanceApi = {};
  PageController pageController = PageController();
  int i = 0;


  final currentWeakStartDate = DateTime.now().obs;
  final currentWeakEndDate = DateTime.now().obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      menuName.value = Get.arguments[0];
      currentWeakStartDate.value = CommonCalendarMethods.getPreviousMonday(DateTime.now());

      monthNameForMonthViewValue.value = monthNameForMonthViewList[currentMonth.value.month-1];
      monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
      await callingGetMonthlyAttendanceDataApi();
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnMonthTab() async {
    tabBarValue.value = 'Month';
    monthNameForMonthViewValue.value = monthNameForMonthViewList[DateTime.now().month - 1];
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
    monthTotalDaysListDataAdd();
    await callingGetMonthlyAttendanceDataApi();
  }

  Future<void> clickOnWeekTab() async {
    tabBarValue.value = 'Week';
    monthNameForWeekViewValue.value = monthNameForMonthViewList[DateTime.now().month - 1];
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForWeekViewValue.value);
    currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
    monthTotalDaysListDataAdd();
    await callingGetWeeklyAttendanceDataApi();
    apiResValue.value = false;
  }

  ///Todo Month View working

  void monthTotalDaysListDataAdd() {
    monthTotalDaysList.clear();
    for (var i = 1; i <= 31; i++) {
      monthTotalDaysList.add(i);
    }
  }

  Future<void> clickOnMonthNameFromMonthView() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        isFullScreen: true,
        children: [
          Center(
            child: Text(
              'Select Month',
              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              monthNameForMonthViewList.length,
                  (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: monthNameForMonthViewValue.value == monthNameForMonthViewList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: monthNameForMonthViewValue.value == monthNameForMonthViewList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: monthNameForMonthViewValue.value == monthNameForMonthViewList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          monthNameForMonthViewValue.value = monthNameForMonthViewList[index];
                          monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
                          currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
                          monthTotalDaysListDataAdd();
                          await callingGetMonthlyAttendanceDataApi();
                          Get.back();
                          },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                monthNameForMonthViewList[index],
                                style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              /*Container(
                                height:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                width:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                padding: EdgeInsets.all(2.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bloodGroupValue.value ==
                                        bloodGroupList[index]
                                        ? Col.primary
                                        : Col.text,
                                    width: 1.5.px,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bloodGroupValue.value ==
                                          bloodGroupList[index]
                                          ? Col.primary
                                          : Colors.transparent),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 40.px)
        ]);

  }

  Future<void> clickOnYearFromMonthView() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        isFullScreen: true,
        children: [
          Center(
            child: Text(
              'Select Year',
              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              yearForMonthViewList.length,
                  (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: yearForMonthViewValue.value == yearForMonthViewList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: yearForMonthViewValue.value == yearForMonthViewList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: yearForMonthViewValue.value == yearForMonthViewList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          yearForMonthViewValue.value = yearForMonthViewList[index];
                          monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
                          currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
                          monthTotalDaysListDataAdd();
                          await callingGetMonthlyAttendanceDataApi();
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                yearForMonthViewList[index],
                                style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              /*Container(
                                height:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                width:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                padding: EdgeInsets.all(2.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bloodGroupValue.value ==
                                        bloodGroupList[index]
                                        ? Col.primary
                                        : Col.text,
                                    width: 1.5.px,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bloodGroupValue.value ==
                                          bloodGroupList[index]
                                          ? Col.primary
                                          : Colors.transparent),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 40.px)
        ]);
  }

  /*Future<void> monthDropDownOnChangedForMonth({required String value}) async {
    monthNameForMonthViewValue.value = value;
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
    currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
    monthTotalDaysListDataAdd();
    await callingGetMonthlyAttendanceDataApi();
  }

  Future<void> yearDropDownOnChangedForMonth({required String value}) async {
    yearForMonthViewValue.value = value;
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
    currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
    monthTotalDaysListDataAdd();
    await callingGetMonthlyAttendanceDataApi();
  }*/

  Future<void> monthViewOnRefresh() async {
    apiResValue.value = true;
    // onInit();
    await callingGetMonthlyAttendanceDataApi();
    // currentMonth.value = DateTime(int.parse(yearForMonthViewValue.value), int.parse(monthNameIdForMonthView.value));
  }

  Future<void> callingGetMonthlyAttendanceDataApi() async {
    apiResValue.value = true;
    try {
      bodyParamsForMonthlyAttendanceApi = {
        AK.action: ApiEndPointAction.getMonthlyAttendanceHistoryNew,
        AK.month: monthNameIdForMonthView.value,
        AK.year: yearForMonthViewValue.value,
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
    apiResValue.value = false;
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

  Future<void> clickOnCalendarGrid({required int index, required day}) async {

    DateTime dateTime = DateTime(
      int.parse('${currentMonth.value.year}'),
      int.parse('${currentMonth.value.month}'),
      int.parse('$day'),
    );

    calendarGridClickValue.value = true;
    await CBS.commonBottomSheet(
      isDismissible: false,
      isFullScreen: true,
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
                      commonCardTimeTextView(title: 'Productive Hours', subTitle: CMForDateTime.calculateTimeForHourAndMin(minute: '${monthlyHistoryList?[index].productiveWorkingMinutes}')),
                      commonCardTimeVerticalDividerView(),
                      commonCardTimeTextView(title: 'Shift Hours', subTitle: CMForDateTime.calculateTimeForHourAndMin(minute: '${monthlyHistoryList?[index].totalShiftMinutes}')),
                      commonCardTimeVerticalDividerView(),
                      commonCardTimeTextView(title: 'Extra Hours', subTitle: CMForDateTime.calculateTimeForHourAndMin(minute: '${monthlyHistoryList?[index].extraWorkingMinutes}')),
                    ],
                  ),
                ),
              ),
              if (monthlyHistoryList?[index].present == true)
              SizedBox(height: 16.px),
              if (monthlyHistoryList?[index].present == true)
              if(monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty && monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
                  || monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty && monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty)
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
                                    ? CMForDateTime.dateFormatForDateMonthYear(date: '${monthlyHistoryList?[index].punchInDate}')
                                    : 'NIL',
                                timeText: monthlyHistoryList?[index].punchInDate != '0000-00-00' && monthlyHistoryList?[index].punchInDate != null && monthlyHistoryList![index].punchInDate!.isNotEmpty && monthlyHistoryList?[index].punchInTime != null && monthlyHistoryList![index].punchInTime!.isNotEmpty
                                    ? CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime:'${monthlyHistoryList?[index].punchInDate} ${monthlyHistoryList?[index].punchInTime}')
                                    : 'NIL',
                              ),
                              commonTextForCheckInOrCheckOutView(
                                title: 'Punch Out',
                                subTitle: monthlyHistoryList?[index].punchOutDate != '0000-00-00' && monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty
                                    ? CMForDateTime.dateFormatForDateMonthYear(date: '${monthlyHistoryList?[index].punchOutDate}')
                                    : "NIL",
                                timeText: monthlyHistoryList?[index].punchOutDate != '0000-00-00' && monthlyHistoryList?[index].punchOutDate != null && monthlyHistoryList![index].punchOutDate!.isNotEmpty && monthlyHistoryList?[index].punchOutTime != null && monthlyHistoryList![index].punchOutTime!.isNotEmpty
                                    ? CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime: '${monthlyHistoryList?[index].punchOutDate} ${monthlyHistoryList?[index].punchOutTime}')
                                    : "NIL",
                              ),
                              commonTextForCheckInOrCheckOutView(title: 'Total Hours', timeText: CMForDateTime.calculateTimeForHourAndMin(minute: '${monthlyHistoryList?[index].totalWorkingMinutes}')),
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
                              physics: const ScrollPhysics(),
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
                                          CMForDateTime.calculateTimeForHourAndMin(minute: '${attendanceBreakHistory?[attendanceBreakHistoryIndex].totalBreakTimeMinutes}'),
                                          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: Col.primary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.px),
                                    Text(
                                      '${CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime:'${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakStartDate} ${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakStartTime}')} - ${CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime:'${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakEndDate} ${attendanceBreakHistory?[attendanceBreakHistoryIndex].breakEndTime}')}',
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
                SizedBox(height: 16.px),
                Text(
                monthlyHistoryList?[index].present == true  && monthlyHistoryList?[index].extraDay == true
                    ? '(Extra Day)'
                    : monthlyHistoryList?[index].isAbsent == true && monthlyHistoryList?[index].present == false && monthlyHistoryList?[index].attendnacePending == false
                    && monthlyHistoryList?[index].weekOff == false && monthlyHistoryList?[index].holiday == false
                    ? '(Absent)':
                     monthlyHistoryList?[index].attendnacePending ?? false
                    ? '(Attendance Pending)'
                    : monthlyHistoryList?[index].weekOff == true && monthlyHistoryList?[index].present == false
                    ? '(Week Off)'
                    : monthlyHistoryList?[index].holiday == true  && monthlyHistoryList?[index].present == false
                    ? '(Holiday)'
                    : '' ,
                  style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: const MonthView().calendarGridTextColorView(index: index)),
                ),
              if (monthlyHistoryList?[index].present == false && monthlyHistoryList?[index].attendnacePending == false
                  || monthlyHistoryList?[index].weekOff == true && monthlyHistoryList?[index].present == false
                  || monthlyHistoryList?[index].holiday == true  && monthlyHistoryList?[index].present == false
                  || monthlyHistoryList?[index].isPunchOutMissing == true  && monthlyHistoryList?[index].present == true)
              SizedBox(height: 20.px),
              if (monthlyHistoryList?[index].present == false && monthlyHistoryList?[index].attendnacePending == false
                  || monthlyHistoryList?[index].weekOff == true && monthlyHistoryList?[index].present == false
                  || monthlyHistoryList?[index].holiday == true  && monthlyHistoryList?[index].present == false
                  || monthlyHistoryList?[index].isPunchOutMissing == true  && monthlyHistoryList?[index].present == true)
              CW.commonElevatedButton(onPressed: () => clickOnRequestForAttendanceButton(index:index,date:CMForDateTime.dateFormatForDateMonthYear(date: '$dateTime') ),buttonText: 'Request for Attendance')
            ],
          );
        }),
        SizedBox(height: 20.px),
      ],
    ).whenComplete(() {
      bottomSheetBreakListValue.value = false;
      calendarGridClickValue.value = false;
    });
    bottomSheetBreakListValue.value = false;
    calendarGridClickValue.value = false;
  }

  Widget suffixIconForTextFormFiled({required String iconPath}) => SizedBox(
    height: 22.px,
    width: 22.px,
    child: Center(
      child: CW.commonNetworkImageView(
          path: iconPath,
          isAssetImage: true,
          height: 22.px,
          width: 22.px,
          color: Col.secondary),
    ),
  );

  Future<void> clickOnRequestForAttendanceButton({required int index, required String date}) async {
    Get.back();
    checkInDateController.text = date;
    checkOutDateController.text = date;
    await CBS.commonBottomSheet(
        isDismissible: false,
        isFullScreen: true,
        children: [
         Form(
           key: keyForBottomSheet,
           child: Obx((){
             count.value;
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'Attendance Request',
                   style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                 ),
                 SizedBox(height: 16.px),
                 CW.commonTextField(
                   labelText: 'Check In Date',
                   hintText: 'Check In Date',
                   controller: checkInDateController,
                   validator: (value) => V.isValid(value: value, title: 'Please select check in date'),
                   suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/working_days_icon.png'),
                   readOnly: true,
                 ),
                 SizedBox(height: 10.px),
                 CW.commonTextField(
                   labelText: 'Check In Time',
                   hintText: 'Check In Time',
                   controller: checkInTimeController,
                   validator: (value) => V.isValid(value: value, title: 'Please select check in time'),
                   suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/watch_icon.png'),
                   readOnly: true,
                   onTap: () => clickOnCheckInTimeTextFormFiled(),
                 ),
                 SizedBox(height: 10.px),
                 CW.commonTextField(
                   labelText: 'Check Out Date',
                   hintText: 'Check Out Date',
                   controller: checkOutDateController,
                   validator: (value) => V.isValid(value: value, title: 'Please select check out date'),
                   suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/working_days_icon.png'),
                   readOnly: true,
                 ),
                 SizedBox(height: 10.px),
                 CW.commonTextField(
                   labelText: 'Check Out Time',
                   hintText: 'Check Out Time',
                   controller: checkOutTimeController,
                   validator: (value) => V.isValid(value: value, title: 'Please select check out time'),
                   suffixIcon: suffixIconForTextFormFiled(iconPath: 'assets/icons/watch_icon.png'),
                   readOnly: true,
                   onTap: () => clickOnCheckOutTimeTextFormFiled(),
                 ),
                 SizedBox(height: 10.px),
                 CW.commonTextFieldForMultiline(
                     labelText: 'Description',
                     hintText: 'Description',
                     controller: descriptionController,
                     maxLines: 3),
                 SizedBox(height: 10.px),
                 CW.commonElevatedButton(
                   onPressed: sendRequestButtonValue.value
                       ? () => null
                       : () => clickOnSendRequestButton(),
                   buttonText: 'Send Request',
                   isLoading: sendRequestButtonValue.value,
                 ),
                 SizedBox(height: 30.px),
               ],
             );
           }),
         )
       ]
    ).whenComplete(() {
      checkInDateController.clear();
      checkInTimeController.clear();
      checkOutDateController.clear();
      checkOutTimeController.clear();
      descriptionController.clear();
    });
  }

  Future<void> clickOnCheckInTimeTextFormFiled() async {
    print('checkInTimeController.text::::: ${checkInTimeController.text}');
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: checkInTimeController,
      mode: CupertinoDatePickerMode.time,
      firstDate: checkInTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkInTimeController.text).subtract(const Duration(hours: 12))
          : DateTime.now().subtract(const Duration(hours: 12)),
      initialDate: checkInTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkInTimeController.text).subtract(const Duration(hours: 12))
          : DateTime.now().subtract(const Duration(hours: 12)),
      lastDate: checkInTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkInTimeController.text).add(const Duration(hours: 12))
          : DateTime.now().add(const Duration(hours: 12)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnCheckOutTimeTextFormFiled() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: checkOutTimeController,
      mode: CupertinoDatePickerMode.time,
      firstDate: checkOutTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkOutTimeController.text).subtract(const Duration(hours: 12))
          : DateTime.now().subtract(const Duration(hours: 12)),
      initialDate: checkOutTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkOutTimeController.text).subtract(const Duration(hours: 12))
          : DateTime.now().subtract(const Duration(hours: 12)),
      lastDate: checkOutTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(checkOutTimeController.text).add(const Duration(hours: 12))
          : DateTime.now().add(const Duration(hours: 12)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnSendRequestButton() async {
    if(keyForBottomSheet.currentState!.validate()){
      sendRequestButtonValue.value = true;
      await callingAddAttendanceApi();
    }
  }

  Future<void> callingAddAttendanceApi() async {
    try{

      bodyParamsForAddAttendanceApi = {
        AK.action : ApiEndPointAction.addAttendance,
        AK.punchInDate : CMForDateTime.dateTimeFormatForApi(dateTime: checkInDateController.text.trim().toString()),
        AK.punchInTime : checkInTimeController.text.trim().toString(),
        AK.punchOutDate : CMForDateTime.dateTimeFormatForApi(dateTime: checkOutDateController.text.trim().toString()),
        AK.punchOutTime : checkOutTimeController.text.trim().toString(),
        AK.attendanceReason : descriptionController.text.trim().toString(),
      };

      http.Response? res = await CAI.addAttendanceApi(bodyParams: bodyParamsForAddAttendanceApi);
      if(res != null && res.statusCode ==200){
        sendRequestButtonValue.value = false;
        Get.back();
      }else{
        sendRequestButtonValue.value = false;
        CM.error();
        Get.back();
      }
    }catch(e){
      sendRequestButtonValue.value = false;
      CM.error();
      Get.back();
    }
  }

  Widget commonCardTimeTextView({required String title, required String subTitle}) => Column(
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
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
          ),
          if (subTitle != null) SizedBox(height: 2.px),
          if (subTitle != null)
            Text(
              subTitle,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 11.px, fontWeight: FontWeight.w500),
            ),
          SizedBox(height: 2.px),
          Text(
            timeText,
            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      );

  ///Todo Week View working

  /*Future<void> monthDropDownOnChangedForWeek({required String value}) async {
    monthNameForWeekViewValue.value = value;
    monthNameIdForWeekView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForWeekViewValue.value);
    await callingGetWeeklyAttendanceDataApi();
  }

  Future<void> yearDropDownOnChangedForWeek({required String value}) async {
    yearForWeekViewValue.value = value;
    monthNameIdForWeekView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForWeekViewValue.value);
    await callingGetWeeklyAttendanceDataApi();
  }*/

  Future<void> callingGetWeeklyAttendanceDataApi() async {
    apiResValue.value = true;
    pageController = PageController(initialPage: 0);
    try {
      bodyParamsForWeeklyAttendanceApi = {
        AK.action: ApiEndPointAction.getWeeklyAttendanceHistoryNew,
        AK.month: monthNameIdForWeekView.value,
        AK.year: yearForWeekViewValue.value,
      };
      getWeeklyAttendanceDataModal.value = await CAI.getWeeklyAttendanceDataApi(bodyParams: bodyParamsForWeeklyAttendanceApi);
      if (getWeeklyAttendanceDataModal.value != null) {
        weeklyHistoryList = getWeeklyAttendanceDataModal.value?.getWeeklyAttendance?.weeklyHistory;
        if(weeklyHistoryList != null && weeklyHistoryList!.isNotEmpty){
          for ( i = 0; i < weeklyHistoryList!.length-1; i++) {
            if(CMForDateTime.dateFormatForDateMonthYear(date: '${weeklyHistoryList?[i].startDate}') == CMForDateTime.dateFormatForDateMonthYear(date: '${currentWeakStartDate.value}')){
              pageController = PageController(initialPage: i);
              count.value++;
            }
          }
        }
      }
    } catch (e) {
      apiResValue.value = false;
      print('e:::: $e');
      CM.error();
    }
    apiResValue.value = false;
  }

  Future<void> clickOnMonthFromWeekView() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        isFullScreen: true,
        children: [
          Center(
            child: Text(
              'Select Month',
              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              monthNameForMonthViewList.length,
                  (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: monthNameForWeekViewValue.value == monthNameForMonthViewList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: monthNameForWeekViewValue.value == monthNameForMonthViewList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: monthNameForWeekViewValue.value == monthNameForMonthViewList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          monthNameForWeekViewValue.value = monthNameForMonthViewList[index];
                          monthNameIdForWeekView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForWeekViewValue.value);
                          await callingGetWeeklyAttendanceDataApi();
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                monthNameForMonthViewList[index],
                                style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              /*Container(
                                height:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                width:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                padding: EdgeInsets.all(2.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bloodGroupValue.value ==
                                        bloodGroupList[index]
                                        ? Col.primary
                                        : Col.text,
                                    width: 1.5.px,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bloodGroupValue.value ==
                                          bloodGroupList[index]
                                          ? Col.primary
                                          : Colors.transparent),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 40.px)
        ]);
  }

  Future<void> clickOnYearFromWeekView() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        isFullScreen: true,
        children: [
          Center(
            child: Text(
              'Select Year',
              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              yearForMonthViewList.length,
                  (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: yearForWeekViewValue.value == yearForMonthViewList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: yearForWeekViewValue.value == yearForMonthViewList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: yearForWeekViewValue.value == yearForMonthViewList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          yearForWeekViewValue.value = yearForMonthViewList[index];
                          monthNameIdForWeekView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForWeekViewValue.value);
                          await callingGetWeeklyAttendanceDataApi();
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                yearForMonthViewList[index],
                                style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              /*Container(
                                height:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                width:
                                bloodGroupValue.value == bloodGroupList[index]
                                    ? 18.px
                                    : 16.px,
                                padding: EdgeInsets.all(2.px),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: bloodGroupValue.value ==
                                        bloodGroupList[index]
                                        ? Col.primary
                                        : Col.text,
                                    width: 1.5.px,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: bloodGroupValue.value ==
                                          bloodGroupList[index]
                                          ? Col.primary
                                          : Colors.transparent),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 40.px)
        ]);
  }

}
