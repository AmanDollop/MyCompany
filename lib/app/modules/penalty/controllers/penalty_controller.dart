import 'package:get/get.dart';

class PenaltyController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;

  List paidAndUnPaid = [
    'Paid',
    'Unpaid',
    'Paid',
    'Unpaid',
    'Paid',
    'Unpaid',
    'Paid',
    'Unpaid',
    'Paid',
    'Unpaid',
  ];

  @override
  void onInit() {
    super.onInit();
    menuName.value = Get.arguments[0];
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
