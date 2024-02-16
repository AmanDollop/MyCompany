import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/holiday_modal.dart';
import 'package:task/common/calendar_method/calendar_method.dart';
import 'package:task/common/common_methods/cm.dart';

class HolidayController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;
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
  final yearForMonthViewValue = '2024'.obs;

  final monthNameIdForMonthView = '1'.obs;

  List<String> yearForMonthViewList = <String>[
    DateFormat('yyyy').format(DateTime.now().subtract(const Duration(days: 365))),
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.now().add(const Duration(days: 365))),
  ];

  final Random random = Random();
  List<Color> randomColor = [];
  final Set<Color> usedColors = {};

  final getHolidayModal = Rxn<HolidayModal>();
  List<Holiday>? holidayList;
  Map<String, dynamic> bodyParamsForGetHolidayApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    menuName.value = Get.arguments[0];
    await callingGetHolidayApi();
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

  Color getRandomColorForCards() {
    Color randomColor;
    do {
      randomColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0, // Fixed opacity value
      );
    } while (usedColors.contains(randomColor));

    usedColors.add(randomColor);
    return randomColor;
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> monthDropDownOnChanged({required String value}) async {
    monthNameForMonthViewValue.value = value;
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
  }

  Future<void> yearDropDownOnChanged({required String value}) async {
    yearForMonthViewValue.value = value;
    monthNameIdForMonthView.value = CommonCalendarMethods.getMonth(monthNameValue: monthNameForMonthViewValue.value);
  }

  Future<void> callingGetHolidayApi() async {
    try{
      bodyParamsForGetHolidayApi = {
        AK.action : ApiEndPointAction.getHolidays,
        AK.year : yearForMonthViewValue.value,
      };
      getHolidayModal.value = await CAI.getHolidayApi(bodyParams: bodyParamsForGetHolidayApi);
      if(getHolidayModal.value!=null){
        holidayList = getHolidayModal.value?.holiday;
        holidayList?.forEach((element) {
          randomColor.add(getRandomColorForCards().withOpacity(.5));
        });
        apiResValue.value = false;
      }
    }catch(e){
      apiResValue.value=false;
      CM.error();
    }
  }

}
