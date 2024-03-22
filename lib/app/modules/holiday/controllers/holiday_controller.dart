import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/holiday_modal.dart';
import 'package:task/common/calendar_method/calendar_method.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

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

  final isAfterDate = false.obs;

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
      monthNameAndColors.clear();
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
              monthNameAndColors[month] = getRandomColorForCards().withOpacity(.8);
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

  Future<void> clickOnYear() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        children: [
          Center(
            child: Text(
              'Select Year',
              style: Theme.of(Get.context!).textTheme.displaySmall,
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
                    child: CustomOutlineButton(
                      onPressed: () => clickOnYearValue(index: index),
                      padding: EdgeInsets.only(left: 14.px, right: 0.px,top: 2.px,bottom: 2.px),
                      radius: 10.px,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: yearForMonthViewValue.value == yearForMonthViewList[index]
                            ? [
                          Col.primary,
                          Col.primaryColor,
                        ]
                            : [
                          Col.gray,
                          Col.gray,
                        ],
                      ),
                      strokeWidth: 1.px,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 10.px),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              yearForMonthViewList[index],
                              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,
                                  color: yearForMonthViewValue.value == yearForMonthViewList[index]
                                      ? Col.primary
                                      : Col.inverseSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 30.px)
        ]);
  }

  Future<void> clickOnYearValue({required int index}) async {
    yearForMonthViewValue.value = yearForMonthViewList[index];
    await callingGetHolidayApi();
    count.value++;
    Get.back();
  }

}
