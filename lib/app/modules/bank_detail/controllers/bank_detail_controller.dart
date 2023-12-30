import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_widgets/cw.dart';

class BankDetailController extends GetxController
    with GetTickerProviderStateMixin {
  final count = 0.obs;

  final downAndUpValue = true.obs;
  final aNumber = '123456789999'.obs;

  late AnimationController rotationController;
  final rotationValue = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    rotationController = AnimationController(duration: const Duration(milliseconds: 30000), vsync: this);
    rotationController.forward(from: 0.0); // it starts the animation
    await Future.delayed(const Duration(seconds: 1));
    rotationController.stop();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnMenuButton() {
    CBS.commonBottomSheet(
      children: [
        Text('Choose Action',
            style: Theme.of(Get.context!).textTheme.displayLarge),
        SizedBox(height: 16.px),
        commonRowForBottomSheet(
          imagePath: 'assets/icons/edit_pen_icon.png',
          text: 'Edit',
          onTap: () {},
        ),
        Obx(() {
          count.value;
          return SizedBox(
            height: 35.px,
            child: InkWell(
              onTap: !rotationValue.value?() async {
                rotationValue.value = true;
                count.value++;
                rotationController.forward(
                    from: 0.0); // it starts the animation
                await Future.delayed(const Duration(seconds: 2));
                rotationController.stop();
                rotationValue.value = false;
              }:() => null,
              borderRadius: BorderRadius.circular(6.px),
              child: Row(
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 30.0)
                        .animate(rotationController),
                    child: CW.commonNetworkImageView(
                        path: 'assets/icons/sync_icon.png',
                        isAssetImage: true,
                        width: 20.px,
                        height: 20.px),
                  ),
                  SizedBox(width: 12.px),
                  Text(
                    'Set as Primary',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        }),
        commonRowForBottomSheet(
          imagePath: 'assets/icons/delete_icon.png',
          text: 'Remove',
          onTap: () {},
        ),
        SizedBox(height: 25.px),
      ],
    );
  }

  Widget commonRowForBottomSheet(
          {required String imagePath,
          required String text,
          required GestureTapCallback onTap}) =>
      SizedBox(
        height: 35.px,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.px),
          child: Row(
            children: [
              CW.commonNetworkImageView(
                  path: imagePath,
                  isAssetImage: true,
                  width: 20.px,
                  height: 20.px),
              SizedBox(width: 12.px),
              Text(text,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  void clickOnAddNewBankAccountButton() {
    Get.toNamed(Routes.ADD_BANK);
  }
}
