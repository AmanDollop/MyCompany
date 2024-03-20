import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/attendance_tracker/controllers/attendance_tracker_controller.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';

class WeekView extends GetView<AttendanceTrackerController> {
  const WeekView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return ModalProgress(
        inAsyncCall: controller.apiResValue.value,
        child: controller.apiResValue.value
            ? shimmerView()
            : controller.getWeeklyAttendanceDataModal.value != null
                ? Column(
                    children: [
                      Row(
                        children: [
                          commonDropDownView(
                            onTap: () => controller.clickOnMonthFromWeekView(),
                            dropDownView: monthDropDownView(),
                          ),
                          SizedBox(width: 10.px),
                          commonDropDownView(
                            onTap: () => controller.clickOnYearFromWeekView(),
                            dropDownView: yearDropDownView(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.px),
                      controller.weeklyHistoryList != null && controller.weeklyHistoryList!.isNotEmpty
                          ? Expanded(
                              // height: MediaQuery.of(context).size.height * 0.72,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: controller.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.weeklyHistoryList?.length,
                                itemBuilder: (context, index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 1000),
                                    curve: Curves.easeInOut,
                                    // alignment: Alignment.center,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        CustomOutlineButton(
                                          customOutlineForButtonValue: false,
                                          onPressed: () {},
                                          radius: 12.px,
                                          strokeWidth: .2.px,
                                          padding: EdgeInsets.only(bottom: 12.px,left: 12.px,right: 12.px),
                                          gradient: CW.commonLinearGradientForButtonsView(),
                                          child: Column(
                                            children: [
                                              buildHeader(index: index),
                                              SizedBox(height: 10.px),
                                              circularProgressBarView(index: index),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10.px),
                                        listViewBuilder(index: index),
                                        SizedBox(height: 20.px),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : CW.commonNoDataFoundText()
                    ],
                  )
                : CW.commonNoDataFoundText(),
      );
    });
  }

  Widget commonDropDownView({required Widget dropDownView, required GestureTapCallback onTap}) => Expanded(
    child: Container(
      height: 40.px,
      decoration: BoxDecoration(
          color: Col.primary.withOpacity(.2),
          borderRadius: BorderRadius.circular(6.px)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dropDownView,
              Icon(Icons.arrow_drop_down, color: Col.primary)
            ],
          ),
        ),
      ),
    ),
  );

  Widget monthDropDownView() => Text(
        controller.monthNameForWeekViewValue.value,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,color: Col.inverseSecondary
            ),
      );

  /*Widget monthDropDownView() => DropdownButton<String>(
        value: controller.monthNameForWeekViewValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) =>
            controller.monthDropDownOnChangedForWeek(value: value ?? ''),
        items: controller.monthNameForMonthViewList
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
      );*/

  Widget yearDropDownView() => Text(
        controller.yearForWeekViewValue.value,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,color: Col.inverseSecondary
            ),
      );

  /*Widget yearDropDownView() => DropdownButton<String>(
        value: controller.yearForWeekViewValue.value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? value) => controller.yearDropDownOnChangedForWeek(value: value ?? ''),
        items: controller.yearForMonthViewList.map<DropdownMenuItem<String>>((String value) {
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
      );*/

  Widget buildHeader({required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (index > 0)
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Col.inverseSecondary, size: 28.px),
            onPressed: () => controller.clickOnReverseIconButton(index:index),
          ),
        SizedBox(width: 10.px),
        Text(
          '${controller.weeklyHistoryList?[index].week}',
          style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(color: Col.inverseSecondary),
        ),
        SizedBox(width: 10.px),
        if (index < controller.weeklyHistoryList!.length - 1)
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right, color: Col.inverseSecondary, size: 28.px),
            onPressed: () => controller.clickOnForwardIconButton(index:index),
          ),
      ],
    );
  }

  startCircularProgressBar({required int index}){
    double percentage = double.parse('${controller.weeklyHistoryList?[index].totalSpendMinutes}') / double.parse('${controller.weeklyHistoryList?[index].totalWeekMinutes}');
    controller.animation = Tween(begin: 0.0, end: percentage).animate(controller.animationController)..addListener(() {
          controller.progressValue.value = controller.animation.value;
          controller.count.value++;
      });
    // Start the animation
    controller.animationController.forward();
  }

  Widget commonCircularProgressBar({required int index}) {
    startCircularProgressBar(index: index);
      if(controller.progressValue.value.isNaN){
        return CircularProgressIndicator(
          strokeWidth: 8.px,
          value: 0,
          backgroundColor: Col.text,
          strokeCap: StrokeCap.round,
        );
      }else{
        return CircularProgressIndicator(
          strokeWidth: 8.px,
          value: controller.progressValue.value,
          backgroundColor: Col.text,
          strokeCap: StrokeCap.round,
        );
      }

  }

  Widget circularProgressBarView({required int index}) => Row(
        children: [
          Container(
            height: 150.px,
            width: 150.px,
            margin: EdgeInsets.only(left: 4.px),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Col.primary.withOpacity(.2),
                    // spreadRadius: 5,
                    blurRadius: 6,
                    offset: const Offset(0, 1),

                  )
                ]
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 130.px,
                    width: 130.px,
                    child: commonCircularProgressBar(index: index),
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
                      subTitleTextView(
                          text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weeklyHistoryList?[index].totalWeekMinutes}')),
                      SizedBox(height: 5.px),
                      titleTextView(
                          text: 'Total Spend Time', color: Col.secondary),
                      SizedBox(height: 2.px),
                      subTitleTextView(
                          text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weeklyHistoryList?[index].totalSpendMinutes}'))
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
                subTitleTextView(text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weeklyHistoryList?[index].totalProductiveWorkingMinutes}')),
                SizedBox(height: 5.px),
                titleTextView(text: 'Total Extra Time'),
                SizedBox(height: 2.px),
                subTitleTextView(text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weeklyHistoryList?[index].totalWeekExtraMinutes}')),
                SizedBox(height: 5.px),
                titleTextView(text: 'Total Remaining Time'),
                SizedBox(height: 2.px),
                subTitleTextView(text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weeklyHistoryList?[index].totalWeekRemainingMinutes}')),
              ],
            ),
          ),
        ],
      );

  Widget titleTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px, color: Col.gTextColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget subTitleTextView({required String text,Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: color ?? Col.inverseSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget timeTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget listViewBuilder({required int index}) {
    controller.weekDayHistoryList =
        controller.weeklyHistoryList?[index].history;
    if (controller.weekDayHistoryList != null &&
        controller.weekDayHistoryList!.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.weekDayHistoryList?.length,
        itemBuilder: (context, weekDayIndex) {
          return listCardView(weekDayIndex: weekDayIndex);
        },
      );
    } else {
      return SizedBox(
        height: 40.h,
        child: CW.commonNoDataFoundText(),
      );
    }
  }

  Widget listCardView({required int weekDayIndex}) => Card(
        color: Col.gCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.px)),
        child: Padding(
          padding: EdgeInsets.all(8.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleTextView(text: CMForDateTime.dateFormatForDateMonthYear(date: '${controller.weekDayHistoryList?[weekDayIndex].attendanceDate}')),
              SizedBox(height: 2.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  timeTextView(
                    text: '${controller.weekDayHistoryList?[weekDayIndex].dayName}',
                  ),
                  timeTextView(
                    text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weekDayHistoryList?[weekDayIndex].totalWorkingMinutes}'),
                  ),
                ],
              ),
              SizedBox(height: 10.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleTextView(text: 'Total Productive Time'),
                        SizedBox(height: 2.px),
                        subTitleTextView(
                          text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weekDayHistoryList?[weekDayIndex].productiveWorkingMinutes}'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleTextView(text: 'Extra Time'),
                        SizedBox(height: 2.px),
                        subTitleTextView(
                          text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weekDayHistoryList?[weekDayIndex].extraWorkingMinutes}'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleTextView(text: 'Remaining Time'),
                        SizedBox(height: 2.px),
                        subTitleTextView(
                          text: CMForDateTime.calculateTimeForHourAndMin(minute: '${controller.weekDayHistoryList?[weekDayIndex].remainingWorkingMinutes}'),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget shimmerView() => ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                child: CW.commonShimmerViewForImage(height: 40.px),
              ),
              SizedBox(width: 10.px),
              Expanded(
                child: CW.commonShimmerViewForImage(height: 40.px),
              ),
            ],
          ),
          SizedBox(height: 10.px),
          Row(
            children: [
              CW.commonShimmerViewForImage(
                  height: 150.px, width: 150.px, radius: 75.px),
              SizedBox(width: 15.px),
              Flexible(
                child: Column(
                  children: [
                    CW.commonShimmerViewForImage(height: 20.px),
                    SizedBox(height: 5.px),
                    CW.commonShimmerViewForImage(height: 20.px),
                    SizedBox(height: 5.px),
                    CW.commonShimmerViewForImage(height: 20.px),
                    SizedBox(height: 5.px),
                    CW.commonShimmerViewForImage(height: 20.px),
                    SizedBox(height: 5.px),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10.px),
          ListView.builder(
            itemCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 12.px),
              child: CW.commonShimmerViewForImage(
                  height: 70.px, width: double.infinity),
            ),
          ),
          SizedBox(height: 20.px),
        ],
      );
}
