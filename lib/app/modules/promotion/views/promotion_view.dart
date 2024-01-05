import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_packages/model_progress_bar/model_progress_bar.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/promotion_controller.dart';

class PromotionView extends GetView<PromotionController> {
  const PromotionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: 'Promotion',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.apiResValue.value,
          child: controller.experienceModal.value != null
              ? controller.getExperienceDetails != null &&
                      controller.getExperienceDetails!.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.getExperienceDetails?.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                      itemBuilder: (context, index) {
                        print(index);
                        return cardView(index: index);
                      },
                    )
                  : CW.commonNoDataFoundText()
              : CW.commonNoDataFoundText(text: controller.apiResValue.value ? '' : 'No Data Found!'),
        );
      }),
    );
  }

  Widget cardView({required int index}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 12.px,
                  height: 12.px,
                  // margin: EdgeInsets.only(top: 4.px),
                  decoration:
                      BoxDecoration(color: Col.primary, shape: BoxShape.circle),
                ),
                // if(index != 9)
                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  height: 80.px,
                  width: 2.5.px,
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ColoredBox(color: Col.primary),
                )
              ],
            ),
          ),
          // SizedBox(width: 6.px),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: companyNameTextView(text:controller.getExperienceDetails?[index].companyName != null
                          && controller.getExperienceDetails![index].companyName!.isNotEmpty
                          ? '${controller.getExperienceDetails?[index].companyName}'
                          : 'Company name not found!'),
                    ),
                    SizedBox(width: 6.px),
                    verifiedIconView()
                  ],
                ),
                designationTextView(text: controller.getExperienceDetails?[index].designation != null
                    && controller.getExperienceDetails![index].designation!.isNotEmpty
                    ? '${controller.getExperienceDetails?[index].designation}'
                    : 'Designation not found!'),
                locationTextView(text: controller.getExperienceDetails?[index].joiningDate != null
                    && controller.getExperienceDetails![index].joiningDate!.isNotEmpty
                    ? '${controller.getExperienceDetails?[index].joiningDate}'
                    : 'Join date not found!'),
                locationTextView(text:controller.getExperienceDetails?[index].companyLocation != null
                    && controller.getExperienceDetails![index].companyLocation!.isNotEmpty
                    ? '${controller.getExperienceDetails?[index].companyLocation}'
                    : 'Company location not found!'),
                SizedBox(height: 16.px),
              ],
            ),
          )
        ],
      );

  Widget companyNameTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );

  Widget verifiedIconView() => Icon(
    Icons.verified,
    color: Col.success,
    size: 14.px,
  );

  Widget designationTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.textGrayColor, fontWeight: FontWeight.w500),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );

  Widget locationTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 12.px),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );

}
