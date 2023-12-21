import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';

import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CM.unFocusKeyBoard(),
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Otp Verification',
          onBackPressed: () => controller.clickOnBackButton(),
          isLeading: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 24.px),
                  logoView(),
                  SizedBox(height: 24.px),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.px),
                    child: CW.commonOtpView(
                      autoFocus: true,
                      shape: PinCodeFieldShape.box,
                      width: 60.px,
                    ),
                  ),
                  SizedBox(height: 12.px),
                  CW.commonTextButton(
                    onPressed: () => controller.clickOnResendButton(),
                    child: Text(
                      'Resend',
                      style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: Col.primary),
                    ),
                  ),
                ],
              ),
              CW.commonElevatedButton(
                  onPressed: () => controller.clickOnContinueButton(),
                  buttonText: 'Continue')
            ],
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
          child: Center(
            child: CW.commonNetworkImageView(
                isAssetImage: true,
                path: 'assets/images/logo.png',
                height: 44.px,
                width: 44.px),
          ),
        ),
      );
}
