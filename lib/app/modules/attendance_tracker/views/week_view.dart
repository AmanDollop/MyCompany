import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/attendance_tracker/controllers/attendance_tracker_controller.dart';
import 'package:task/theme/colors/colors.dart';

class WeekView extends GetView<AttendanceTrackerController> {
  const WeekView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              commonDropDownView(
                dropDownView: monthDropDownView(),
              ),
              SizedBox(width: 10.px),
              commonDropDownView(
                dropDownView: yearDropDownView(),
              ),
            ],
          ),
          SizedBox(height: 10.px),
          buildHeader(),
          SizedBox(height: 10.px),
          circularProgressBarView(),
          SizedBox(height: 10.px),
        ],
      );
    });
  }

  Widget commonDropDownView({required Widget dropDownView}) => Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: Col.gray.withOpacity(.3),
              borderRadius: BorderRadius.circular(6.px)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: dropDownView,
                ),
                Icon(Icons.arrow_drop_down, color: Col.darkGray)
              ],
            ),
          ),
        ),
      );

  Widget monthDropDownView() => DropdownButton<String>(
        value: controller.monthNameValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) =>
            controller.monthDropDownOnChanged(value: value ?? ''),
        items: controller.monthNameList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          );
        }).toList(),
      );

  Widget yearDropDownView() => DropdownButton<String>(
        value: controller.yearValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) =>
            controller.yearDropDownOnChanged(value: value ?? ''),
        items:
            controller.yearList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          );
        }).toList(),
      );

  Widget commonCircularProgressBar({required double value}) {
    return CircularProgressIndicator(
      strokeWidth: 8.px,
      value: .5,
      backgroundColor: Col.primary.withOpacity(.2),
      strokeCap: StrokeCap.round,
    );
  }

  Widget circularProgressBarView() => Row(
        children: [
          SizedBox(
            height: 150.px,
            width: 150.px,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 130.px,
                    width: 130.px,
                    child: commonCircularProgressBar(value: 0.0),
                  ),
                ),
                SizedBox(
                  width: 120.px,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleTextView(text: 'Total time', color: Col.secondary),
                      SizedBox(height: 2.px),
                      subTitleTextView(text: '140 hr'),
                      SizedBox(height: 5.px),
                      titleTextView(
                          text: 'Total Spend Time', color: Col.secondary),
                      SizedBox(height: 2.px),
                      subTitleTextView(text: '20 hr 20 min')
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.px),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTextView(text: 'Total Productive Time'),
                SizedBox(height: 2.px),
                subTitleTextView(text: '50hr 50 min.'),
                SizedBox(height: 5.px),
                titleTextView(text: 'Total Extra Time'),
                SizedBox(height: 2.px),
                subTitleTextView(text: '50hr 50 min.'),
                SizedBox(height: 5.px),
                titleTextView(text: 'Total Remaining Time'),
                SizedBox(height: 2.px),
                subTitleTextView(text: '50 min.'),
              ],
            ),
          ),
        ],
      );

  Widget titleTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .labelMedium
            ?.copyWith(fontSize: 10.px, color: color),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget subTitleTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
              color: Col.secondary, size: 28.px),
          onPressed: () {
            controller.currentMonth.value = DateTime(
                controller.currentMonth.value.year,
                controller.currentMonth.value.month - 1);
          },
        ),
        SizedBox(width: 10.px),
        Text(
          '${DateFormat('dd').format(DateTime(controller.currentMonth.value.day).subtract(const Duration(days: 7)),)}-${DateFormat('dd MMM').format(DateTime(controller.currentMonth.value.day,controller.currentMonth.value.month))} ${controller.currentMonth.value.year}',
          style: Theme.of(Get.context!).textTheme.displayLarge,
        ),
        SizedBox(width: 10.px),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_right, color: Col.secondary, size: 28.px),
          onPressed: () {
            controller.currentMonth.value = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1);
          },
        ),
      ],
    );
  }
}
