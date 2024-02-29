import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class LeaveDetailController extends GetxController {

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

  void clickOnEditButton() {
    Get.toNamed(Routes.ADD_LEAVE,arguments: ['Update Leave']);
  }
}
