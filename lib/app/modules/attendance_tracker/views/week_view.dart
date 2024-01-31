import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          listViewBuilder(),
          SizedBox(height: 20.px),
        ],
      );
    });
  }

  Widget commonDropDownView({required Widget dropDownView}) => Expanded(
        child: Container(
          height: 40.px,
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

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left,
              color: Col.secondary, size: 28.px),
          onPressed: () {
            controller.currentWeakStartDate.value = controller
                .currentWeakStartDate.value
                .subtract(const Duration(days: 7));
            controller.currentWeakEndDate.value = controller
                .currentWeakEndDate.value
                .subtract(Duration(days: DateTime.now().weekday));
          },
        ),
        SizedBox(width: 10.px),
        Column(
          children: [
            Text(
              '${controller.currentWeakStartDate.value.day}-${controller.currentWeakEndDate.value.day} ${DateFormat('MMM yyyy').format(DateTime.now())}',
              style: Theme.of(Get.context!).textTheme.displayLarge,
            ),
          ],
        ),
        SizedBox(width: 10.px),
        if (controller.currentWeakEndDate.value.day != DateTime.now().day)
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right,
                color: Col.secondary, size: 28.px),
            onPressed: () {
              controller.currentWeakStartDate.value = controller
                  .currentWeakStartDate.value
                  .add(const Duration(days: 7));
              controller.currentWeakEndDate.value = controller
                  .currentWeakEndDate.value
                  .add(Duration(days: DateTime.now().weekday));
            },
          ),
      ],
    );
  }

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

  Widget timeTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget listViewBuilder() => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 7,
    itemBuilder: (context, index) {
      return listCardView(index:index);
    },
  );

  Widget listCardView({required int index}) => Card(
    color: Col.inverseSecondary,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.px)
    ),
    child: Padding(
      padding:  EdgeInsets.all(8.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleTextView(text: '23rd January 2024'),
          SizedBox(height: 2.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              timeTextView(text: 'Monday',),
              timeTextView(text: '09 hr 10 min',),
            ],
          ),
          SizedBox(height: 10.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleTextView(text: 'Total Productive Time'),
                    SizedBox(height: 2.px),
                    subTitleTextView(text: '50hr 50 min.'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleTextView(text: 'Extra Hours'),
                    SizedBox(height: 2.px),
                    subTitleTextView(text: '50hr 50 min.'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );

}
