import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
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
              data: MediaQuery.of(context)
                  .copyWith(alwaysUse24HourFormat: use24HourTime),
              child: child ?? const SizedBox()),
        );
      },
    );

    return pickedTime;
  }

  static Future<DateTime?> iosPicker({
    DateTime? lastDate,
    DateTime? firstDate,
    DateTime? initialDate,
    required BuildContext context,
    VoidCallback? clickOnSelect,
    double? height,
    double? borderRadius,
    Color? backgroundColor,
    bool use24hFormat = false,
    bool showDayOfWeek = false,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    DatePickerDateOrder order = DatePickerDateOrder.dmy,
  }) async {
    DateTime? pickedDate;
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
                SizedBox(
                  height: height ?? MediaQuery.of(context).size.height / 3.5,
                  child: CupertinoDatePicker(
                    initialDateTime: initialDate ?? DateTime.now(),
                    minimumDate: firstDate ?? DateTime(2000),
                    maximumDate: lastDate ?? DateTime.now(),
                    onDateTimeChanged: (value) {
                      pickedDate = value;
                    },
                    showDayOfWeek: showDayOfWeek,
                    use24hFormat: use24hFormat,
                    mode: mode,
                    dateOrder: order,
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
                  padding: EdgeInsets.symmetric(
                      vertical: 10.px,
                      horizontal: MediaQuery.of(Get.context!).size.width / 6.5),
                  child: Center(
                    child: Text(
                      C.textCancel,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Col.primary),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: clickOnSelect ??
                  () {
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
                  padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: MediaQuery.of(Get.context!).size.width / 6.5),
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
        SizedBox(
          height: 20.px,
        ),
      ],
      backGroundColor: Colors.transparent,
      showDragHandle: false,
      isDismissible: false,
    );
    return pickedDate;
  }
}
