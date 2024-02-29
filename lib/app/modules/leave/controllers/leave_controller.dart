import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class LeaveController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;
  final apiResValue = true.obs;

  @override
  void onInit() {
    super.onInit();
    apiResValue.value = true;
    menuName.value = Get.arguments[0];
    Future.delayed(const Duration(seconds: 1),() => apiResValue.value = false,);
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

  void clickOnBackButton(){
    Get.back();
  }

  void clickOnViewMoreButton({required int index}) {
    Get.toNamed(Routes.LEAVE_DETAIL);
  }

  void clickOnAddButton() {
    Get.toNamed(Routes.ADD_LEAVE,arguments: ['Add Leave']);
  }

}
