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
    return CW.commonScaffoldBackgroundColor(
      child: GestureDetector(
        onTap: () {
          CM.unFocusKeyBoard();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: CW.commonAppBarView(
            //   title: 'Registration',
            //   isLeading: true,
            //   onBackPressed: () => controller.clickOnBackButton(),
            // ),
            body: Obx(() {
              controller.count.value;
              return Form(
                key: controller.key,
                child: ListView(
                  padding: EdgeInsets.all(12.px),
                  children: [
                    CW.myAppBarView(title: 'Welcome Developer',onLeadingPressed: () => controller.clickOnBackButton(),),
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
                                    controller.genderType.value = controller.genderText.value[index];
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
                    CW.myElevatedButton(onPressed:controller.registerButtonValue.value
                        ? () => null
                        :() => controller.clickOnRegisterButton(),
                        buttonText: 'Register',isLoading: controller.registerButtonValue.value),
                  ],
                ),
              );
            }),
          ),
        ),
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

  Widget firstNameTextField() {
    return CW.commonTextField(
      focusNode: controller.focusNodeForFirstName,
      controller: controller.firstNameController,
      labelText: 'First Name',
      hintText: 'First Name',
      keyboardType: TextInputType.name,
      prefixIconPath: 'assets/icons/user_icon.png',
      validator: (value) => V.isValid(value: value, title: 'Please enter first name'),
      onChanged: (value) {
        controller.count.value++;
      },
    );
  }

  Widget lastNameTextField() => CW.commonTextField(
        controller: controller.lastNameController,
        focusNode: controller.focusNodeForLastName,
        labelText: 'Last Name',
        hintText: 'Last Name',
        keyboardType: TextInputType.name,
        prefixIconPath: 'assets/icons/user_icon.png',
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter last name'),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget selectYourBranchTextField() => CW.commonTextField(
        controller: controller.selectYourBranchController,
        focusNode: controller.focusNodeForSelectYourBranch,
        labelText: 'Select Your Branch',
        hintText: 'Select Your Branch',
        prefixIconPath: 'assets/icons/department_icon.png',
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 26.px, color: Col.inverseSecondary),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnSelectYourBranchTextField(),
        validator: (value) => V.isValid(value: value, title: 'Please select your branch'),
      );

  Widget selectYourDepartmentTextField() => CW.commonTextField(
        controller: controller.selectYourDepartmentController,
    focusNode: controller.focusNodeForSelectYourDepartment,
        labelText: 'Select Your Department',
        hintText: 'Select Your Department',
        prefixIconPath: 'assets/icons/department_icon.png',
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 26.px, color: Col.inverseSecondary),
        onTap: () => controller.clickOnSelectYourDepartmentTextField(),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please select your department'),
      );

  Widget shiftTimeTextField() => CW.commonTextField(
        controller: controller.shiftTimeController,
        focusNode: controller.focusNodeForShiftTime,
        labelText: 'Shift Time',
        hintText: 'Shift Time',
        prefixIconPath: 'assets/icons/watch_icon.png',
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 26.px, color: Col.inverseSecondary),
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnShiftTimeTextField(),
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter shift time'),
      );

  Widget joiningDateTextField() => CW.commonTextField(
        controller: controller.joiningDateController,
        focusNode: controller.focusNodeForJoiningDate,
        labelText: 'Joining Date',
        hintText: 'Joining Date',
        prefixIconPath: 'assets/icons/calender_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        onTap: () => controller.clickOnJoiningDateTextField(),
        readOnly: true,
        suffixIcon: Icon(Icons.arrow_right, size: 30.px, color: Col.inverseSecondary),
        validator: (value) => V.isValid(value: value, title: 'Please enter joining date'),
      );

  Widget designationTextField() => CW.commonTextField(
        controller: controller.designationController,
        focusNode: controller.focusNodeForDesignation,
        labelText: 'Designation',
        hintText: 'Designation',
        prefixIconPath: 'assets/icons/email_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter designation'),
      );

  Widget emailTextField() => CW.commonTextField(
        controller: controller.emailController,
        focusNode: controller.focusNodeForEmail,
        keyboardType: TextInputType.emailAddress,
        labelText: 'Email Address',
        hintText: 'Email Address',
        prefixIconPath: 'assets/icons/email_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
    textCapitalization: TextCapitalization.none,
        validator: (value) => V.isEmailValid(value: value),
      );

  Widget mobileNumberTextField() => CW.commonTextField(
        controller: controller.mobileNumberController,
       focusNode: controller.focusNodeForMobileNumber,
        keyboardType: TextInputType.number,
        labelText: 'Mobile Number',
        hintText: 'Mobile Number',
        prefixIcon: commonIconImage(imagePath: 'assets/icons/contact_phone_icon.png'),
        isCountrySelection: true,
        selectedCountryCode: controller.countryCode,
        countryFlagPath: controller.countryImagePath.value,
        maxLength: 10,
        clickOnArrowDown: () => controller.clickOnCountryCode(),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isNumberValid(value: value,countyCode: controller.countryCode,countryCodeValue: true),
      );

  Widget commonIconImage({required String imagePath, double? height, double? width}) => SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: true,
              width: width ?? 24.px,
              height: height ?? 24.px,color: Col.inverseSecondary),
        ),
      );

  Widget genderLabelTextView({required String text}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
      );

}
