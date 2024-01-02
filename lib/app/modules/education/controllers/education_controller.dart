import 'package:get/get.dart';

class EducationController extends GetxController {

  final count = 0.obs;


  final accessType = ''.obs;
  final isChangeable = ''.obs;

  @override
  void onInit() {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
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
}
