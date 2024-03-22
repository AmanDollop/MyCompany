import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
            //   title: 'Welcome Developer',
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
                    logoView(),
                    SizedBox(height: 24.px),
                    emailTextField(),
                    SizedBox(height: 14.px),
                    Row(
                      children: [
                        CW.myCheckBoxView(onPressed: () {
                          controller.termsCheckBoxValue.value = !controller.termsCheckBoxValue.value;
                        }, checkBoxValue: controller.termsCheckBoxValue.value,),
                        // SizedBox(
                        //   width: 24.px,
                        //   height: 24.px,
                        //   child: CW.commonCheckBoxView(
                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
                        //     changeValue: controller.termsCheckBoxValue.value,
                        //     onChanged: (value) {
                        //       controller.termsCheckBoxValue.value = value ?? false;
                        //     },
                        //   ),
                        // ),
                        SizedBox(width: 5.px),
                        Flexible(
                          child: RichText(
                            text: commonTextSpanView(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.px),
                    CW.myElevatedButton(
                      onPressed: controller.loginButtonValue.value
                          ? () => null
                          : () => controller.clickOnContinueButton(),
                      buttonText: 'Continue',
                      isLoading: controller.loginButtonValue.value,
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
        ),
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

  Widget commonIconImage({required String imagePath, double? height, double? width, bool isAssetImage = true,Color? color}) => SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: isAssetImage,
              width: width ?? 24.px,
              height: height ?? 24.px,color: color),
        ),
      );

  Widget emailTextField() => CW.commonTextField(
        textCapitalization: TextCapitalization.none,
        controller: controller.emailController,
        labelText: 'Email Address',
        hintText: 'Email Address',
        keyboardType: TextInputType.emailAddress,
        prefixIconPath: 'assets/icons/email_icon.png',
        focusNode: controller.focusNodeForEmail,
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  TextSpan commonTextSpanView() => TextSpan(
        text: 'Accept all ',
        style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12.px,color: Col.inverseSecondary),
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
              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12.px,color: Col.inverseSecondary)),
          TextSpan(
              text: ' Privacy Policy',
              style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
                  color: Col.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.px)),
        ],
      );
}
