import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class SocialInfoController extends GetxController {

  final count = 0.obs;

  List title  = [
    'Twitter',
    'Facebook',
    'Instagram',
    'Linkedin',
  ];

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
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

  void clickOnEditViewButton() {
    Get.toNamed(Routes.ADD_SOCIAL_INFO);
  }
}
