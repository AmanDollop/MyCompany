import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

import '../controllers/add_experience_controller.dart';

class AddExperienceView extends GetView<AddExperienceController> {
  const AddExperienceView({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
            title: controller.profileMenuName.value,
            isLeading: true,
            onBackPressed: () => controller.clickOnBackButton()),
        body: Obx(() {
          controller.count.value;
          return AC.isConnect.value
              ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Form(
                key: controller.key,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                  children: [
                    SizedBox(height: 8.px),
                    designationTextField(),
                    SizedBox(height: 20.px),
                    companyNameTextField(),
                    SizedBox(height: 20.px),
                    joiningDateTextField(),
                    SizedBox(height: 20.px),
                    releaseDateTextField(),
                    SizedBox(height: 20.px),
                    locationTextField(),
                    SizedBox(height: 20.px),
                    remarkTextField(),
                    SizedBox(height: 20.px),

                  ],
                ),
              ),
              Container(
                height: 80.px,
                padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                color: Col.inverseSecondary,
                child: Center(
                  child: CW.commonElevatedButton(
                      onPressed: () => controller.clickOnSaveButton(),
                      buttonText: controller.profileMenuName.value=='Add Experience'?'Add Experience':'UpDate Experience',
                      isLoading: controller.sendChangeRequestButtonValue.value
                  ),
                ),
              ),
            ],
          )
              : CW.commonNoNetworkView();
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
    validator: (value) => V.isValid(value: value, title: 'Please enter designation'),
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
    validator: (value) => V.isValid(value: value, title: 'Please enter company name'),
  );

  Widget joiningDateTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.joiningDateController,
    labelText: 'Joining Date',
    hintText: 'Joining Date',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    onTap: () => controller.clickOnJoiningDateTextField(),
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
    validator: (value) => V.isValid(value: value, title: 'Please enter joining date'),
  );

  Widget releaseDateTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.releaseDateController,
    labelText: 'Release Date',
    hintText: 'Release Date',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    onTap: () => controller.clickOnReleaseDateTextField(),
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
    validator: (value) => V.isValid(value: value, title: 'Please enter release date'),
  );

  Widget locationTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: controller.locationController,
    labelText: 'Company Location',
    hintText: 'Company Location',
    labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
    hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
    validator: (value) => V.isValid(value: value, title: 'Please enter company location'),
  );

  Widget remarkTextField() => CW.commonTextFieldForMultiline(
    fillColor: Colors.transparent,
    textInputAction: TextInputAction.newline,
    controller: controller.remarkController,
    labelText: 'Remark',
    hintText: 'Remark',
    keyboardType: TextInputType.multiline,
    prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/user_icon.png'),
    onChanged: (value) {
      controller.count.value++;
    },
  );

}
