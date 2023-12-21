import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class OtpVerificationController extends GetxController {

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
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

  void clickOnContinueButton() {
    CM.unFocusKeyBoard();
    Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
  }

  void clickOnResendButton() {}

}
