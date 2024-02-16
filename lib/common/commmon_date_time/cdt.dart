import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

class CDT {
  static Future<DateTime?> androidDatePicker({
    DateTime? lastDate,
    DateTime? firstDate,
    DateTime? initialDate,
    required BuildContext context,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData(
          primarySwatch: CM.getMaterialColor(color: Col.primary),
        ),
        child: child ?? const SizedBox(),
      ),
      context: context,
    );
    return pickedDate;
  }

  static Future<TimeOfDay?> androidTimePicker({
    required BuildContext context,
    TimeOfDay? initialTime,
    bool use24HourTime = false,
  }) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primarySwatch: CM.getMaterialColor(color: Col.primary),
          ),
          child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24HourTime),
              child: child ?? const SizedBox()),
        );
      },
    );

    return pickedTime;
  }


  static Future<TimeOfDay?> iosTimePicker({
    required BuildContext context,
    DateTime? initialTime,
    bool use24HourTime = false,
  }) async {
    TimeOfDay? pickedTime;
    pickedTime = await showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                width: 34.px,
                height: 34.px,
                decoration: BoxDecoration(
                  color: Col.secondary,
                  shape: BoxShape.circle,
                ),
                child:  Center(child: Icon(Icons.close,color: Col.inverseSecondary,size: 16.px),),
              ),
            ),
            SizedBox(height: 10.px),
            Container(
              height: 250,
              padding: EdgeInsets.all(16.px),
              decoration: BoxDecoration(
                color: Col.inverseSecondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular( 20.px),
                  topRight: Radius.circular(20.px),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: initialTime ?? DateTime.now(),
                      onDateTimeChanged: (DateTime dateTime) {
                        pickedTime = TimeOfDay.fromDateTime(dateTime);
                      },
                    ),
                  ),
                  SizedBox(height: 10.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Col.inverseSecondary,
                            borderRadius: BorderRadius.circular(10.px),
                            border: Border.all(color: Col.secondary, width: 1.px),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                            child: Center(
                              child: Text(
                                C.textCancel,
                                style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:  () {
                          Navigator.of(context).pop(pickedTime);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Col.inverseSecondary,
                            borderRadius: BorderRadius.circular(10.px),
                            border: Border.all(color: Col.secondary, width: 1.px),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                            child: Center(
                              child: Text(
                                C.textSelect,
                                style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.px),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return pickedTime;
  }

  static Future<String> iosPicker({
    DateTime? lastDate,
    DateTime? firstDate,
    DateTime? initialDate,
    int? minimumYear,
    int? maximumYear,
    required BuildContext context,
    VoidCallback? clickOnSelect,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    bool use24hFormat = false,
    bool showDayOfWeek = false,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    DatePickerDateOrder order = DatePickerDateOrder.dmy,
    TextEditingController? dateController
  }) async {
    String formattedDate = CMForDateTime.dateFormatForDateMonthYear(date: '${DateTime.now()}');

    CBS.commonBottomSheet(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.px, bottom: 10.px),
          child: Ink(
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.circular(20.px),
              border: Border.all(color: Col.secondary, width: 1.px),
            ),
            child: Column(
              children: [
                CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: height ?? MediaQuery.of(context).size.height / 3.5,
                    child: CupertinoDatePicker(
                      initialDateTime:  initialDate ?? DateTime(DateTime.now().year - 18),
                      minimumDate: firstDate ?? DateTime(1900),
                      maximumDate: lastDate ?? DateTime.now(),
                      onDateTimeChanged: (value) {
                        formattedDate = CMForDateTime.dateFormatForDateMonthYear(date: '$value');
                        // dateController?.text = formattedDate;
                      },
                      minimumYear: minimumYear ?? DateTime.now().year - 123,
                      maximumYear: maximumYear ?? DateTime.now().year,

                      showDayOfWeek: showDayOfWeek,
                      use24hFormat: use24hFormat,
                      mode: mode,
                      dateOrder: order,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textCancel,
                      style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: clickOnSelect ??
                  () {
                    dateController?.text = formattedDate;
                    Get.back();
                  },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textSelect,
                      style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.px),
      ],
      backGroundColor: Colors.transparent,
      showDragHandle: false,
      isDismissible: false,
    );

    return formattedDate;
  }

  static Future<String> iosPicker1({
    DateTime? lastDate,
    DateTime? firstDate,
    DateTime? initialDate,
    int? minimumYear,
    int? maximumYear,
    required BuildContext context,
    VoidCallback? clickOnSelect,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    bool use24hFormat = false,
    bool showDayOfWeek = false,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    DatePickerDateOrder order = DatePickerDateOrder.dmy,
    TextEditingController? dateController
  })  async {
    String formattedDate;
    if(mode == CupertinoDatePickerMode.time){
      formattedDate = CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime: '${DateTime.now()}');
    }else{
      formattedDate = CMForDateTime.dateFormatForDateMonthYear(date: '${DateTime.now()}');
    }

    await CBS.commonBottomSheet(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.px, bottom: 10.px),
          child: Ink(
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.circular(20.px),
              border: Border.all(color: Col.secondary, width: 1.px),
            ),
            child: Column(
              children: [
                CupertinoTheme(
                  data:  CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 16.px,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: height ?? MediaQuery.of(context).size.height / 3.5,
                    child: CupertinoDatePicker(
                      initialDateTime:  initialDate ?? DateTime(DateTime.now().year - 18),
                      minimumDate: firstDate ?? DateTime(1900),
                      maximumDate: lastDate ?? DateTime.now(),
                      onDateTimeChanged: (value) {

                        if(mode == CupertinoDatePickerMode.time){
                          formattedDate = CMForDateTime.timeFormatForHourMinuetAmPm(dateAndTime: '$value');
                        }else{
                          formattedDate = CMForDateTime.dateFormatForDateMonthYear(date: '$value');
                        }
                        // dateController?.text = formattedDate;
                      },
                      minimumYear: minimumYear ?? DateTime.now().year - 123,
                      maximumYear: maximumYear ?? DateTime.now().year,

                      showDayOfWeek: showDayOfWeek,
                      use24hFormat: use24hFormat,
                      mode: mode,
                      dateOrder: order,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textCancel,
                      style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: clickOnSelect ?? () {
                    dateController?.text = formattedDate;
                    Get.back();
                  },
              borderRadius: BorderRadius.circular(10.px),
              child: Ink(
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.circular(10.px),
                  border: Border.all(color: Col.secondary, width: 1.px),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 7),
                  child: Center(
                    child: Text(
                      C.textSelect,
                      style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.px),
      ],
      backGroundColor: Colors.transparent,
      showDragHandle: false,
      isDismissible: false,
    );

    return formattedDate;
  }

}
