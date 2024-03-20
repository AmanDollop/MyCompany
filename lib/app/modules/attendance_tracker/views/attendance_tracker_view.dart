import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/attendance_tracker/views/month_view.dart';
import 'package:task/app/modules/attendance_tracker/views/week_view.dart';
import 'package:task/common/common_widgets/cw.dart';
import '../controllers/attendance_tracker_controller.dart';

class AttendanceTrackerView extends GetView<AttendanceTrackerController> {
  const AttendanceTrackerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () => controller.clickOnBackButton(),
          child: Scaffold(
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(() {
                    controller.count.value;

                    ///Tab Bar View For Month And Week
                    return AC.isConnect.value
                        ? CW.commonRefreshIndicator(
                            onRefresh: controller.tabBarValue.value == 'Month'
                                ? () => controller.monthViewOnRefresh()
                                : () => controller.weekViewOnRefresh(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.px),
                              child: Column(
                                children: [
                                  SizedBox(height: 16.px),
                                  tabBarView(),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 16.px),
                                      child: controller.tabBarValue.value == 'Month'
                                          ? const MonthView()
                                          : const WeekView(),
                                    ),
                                  ),
                                  SizedBox(height: 12.px)
                                ],
                              ),
                            ),
                          )
                        : CW.commonNoNetworkView();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: controller.menuName.value,
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  Widget tabBarView() => CW.myCommonTabBarView(
      tabBarValue: controller.tabBarValue.value,
      tab1ButtonText: 'Month',
      tab2ButtonText: 'Week',
      tab1ButtonOnPressed: () => controller.clickOnMonthTab(),
      tab2ButtonOnPressed: () => controller.clickOnWeekTab());

}
