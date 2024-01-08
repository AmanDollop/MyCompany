import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../controllers/shift_detail_controller.dart';

class ShiftDetailView extends GetView<ShiftDetailController> {
  const ShiftDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBack()),
      body: Obx(
        () {
          controller.count.value;
          if (controller.shiftDetailsModal.value != null) {
            if (controller.shiftDetails != null) {
              return ModalProgress(
                inAsyncCall: controller.apiResValue.value,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: C.margin - 4, vertical: 24.px),
                  children: [
                    Card(
                      elevation: 0,
                      color: Col.primary.withOpacity(.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.px)),
                      child: Padding(
                        padding: EdgeInsets.all(8.px),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonTitleRowView(
                              text: 'Shift Name',
                              text1:
                                  controller.shiftDetails?.shiftName != null &&
                                          controller.shiftDetails!.shiftName!
                                              .isNotEmpty
                                      ? '${controller.shiftDetails?.shiftName}'
                                      : 'N/A',
                            ),
                            SizedBox(height: 10.px),
                            commonTitleRowView(
                                text: 'Shift Code',
                                text1: controller.shiftDetails?.shiftCode !=
                                            null &&
                                        controller
                                            .shiftDetails!.shiftCode!.isNotEmpty
                                    ? '${controller.shiftDetails?.shiftCode}'
                                    : 'N/A')
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Col.inverseSecondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
                      child: Padding(
                        padding: EdgeInsets.all(8.px),
                        child: Column(
                          children: [
                            SizedBox(height: 14.px),
                            commonRowForDetailView(
                                text1: 'Week Off',
                                text2: controller.shiftDetails?.weekOffDaysView != null && controller.shiftDetails!.weekOffDaysView!.isNotEmpty
                                    ? '${controller.shiftDetails?.weekOffDaysView}'
                                    : 'N/A',
                                flex1: 5,
                                flex2: 7),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Has Auto Week Off',
                                text2: controller.shiftDetails?.hasAlternateWeekOff != null && controller.shiftDetails!.hasAlternateWeekOff!.isNotEmpty
                                    ? controller.shiftDetails?.hasAlternateWeekOff == '1'
                                        ? 'Yes'
                                        : 'No'
                                    : 'N/A',
                                flex1: 5,
                                flex2: 7),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Alternate Week Off',
                                text2: controller.shiftDetails?.alternateWeekOffView != null && controller.shiftDetails!.alternateWeekOffView!.isNotEmpty
                                    ? '${controller.shiftDetails?.alternateWeekOffView}'
                                        : 'N/A',
                                flex1: 5,
                                flex2: 7),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Alternate Week Off Days',
                                text2: controller.shiftDetails?.alternateWeekOffDaysView != null && controller.shiftDetails!.alternateWeekOffDaysView!.isNotEmpty
                                    ? '${controller.shiftDetails?.alternateWeekOffDaysView}'
                                    : 'N/A',
                                flex1: 5,
                                flex2: 7),
                            commonDividerView(),
                            // commonRowForDetailView(
                            //     text1: 'Paid Leave on Extra Day', text2: 'Yes'),
                            // SizedBox(height: 10.px),
                            // commonRowForDetailView(
                            //     text1: 'Extra Day Leave Expire Days',
                            //     text2: '60 Days'),
                            // SizedBox(height: 10.px),
                            // commonRowForDetailView(
                            //     text1: 'Applicable Extra Day Leave in Month',
                            //     text2: '4'),
                            // SizedBox(height: 10.px),
                            // commonRowForDetailView(
                            //     text1: 'Allow Comp Off Leave on Past Date',
                            //     text2: 'No'),
                            // commonDividerView(),
                            // commonRowForDetailView(text1: 'Multiple Punch in Allowed', text2: 'Yes'),
                            // SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Late In Reason Required',
                                text2: controller.shiftDetails?.lateInReasonRequired != null && controller.shiftDetails!.lateInReasonRequired!.isNotEmpty
                                    ? controller.shiftDetails?.lateInReasonRequired == '1'
                                    ? 'Yes'
                                    : 'No'
                                    : 'N/A'),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Early Out Reason Required',
                                text2: controller.shiftDetails?.earlyOutReasonRequired != null && controller.shiftDetails!.earlyOutReasonRequired!.isNotEmpty
                                    ? controller.shiftDetails?.earlyOutReasonRequired == '1'
                                    ? 'Yes'
                                    : 'No'
                                    : 'N/A'),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1:
                                    'Take Reason If Punch In/ Punch Out  is Out of Range',
                                text2: controller.shiftDetails?.outOfRangeReasonRequired != null && controller.shiftDetails!.outOfRangeReasonRequired!.isNotEmpty
                                    ? controller.shiftDetails?.outOfRangeReasonRequired == '1'
                                    ? 'Yes'
                                    : 'No'
                                    : 'N/A'),
                            commonDividerView(),
                            commonRowForDetailView(
                                text1: 'Total Late In Allowed Per Month',
                                text2: controller.shiftDetails?.maxLateInMonth != null && controller.shiftDetails!.maxLateInMonth!.isNotEmpty
                                    ? '${controller.shiftDetails?.maxLateInMonth}'
                                    : 'N/A'),
                            SizedBox(height: 10.px),
                            commonRowForDetailView(
                                text1: 'Total Early Out Allowed Per Month',
                                text2: controller.shiftDetails?.maxEarlyOutMonth != null && controller.shiftDetails!.maxEarlyOutMonth!.isNotEmpty
                                    ? '${controller.shiftDetails?.maxEarlyOutMonth}'
                                    : 'N/A'),
                            SizedBox(height: 10.px),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                              style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.onSecondary, fontSize: 10.px),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            commonDividerView(),
                          ],
                        ),
                      ),
                    ),
                    controller.shiftTimeList != null && controller.shiftTimeList!.isNotEmpty
                        ? shiftListView()
                        : SizedBox(height: 14.h,child: CW.commonNoDataFoundText(text: 'Shift data not Found!'),),
                  ],
                ),
              );
            } else {
              return CW.commonNoDataFoundText();
            }
          } else {
            return CW.commonNoDataFoundText(text: controller.apiResValue.value ? '' : 'No Data Found!');
          }
        },
      ),
    );
  }

  Widget commonTitleRowView({required String text, required String text1}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.start),
          SizedBox(width: 10.px),
          Flexible(
            child: Text(
              text1,
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  Widget commonRowForDetailView({required String text1, required String text2, int? flex1, int? flex2}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flex1 ?? 3,
            child: Text(
              text1,
              style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(
                  color: Col.onSecondary, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 6.px),
          Text(
            ':',
            style: Theme.of(Get.context!)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: Col.secondary),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 14.px),
          Expanded(
            flex: flex2 ?? 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text2,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );

  Widget commonDividerView() => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.px),
        child: CW.commonDividerView(color: Col.gray, wight: .2.px),
      );

  Widget commonDash() => Center(
        child: Dash(
            direction: Axis.horizontal,
            length: 12.w,
            dashLength: 5.px,
            dashThickness: 1.px,
            dashColor: Col.primary),
      );

  Widget shiftListView() => ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            shiftCardView(index: index),
          ],
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.shiftTimeList?.length,
      shrinkWrap: true,
  );

  Widget shiftCardView({required int index}) {
    return Card(
      color: Col.inverseSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
      child: Padding(
        padding: EdgeInsets.all(8.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dayTextView(
                dayText: controller.shiftTimeList?[index].shiftDayName!=null&& controller.shiftTimeList![index].shiftDayName!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftDayName}'
                    : 'N/A'),
            dayTextBoarderView(
                dayText: controller.shiftTimeList?[index].shiftDayName!=null&& controller.shiftTimeList![index].shiftDayName!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftDayName}'
                    : 'N/A'),
            SizedBox(height: 12.px),
            timeRowView(
                morningTimeText: controller.shiftTimeList?[index].shiftStartTime!=null&& controller.shiftTimeList![index].shiftStartTime!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftStartTime} AM'
                    : 'N/A',
                totalTimeText: controller.shiftTimeList?[index].totalShiftMinutes!=null&& controller.shiftTimeList![index].totalShiftMinutes!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].totalShiftMinutes} Min'
                    : 'N/A',
                eveningTimeText: controller.shiftTimeList?[index].shiftEndTime!=null&& controller.shiftTimeList![index].shiftEndTime!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftEndTime} PM'
                    : 'N/A'),
            SizedBox(height: 12.px),
            breakShiftTextView(
                breakText: 'Shift Type', breakTimeText: controller.shiftTimeList?[index].shiftType!=null&& controller.shiftTimeList![index].shiftType!.isNotEmpty
                ? '${controller.shiftTimeList?[index].shiftType}'
                : 'N/A'),
            SizedBox(height: 6.px),
            if(controller.shiftTimeList?[index].lunchBreakStartTime!= null && controller.shiftTimeList![index].lunchBreakStartTime!.isNotEmpty && controller.shiftTimeList?[index].lunchBreakEndTime!= null && controller.shiftTimeList![index].lunchBreakEndTime!.isNotEmpty)
            breakShiftTextView(breakText: 'Lunch Break ( ${controller.shiftTimeList?[index].lunchBreakStartTime} PM - ${controller.shiftTimeList?[index].lunchBreakEndTime} PM )', breakTimeText: '30 Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Take Lunch Break Before Minutes', breakTimeText: '60 Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Late In Relaxation ( 09:30 AM)', breakTimeText: '30 Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Early Out Relaxation ( 05:30 PM)', breakTimeText: '30 Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Mark As Half Day ( Punch In After)', breakTimeText: '01:30 PM'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Mark As Half Day ( Punch Out Before)', breakTimeText: '02:00 PM'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Minimum Working Hours For Half Day', breakTimeText: '04 hr 30 min'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Minimum Working Hours For Full Day', breakTimeText: '08 hr 30 min'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Max Tea Break', breakTimeText: '1'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'MaxLunch Break', breakTimeText: '1'),
          ],
        ),
      ),
    );
  }

  Widget dayTextView({required String dayText}) => Text(
        dayText,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Col.primary),
      );

  Widget dayTextBoarderView({required String dayText}) => Container(
        height: 2.px,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Col.primary),
                left: BorderSide(color: Col.primary),
                right: BorderSide(color: Col.primary))),
        child: dayTextView(dayText: dayText),
      );

  Widget timeRowView({required String morningTimeText, required String totalTimeText, required String eveningTimeText}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeTextView(text: morningTimeText),
          SizedBox(width: 6.px),
          commonDash(),
          SizedBox(width: 6.px),
          timeTextView(text: totalTimeText, textColor: Col.primary),
          SizedBox(width: 6.px),
          commonDash(),
          SizedBox(width: 6.px),
          timeTextView(text: eveningTimeText),
        ],
      );

  Widget timeTextView({required String text, Color? textColor}) => Flexible(
        child: Text(
          text,
          style: Theme.of(Get.context!)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600, color: textColor),
        ),
      );

  Widget breakShiftTextView({required String breakText, required String breakTimeText}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Container(
                  height: 6.px,
                  width: 6.px,
                  decoration: BoxDecoration(
                      color: Col.secondary, shape: BoxShape.circle),
                ),
                SizedBox(width: 10.px),
                Flexible(
                  child: Text(
                    breakText,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 10.px),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.px),
          Expanded(
            flex: 3,
            child: Text(
              breakTimeText,
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 10.px),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
