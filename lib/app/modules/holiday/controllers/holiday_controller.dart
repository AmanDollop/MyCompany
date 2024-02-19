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


  final yearForMonthViewValue = DateFormat('yyyy').format(DateTime.now()).obs;

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

  List monthNameForCalender = [];
  Map<String, Color> monthNameAndColors = {};

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

  Future<void> onRefresh() async {
    yearForMonthViewValue.value = DateFormat('yyyy').format(DateTime.now());
    await callingGetHolidayApi();
  }

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

  Future<void> yearDropDownOnChanged({required String value}) async {
    yearForMonthViewValue.value = value;
    await callingGetHolidayApi();
  }

  Future<void> callingGetHolidayApi() async {
    try{
      apiResValue.value = true;
      bodyParamsForGetHolidayApi = {
        AK.action : ApiEndPointAction.getHolidays,
        AK.year : yearForMonthViewValue.value,
      };
      getHolidayModal.value = await CAI.getHolidayApi(bodyParams: bodyParamsForGetHolidayApi);
      if(getHolidayModal.value!=null){
        holidayList = getHolidayModal.value?.holiday;
        holidayList?.forEach((element) {
          monthNameForCalender.add(monthName(monthId: '${DateTime.parse('${element.holidayStartDate}').month}'));
          for (String month in monthNameForCalender) {
            if (!monthNameAndColors.containsKey(month)) {
              monthNameAndColors[month] = getRandomColorForCards().withOpacity(.2);
            }
          }
        });
      }
    }catch(e){
      apiResValue.value=false;
      CM.error();
    }
    apiResValue.value = false;
  }

  String monthName({required String monthId}){
    if(monthId == '1'){
      return 'JAN';
    }else if(monthId == '2'){
      return 'FEB';
    }else if(monthId == '3'){
      return ' MAR';
    }else if(monthId == '4'){
      return 'APR';
    }else if(monthId == '5'){
      return 'MAY';
    }else if(monthId == '6'){
      return 'JUN';
    }else if(monthId == '7'){
      return 'JUL';
    }else if(monthId == '8'){
      return ' AUG';
    }else if(monthId == '9'){
      return ' SEP';
    }else if(monthId == '10'){
      return ' OCT';
    }else if(monthId == '11'){
      return ' NOV';
    }else if(monthId == '12'){
      return ' DEC';
    }else{
      return '?';
    }
  }

}
