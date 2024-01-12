import 'package:get/get.dart';

class CircularController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    menuName.value=Get.arguments[0];
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
