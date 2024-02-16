import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/modules/attendance_tracker/views/month_view.dart';
import 'package:task/app/modules/attendance_tracker/views/week_view.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/attendance_tracker_controller.dart';

class AttendanceTrackerView extends GetView<AttendanceTrackerController> {
  const AttendanceTrackerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(title: controller.menuName.value,isLeading: true,onBackPressed: () => controller.clickOnBackButton(),),
      body:Obx(() {
        controller.count.value;
        ///Tab Bar View For Month And Week
        return  Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.px),
          child: Column(
            children: [
              SizedBox(height: 16.px),
              tabBarView(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.px),
                  child: AnimatedCrossFade(
                    crossFadeState: controller.tabBarValue.value == 'Month'
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1000),
                    firstCurve: Curves.fastOutSlowIn,
                    secondCurve: Curves.fastOutSlowIn,
                    firstChild: const MonthView(),
                    secondChild: const WeekView(),
                  ),
                ),
              ),
              SizedBox(height: 12.px)
            ],
          ),
        );
        // return Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 12.px),
        //   child: Column(
        //     children: [
        //       SizedBox(height: 16.px),
        //       const Expanded(child: MonthView()),
        //     ],
        //   ),
        // );
      })
    );
  }

  Widget tabBarView() => AnimatedContainer(
    height: 44.px,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 6.px),
    decoration: BoxDecoration(color: Col.primary, borderRadius: BorderRadius.circular(6.px)
    ),
    duration: const Duration(milliseconds: 500),
    child:  Row(
      children: [
        Expanded(
          child: monthButtonView(),
        ),
        SizedBox(width: 8.px),
        Expanded(
          child: weekButtonView(),
        ),
      ],
    ),
  );

  Widget monthButtonView()=> CW.commonElevatedButton(
    onPressed: () => controller.clickOnMonthTab(),
    buttonText: 'Month',
    height: 36.px,
    borderRadius: 6.px,
    buttonColor: controller.tabBarValue.value == 'Month'
        ? Col.inverseSecondary
        : Col.primary,
    buttonTextColor: controller.tabBarValue.value == 'Month'
        ? Col.primary
        : Col.inverseSecondary,
  );

  Widget weekButtonView()=> CW.commonElevatedButton(
    onPressed: () => controller.clickOnWeekTab(),
    buttonText: 'Week',
    height: 36.px,
    borderRadius: 6.px,
    buttonColor: controller.tabBarValue.value == 'Week'
        ? Col.inverseSecondary
        : Col.primary,
    buttonTextColor: controller.tabBarValue.value == 'Week'
        ? Col.primary
        : Col.inverseSecondary,
  );

}
