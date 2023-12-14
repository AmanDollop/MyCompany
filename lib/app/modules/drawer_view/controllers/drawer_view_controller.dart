import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';

class DrawerViewController extends GetxController {
  final count = 0.obs;

  final iconList = [
    'assets/icons/home_icon.png',
    'assets/icons/activity_icon.png',
    'assets/icons/attendence_icon.png',
    'assets/icons/transaction_icon.png',
    'assets/icons/admin_icon.png',
    'assets/icons/setting_icon.png',
    'assets/icons/rate_icon.png',
    'assets/icons/share_icon.png',
    'assets/icons/logout_icon.png',
  ].obs;

  final titleList = [
    'Home',
    'My Activities',
    'Local Attendance',
    'My Transaction',
    'Admin View',
    'Settings',
    'Rate App',
    'Share App',
    'Log out',
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

  void clickOnUserProfileView() {
    Get.back();
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  Future<void> clickOnList({required int index}) async {
    if (index == 0) {
      Get.back();
    } else if (index == 1) {
      Get.back();
    } else if (index == 2) {
      Get.back();
    } else if (index == 3) {
      Get.back();
    } else if (index == 4) {
      Get.back();
    } else if (index == 5) {
      Get.back();
    } else if (index == 6) {
      Get.back();
    } else if (index == 7) {
      Get.back();
    } else {
      Get.back();
      await CD.commonIosLogoutDialog(
        clickOnCancel: () {
          Get.back();
        },
        clickOnLogout: () {
          Get.offAllNamed(Routes.LOGIN);
        },
      );

    }
  }

}
