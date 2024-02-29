import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/leave_controller.dart';

class LeaveView extends GetView<LeaveController> {
  const LeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.addButtonExpandValue.value = false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
            title: controller.menuName.value,
            isLeading: true,
            onBackPressed: () => controller.clickOnBackButton()),
        body: Obx(() {
          controller.count.value;
          return ModalProgress(
            inAsyncCall: controller.apiResValue.value,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
              children: [
                Row(
                  children: [
                    Text(
                      'Leave Balance',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                              fontWeight: FontWeight.w600, color: Col.primary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 5.px),
                    Icon(Icons.arrow_right_alt_outlined, color: Col.primary)
                  ],
                ),
                CW.commonDividerView(
                    color: Col.primary,
                    wight: 1.5.px,
                    rightPadding: 60.w,
                    height: 0),
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
                        color: Col.inverseSecondary,
                        borderRadius: BorderRadius.circular(10.px),
                        boxShadow: [
                          BoxShadow(
                              color: Col.primary.withOpacity(.4), blurRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 12.px),
                          commonRowForCardView(
                              text1: 'Leave Type', text2: 'Medical Leave (Paid)'),
                          commonRowForCardView(
                              text1: 'Leave Day Type ', text2: ' Full Day'),
                          commonRowForCardView(
                              text1: 'Date',
                              text2: 'Feb 19,2024  - Feb 22, 2024'),
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
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      'Rejected',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                viewMoreTextButtonView(
                                    onPressedViewAllButton: () => controller
                                        .clickOnViewMoreButton(index: index))
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
            ),
          );
        }),
        floatingActionButton: addFloatingActionButtonView(),
      ),
    );
  }

  Widget commonRowForCardView({required String text1, required String text2}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.px),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text1,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 5.px),
          Text(':', style: Theme.of(Get.context!).textTheme.bodyLarge),
          SizedBox(width: 5.px),
          Expanded(
            flex: 5,
            child: Text(
              text2,
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
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
          style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(color: Col.primary, fontWeight: FontWeight.w700),
        ),
      );

  Widget addFloatingActionButtonView() => Obx(() {
        controller.count.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 10.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedCrossFade(
                  firstChild: CW.commonOutlineButton(
                      onPressed: () => controller.clickOnAddExpandButton(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 20.px,
                            width: 20.px,
                            margin: EdgeInsets.only(right: 6.px),
                            decoration: BoxDecoration(
                                color: Col.inverseSecondary,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: Col.primary,
                              size: 16.px,
                            ),
                          ),
                          Text(
                            'Apply Leave',
                            style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      height: 40.px,
                      backgroundColor: Col.primary,
                      borderColor: Colors.transparent,
                      borderRadius: 10.px,
                      padding: EdgeInsets.symmetric(horizontal: 12.px)),
                  secondChild: CW.commonOutlineButton(
                      onPressed: () => controller.clickOnAddButton(),
                      child: Icon(
                        controller.addButtonExpandValue.value
                            ? Icons.close
                            : Icons.add,
                        color: Col.inverseSecondary,
                        size: 22.px,
                      ),
                      height: 50.px,
                      width: 50.px,
                      backgroundColor: Col.primary,
                      borderColor: Colors.transparent,
                      borderRadius: 25.px),
                  crossFadeState: controller.addButtonExpandValue.value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(microseconds: 0),
                reverseDuration: const Duration(microseconds: 0),
              )
            ],
          ),
        );
      });

}
