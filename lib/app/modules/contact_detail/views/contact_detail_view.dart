import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/contact_detail_controller.dart';

class ContactDetailView extends GetView<ContactDetailController> {
  const ContactDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return WillPopScope(
        onWillPop: () => controller.clickOnBackButton(),
        child: GestureDetector(
          onTap: () {
            CM.unFocusKeyBoard();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton:controller.valueForEditFiled.value
                ? const SizedBox()
                :Padding(
              padding:  EdgeInsets.only(bottom: 10.px),
              child: CW.commonOutlineButton(onPressed: () => controller.clickOnEditViewButton(),child: Icon(Icons.edit,color: Col.inverseSecondary,size: 22.px,),height: 50.px,width: 50.px,backgroundColor: Col.primary,borderColor: Colors.transparent,borderRadius: 25.px),
            ),
            appBar: appBarView(),
            body: Obx(() {
              controller.count.value;
              if (controller.apiResponseValue.value) {
                return Center(
                  child: CW.commonProgressBarView(color: Col.primary),
                );
              }
              else {
                return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
                      children: [
                        AnimatedCrossFade(
                          crossFadeState: controller.valueForEditFiled.value
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 500),
                          firstChild: ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
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
                          secondChild: ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: [
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/contact_phone_icon.png',
                                  title: 'Contact',
                                  subTitle: controller.countryCode.value.isNotEmpty||controller.mobileNumber.value.isNotEmpty
                                      ?'${controller.countryCode} ${controller.mobileNumber}':'No Data Available!'),
                              SizedBox(height: 5.px),
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/contact_phone_icon.png',
                                  title: 'Emergency',
                                  subTitle:  controller.countryCode.value.isNotEmpty||controller.mobileNumber.value.isNotEmpty
                                      ?'${controller.countryCode} ${controller.mobileNumber}':'No Data Available!'),
                              SizedBox(height: 5.px),
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/email_icon.png',
                                  title: 'Company Email',
                                  subTitle: controller.companyEmailController.text.isNotEmpty
                                      ?controller.companyEmailController.text:'No Data Available!'),
                              SizedBox(height: 5.px),
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/email_icon.png',
                                  title: 'Personal Email',
                                  subTitle: controller.personalEmailController.text.isNotEmpty
                                      ?controller.personalEmailController.text:'No Data Available!'),
                              SizedBox(height: 5.px),
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/current_location_icon.png',
                                  title: 'Current Address',
                                  subTitle: controller.currentAddressController.text.isNotEmpty
                                      ?controller.currentAddressController.text:'No Data Available!'),
                              SizedBox(height: 5.px),
                              commonRowForContactDetailView(
                                  imagePath: 'assets/icons/location_icon.png',
                                  title: 'Permanent Address',
                                  subTitle: controller.permanentAddressController.text.isNotEmpty
                                      ?controller.permanentAddressController.text:'No Data Available!'),
                              SizedBox(height: 5.px),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(controller.valueForEditFiled.value)
                  Container(
                    color: Col.inverseSecondary,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.px,right: 12.px, bottom: 24.px,top: 12.px),
                      child: CW.commonElevatedButton(
                          onPressed: () =>  controller.clickOnEditUpdateButton(),
                          buttonText: 'Save'),
                    ),
                  )
                ],
              );
              }
            }),
          ),
        ),
      );
    });
  }

  AppBar appBarView() => CW.commonAppBarView(
        title: controller.valueForEditFiled.value
            ? 'Update Contact Detail'
            : 'Contact Detail',
        isLeading: true,
        onBackPressed: () => controller.clickOnBackButton(),
      );

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

  Widget contactTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.contactController,
        labelText: 'Contact',
        hintText: 'Contact',
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/contact_phone_icon.png'),
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
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/emergency_phone_icon.png'),
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
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/email_icon.png'),
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
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/email_icon.png'),
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
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/current_location_icon.png'),
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
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/location_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget commonRowForContactDetailView({required String imagePath, required String title, required String subTitle,}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonIconImageForTextField(
                imagePath: imagePath, imageColor: Col.darkGray),
            SizedBox(width: 10.px),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonTitleTextView(
                    title: title,
                    textAlign: TextAlign.start,
                    color: Col.darkGray,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 6.px),
                if (subTitle.isNotEmpty)
                  commonTitleTextView(title: subTitle, textAlign: TextAlign.end, maxLines: 3),
              ],
            ),
          ],
        ),
        if (subTitle.isNotEmpty) SizedBox(height: 4.px),
        CW.commonDividerView(leftPadding: 20.px),
        SizedBox(height: 10.px),
      ],
    );
  }

  Widget commonTitleTextView({required String title, TextAlign? textAlign, int? maxLines, Color? color, FontWeight? fontWeight}) =>
      Text(
        title,
        style: Theme.of(Get.context!)
            .textTheme
            .displayLarge
            ?.copyWith(fontSize: 14.px, color: color, fontWeight: fontWeight),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
      );
}
