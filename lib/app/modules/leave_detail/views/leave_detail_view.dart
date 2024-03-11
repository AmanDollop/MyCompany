import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_detail_controller.dart';

class LeaveDetailView extends GetView<LeaveDetailController> {
  const LeaveDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Leave Detail',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
          actions: [
            if (controller.getLeaveDetailModal.value?.isEdit ?? false)
              CW.commonIconButton(
                onPressed: () => controller.clickOnEditButton(),
                isAssetImage: true,
                imagePath: 'assets/icons/edit_pen_icon.png',
                color: Col.inverseSecondary, //assets/icons/delete_icon.png
              ),
            if (controller.getLeaveDetailModal.value?.isDelete ?? false)
              CW.commonIconButton(
                onPressed: () => controller.clickOnDeleteButton(),
                isAssetImage: true,
                imagePath: 'assets/icons/delete_icon.png',
                color: Col.inverseSecondary,
              ),
            SizedBox(width: 5.px)
          ],
        ),
        body: Obx(() {
          controller.count.value;
          return AC.isConnect.value
              ? CW.commonRefreshIndicator(
                  onRefresh: () => controller.onRefresh(),
                  child: ModalProgress(
                    inAsyncCall: controller.apiResValue.value,
                    child: controller.apiResValue.value
                        ? shimmerView()
                        : controller.getLeaveDetailModal.value != null
                            ? controller.getLeaveDetailsList != null
                                ? ListView(
                                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                    children: [
                                      commonColumnView(text1: 'Leave Type', text2: '${controller.getLeaveDetailsList?.leaveTypeName} (${controller.getLeaveDetailsList?.isPaidView})'),
                                      if (controller.getLeaveDetailsList?.leaveDayTypeView != null &&
                                          controller.getLeaveDetailsList!.leaveDayTypeView!.isNotEmpty)
                                        SizedBox(height: 6.px),
                                      if (controller.getLeaveDetailsList?.leaveDayTypeView != null && controller.getLeaveDetailsList!.leaveDayTypeView!.isNotEmpty)
                                        commonColumnView(
                                          text1: 'Leave Day Type',
                                          text2: controller.getLeaveDetailsList?.leaveDayTypeSession != 'Full Day' &&
                                                  controller.getLeaveDetailsList?.leaveDayTypeSession != null &&
                                                  controller.getLeaveDetailsList!.leaveDayTypeSession!.isNotEmpty
                                              ? '${controller.getLeaveDetailsList?.leaveDayTypeView} (${controller.getLeaveDetailsList?.leaveDayTypeSession})'
                                              : '${controller.getLeaveDetailsList?.leaveDayTypeView}',
                                        ),
                                      if (controller.getLeaveDetailsList?.leaveStatus != null && controller.getLeaveDetailsList!.leaveStatus!.isNotEmpty)
                                        SizedBox(height: 6.px),
                                      if (controller.getLeaveDetailsList?.leaveStatus != null &&
                                          controller.getLeaveDetailsList!.leaveStatus!.isNotEmpty)
                                        commonColumnView(
                                            text1: 'Leave Status',
                                            text2: controller.getLeaveDetailsList?.leaveStatus == '0'
                                                ? 'Padding'
                                                : controller.getLeaveDetailsList?.leaveStatus == '1'
                                                    ? 'Approved'
                                                    : 'Rejected',
                                            color: controller.getLeaveDetailsList?.leaveStatus == '0'
                                                ? Col.yellow
                                                : controller.getLeaveDetailsList?.leaveStatus == '1'
                                                    ? Col.success
                                                    : Col.error,
                                            containerValue: true),
                                      if (controller.getLeaveDetailsList?.leaveStartDate != null && controller.getLeaveDetailsList!.leaveStartDate!.isNotEmpty)
                                        SizedBox(height: 6.px),
                                      if (controller.getLeaveDetailsList?.leaveStartDate != null && controller.getLeaveDetailsList!.leaveStartDate!.isNotEmpty)
                                        commonColumnView(
                                            text1: 'Date',
                                            text2: CMForDateTime.dateFormatForDateMonthYear(date: '${controller.getLeaveDetailsList?.leaveStartDate}')),
                                      SizedBox(height: 6.px),
                                      commonColumnView(
                                          text1: 'Approved by',
                                          text2: '${controller.getLeaveDetailsList?.leaveAddedByType}'),
                                      if (controller.getLeaveDetailsList?.leaveReason != null && controller.getLeaveDetailsList!.leaveReason!.isNotEmpty)
                                        SizedBox(height: 6.px),
                                      if (controller.getLeaveDetailsList?.leaveReason != null && controller.getLeaveDetailsList!.leaveReason!.isNotEmpty)
                                        commonColumnView(
                                            text1: 'Reason',
                                            text2: '${controller.getLeaveDetailsList?.leaveReason}'),
                                      if (controller.getLeaveDetailsList?.leaveAttachment != null && controller.getLeaveDetailsList!.leaveAttachment!.isNotEmpty)
                                        SizedBox(height: 6.px),
                                      if (controller.getLeaveDetailsList?.leaveAttachment != null &&
                                          controller.getLeaveDetailsList!.leaveAttachment!.isNotEmpty)
                                        commonColumnView(
                                            text1: 'Attachment',
                                            text2: '${AU.baseUrlAllApisImage}${controller.getLeaveDetailsList?.leaveAttachment}',
                                            attachmentValue: true),
                                      SizedBox(height: 6.px),
                                    ],
                                  )
                                : CW.commonNoDataFoundText()
                            : CW.commonNoDataFoundText(),
                  ),
                )
              : CW.commonNoNetworkView();
        }),
      );
    });
  }

  Widget commonColumnView({required String text1, required String text2, bool attachmentValue = false, bool containerValue = false, Color? color}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.px),
          attachmentValue
              ? Container(
                  padding: EdgeInsets.all(4.px),
                  decoration: BoxDecoration(
                      border: Border.all(width: .5.px, color: Col.primary),
                      borderRadius: BorderRadius.circular(4.px),
                      color: Col.primary.withOpacity(.1)),
                  child: CW.commonNetworkImageView(
                      path: text2,
                      isAssetImage: false,
                      height: 110,
                      width: 150,
                      fit: BoxFit.contain),
                )
              : Row(
                  children: [
                    if (containerValue)
                      Container(
                        height: 8.px,
                        width: 8.px,
                        decoration:
                            BoxDecoration(color: color, shape: BoxShape.circle),
                      ),
                    if (containerValue) SizedBox(width: 6.px),
                    Text(
                      text2,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600, color: color),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
          // SizedBox(height: 2.px),
          CW.commonDividerView()
        ],
      );

  Widget shimmerView() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        children: [
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(),
          SizedBox(height: 10.px),
          commonColumnViewForShimmer(attachmentValue: true),
          SizedBox(height: 10.px),
        ],
      );

  Widget commonColumnViewForShimmer({bool attachmentValue = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CW.commonShimmerViewForImage(width: 60.px, height: 10.px, radius: 2.px),
          SizedBox(height: 6.px),
          attachmentValue
              ? CW.commonShimmerViewForImage(width: 150.px, height: 110.px, radius: 8.px)
              : CW.commonShimmerViewForImage(width: 120.px, height: 10.px, radius: 2.px),
          SizedBox(height: 4.px),
          CW.commonShimmerViewForImage(height: 2.px, radius: 0.px),
        ],
      );
}


