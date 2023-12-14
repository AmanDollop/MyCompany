import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return Scaffold(
        body: Center(
          child: Container(
            height: 150.px,
            width: 150.px,
            decoration: BoxDecoration(
              color: Col.primary,
              shape: BoxShape.circle
            ),
            child: Center(
              child: CW.commonNetworkImageView(
                path: 'assets/images/logo.png',
                isAssetImage: true,
                height: 50.px,
                width: 50.px,
              ),
            ),
          ),
        ),
      );
    });
  }
}
