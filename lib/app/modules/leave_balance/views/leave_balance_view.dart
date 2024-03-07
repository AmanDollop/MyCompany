import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_balance_controller.dart';

class LeaveBalanceView extends GetView<LeaveBalanceController> {
  const LeaveBalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Leave Balance',
          onBackPressed: () => controller.clickOnBackButton(),
          isLeading: true,
          actions: [
            SizedBox(
              width: 120.px,
              child: commonDropDownView(
                onTap: () => controller.clickOnYear(),
                dropDownView: yearDropDownView(),
              ),
            ),
          ],
      ),
      body: Obx(() {
        if (AC.isConnect.value) {
          return CW.commonRefreshIndicator(
            onRefresh: () => controller.onRefresh(),
            child: ModalProgress(
              inAsyncCall: controller.apiResValue.value,
              child: controller.apiResValue.value
                  ? shimmerView()
                  : controller.getLeaveTypeBalanceCountModal.value != null
                      ? ListView(
                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                          children: [
                            if (controller.getLeaveTypeBalanceCountModal.value?.isTotalLeave != null && controller.getLeaveTypeBalanceCountModal.value!.isTotalLeave!.isNotEmpty ||
                                controller.getLeaveTypeBalanceCountModal.value?.isUsedLeave != null && controller.getLeaveTypeBalanceCountModal.value!.isUsedLeave!.isNotEmpty)
                              Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      totalLeaveCircularProgressBarView(),
                                      totalLeaveCircularProgressBarTextView()
                                    ],
                                  ),
                                  SizedBox(height: 16.px),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      commonRowForTotalAndUsedLeaveTextView(
                                          text: 'Total Leave',
                                          containerColor: Col.primary),
                                      commonRowForTotalAndUsedLeaveTextView(
                                          text: 'Used Leave',
                                          containerColor:
                                              Col.primary.withOpacity(.2)),
                                    ],
                                  ),
                                  SizedBox(height: 16.px),
                                ],
                              ),
                                controller.leaveBalanceCountList != null && controller.leaveBalanceCountList!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: controller.leaveBalanceCountList?.length,
                                    itemBuilder: (context, index) {
                                      return commonCardView(index: index);
                                    },
                                  )
                                : CW.commonNoDataFoundText(),
                          ],
                        )
                      : CW.commonNoDataFoundText(),
            ),
          );
        } else {
          return CW.commonNoNetworkView();
        }
      }),
    );
  }

  Widget commonDropDownView({required Widget dropDownView, required GestureTapCallback onTap}) => Container(
        height: 40.px,
        margin: EdgeInsets.only(right: 12.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(6.px),
        ),
        child: InkWell(
          onTap: onTap,
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

  Widget yearDropDownView() => Text(
        controller.yearForMonthViewValue.value,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      );

  Widget totalLeaveCircularProgressBarView() => SizedBox(
        height: 130.px,
        width: 130.px,
        child: CW.commonProgressBarView(
            value: 0,
            backgroundColor: Col.primary.withOpacity(.2),
            color: Col.primary,
            strokeWidth: 8.px),
      );

  Widget totalLeaveCircularProgressBarTextView() => Container(
        height: 120.px,
        width: 120.px,
        decoration: BoxDecoration(
          color: Col.inverseSecondary,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '00',
              style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
            ),
            Text(
              'Leave summary',
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(color: Col.primary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  Widget commonRowForTotalAndUsedLeaveTextView({required String text, required Color containerColor}) => Row(
        children: [
          Container(
            height: 10.px,
            width: 10.px,
            decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 8.px),
          Text(
            text,
            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );

  Widget commonCardView({required int index}) => Container(
        margin: EdgeInsets.only(bottom: 12.px),
        decoration: BoxDecoration(
          color: Col.inverseSecondary,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.px),
            bottomLeft: Radius.circular(10.px),
          ),
          boxShadow: [
            BoxShadow(
              color: Col.primary.withOpacity(.1),
              // blurRadius: 1,
              spreadRadius: 2,
              blurRadius: 4,
              // offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36.px,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.px),
              decoration: BoxDecoration(
                color: Col.primary.withOpacity(.15),
              ),
              child: Text(
                controller.leaveBalanceCountList?[index].leaveTypeName != null && controller.leaveBalanceCountList![index].leaveTypeName!.isNotEmpty
                    ? '${controller.leaveBalanceCountList?[index].leaveTypeName}'
                    : '?',
                style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonColumnViewForCard(
                      text1: controller.leaveBalanceCountList?[index].totalUsedLeave != null && controller.leaveBalanceCountList![index].totalUsedLeave!.isNotEmpty
                          ? '${controller.leaveBalanceCountList?[index].totalUsedLeave}'
                          : '00',
                      text2: 'Used Leave'),
                  commonColumnViewForCard(
                      text1: controller.leaveBalanceCountList?[index].totalLeave != null && controller.leaveBalanceCountList![index].totalLeave!.isNotEmpty
                          ? '${controller.leaveBalanceCountList?[index].totalLeave}'
                          : '00',
                      text2: 'Total Leave'),
                  commonColumnViewForCard(
                      text1: controller.leaveBalanceCountList?[index].totalRemainingLeave != null && controller.leaveBalanceCountList![index].totalRemainingLeave!.isNotEmpty
                          ? '${controller.leaveBalanceCountList?[index].totalRemainingLeave}'
                          : '00',
                      text2: 'Total Remaining'),
                  commonColumnViewForCard(
                      text1: controller.leaveBalanceCountList?[index].remainingLeaveMonth != null && controller.leaveBalanceCountList![index].remainingLeaveMonth!.isNotEmpty
                          ? '${controller.leaveBalanceCountList?[index].remainingLeaveMonth}'
                          : '00',
                      text2: 'Month Remaining'),
                ],
              ),
            )
          ],
        ),
      );

  Widget commonColumnViewForCard({required String text1, required String text2}) => Column(
        children: [
          Text(
            text1,
            style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5.px),
          Text(
            text2,
            style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 10.px),
          ),
        ],
      );

  Widget shimmerView() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: CW.commonShimmerViewForImage(
                height: 130.px, width: 130.px, radius: 65.px),
          ),
          SizedBox(height: 16.px),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              commonRowForTotalAndUsedLeaveShimmerView(),
              commonRowForTotalAndUsedLeaveShimmerView(),
            ],
          ),
          SizedBox(height: 16.px),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 12.px),
                decoration: BoxDecoration(
                  color: Col.inverseSecondary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.px),
                    bottomLeft: Radius.circular(10.px),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Col.primary.withOpacity(.1),
                      // blurRadius: 1,
                      spreadRadius: 2,
                      blurRadius: 4,
                      // offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36.px,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.px),
                      decoration: BoxDecoration(
                        color: Col.primary.withOpacity(.15),
                      ),
                      child: CW.commonShimmerViewForImage(height: 12.px, width: 130.px, radius: 2.px),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.px),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonColumnViewForCardShimmer(),
                          commonColumnViewForCardShimmer(),
                          commonColumnViewForCardShimmer(),
                          commonColumnViewForCardShimmer(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );

  Widget commonRowForTotalAndUsedLeaveShimmerView() => Row(
        children: [
          CW.commonShimmerViewForImage(height: 14.px, width: 14.px, radius: 7.px),
          SizedBox(width: 6.px),
          CW.commonShimmerViewForImage(height: 10.px, width: 100.px, radius: 2.px),
        ],
      );

  Widget commonColumnViewForCardShimmer() => Column(
        children: [
          CW.commonShimmerViewForImage(
              height: 20.px, width: 20.px, radius: 2.px),
          SizedBox(height: 5.px),
          CW.commonShimmerViewForImage(
              height: 8.px, width: 60.px, radius: 2.px),
        ],
      );
}
