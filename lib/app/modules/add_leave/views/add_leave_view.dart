import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_leave_controller.dart';

class AddLeaveView extends GetView<AddLeaveController> {
  const AddLeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: controller.pageName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return ModalProgress(
            isLoader: true,
            inAsyncCall: controller.apiResValue.value,
            child: controller.apiResValue.value
                ? const SizedBox()
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 16.px, top: 8.px),
                        children: [
                          calendarBuildHeader(index: 0),
                          SizedBox(height: 10.px),
                          getDayNames(),
                          SizedBox(height: 10.px),
                          calendarGridView(),
                          SizedBox(height: 20.px),
                          if (controller.dateAddForLeaveList.isNotEmpty)
                           leaveDateGridView(),
                          if (controller.dateAddForLeaveList.isNotEmpty)
                           SizedBox(height: 10.px),
                          leaveTypeTextField(),
                          SizedBox(height: 10.px),
                          fullAndHalfDayView(),
                          SizedBox(height: 10.px),
                          firstAndSecondHalfView(),
                          SizedBox(height: 10.px),
                          paidAndUnPaidView(),
                          SizedBox(height: 10.px),
                          reasonTextFormFiled(),
                          SizedBox(height: 10.px),
                          attachFile(),
                          SizedBox(height: 80.px),
                        ],
                      ),
                      applyLeaveButtonView()
                    ],
                  ),
          );
        }),
      ),
    );
  }

  Widget calendarBuildHeader({required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        controller.currentMonth.value.month != DateTime.parse('${controller.getLeaveDateCalenderModal.value?.isBeforeDate}').month
            ? IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: Col.secondary, size: 28.px),
                onPressed: () => controller.clickOnReverseIconButton(index: index),
              )
            : SizedBox(width: 50.px),
        SizedBox(width: 10.px),
        Text(
          CMForDateTime.dateFormatForMonthYear(
              date: '${controller.currentMonth.value}'),
          style: Theme.of(Get.context!).textTheme.displayLarge,
        ),
        SizedBox(width: 10.px),
        controller.currentMonth.value.month != DateTime.parse('${controller.getLeaveDateCalenderModal.value?.isAfterDate}').month
            ? IconButton(
                icon: Icon(Icons.keyboard_arrow_right, color: Col.secondary, size: 28.px),
                onPressed: () => controller.clickOnForwardIconButton(index: index),
              )
            : SizedBox(width: 50.px),
      ],
    );
  }

  Widget getDayNames() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (var day in controller.days)
          Text(
            day,
            style: Theme.of(Get.context!).textTheme.titleLarge,
          ),
      ],
    );
  }

  String convertDateFormat({required String originalDateString}) {
    // Split the original date string
    List<String> parts = originalDateString.split(' ');

    // Extract day, month, and year
    int day = int.parse(parts[0]);
    String month = parts[1];
    int year = int.parse(parts[2]);

    // Convert month name to month number
    int monthNumber = CMForDateTime.monthToNumber(month);

    // Format the date as "yyyy-MM-dd"
    String formattedDate = "$year-${CMForDateTime.formatWithLeadingZeros(monthNumber)}-${CMForDateTime.formatWithLeadingZeros(day)}";

    return formattedDate;
  }

  c({required String currentDate, required String isAfterDate, required String isBeforeDate}) {
    DateTime current = DateTime.parse(currentDate);
    DateTime after = DateTime.parse(isAfterDate);
    DateTime before = DateTime.parse(isBeforeDate);

    // Compare the dates
    if (current.isBefore(before) || current.isAfter(after)) {
      return true;
    } else {
      return false;
    }
  }

  Widget calendarGridView() {
    var daysInMonth = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1, 0).day;

    var t = '1-${controller.currentMonth.value.month}-${controller.currentMonth.value.year}';

    DateTime parsedDate = DateFormat("d-M-yyyy").parse(t);

    var extra = parsedDate.weekday == 7 ? 0 : parsedDate.weekday;

    daysInMonth = daysInMonth + extra;

    controller.monthTotalDaysListDataAdd();

    for (var i = 0; i < extra; i++) {
      controller.monthTotalDaysList.insert(0, 0);
    }
    if (controller.getLeaveDateCalenderModal.value != null) {
      if (controller.leaveDateCalenderList != null &&
          controller.leaveDateCalenderList!.isNotEmpty) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
          ),
          itemCount: daysInMonth,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final day = controller.monthTotalDaysList[index];
            if (day == 0) {
              return const SizedBox();
            } else {
              if (controller.getLeaveDateCalenderModal.value?.isBeforeDate != null &&
                  controller.getLeaveDateCalenderModal.value!.isBeforeDate!.isNotEmpty &&
                  controller.getLeaveDateCalenderModal.value?.isAfterDate != null &&
                  controller.getLeaveDateCalenderModal.value!.isAfterDate!.isNotEmpty) {
                controller.isAfterAndBeforeCalenderDateValue.value = c(
                  currentDate: '${controller.currentMonth.value.year}-${CMForDateTime.formatWithLeadingZeros(controller.currentMonth.value.month)}-${CMForDateTime.formatWithLeadingZeros(day)}',
                  isAfterDate: '${controller.getLeaveDateCalenderModal.value?.isAfterDate}',
                  isBeforeDate: '${controller.getLeaveDateCalenderModal.value?.isBeforeDate}',
                );
              }
              return InkWell(
                onTap: () {
                  if (controller.getLeaveDateCalenderModal.value?.isBeforeDate != null &&
                      controller.getLeaveDateCalenderModal.value!.isBeforeDate!.isNotEmpty &&
                      controller.getLeaveDateCalenderModal.value?.isAfterDate != null &&
                      controller.getLeaveDateCalenderModal.value!.isAfterDate!.isNotEmpty) {
                    if (!c(currentDate: '${controller.currentMonth.value.year}-${CMForDateTime.formatWithLeadingZeros(controller.currentMonth.value.month)}-${CMForDateTime.formatWithLeadingZeros(day)}',
                      isAfterDate: '${controller.getLeaveDateCalenderModal.value?.isAfterDate}',
                      isBeforeDate: '${controller.getLeaveDateCalenderModal.value?.isBeforeDate}',
                    )) {
                      if (controller.leaveDateCalenderList?[index - extra].holiday == false &&
                          controller.leaveDateCalenderList?[index - extra].weekOff == false &&
                          controller.leaveDateCalenderList?[index - extra].isLeave == false &&
                          controller.leaveDateCalenderList?[index - extra].isPresent == false) {
                        if (controller.dateAddForLeaveList.contains('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}')) {
                          controller.dateAddForLeaveList.remove('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}');
                          controller.formattedDateListForApi = controller.dateAddForLeaveList.map((dateString) => convertDateFormat(originalDateString: dateString)).toList();
                        } else {
                          controller.dateAddForLeaveList.add('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}');
                          controller.formattedDateListForApi = controller.dateAddForLeaveList.map((dateString) => convertDateFormat(originalDateString: dateString)).toList();
                        }
                      }
                      else if (controller.leaveDateCalenderList?[index - extra].holiday == true) {
                        CM.showSnackBar(message: 'Holiday');
                      }
                      else if (controller.leaveDateCalenderList?[index - extra].weekOff == true) {
                        CM.showSnackBar(message: 'WeekOff');
                      }
                      else if (controller.leaveDateCalenderList?[index - extra].isLeave == true) {
                        CM.showSnackBar(message: 'Leave');
                      }
                      else if (controller.leaveDateCalenderList?[index - extra].isPresent == true || (controller.leaveDateCalenderList?[index - extra].isPresent == true && controller.leaveDateCalenderList?[index - extra].holiday == true)) {
                        CM.showSnackBar(message: 'Present');
                      }
                    }
                  }
                  controller.count.value++;
                },
                borderRadius: BorderRadius.circular(20.px),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: /*controller.isAfterAndBeforeCalenderDateValue.value
                     && controller.leaveDateCalenderList?[index - extra].weekOff == false
                     && controller.leaveDateCalenderList?[index - extra].isLeave == false
                     && controller.leaveDateCalenderList?[index - extra].isPresent == false
                     && controller.leaveDateCalenderList?[index - extra].holiday == false
                      ? Col.primary.withOpacity(.2)
                      :*/
                      controller.dateAddForLeaveList.contains('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}')
                          ? Col.primary
                          : calendarGridColorView(index: index - extra),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.px)),
                  child: SizedBox(
                    height: 30.px,
                    width: 30.px,
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 10.px,
                                color: controller.isAfterAndBeforeCalenderDateValue.value &&
                                        controller.leaveDateCalenderList?[index - extra].weekOff == false &&
                                        controller.leaveDateCalenderList?[index - extra].isLeave == false &&
                                        controller.leaveDateCalenderList?[index - extra].isPresent == false &&
                                        controller.leaveDateCalenderList?[index - extra].holiday == false
                                    ? Col.darkGray.withOpacity(.4)
                                    : controller.dateAddForLeaveList.contains('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}')
                                        ? Col.inverseSecondary
                                        : Col.text),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }

  Color calendarGridColorView({required int index}) {
    if (controller.leaveDateCalenderList?[index].isPresent == true || (controller.leaveDateCalenderList?[index].isPresent == true && controller.leaveDateCalenderList?[index].holiday == true)) {
      return const Color(0xffF2FFF3);
    } else if (controller.leaveDateCalenderList?[index].holiday ?? false) {
      return const Color(0xffDDE0FB);
    } else if (controller.leaveDateCalenderList?[index].weekOff ?? false) {
      return const Color(0xffE6E6E6);
    } else if (controller.leaveDateCalenderList?[index].isLeave ?? false) {
      return const Color(0xffE0F1FF);
    } else {
      return Colors.transparent;
    }
  }

  Widget leaveDateGridView() {
    return Container(
      padding: EdgeInsets.all(12.px),
      decoration: BoxDecoration(
          color: Col.primary.withOpacity(.1),
          borderRadius: BorderRadius.circular(10.px),
          border: Border.all(color: Col.gray)),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.px,
            mainAxisSpacing: 10.px,
            childAspectRatio: 1.4),
        itemCount: controller.dateAddForLeaveList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.px)),
            margin: EdgeInsets.zero,
            color: Col.inverseSecondary,
            child: Padding(
              padding: EdgeInsets.all(8.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CMForDateTime.formatDate(controller.dateAddForLeaveList[index]),
                    style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   'Paid',
                  //   style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px,fontWeight: FontWeight.w500),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget leaveTypeTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.leaveTypeController,
        labelText: 'Leave Type',
        hintText: 'Leave Type',
        keyboardType: TextInputType.name,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select leave type'),
        onChanged: (value) {
          controller.count.value++;
        },
        readOnly: true,
        onTap: () => controller.clickOnLeaveTypeField(),
        suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary),
      );

  Widget commonContainerView({required Widget child}) => Container(
        height: 50.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.px),
            border: Border.all(color: Col.gray)),
        child: child,
      );

  Widget radioButtonLabelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
      );

  Widget fullAndHalfDayView() => commonContainerView(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                CW.commonRadioView(
                  onChanged: (value) {
                    CM.unFocusKeyBoard();
                    controller.fullAndHalfDayIndexValue.value = value;
                    controller.fullAndHalfDayType.value =
                        controller.fullAndHalfDayText[index];
                    controller.count.value++;
                  },
                  index: index.toString(),
                  selectedIndex:
                      controller.fullAndHalfDayIndexValue.value.toString(),
                ),
                radioButtonLabelTextView(
                    text: controller.fullAndHalfDayText[index])
              ],
            );
          },
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget firstAndSecondHalfView() => commonContainerView(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                CW.commonRadioView(
                  onChanged: (value) {
                    CM.unFocusKeyBoard();
                    controller.firstAndSecondHalfIndexValue.value = value;
                    controller.firstAndSecondHalfType.value =
                        controller.firstAndSecondHalfText[index];
                    controller.count.value++;
                  },
                  index: index.toString(),
                  selectedIndex:
                      controller.firstAndSecondHalfIndexValue.value.toString(),
                ),
                radioButtonLabelTextView(
                    text: controller.firstAndSecondHalfText[index])
              ],
            );
          },
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget paidAndUnPaidView() => commonContainerView(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                CW.commonRadioView(
                  onChanged: (value) {
                    CM.unFocusKeyBoard();
                    controller.paidAndUnPaidIndexValue.value = value;
                    controller.paidAndUnPaidType.value =
                        controller.paidAndUnPaidText[index];
                    controller.count.value++;
                  },
                  index: index.toString(),
                  selectedIndex:
                      controller.paidAndUnPaidIndexValue.value.toString(),
                ),
                radioButtonLabelTextView(
                    text: controller.paidAndUnPaidText[index])
              ],
            );
          },
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget reasonTextFormFiled() => CW.commonTextFieldForMultiline(
        labelText: 'Reason',
        hintText: 'Reason',
        controller: controller.reasonController,
        maxLines: 3,
      );

  Widget attachFile() {
    return Center(
      child: InkWell(
        onTap: () => controller.clickOnAttachmentButton(),
        borderRadius: BorderRadius.circular(10.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(12.px),
          // padding: EdgeInsets.all(12.px),
          child: Container(
            width: double.infinity,
            height: 100.px,
            padding: EdgeInsets.all(12.px),
            decoration: BoxDecoration(
                color: Col.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.px)),
            child: attachmentRowTextView(),
          ),
        ),
      ),
    );
  }

  Widget attachmentRowTextView() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CW.commonNetworkImageView(
              path: 'assets/icons/attach_file_icon.png',
              isAssetImage: true,
              width: 20.px,
              height: 20.px),
          SizedBox(width: 5.px),
          Text(
            'Attachment',
            style: Theme.of(Get.context!)
                .textTheme
                .titleMedium
                ?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
          )
        ],
      );

  Widget applyLeaveButtonView() => Container(
        height: 80.px,
        padding: EdgeInsets.only(
            left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
        color: Col.inverseSecondary,
        child: Center(
          child: CW.commonElevatedButton(
              onPressed: controller.applyLeaveButtonValue.value
                  ? () => null
                  : () => controller.clickOnApplyLeaveButton(),
              // buttonColor: controller.notCompletedTaskValue.value &&
              //         controller.repeatTaskValue.value
              //     ? Col.primary
              //     : Col.primary.withOpacity(.7),
              buttonText: 'Apply Leave',
              borderRadius: 10.px,
              isLoading: controller.applyLeaveButtonValue.value),
        ),
      );
}

