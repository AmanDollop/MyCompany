import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

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
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      profileView(),
                      cameraView()
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.px),
              textFiledLabelTextView(text: 'First Name'),
              SizedBox(height: 6.px),
              firstNameTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Last Name'),
              SizedBox(height: 6.px),
              lastNameTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Select Your Branch'),
              SizedBox(height: 6.px),
              selectYourBranchTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Select Your Department'),
              SizedBox(height: 6.px),
              selectYourDepartmentTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Shift Time'),
              SizedBox(height: 6.px),
              shiftTimeTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Joining Date'),
              SizedBox(height: 6.px),
              joiningDateTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Designation'),
              SizedBox(height: 6.px),
              designationTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Email ID'),
              SizedBox(height: 6.px),
              emailTextField(),
              SizedBox(height: 10.px),
              textFiledLabelTextView(text: 'Mobile Number'),
              SizedBox(height: 6.px),
              mobileNumberTextField(),
              SizedBox(height: 10.px),
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
                              controller.count.value++;
                            },
                            index: index.toString(),
                            selectedIndex: controller.genderIndexValue.value.toString(),
                          ),

                          genderLabelTextView(text: controller.genderText[index])
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
          );
        }),
      ),
    );
  }

  Widget textFiledLabelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleMedium,
      );

  Widget firstNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.firstNameController,
        // labelText: '',
        hintText: 'First Name',
        keyboardType: TextInputType.name,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget lastNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.lastNameController,
        // labelText: '',
        hintText: 'Last Name',
        keyboardType: TextInputType.name,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/user_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget selectYourBranchTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.selectYourBranchController,
        // labelText: 'Select your department',
        hintText: 'Select Your Branch',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon:
            commonIconImage(imagePath: 'assets/icons/department_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnSelectYourBranchTextField(),
      );

  Widget selectYourDepartmentTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.selectYourDepartmentController,
        // labelText: 'Select your department',
        hintText: 'Select your department',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon:
            commonIconImage(imagePath: 'assets/icons/department_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget shiftTimeTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.shiftTimeController,
        // labelText: 'Shift Time',
        hintText: 'Shift Time',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/watch_icon.png'),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
        onChanged: (value) {
      controller.count.value++;
    },
        onTap: () => controller.clickOnShiftTimeTextField(),
  );

  Widget joiningDateTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.joiningDateController,
        // labelText: 'Joining Date',
        hintText: 'Joining Date',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/calender_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnJoiningDateTextField(),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.gray),
      );

  Widget designationTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.designationController,
        // labelText: 'Designation',
        hintText: 'Designation',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget emailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        // labelText: 'Email Address',
        hintText: 'Email Address',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget mobileNumberTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.mobileNumberController,
        keyboardType: TextInputType.number,
        // labelText: 'Mobile Number',
        hintText: 'Mobile Number',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget commonIconImage({
    required String imagePath,
    double? height,
    double? width,
  }) =>
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

  Widget profileView() => SizedBox(
    height: 120.px,
    width: 120.px,
    child: commonIconImage(
        height: 100.px,
        width: 100.px,
        imagePath: 'assets/images/profile.png'),
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
      child: Icon(Icons.camera_alt,
          color: Col.inverseSecondary, size: 16.px),
    ),
  );
}
