import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/experience_controller.dart';

class ExperienceView extends GetView<ExperienceController> {
  const ExperienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.apiResValue.value,
          isLoader: false,
          child: controller.apiResValue.value
              ? shimmerView()
              : controller.experienceModal.value != null
              ? controller.getExperienceDetails != null && controller.getExperienceDetails!.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.getExperienceDetails?.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                      itemBuilder: (context, index) {
                        return InkWell(
                            borderRadius: BorderRadius.circular(6.px),
                            onTap: () =>
                                controller.clickOnExperience(index: index),
                            child: cardView(index: index));
                      },
                    )
                  : CW.commonNoDataFoundText()
              : CW.commonNoDataFoundText(
              text: controller.apiResValue.value ? '' : 'No Data Found!'),
        );
      }),
      floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
          ? Padding(
              padding: EdgeInsets.only(bottom: 10.px),
              child: CW.commonOutlineButton(
                  onPressed: () => controller.clickOnAddViewButton(),
                  child: Icon(
                    Icons.add,
                    color: Col.inverseSecondary,
                    size: 22.px,
                  ),
                  height: 50.px,
                  width: 50.px,
                  backgroundColor: Col.primary,
                  borderColor: Colors.transparent,
                  borderRadius: 25.px),
            )
          : const SizedBox(),
    );
  }

  Widget cardView({required int index}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  width: 12.px,
                  height: 12.px,

                  // margin: EdgeInsets.only(top: 4.px),
                  decoration:
                      BoxDecoration(color: Col.primary, shape: BoxShape.circle),
                  child: Center(child: ColoredBox(color: Col.primary)),
                ),
                // if(index != controller.getExperienceDetails!.length-1)
                AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  height: 82.px,
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
                      child: companyNameTextView(
                          text: controller.getExperienceDetails?[index].companyName != null && controller.getExperienceDetails![index].companyName!.isNotEmpty
                              ? '${controller.getExperienceDetails?[index].companyName}'
                              : 'Company name not found!'),
                    ),
                    SizedBox(width: 6.px),
                    verifiedIconView()
                  ],
                ),
                designationTextView(
                    text: controller.getExperienceDetails?[index].designation != null &&
                            controller.getExperienceDetails![index].designation!.isNotEmpty
                        ? '${controller.getExperienceDetails?[index].designation}'
                        : 'Designation not found!'),
                locationTextView(
                    text: controller.getExperienceDetails?[index].joiningDate != null &&
                            controller.getExperienceDetails![index].joiningDate!.isNotEmpty
                        ? '${controller.getExperienceDetails?[index].joiningDate}'
                        : 'Join date not found!'),
                locationTextView(
                    text: controller.getExperienceDetails?[index].companyLocation != null &&
                            controller.getExperienceDetails![index].companyLocation!.isNotEmpty
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
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w600),
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
        style: Theme.of(Get.context!)
            .textTheme
            .titleMedium
            ?.copyWith(color: Col.textGrayColor, fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget locationTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleMedium
            ?.copyWith(fontSize: 12.px),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget shimmerView() => ListView.builder(itemBuilder:(context, index) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        children: [
          CW.commonShimmerViewForImage(
              width: 12.px,
              height: 12.px,
              radius: 6.px
          ),
          CW.commonShimmerViewForImage(
            width: 2.5.px,
            height: 88.px,
          ),
        ],
      ),
      SizedBox(width: 14.px),
      Column(
        children: [
          CW.commonShimmerViewForImage(
            width: 150.px,
            height: 24.px,
          ),
          SizedBox(height: 5.px),
          CW.commonShimmerViewForImage(
            width: 150.px,
            height: 20.px,
          ),
          SizedBox(height: 5.px),
          CW.commonShimmerViewForImage(
            width: 150.px,
            height: 16.px,
          ),
          SizedBox(height: 5.px),
          CW.commonShimmerViewForImage(
            width: 150.px,
            height: 16.px,
          ),
        ],
      ),
    ],
  ),itemCount: 5,padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),);
}
