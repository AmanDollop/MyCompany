import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class PersonalInfoController extends GetxController {

  final count = 0.obs;

  final userPic = ''.obs;
  final userFirstName = ''.obs;
  final userLastName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final dob = ''.obs;
  final bloodGroup = ''.obs;
  final gender = ''.obs;
  final interestHobbies = ''.obs;
  final specialSkills = ''.obs;
  final languagesKnown = ''.obs;


  final apiResponseValue = true.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    await setDefaultData();
    apiResponseValue.value=false;
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

  Future<void> setDefaultData() async {

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userProfilePic, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userPic.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userProfilePic, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userFirstName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userFirstName.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userFirstName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userLastName, tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      userLastName.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userLastName, tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      email.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userEmail, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if (await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo) != 'null') {
      mobileNumber.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.userMobile, tableName: DataBaseConstant.tableNameForContactInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.memberDatePOfBirth,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      dob.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.memberDatePOfBirth,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.bloodGroup,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      bloodGroup.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.bloodGroup,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.gender,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      gender.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.gender,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.hobbiesAndInterest,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      interestHobbies.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.hobbiesAndInterest,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.skills,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      specialSkills.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.skills,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

    if(await DataBaseHelper().getParticularData(key: DataBaseConstant.languageKnown,tableName: DataBaseConstant.tableNameForPersonalInfo) != 'null') {
      languagesKnown.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.languageKnown,tableName: DataBaseConstant.tableNameForPersonalInfo);
    }

  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditViewButton() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }


}