/*
                  MarkdownToolbar(
                    // If you set useIncludedTextField to true, remove
                    // a) the controller and focusNode fields below and
                    // b) the TextField outside below widget
                    useIncludedTextField: false,
                    controller: controller.textEditingController,
                    focusNode: controller.focusNode,
                    // Uncomment some of the options below to observe the changes. This list is not exhaustive

                    collapsable: true,
                    alignCollapseButtonEnd: true,
                    backgroundColor: Colors.lightBlue,
                    dropdownTextColor: Colors.red,
                    iconColor: Colors.white,
                    iconSize: 30,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    width: 70,
                    height: 50,
                    spacing: 16.0,
                    runSpacing: 12.0,
                    alignment: WrapAlignment.start,
                    hideCheckbox: true,
                    hideQuote: true,
                    hideBulletedList: true,
                    hideNumberedList: true,
                    hideStrikethrough: true,
                    hideHorizontalRule: true,
                    // italicCharacter: '_',
                    // bulletedListCharacter: '*',
                    // horizontalRuleCharacter: '***',
                    // hideImage: true,
                    // hideCode: true,
                    linkTooltip: 'Add a link',
                  ),
                  const Divider(),
                  TextField(
                    controller: controller.textEditingController,
                    focusNode: controller.focusNode,
                    minLines: 5,
                    maxLines: null,
                    onChanged: (value) {
                      controller.count.value++;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Placeholder text',
                      labelText: 'Label text',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  )*/