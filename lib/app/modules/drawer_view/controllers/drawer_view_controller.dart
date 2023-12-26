import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

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

  final userPic = ''.obs;
  final firstName = ''.obs;
  final lastName = ''.obs;
  final companyName = ''.obs;
  final developerType = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await setDefaultData();
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
    Get.toNamed(Routes.MY_PROFILE);
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
        clickOnLogout: () async {
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForUserToken);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForPersonalInfo);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForContactInfo);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForJobInfo);
          await DataBaseHelper().deleteDataBase(tableName: DataBaseConstant.tableNameForSocialInfo);
          await CM.setString(key: AK.baseUrl, value: '');
          Get.offAllNamed(Routes.SEARCH_COMPANY);
        },
      );

    }
  }

  Future<void> setDefaultData() async {

    firstName.value = await DataBaseHelper().getParticularData(key: 'user_first_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    lastName.value = await DataBaseHelper().getParticularData(key: 'user_last_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    userPic.value = await DataBaseHelper().getParticularData(key: 'user_profile_pic',tableName: DataBaseConstant.tableNameForPersonalInfo);
    companyName.value = await DataBaseHelper().getParticularData(key: 'user_email',tableName: DataBaseConstant.tableNameForContactInfo);
    developerType.value = await DataBaseHelper().getParticularData(key: 'user_designation',tableName: DataBaseConstant.tableNameForJobInfo);

  }

}
