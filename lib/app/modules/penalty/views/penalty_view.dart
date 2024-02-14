import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/penalty_controller.dart';

class PenaltyView extends GetView<PenaltyController> {
  const PenaltyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
        title: controller.menuName.value,
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      ),
      body: Obx(
        () {
          controller.count.value;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
            itemCount: controller.paidAndUnPaid.length,
            itemBuilder: (context, index) {
              return Card(
                color: Col.inverseSecondary,
                margin: EdgeInsets.only(bottom: 10.px, left: 0.px, right: 0.px, top: 0.px),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.px),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dateTextView(index: index),
                          paidAndUnPaidTextView(index: index),
                        ],
                      ),
                      SizedBox(height: 5.px),
                      penaltyDetailTextView(index: index),
                      SizedBox(height: 5.px),
                      penaltyAmountTextView(index: index),
                      SizedBox(height: 5.px),
                      SizedBox(
                        height: 50.px,
                        child: penaltyImageListViewBuilder(index: index),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget dateTextView({required int index}) => Text(
        'Date : 19/01/2024',
        style: Theme.of(Get.context!)
            .textTheme
            .labelMedium
            ?.copyWith(fontSize: 10.px),
      );

  Widget paidAndUnPaidTextView({required int index}) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
        decoration: BoxDecoration(
            color: controller.paidAndUnPaid[index] == 'Paid'
                ? Col.success.withOpacity(.1)
                : Col.error.withOpacity(.1),
            borderRadius: BorderRadius.circular(4.px)),
        child: Text(
          controller.paidAndUnPaid[index],
          style: Theme.of(Get.context!).textTheme.labelMedium?.copyWith(
              color: controller.paidAndUnPaid[index] == 'Paid'
                  ? Col.success
                  : Col.error,
              fontSize: 10.px,fontWeight: FontWeight.w500),
        ),
      );

  Widget penaltyDetailTextView({required int index}) => Text(
        'Lorem ipsum dolor sit amet Lorem ipsum dolor sit ametLorem ipsum dolor sit amet',
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
      );

  Widget penaltyAmountTextView({required int index}) => Text(
        'Amount - ₹200',
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      );

  Widget penaltyImageListViewBuilder({required int index}) => ListView.builder(
        itemCount: 13,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => Padding(
          padding: EdgeInsets.only(right: 8.px),
          child: CW.commonNetworkImageView(
            path: 'assets/images/profile.png',
            isAssetImage: true,
            height: 50.px,
            width: 50.px,
          ),
        ),
      );

}
