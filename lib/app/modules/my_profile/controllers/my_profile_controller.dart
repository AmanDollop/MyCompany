import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class MyProfileController extends GetxController {

  final count = 0.obs;

  final titleList = [
    'Take Order',
    'Sales Summery',
    'Leave Tracker',
    'Assets',
    'My Expense',
  ].obs;

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
    Get.toNamed(Routes.EDIT_PROFILE);
  }

}
