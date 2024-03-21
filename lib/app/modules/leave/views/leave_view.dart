import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_packages/load_more/lm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_controller.dart';

class LeaveView extends GetView<LeaveController> {
  const LeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Obx(() {
          controller.count.value;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: AC.isConnect.value
                      ? CW.commonRefreshIndicator(
                          onRefresh: () => controller.onRefresh(),
                          child: ModalProgress(
                            inAsyncCall: controller.apiResValue.value,
                            child: controller.apiResValue.value
                                ? shimmerView()
                                : controller.getAllLeaveModal.value != null
                                    ? LM(
                                        noMoreWidget: const SizedBox(),
                                        isLastPage: controller.isLastPage.value,
                                        onLoadMore: () => controller.onLoadMore(),
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () => controller.clickOnLeaveBalance(),
                                                  borderRadius: BorderRadius.circular(2.px),
                                                  splashColor: Col.primary.withOpacity(.4),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Leave Balance',
                                                        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Col.primary),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(width: 5.px),
                                                      Icon(Icons.arrow_right_alt_outlined, color: Col.primary)
                                                    ],
                                                  ),
                                                ),
                                                CW.commonDividerView(
                                                    color: Col.primary,
                                                    wight: 1.5.px,
                                                    rightPadding: 60.w,
                                                    height: 0),
                                              ],
                                            ),
                                            SizedBox(height: 10.px),
                                            controller.getLeaveList.isNotEmpty
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: controller.getLeaveList.length,
                                                    padding: EdgeInsets.zero,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(bottom: 10.px),
                                                        decoration: BoxDecoration(
                                                          color: Col.gCardColor,
                                                          borderRadius: BorderRadius.circular(10.px),
                                                          // boxShadow: [
                                                          //   BoxShadow(color: Col.primary.withOpacity(.4), blurRadius: 1)
                                                          // ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(height: 12.px),
                                                            commonRowForCardView(text1: 'Leave Type', text2: '${controller.getLeaveList[index].leaveTypeName} (${controller.getLeaveList[index].isPaidView})'),
                                                            commonRowForCardView(
                                                                text1: 'Leave Day Type ',
                                                                text2: controller.getLeaveList[index].leaveDayTypeSessionView != null
                                                                    && controller.getLeaveList[index].leaveDayTypeSessionView!.isNotEmpty
                                                                    && controller.getLeaveList[index].leaveDayTypeSessionView != 'Full Day'
                                                                    ? '${controller.getLeaveList[index].leaveDayTypeView} (${controller.getLeaveList[index].leaveDayTypeSessionView})'
                                                                    : '${controller.getLeaveList[index].leaveDayTypeView}',
                                                            ),
                                                            if(controller.getLeaveList[index].leaveStartDate != null && controller.getLeaveList[index].leaveStartDate!.isNotEmpty)
                                                            commonRowForCardView(
                                                                text1: 'Date',
                                                                text2: CMForDateTime.dateFormatForDateMonthYear(date: '${controller.getLeaveList[index].leaveStartDate}')),
                                                            SizedBox(height: 12.px),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 12.px),
                                                              decoration: BoxDecoration(
                                                                color: Col.primary.withOpacity(.1),
                                                                borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius.circular(10.px),
                                                                  bottomRight: Radius.circular(10.px),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height: 8.px,
                                                                        width: 8.px,
                                                                        margin: EdgeInsets.only(right: 6.px),
                                                                        decoration: BoxDecoration(
                                                                            color: controller.getLeaveList[index].leaveStatus == '0'
                                                                                ? Col.yellow
                                                                                : controller.getLeaveList[index].leaveStatus == '1'
                                                                                    ? Col.success
                                                                                    : Col.error,
                                                                            shape: BoxShape.circle),
                                                                      ),
                                                                      Text(
                                                                        controller.getLeaveList[index].leaveStatus == '0'
                                                                            ? 'Padding'
                                                                            : controller.getLeaveList[index].leaveStatus == '1'
                                                                                ? 'Approved'
                                                                                : 'Rejected',
                                                                        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                                                                                fontWeight: FontWeight.w600,
                                                                                color: controller.getLeaveList[index].leaveStatus == '0'
                                                                                    ? Col.yellow
                                                                                    : controller.getLeaveList[index].leaveStatus == '1'
                                                                                        ? Col.success
                                                                                        : Col.error),
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  viewMoreTextButtonView(onPressedViewAllButton: () => controller.clickOnViewMoreButton(index: index))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : CW.commonNoDataFoundText(),
                                            // SizedBox(height: 8.h)
                                          ],
                                        ),
                                      )
                                    : CW.commonNoDataFoundText(),
                          ),
                        )
                      : CW.commonNoNetworkView(),
                ),
              ],
            ),
            floatingActionButton: addFloatingActionButtonView(),
          );
        }),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.menuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
    actionValue: true,
    action: SizedBox(
      width: 120.px,
      child: commonDropDownView(
        onTap: () => controller.clickOnYear(),
        dropDownView: yearDropDownView(),
      ),
    ),
  );

  Widget commonDropDownView({required Widget dropDownView, required GestureTapCallback onTap}) => Container(
        height: 40.px,
        margin: EdgeInsets.only(right: 12.px),
        decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(6.px)),
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

  Widget commonRowForCardView({required String text1, required String text2}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.px),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text1,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500,color: Col.gTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5.px),
          Text(':', style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),),
          SizedBox(width: 5.px),
          Expanded(
            flex: 5,
            child: Text(
              text2,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewMoreTextButtonView({required VoidCallback onPressedViewAllButton}) => CW.commonTextButton(
        onPressed: onPressedViewAllButton,
        child: Text(
          'View More',
          style: Theme.of(Get.context!)
              .textTheme
              .labelSmall
              ?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget addFloatingActionButtonView() => CW.commonFloatingActionButton(icon: Icons.add, onPressed: () => controller.clickOnAddButton());

  Widget shimmerView() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
        children: [
          Row(
            children: [
              CW.commonShimmerViewForImage(width: 100.px, height: 12.px, radius: 2.px),
              SizedBox(width: 5.px),
              CW.commonShimmerViewForImage(width: 20.px, height: 4.px, radius: 1.px)
            ],
          ),
          SizedBox(height: 4.px),
          Row(
            children: [
              CW.commonShimmerViewForImage(width: 135.px, height: 4.px, radius: 1.px),
            ],
          ),
          SizedBox(height: 10.px),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10.px),
                decoration: BoxDecoration(
                  color: Col.gCardColor,
                  borderRadius: BorderRadius.circular(10.px),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12.px),
                    commonRowForCardShimmer(),
                    SizedBox(height: 5.px),
                    commonRowForCardShimmer(),
                    SizedBox(height: 5.px),
                    commonRowForCardShimmer(),
                    SizedBox(height: 12.px),
                    Container(
                      padding: EdgeInsets.all(12.px),
                      decoration: BoxDecoration(
                        color: Col.primary.withOpacity(.1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.px),
                          bottomRight: Radius.circular(10.px),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CW.commonShimmerViewForImage(
                                  width: 8.px, height: 8.px, radius: 4.px),
                              SizedBox(width: 4.px),
                              CW.commonShimmerViewForImage(
                                  width: 100.px, height: 12.px, radius: 2.px),
                            ],
                          ),
                          CW.commonShimmerViewForImage(
                              width: 80.px, height: 12.px, radius: 2.px),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 8.h)
        ],
      );

  Widget commonRowForCardShimmer() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.px),
        child: Row(
          children: [
            CW.commonShimmerViewForImage(
                width: 100.px, height: 14.px, radius: 2.px),
            SizedBox(width: 15.px),
            CW.commonShimmerViewForImage(
                width: 4.px, height: 12.px, radius: 1.px),
            SizedBox(width: 15.px),
            CW.commonShimmerViewForImage(
                width: 100.px, height: 14.px, radius: 2.px),
          ],
        ),
      );
}
