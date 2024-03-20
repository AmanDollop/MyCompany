import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';
import '../../../../common/custom_outline_button.dart';
import '../controllers/shift_detail_controller.dart';

class ShiftDetailView extends GetView<ShiftDetailController> {
  const ShiftDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(
                  () {
                    controller.count.value;
                    if (controller.shiftDetails != null) {
                      return ModalProgress(
                        inAsyncCall: controller.apiResValue.value,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 12.px),
                          children: [
                            CustomOutlineButton(
                              strokeWidth: .5.px,
                              radius: 6.px,
                              gradient: CW.commonLinearGradientForButtonsView(),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Col.primary.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(6.px),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.px),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      commonTitleRowView(
                                        text: 'Shift Name',
                                        text1: controller.shiftDetails?.shiftName != null && controller.shiftDetails!.shiftName!.isNotEmpty
                                            ? '${controller.shiftDetails?.shiftName}'
                                            : 'N/A',
                                      ),
                                      SizedBox(height: 10.px),
                                      commonTitleRowView(
                                          text: 'Shift Code',
                                          text1: controller.shiftDetails?.shiftCode != null && controller.shiftDetails!.shiftCode!.isNotEmpty
                                              ? '${controller.shiftDetails?.shiftCode}'
                                              : 'N/A')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: 20.px),
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
                                  style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.inverseSecondary, fontSize: 10.px),
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                commonDividerView(),
                              ],
                            ),
                            controller.shiftTimeList != null && controller.shiftTimeList!.isNotEmpty
                                ? shiftListView()
                                : SizedBox(height: 14.h,child: CW.commonNoDataFoundText(text: 'Shift data not Found!'),),
                          ],
                        ),
                      );
                    } else {
                      return CW.commonNoDataFoundText(text: controller.apiResValue.value ? '' : 'No Data Found!');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.profileMenuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget commonTitleRowView({required String text, required String text1}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
              textAlign: TextAlign.start),
          SizedBox(width: 10.px),
          Flexible(
            child: Text(
              text1,
              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

  Widget commonRowForDetailView({required String text1, required String text2, int? flex1, int? flex2}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: flex1 ?? 3,
            child: Text(
              text1,
              style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(color: Col.inverseSecondary, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 6.px),
          Text(
            ':',
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Col.inverseSecondary),
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
                  style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
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
        child: CW.commonDividerView(wight: 1.px),
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
    physics: const NeverScrollableScrollPhysics(),
    itemCount: controller.shiftTimeList?.length,
    shrinkWrap: true,
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
        return Column(
          children: [
            shiftCardView(index: index),
          ],
        );
      },
  );

  String convertTo12HourFormat({required String time24HourFormat}) {
    final inputFormat = DateFormat('HH:mm');
    final outputFormat = DateFormat('hh:mm a');

    DateTime dateTime = inputFormat.parse(time24HourFormat);
    return outputFormat.format(dateTime);
  }

  String subtractMinutes({required String time12HourFormat,required int subtractValue}) {
    final inputFormat = DateFormat('hh:mm a');
    final outputFormat = DateFormat('hh:mm a');

    // Parse the input time in 12-hour format
    DateTime dateTime = inputFormat.parse(time12HourFormat);

      // Subtract minutes
    dateTime = dateTime.subtract(Duration(minutes: subtractValue));

    // Format the adjusted time in 12-hour format
    return outputFormat.format(dateTime);
  }

  String addMinutes({required String time12HourFormat,required int addValue}) {
    final inputFormat = DateFormat('hh:mm a');
    final outputFormat = DateFormat('hh:mm a');

    // Parse the input time in 12-hour format
    DateTime dateTime = inputFormat.parse(time12HourFormat);

      // Subtract minutes
    dateTime = dateTime.add(Duration(minutes: addValue));

    // Format the adjusted time in 12-hour format
    return outputFormat.format(dateTime);
  }

  int subtractTimes(String startTimeString, String endTimeString) {
    final inputFormat = DateFormat('hh:mm a');
    final outputFormat = DateFormat('hh:mm a');

    // Parse the input times in 12-hour format
    DateTime startTime = inputFormat.parse(startTimeString);
    DateTime endTime = inputFormat.parse(endTimeString);

    // If the end time is before the start time, assume it's on the next day
    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(const Duration(days: 1));
    }

    // Calculate the difference in minutes
    int differenceInMinutes = endTime.difference(startTime).inMinutes;

    return differenceInMinutes;
  }

  Widget shiftCardView({required int index}) {

    if(controller.shiftTimeList?[index].totalShiftMinutes!=null&& controller.shiftTimeList![index].totalShiftMinutes!.isNotEmpty) {
       controller.totalMinutes = controller.shiftTimeList?[index].totalShiftMinutes;
    }

    if(controller.totalMinutes!=null&& controller.totalMinutes!.isNotEmpty) {
     controller.totalHoursFormApi = int.parse(controller.totalMinutes.toString()) / 60;
    }

    if(controller.shiftTimeList?[index].shiftStartTime!=null&& controller.shiftTimeList![index].shiftStartTime!.isNotEmpty) {
      controller.shiftStartTimeString = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].shiftStartTime ?? '');
    }

    if(controller.shiftTimeList?[index].shiftEndTime!=null&& controller.shiftTimeList![index].shiftEndTime!.isNotEmpty) {
      controller.shiftEndTimeString  = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].shiftEndTime ?? '');
    }

    if(controller.totalHoursFormApi == 0.0){
      controller.totalHoursLocal = subtractTimes(controller.shiftStartTimeString ?? '',controller.shiftEndTimeString??'');
    }

    if(controller.shiftTimeList?[index].lunchBreakStartTime!=null&& controller.shiftTimeList![index].lunchBreakStartTime!.isNotEmpty) {
      controller.lunchBreakStartTime  = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].lunchBreakStartTime ?? '');
    }

    if(controller.shiftTimeList?[index].lunchBreakEndTime!=null&& controller.shiftTimeList![index].lunchBreakEndTime!.isNotEmpty) {
      controller.lunchBreakEndTime  = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].lunchBreakEndTime ?? '');
    }

    controller.lunchBreakTime = subtractTimes(controller.lunchBreakStartTime ?? '',controller.lunchBreakEndTime??'');

    if(controller.shiftTimeList?[index].lateInMinutes!=null&& controller.shiftTimeList![index].lateInMinutes!.isNotEmpty) {
      controller.lateInRelaxationText  = '${controller.shiftTimeList?[index].lateInMinutes}';
      controller.lateInRelaxationTime = addMinutes(time12HourFormat: controller.shiftStartTimeString??'',addValue: int.parse(controller.lateInRelaxationText??''));
    }

    if(controller.shiftTimeList?[index].earlyOutMinutes!=null&& controller.shiftTimeList![index].earlyOutMinutes!.isNotEmpty) {
      controller.earlyOutRelaxationText  = '${controller.shiftTimeList?[index].earlyOutMinutes}';
      controller.earlyOutRelaxationTime = subtractMinutes(time12HourFormat: controller.shiftEndTimeString??'',subtractValue: int.parse(controller.earlyOutRelaxationText??''));
    }

    if(controller.shiftTimeList?[index].halfDayBeforeTime!=null&& controller.shiftTimeList![index].halfDayBeforeTime!.isNotEmpty) {
      controller.halfDayBeforeTime  = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].halfDayBeforeTime ?? '');
    }

    if(controller.shiftTimeList?[index].halfDayAfterTime!=null&& controller.shiftTimeList![index].halfDayAfterTime!.isNotEmpty) {
      controller.halfDayAfterTime  = convertTo12HourFormat(time24HourFormat: controller.shiftTimeList?[index].halfDayAfterTime ?? '');
    }

    if(controller.shiftTimeList?[index].minHalfHours!=null&& controller.shiftTimeList![index].minHalfHours!.isNotEmpty) {
      controller.minHalfHours  = '${controller.shiftTimeList?[index].minHalfHours} Hours';
    }

    if(controller.shiftTimeList?[index].minFullDayHours!=null&& controller.shiftTimeList![index].minFullDayHours!.isNotEmpty) {
      controller.minFullDayHours  = '${controller.shiftTimeList?[index].minFullDayHours} Hours';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.px),
      decoration: BoxDecoration(
        color: Col.gCardColor,
        borderRadius: BorderRadius.circular(6.px),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dayTextView(
                dayText: controller.shiftTimeList?[index].shiftDayName!=null && controller.shiftTimeList![index].shiftDayName!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftDayName}'
                    : 'N/A'),
            dayTextBoarderView(
                dayText: controller.shiftTimeList?[index].shiftDayName!=null&& controller.shiftTimeList![index].shiftDayName!.isNotEmpty
                    ? '${controller.shiftTimeList?[index].shiftDayName}'
                    : 'N/A'),
            SizedBox(height: 12.px),
            timeRowView(
                morningTimeText: controller.shiftStartTimeString !=null && controller.shiftStartTimeString!.isNotEmpty
                    ? '${controller.shiftStartTimeString}'
                    : 'N/A',
                totalTimeText: controller.totalHoursFormApi != 0.0
                    ? '${controller.totalHoursFormApi} Hours'
                    : '${controller.totalHoursLocal / 60} Hours',
                eveningTimeText: controller.shiftEndTimeString!=null&& controller.shiftEndTimeString!.isNotEmpty
                    ? '${controller.shiftEndTimeString}'
                    : 'N/A'),
            SizedBox(height: 12.px),
            breakShiftTextView(
                breakText: 'Shift Type', breakTimeText: controller.shiftTimeList?[index].shiftType!=null&& controller.shiftTimeList![index].shiftType!.isNotEmpty
                ? '${controller.shiftTimeList?[index].shiftType}'
                : 'N/A'),
            if(controller.lunchBreakStartTime != null && controller.lunchBreakStartTime!.isNotEmpty && controller.lunchBreakEndTime!= null && controller.lunchBreakEndTime!.isNotEmpty)
              SizedBox(height: 6.px),
            if(controller.lunchBreakStartTime != null && controller.lunchBreakStartTime!.isNotEmpty && controller.lunchBreakEndTime!= null && controller.lunchBreakEndTime!.isNotEmpty)
            breakShiftTextView(breakText: 'Lunch Break ( ${controller.lunchBreakStartTime} - ${controller.lunchBreakEndTime} )', breakTimeText: '${controller.lunchBreakTime} Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Late In Relaxation ( ${controller.lateInRelaxationTime} )', breakTimeText: '${controller.lateInRelaxationText} Minutes'),
            SizedBox(height: 6.px),
            breakShiftTextView(breakText: 'Early Out Relaxation ( ${controller.earlyOutRelaxationTime} )', breakTimeText: '${controller.earlyOutRelaxationText} Minutes'),
            if(controller.halfDayAfterTime != null && controller.halfDayAfterTime!.isNotEmpty)
            SizedBox(height: 6.px),
            if(controller.halfDayAfterTime != null && controller.halfDayAfterTime!.isNotEmpty)
            breakShiftTextView(breakText: 'Mark As Half Day ( Punch In After)', breakTimeText: '${controller.halfDayAfterTime}'),
            if(controller.halfDayBeforeTime != null && controller.halfDayBeforeTime!.isNotEmpty)
            SizedBox(height: 6.px),
            if(controller.halfDayBeforeTime != null && controller.halfDayBeforeTime!.isNotEmpty)
            breakShiftTextView(breakText: 'Mark As Half Day ( Punch Out Before)', breakTimeText: '${controller.halfDayBeforeTime}'),
            if(controller.minHalfHours != null && controller.minHalfHours!.isNotEmpty)
            SizedBox(height: 6.px),
            if(controller.minHalfHours != null && controller.minHalfHours!.isNotEmpty)
            breakShiftTextView(breakText: 'Minimum Working Hours For Half Day', breakTimeText: '${controller.minHalfHours}'),
            if(controller.minFullDayHours != null && controller.minFullDayHours!.isNotEmpty)
            SizedBox(height: 6.px),
            if(controller.minFullDayHours != null && controller.minFullDayHours!.isNotEmpty)
            breakShiftTextView(breakText: 'Minimum Working Hours For Full Day', breakTimeText: '${controller.minFullDayHours}'),
            SizedBox(height: 6.px),
          ],
        ),
      ),
    );
  }

  Widget dayTextView({required String dayText}) => Text(
        dayText,
        style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(color: Col.primary),
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

  Widget timeRowView({required String morningTimeText, required String totalTimeText, required String eveningTimeText}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timeTextView(text: morningTimeText,textColor: Col.inverseSecondary),
          SizedBox(width: 6.px),
          commonDash(),
          SizedBox(width: 6.px),
          Container(padding: EdgeInsets.symmetric(horizontal: 8.px,vertical: 4.px),decoration: BoxDecoration(color: Col.primary.withOpacity(.2.px),borderRadius: BorderRadius.circular(6.px),),child: timeTextView(text: totalTimeText, textColor: Col.primary)),
          SizedBox(width: 6.px),
          commonDash(),
          SizedBox(width: 6.px),
          timeTextView(text: eveningTimeText,textColor: Col.inverseSecondary),
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

  Widget breakShiftTextView({required String breakText, required String breakTimeText}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Container(
                  height: 6.px,
                  width: 6.px,
                  decoration: BoxDecoration(color: Col.inverseSecondary, shape: BoxShape.circle),
                ),
                SizedBox(width: 10.px),
                Flexible(
                  child: Text(
                    breakText,
                    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px,color: Col.inverseSecondary),
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
                  ?.copyWith(fontSize: 10.px,color: Col.inverseSecondary),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
}
