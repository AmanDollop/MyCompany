import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        'ima:::::::::   ${AU.baseUrlForSearchCompanyImage}${controller.companyLogo}');
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Welcome Developer',
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
                logoView(),
                SizedBox(height: 24.px),
                emailTextField(),
                SizedBox(height: 14.px),
                Row(
                  children: [
                    SizedBox(
                      width: 24.px,
                      height: 24.px,
                      child: CW.commonCheckBoxView(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.px)),
                        changeValue: controller.termsCheckBoxValue.value,
                        onChanged: (value) {
                          controller.termsCheckBoxValue.value = value ?? false;
                        },
                      ),
                    ),
                    SizedBox(width: 5.px),
                    Flexible(
                      child: RichText(
                        text: commonTextSpanView(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.px),
                CW.commonElevatedButton(
                  onPressed: controller.loginButtonValue.value
                      ? () => null
                      : () => controller.clickOnContinueButton(),
                  buttonText: 'Continue',
                  isLoading: controller.loginButtonValue.value,
                  buttonColor: controller.emailController.text.isNotEmpty&&controller.termsCheckBoxValue.value ? Col.primary : Col.primary.withOpacity(.8)
                ),
                //  SizedBox(height: 40.px),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CW.commonOutlineButton(
                //       onPressed: () {},
                //       child: commonIconImage(
                //           imagePath: 'assets/icons/google_icon.png',
                //           width: 20.px,
                //           height: 20.px),
                //     ),
                //     SizedBox(width: 20.px),
                //     CW.commonOutlineButton(
                //       onPressed: () {},
                //       child: commonIconImage(
                //           imagePath: 'assets/icons/facebook_icon.png',
                //           width: 20.px,
                //           height: 20.px),
                //     ),
                //     SizedBox(width: 20.px),
                //     CW.commonOutlineButton(
                //       onPressed: () {},
                //       child: commonIconImage(
                //           imagePath: 'assets/icons/apple_icon.png',
                //           width: 20.px,
                //           height: 20.px),
                //     ),
                //   ],
                // ),
                SizedBox(height: 10.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New here? ',
                      style: Theme.of(Get.context!).textTheme.labelMedium,
                    ),
                    CW.commonTextButton(
                      onPressed: () => controller.clickOnCreateAccountButton(),
                      child: Text(
                        'Create Account',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                                color: Col.primary,
                                fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget logoView() => Center(
        child: Container(
          height: 70.px,
          width: 70.px,
          decoration: BoxDecoration(
            color: Col.primary,
            borderRadius: BorderRadius.circular(8.px),
          ),
          child: commonIconImage(
              imagePath: controller.companyLogo.isNotEmpty
                  ? '${AU.baseUrlForSearchCompanyImage}${controller.companyLogo}'
                  : 'assets/images/logo.png',
              height: controller.companyLogo.isNotEmpty ? 66.px : 44.px,
              width: controller.companyLogo.isNotEmpty ? 66.px : 44.px,
              isAssetImage: controller.companyLogo.isNotEmpty ? false : true),
        ),
      );

  Widget commonIconImage({required String imagePath, double? height, double? width, bool isAssetImage = true}) =>
      SizedBox(
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

  Widget emailTextField() => CW.commonTextField(
        textCapitalization: TextCapitalization.none,
        fillColor: Colors.transparent,
        controller: controller.emailController,
        labelText: 'Email Address',
        hintText: 'Email Address',
        keyboardType: TextInputType.emailAddress,
        labelStyle: Theme.of(Get.context!).textTheme.titleMedium,
        hintStyle: Theme.of(Get.context!).textTheme.titleMedium,
        // style: Theme.of(Get.context!).textTheme.bodyLarge,
        prefixIcon: commonIconImage(imagePath: 'assets/icons/email_icon.png'),
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  TextSpan commonTextSpanView() => TextSpan(
        text: 'Accept all ',
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: 12.px),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                color: Col.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12.px),
          ),
          TextSpan(
              text: ' and',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 12.px)),
          TextSpan(
              text: ' Privacy Policy',
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: Col.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.px)),
        ],
      );
}
