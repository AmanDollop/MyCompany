import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class MyProfileController extends GetxController {

  final count = 0.obs;

  final userPic = ''.obs;
  final firstName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final countryCode = ''.obs;
  final developerType = ''.obs;

  final titleList = [
    'Take Order',
    'Sales Summery',
    'Leave Tracker',
    'Assets',
    'My Expense',
  ].obs;

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

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditButton() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  void clickOnReportingPerson({required int reportingPersonIndex}) {
    Get.toNamed(Routes.CONTACT_DETAIL);
  }

  Future<void> setDefaultData() async {
    if(await DataBaseHelper().getParticularData(key: 'user_first_name',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      firstName.value = await DataBaseHelper().getParticularData(key: 'user_first_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }
    if(await DataBaseHelper().getParticularData(key: 'user_last_name',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      lastName.value = await DataBaseHelper().getParticularData(key: 'user_last_name',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_profile_pic',tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userPic.value = await DataBaseHelper().getParticularData(key: 'user_profile_pic',tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_email',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      email.value = await DataBaseHelper().getParticularData(key: 'user_email',tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'user_mobile',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: 'user_mobile',tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: 'country_code',tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      countryCode.value = await DataBaseHelper().getParticularData(key: 'country_code',tableName: DataBaseConstant.tableNameForContactInfo);
    }

  }

}
