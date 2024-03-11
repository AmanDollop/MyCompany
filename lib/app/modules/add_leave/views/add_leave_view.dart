import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_leave_controller.dart';


/// Apply bulk leave show hide working

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
          if (AC.isConnect.value) {
            controller.allMonthsSameValue.value = checkIfAllMonthsSame(dates: controller.formattedDateListForApi);
            if(controller.dateAddForLeaveList.isEmpty /*controller.dateAddForLeaveList.length <= 1*/){
              controller.applyBulkLeaveValue.value = false;
              controller.applyBulkLeaveButtonHideAndShowValue.value = false;
            }
            return ModalProgress(
              isLoader: true,
              inAsyncCall: controller.apiResValue.value,
              child: controller.apiResValue.value
                  ? const SizedBox()
                  : controller.getLeaveDateCalenderModal.value != null
                  ? controller.leaveDateCalenderList != null && controller.leaveDateCalenderList!.isNotEmpty
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                         ListView(
                          padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 16.px, top: controller.applyBulkLeaveValue.value ? 20.px : 8.px),
                          children: [
                            SizedBox(
                              height: 50.h,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller.pageController,
                                itemCount: controller.leaveDateCalenderList?.length,
                                itemBuilder: (context, pageViewIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    calendarBuildHeader(pageViewIndex: pageViewIndex),
                                    SizedBox(height: controller.applyBulkLeaveValue.value ? 20.px : 10.px),
                                    getDayNames(),
                                    SizedBox(height: 10.px),
                                    calendarGridView(pageViewIndex:pageViewIndex),
                                  ],
                                );
                              },),
                            ),
                            SizedBox(height: 20.px),
                            if (controller.dateAddForLeaveList.isNotEmpty)
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  leaveDateGridView(),
                                  if (controller.dateAddForLeaveList.length > 1 && controller.allMonthsSameValue.value)
                                    SizedBox(height: 6.px),
                                  if (controller.dateAddForLeaveList.length > 1 && controller.allMonthsSameValue.value)
                                    applyBulkLeaveView(),
                                  if (controller.dateAddForLeaveList.length > 1 && controller.allMonthsSameValue.value)
                                    SizedBox(height: 14.px),
                                  Form(
                                    key: controller.keyForLeaveReason,
                                    child: reasonTextFormFiled(),
                                  ),
                                  SizedBox(height: 10.px),
                                  attachFile(),
                                  SizedBox(height: 80.px),
                                ],
                              )
                          ],
                        ),
                        // if (controller.dateAddForLeaveList.isNotEmpty)
                        applyLeaveButtonView()
                      ],
                    )
                  : CW.commonNoDataFoundText()
                  : CW.commonNoDataFoundText(),
            );
          }
          else {
            return CW.commonNoNetworkView();
          }
        }),
      ),
    );
  }

  Widget calendarBuildHeader({required int pageViewIndex}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!controller.applyBulkLeaveValue.value)
          controller.currentMonth.value.month != DateTime.parse('${controller.getLeaveDateCalenderModal.value?.isBeforeDate}').month
              ? IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Col.secondary, size: 28.px),
                  onPressed: () => controller.clickOnReverseIconButton(),
                )
              : SizedBox(width: 50.px),
        SizedBox(width: 10.px),
        Text(
          CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}'),
          style: Theme.of(Get.context!).textTheme.displayLarge,
        ),
        SizedBox(width: 10.px),
        if (!controller.applyBulkLeaveValue.value)
            controller.currentMonth.value.month != DateTime.parse('${controller.getLeaveDateCalenderModal.value?.isAfterDate}').month
              ? IconButton(
                  icon: Icon(Icons.keyboard_arrow_right, color: Col.secondary, size: 28.px),
                  onPressed: () => controller.clickOnForwardIconButton(),
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
    String formattedDate =
        "$year-${CMForDateTime.formatWithLeadingZeros(monthNumber)}-${CMForDateTime.formatWithLeadingZeros(day)}";

    return formattedDate;
  }

  bool isAfterAndBeforeDateCheckerMethod({required String currentDate, required String isAfterDate, required String isBeforeDate}) {
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

  Widget calendarGridView({required int pageViewIndex}) {
    controller.monthDatesList = controller.leaveDateCalenderList?[pageViewIndex].monthDates;

    var daysInMonth = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1, 0).day;

    var t = '1-${controller.currentMonth.value.month}-${controller.currentMonth.value.year}';

    DateTime parsedDate = DateFormat("d-M-yyyy").parse(t);

    var extra = parsedDate.weekday == 7 ? 0 : parsedDate.weekday;

    daysInMonth = daysInMonth + extra;

    controller.monthTotalDaysListDataAdd();

    for (var i = 0; i < extra; i++) {
      controller.monthTotalDaysList.insert(0, 0);
    }

    if (controller.monthDatesList != null && controller.monthDatesList!.isNotEmpty ) {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 10.px,
          mainAxisSpacing: 10.px,
        ),
        itemCount: daysInMonth,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, calendarIndex) {
          final day = controller.monthTotalDaysList[calendarIndex];
          if (day == 0) {
            return const SizedBox();
          } else {
            if (controller.getLeaveDateCalenderModal.value?.isBeforeDate != null &&
                controller.getLeaveDateCalenderModal.value!.isBeforeDate!.isNotEmpty &&
                controller.getLeaveDateCalenderModal.value?.isAfterDate != null &&
                controller.getLeaveDateCalenderModal.value!.isAfterDate!.isNotEmpty) {
              controller.isAfterAndBeforeCalenderDateValue.value = isAfterAndBeforeDateCheckerMethod(
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
                  if (!isAfterAndBeforeDateCheckerMethod(
                    currentDate: '${controller.currentMonth.value.year}-${CMForDateTime.formatWithLeadingZeros(controller.currentMonth.value.month)}-${CMForDateTime.formatWithLeadingZeros(day)}',
                    isAfterDate: '${controller.getLeaveDateCalenderModal.value?.isAfterDate}',
                    isBeforeDate: '${controller.getLeaveDateCalenderModal.value?.isBeforeDate}',
                  )) {
                    if (controller.monthDatesList?[calendarIndex - extra].holiday == false &&
                        controller.monthDatesList?[calendarIndex - extra].weekOff == false &&
                        controller.monthDatesList?[calendarIndex - extra].isLeave == false &&
                        controller.monthDatesList?[calendarIndex - extra].isPresent == false) {
                      if (controller.dateAddForLeaveList.contains('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}')) {
                        controller.removeLocalDataByDate(date: '$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}');
                        controller.formattedDateListForApi = controller.dateAddForLeaveList.map((dateString) => convertDateFormat(originalDateString: dateString)).toList();
                      }
                      else {
                        LocalData data = LocalData(
                          date: '$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}',
                          value: false,
                          firstAndSecondHalf: '',
                          fullAndHalfDay: '',
                          leaveType: '',
                          paidAndUnPaid: '',
                          leaveTypeId: '',
                        );
                        controller.addLocalData(data: data);
                        controller.formattedDateListForApi = controller.dateAddForLeaveList.map((dateString) => convertDateFormat(originalDateString: dateString)).toList();
                      }
                    } else if (controller.monthDatesList?[calendarIndex - extra].holiday == true) {
                      CM.showSnackBar(message: 'Holiday');
                    }
                    else if (controller.monthDatesList?[calendarIndex - extra].weekOff == true) {
                      CM.showSnackBar(message: 'WeekOff');
                    }
                    else if (controller.monthDatesList?[calendarIndex - extra].isLeave == true) {
                      CM.showSnackBar(message: 'Leave');
                    }
                    else if (controller.monthDatesList?[calendarIndex - extra].isPresent == true ||
                        (controller.monthDatesList?[calendarIndex - extra].isPresent == true &&
                            controller.monthDatesList?[calendarIndex - extra].holiday == true)) {
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
                color: controller.dateAddForLeaveList.contains('$day ${CMForDateTime.dateFormatForMonthYear(date: '${controller.currentMonth.value}')}')
                    ? Col.primary
                    : calendarGridColorView(calendarIndex: calendarIndex - extra),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.px)),
                child: SizedBox(
                  height: 30.px,
                  width: 30.px,
                  child: Center(
                    child: Text(
                      day != null
                          ? '$day'
                          : '',
                      style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.px,
                          color: controller.isAfterAndBeforeCalenderDateValue.value &&
                              controller.monthDatesList?[calendarIndex - extra].weekOff == false &&
                              controller.monthDatesList?[calendarIndex - extra].isLeave == false &&
                              controller.monthDatesList?[calendarIndex - extra].isPresent == false &&
                              controller.monthDatesList?[calendarIndex - extra].holiday == false
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
  }

  Color calendarGridColorView({required int calendarIndex}) {
    if (controller.monthDatesList?[calendarIndex].isPresent == true || (controller.monthDatesList?[calendarIndex].isPresent == true && controller.monthDatesList?[calendarIndex].holiday == true)) {
      return const Color(0xffF2FFF3);
    } else if (controller.monthDatesList?[calendarIndex].holiday ?? false) {
      return const Color(0xffDDE0FB);
    } else if (controller.monthDatesList?[calendarIndex].weekOff ?? false) {
      return const Color(0xffE6E6E6);
    } else if (controller.monthDatesList?[calendarIndex].isLeave ?? false) {
      return const Color(0xffE0F1FF);
    } else {
      return Colors.transparent;
    }
  }

  bool checkIfAllMonthsSame({required List<String> dates}) {
    if (dates.isEmpty) {
      return false;
    }
    int firstMonth = DateTime.parse(dates.first).month;
    for (int i = 1; i < dates.length; i++) {
      if (DateTime.parse(dates[i]).month != firstMonth) {
        return false;
      }
    }
    return true;
  }

  Widget leaveDateGridView() {
    return ListView.builder(
      shrinkWrap: true,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 4,
      //     crossAxisSpacing: 10.px,
      //     mainAxisSpacing: 10.px,
      //     childAspectRatio: 1.4),
      itemCount: controller.localData.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.px),
          decoration: BoxDecoration(
            color: Col.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(6.px),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CMForDateTime.formatDate(
                          controller.localData[index].date ?? ''),
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    addAndMinusButtonView(index: index),
                  ],
                ),
                if (controller.localData[index].value ?? false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              '${controller.localData[index].leaveType}',
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      fontSize: 10.px,
                                      fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6.px),
                          Text(
                            '(${controller.localData[index].paidAndUnPaid})',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontSize: 10.px,
                                    fontWeight: FontWeight.w500,
                                    color: controller.localData[index]
                                                .paidAndUnPaid ==
                                            'Paid'
                                        ? Col.success
                                        : Col.error),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.px),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${controller.localData[index].fullAndHalfDay}',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontSize: 10.px,
                                    fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 6.px),
                          if (controller.localData[index].firstAndSecondHalf !=
                                  null &&
                              controller.localData[index].firstAndSecondHalf!
                                  .isNotEmpty)
                            Text(
                              '(${controller.localData[index].firstAndSecondHalf})',
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      fontSize: 10.px,
                                      fontWeight: FontWeight.w500),
                            ),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addAndMinusButtonView({required int index}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.px),
      onTap: () async {
        if (controller.localData[index].value == true) {
            controller.removeLocalDataByDate(date: '${controller.localData[index].date}');
        } else {
          await controller.openBottomSheet(index: index);
        }
        controller.count.value++;
      },
      child: Center(
        child: controller.localData[index].value == true
            ? commonImageForAddAndMinus(path: 'assets/icons/outline_minus_icon.png')
            : commonImageForAddAndMinus(path: 'assets/icons/outline_add_icon.png'),
      ),
    );
  }

  Widget commonImageForAddAndMinus({required String path}) => CW.commonNetworkImageView(
        path: path,
        height: 20.px,
        width: 20.px,
        isAssetImage: true,
      );

  Widget applyBulkLeaveView() {
    String? v;

    for (var element in controller.localData) {
      if(element.leaveType != null && element.leaveType!.isNotEmpty) {
        v = element.leaveType;
      }
    }

    print('v::::: $v');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       controller.applyBulkLeaveButtonHideAndShowValue.value
           ? Container(
         width: 16.px,
         height: 16.px,
         decoration: BoxDecoration(
           border: Border.all(
             color: Col.gray,
             width: 1.px,
           ),
           borderRadius: BorderRadius.circular(4.px)
         ),
       )
           : SizedBox(
          height: 16.px,
          width: 16.px,
          child: CW.commonCheckBoxView(
            changeValue: controller.applyBulkLeaveValue.value,
            onChanged: (value) async {
              if(!controller.applyBulkLeaveValue.value){
                await controller.openBottomSheetForApplyBulkLeaves();
              }else{

              }
              controller.count.value++;
            },
          ),
        ),
        SizedBox(width: 10.px),
        Text(
          'Apply bulk leave',
          style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget reasonTextFormFiled() => CW.commonTextFieldForMultiline(
        labelText: 'Leave Reason',
        hintText: 'Leave Reason',
        controller: controller.reasonController,
        maxLines: 3,
        validator: (value) => V.isValid(value: value, title: 'Please enter leave reason'),
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
            padding: EdgeInsets.symmetric(vertical: 2.px),
            decoration: BoxDecoration(
                color: Col.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.px)),
            child: controller.result.value?.files != null &&
                    controller.result.value!.files.isNotEmpty
                ? fileImageAndNetworkImageView(
                    imagePath: controller.imageFile.value!.path,
                    isFileImage: true)
                : attachmentRowTextView(),
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

  Widget fileImageAndNetworkImageView({bool isFileImage = false, required String imagePath}) {
    return Center(
      child: Container(
        height: 100.px,
        width: 100.px,
        padding: EdgeInsets.all(6.px),
        decoration: BoxDecoration(
          color: Col.primary.withOpacity(.2),
          border: Border.all(color: Col.primary, width: .5.px),
          borderRadius: BorderRadius.circular(6.px),
        ),
        child: Center(
          child: isFileImage
              ? Image.file(
                  File(imagePath),
                  fit: BoxFit.contain,
                )
              : CW.commonNetworkImageView(
                  path: imagePath,
                  isAssetImage: false,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }

  Widget applyLeaveButtonView() {
    String? v;
    for (var element in controller.localData) {
        v = element.leaveType;
    }
    return Container(
      height: 80.px,
      padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
      color: Col.inverseSecondary,
      child: Center(
        child: CW.commonElevatedButton(
            onPressed: v != null && v.isNotEmpty
                ?  controller.applyLeaveButtonValue.value
                ? () => null
                : () => controller.clickOnApplyLeaveButton()
                : () => null,
            buttonColor: v != null && v.isNotEmpty
                ? Col.primary
                : Col.primary.withOpacity(.7),
            buttonText: 'Apply Leave',
            borderRadius: 10.px,
            isLoading: controller.applyLeaveButtonValue.value),
      ),
    );
  }
}

class LocalData {
  String? date;
  String? leaveType;
  String? firstAndSecondHalf;
  String? fullAndHalfDay;
  String? paidAndUnPaid;
  String? leaveTypeId;
  bool? value;

  LocalData({
    this.date,
    this.leaveType,
    this.leaveTypeId,
    this.firstAndSecondHalf,
    this.fullAndHalfDay,
    this.paidAndUnPaid,
    this.value,
  });

  LocalData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    leaveType = json['leaveType'];
    leaveTypeId = json['leaveTypeId'];
    firstAndSecondHalf = json['firstAndSecondHalf'];
    fullAndHalfDay = json['fullAndHalfDay'];
    paidAndUnPaid = json['paidAndUnPaid'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['leaveType'] = leaveType;
    data['leaveTypeId'] = leaveTypeId;
    data['firstAndSecondHalf'] = firstAndSecondHalf;
    data['fullAndHalfDay'] = fullAndHalfDay;
    data['paidAndUnPaid'] = paidAndUnPaid;
    data['value'] = value;
    return data;
  }
}

class LocalDataForLeaveType {
  String? leaveId;
  double? availablePaidAndUnPaidLeaveValue;

  LocalDataForLeaveType({
    this.leaveId,
    this.availablePaidAndUnPaidLeaveValue,
  });

  LocalDataForLeaveType.fromJson(Map<String, dynamic> json) {
    leaveId = json['leaveId'];
    availablePaidAndUnPaidLeaveValue = json['availablePaidAndUnPaidLeaveValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leaveId'] = leaveId;
    data['availablePaidAndUnPaidLeaveValue'] = availablePaidAndUnPaidLeaveValue;
    return data;
  }
}
