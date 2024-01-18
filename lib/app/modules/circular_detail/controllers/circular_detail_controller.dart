import 'package:get/get.dart';
import 'package:task/api/api_model/circular_detail_modal.dart';

class CircularDetailController extends GetxController {

  final count = 0.obs;
  Circular? circularList;

  @override
  void onInit() {
    super.onInit();
    circularList=Get.arguments[0];
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
