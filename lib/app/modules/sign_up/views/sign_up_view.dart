import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Registration',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return Form(
            key: controller.key,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [profileView(), cameraView()],
                    ),
                  ],
                ),
                SizedBox(height: 20.px),
                firstNameTextField(),
                SizedBox(height: 16.px),
                lastNameTextField(),
                SizedBox(height: 16.px),
                emailTextField(),
                SizedBox(height: 16.px),
                mobileNumberTextField(),
                SizedBox(height: 16.px),
                selectYourBranchTextField(),
                if(controller.selectYourBranchController.text.isNotEmpty)
                SizedBox(height: 16.px),
                if(controller.selectYourBranchController.text.isNotEmpty)
                selectYourDepartmentTextField(),
                SizedBox(height: 16.px),
                shiftTimeTextField(),
                SizedBox(height: 16.px),
                joiningDateTextField(),
                SizedBox(height: 16.px),
                designationTextField(),
                SizedBox(height: 16.px),
                textFiledLabelTextView(text: 'Gender'),
                SizedBox(height: 6.px),
                SizedBox(
                  height: 30.px,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CW.commonRadioView(
                              onChanged: (value) {
                                CM.unFocusKeyBoard();
                                controller.genderIndexValue.value = value;
                                controller.genderType.value =
                                    controller.genderText.value[index];
                                controller.count.value++;
                              },
                              index: index.toString(),
                              selectedIndex:
                                  controller.genderIndexValue.value.toString(),
                            ),
                            genderLabelTextView(
                                text: controller.genderText[index])
                          ],
                        );
                      },
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal),
                ),
                SizedBox(height: 25.px),
                CW.commonElevatedButton(
                    onPressed: () => controller.clickOnRegisterButton(),
                    buttonText: 'Register'),

              ],
            ),
          );
        }),
      ),
    );
  }

  Widget profileView() => Container(
        height: 120.px,
        width: 120.px,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.px),
        ),
        child: Center(
          child: Container(
            height: 100.px,
            width: 100.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.px),
              // border: Border.all(width: 1.px, color: Col.primary),
              image: DecorationImage(image: controller.selectImage(), fit: BoxFit.cover),
            ),
          ),
        ),
      );

  Widget cameraView() => InkWell(
        onTap: () => controller.clickOnProfileButton(),
        borderRadius: BorderRadius.circular(6.px),
        child: Container(
          width: 24.px,
          height: 24.px,
          decoration: BoxDecoration(
            color: Col.primary,
            borderRadius: BorderRadius.circular(6.px),
          ),
          child:
              Icon(Icons.camera_alt, color: Col.inverseSecondary, size: 16.px),
        ),
      );

  Widget textFiledLabelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleMedium,
      );

  Widget firstNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.firstNameController,
        labelText: 'First Name',
        hintText: 'First Name',
        keyboardType: TextInputType.name,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter first name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget lastNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.lastNameController,
        labelText: 'Last Name',
        hintText: 'Last Name',
        keyboardType: TextInputType.name,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter last name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget selectYourBranchTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.selectYourBranchController,
        labelText: 'Select Your Branch',
        hintText: 'Select Your Branch',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/department_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnSelectYourBranchTextField(),
        validator: (value) => V.isValid(value: value, title: 'Please select your branch'),
      );

  Widget selectYourDepartmentTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.selectYourDepartmentController,
        labelText: 'Select Your Department',
        hintText: 'Select Your Department',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon:
            commonIconImage(imagePath: 'assets/icons/department_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onTap: () => controller.clickOnSelectYourDepartmentTextField(),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please select your department'),
      );

  Widget shiftTimeTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.shiftTimeController,
        labelText: 'Shift Time',
        hintText: 'Shift Time',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/watch_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnShiftTimeTextField(),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter shift time'),
      );

  Widget joiningDateTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.joiningDateController,
        labelText: 'Joining Date',
        hintText: 'Joining Date',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon:
            commonIconImage(imagePath: 'assets/icons/calender_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnJoiningDateTextField(),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter joining date'),
      );

  Widget designationTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.designationController,
        labelText: 'Designation',
        hintText: 'Designation',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter designation'),
      );

  Widget emailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        labelText: 'Email Address',
        hintText: 'Email Address',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isEmailValid(value: value),
      );

  Widget mobileNumberTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.mobileNumberController,
        keyboardType: TextInputType.number,
        labelText: 'Mobile Number',
        hintText: 'Mobile Number',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        isCountrySelection: true,
        selectedCountryCode: '+91',
        clickOnArrowDown: () => controller.clickOnCountryCode(),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isNumberValid(
          value: value,
        ),
      );

  Widget commonIconImage({required String imagePath, double? height, double? width}) =>
      SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: true,
              width: width ?? 24.px,
              height: height ?? 24.px),
        ),
      );

  Widget genderLabelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w500),
      );

}
