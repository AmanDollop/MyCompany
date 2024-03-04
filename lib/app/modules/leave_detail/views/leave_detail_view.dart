import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: 'Leave Detail',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
        actions: [
          CW.commonIconButton(
            onPressed: () => controller.clickOnEditButton(),
            isAssetImage: true,
            imagePath: 'assets/icons/edit_pen_icon.png',
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
                                    commonColumnView(
                                        text1: 'Leave Type',
                                        text2: '${controller.getLeaveDetailsList?.leaveTypeName} (${controller.getLeaveDetailsList?.isPaidView})'),
                                    if (controller.getLeaveDetailsList?.leaveDayTypeView != null && controller.getLeaveDetailsList!.leaveDayTypeView!.isNotEmpty)
                                      SizedBox(height: 6.px),
                                    if (controller.getLeaveDetailsList?.leaveDayTypeView != null && controller.getLeaveDetailsList!.leaveDayTypeView!.isNotEmpty)
                                      commonColumnView(
                                          text1: 'Leave Day Type',
                                          text2: '${controller.getLeaveDetailsList?.leaveDayTypeView}'),
                                    if (controller.getLeaveDetailsList?.leaveDayType != null && controller.getLeaveDetailsList!.leaveDayType!.isNotEmpty)
                                      SizedBox(height: 6.px),
                                    if (controller.getLeaveDetailsList?.leaveDayType != null && controller.getLeaveDetailsList!.leaveDayType!.isNotEmpty)
                                      commonColumnView(
                                          text1: 'Leave Status',
                                          text2: controller.getLeaveDetailsList?.isPaid == '0'
                                              ? 'Padding'
                                              : controller.getLeaveDetailsList?.isPaid == '1'
                                                  ? 'Approved'
                                                  : 'Rejected',
                                          color: controller.getLeaveDetailsList?.isPaid == '0'
                                              ? Col.yellow
                                              : controller.getLeaveDetailsList?.isPaid == '1'
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
                                    if (controller.getLeaveDetailsList?.leaveAttachment != null && controller.getLeaveDetailsList!.leaveAttachment!.isNotEmpty)
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
              ? CW.commonNetworkImageView(
                  path: text2,
                  isAssetImage: false,
                  height: 110,
                  width: 150,
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
                      style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: color),
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
