import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/experience_controller.dart';

class ExperienceView extends GetView<ExperienceController> {
  const ExperienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
            title: 'Experience',
            isLeading: true,
            onBackPressed: () => controller.clickOnBackButton()),
        body: Obx(() {
          controller.count.value;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                children: [
                  SizedBox(height: 8.px),
                  designationTextField(),
                  SizedBox(height: 20.px),
                  companyNameTextField(),
                  SizedBox(height: 20.px),
                  workFromTextField(),
                  SizedBox(height: 20.px),
                  workToTextField(),
                  SizedBox(height: 20.px),
                  locationTextField(),
                  SizedBox(height: 20.px),

                ],
              ),
              Container(
                height: 80.px,
                padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                color: Col.inverseSecondary,
                child: Center(
                  child: CW.commonElevatedButton(
                      onPressed: () => controller.clickOnSendChangeRequestButton(),
                      buttonText: 'Send Change Request',
                      isLoading: controller.sendChangeRequestButtonValue.value
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, Color? imageColor, bool isAssetImage = true}) => SizedBox(
    width: height ?? 24.px,
    height: width ?? 24.px,
    child: Center(
      child: CW.commonNetworkImageView(
          path: imagePath,
          isAssetImage: isAssetImage,
          color: imageColor,
          width: width ?? 24.px,
          height: height ?? 24.px),
    ),
  );

  Widget designationTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.designationController,
    labelText: 'Designation',
    hintText: 'Designation',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget companyNameTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.companyNameController,
    labelText: 'Company Name',
    hintText: 'Company Name',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget workFromTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.workFromController,
    labelText: 'Work From',
    hintText: 'Work From',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget workToTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.workToController,
    labelText: 'Work To',
    hintText: 'Work To',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

  Widget locationTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.locationController,
    labelText: 'Location',
    hintText: 'Location',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

}
