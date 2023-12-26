import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/validator/v.dart';

import '../controllers/contact_detail_controller.dart';

class ContactDetailView extends GetView<ContactDetailController> {
  const ContactDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        appBar: appBarView(),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
          children: [
            contactTextField(),
            SizedBox(height: 20.px),
            emergencyTextField(),
            SizedBox(height: 20.px),
            companyEmailTextField(),
            SizedBox(height: 20.px),
            personalEmailTextField(),
            SizedBox(height: 20.px),
            currentAddressTextField(),
            SizedBox(height: 20.px),
            permanentAddressTextField(),
            SizedBox(height: 20.px),
          ],
        ),
      ),
    );
  }

  AppBar appBarView() => CW.commonAppBarView(
        title: 'Contact Detail',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
        actions: [
          CW.commonIconButton(
            onPressed: () => controller.clickOnEditButton(),
            isAssetImage: true,
            imagePath: 'assets/icons/w_edit_icon.png',
            width: 24.px,
            size: 24.px,
          ),
          SizedBox(width: 10.px),
        ],
      );

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, bool isAssetImage = true}) => SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: isAssetImage,
              width: width ?? 24.px,
              height: height ?? 24.px),
        ),
      );

  Widget contactTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.contactController,
        labelText: 'Contact',
        hintText: 'Contact',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget emergencyTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.emergencyController,
        labelText: 'Emergency',
        hintText: 'Emergency',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/emergency_phone_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget companyEmailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.companyEmailController,
        labelText: 'Company Email',
        hintText: 'Company Email',
        keyboardType: TextInputType.emailAddress,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/email_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget personalEmailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.personalEmailController,
        labelText: 'Personal Email',
        hintText: 'Personal Email',
        keyboardType: TextInputType.emailAddress,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/email_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget currentAddressTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.currentAddressController,
        labelText: 'Current Address',
        hintText: 'Current Address',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/current_location_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget permanentAddressTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.permanentAddressController,
        labelText: 'Permanent Address',
        hintText: 'Permanent Address',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/location_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

}
