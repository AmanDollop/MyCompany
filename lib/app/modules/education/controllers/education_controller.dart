import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/education_modal.dart';
import 'package:task/app/routes/app_pages.dart';

class EducationController extends GetxController {
  final count = 0.obs;

  final apiResponseValue = true.obs;

  final tabBarValue = 'Education'.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  final educationOrAchievementsModal = Rxn<EducationDetailsModal>();
  List<GetEducationDetails> getEducationList = [];
  List<GetEducationDetails> getAchievementsList = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    apiResponseValue.value = true;
    try{
      accessType.value = Get.arguments[0];
      isChangeable.value = Get.arguments[1];
      profileMenuName.value = Get.arguments[2];
      await callingGetEducationOrAchievementsApi();
    }catch(e){
      apiResponseValue.value=false;
    }
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

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEducationTab() {
    tabBarValue.value = 'Education';
  }

  void clickOnAchievementsTab() {
    tabBarValue.value = 'Achievement';
  }

  Future<void> callingGetEducationOrAchievementsApi() async {
    getAchievementsList.clear();
    getEducationList.clear();
    educationOrAchievementsModal.value = await CAI.getEducationOrAchievementsApi(bodyParams: {AK.action: 'getEducationDetails'});
    if(educationOrAchievementsModal.value != null){
      educationOrAchievementsModal.value?.getEducationDetails?.forEach((element) {
        if(element.type == '1'){
          getAchievementsList.add(element);
        }else{
          getEducationList.add(element);
        }
      });

    }
  }

  Future<void> clickOnAddViewButton() async {
    await Get.toNamed(Routes.ADD_EDUCATION,arguments: ['Add ${tabBarValue.value}',tabBarValue.value]);
   onInit();
  }

  Future<void> clickOnEducationData({required int index}) async {
    await Get.toNamed(Routes.ADD_EDUCATION,arguments: ['UpDate ${tabBarValue.value}',getEducationList[index]]);
    onInit();
  }

  Future<void> clickOnAchievementsData({required int index}) async {
    await Get.toNamed(Routes.ADD_EDUCATION,arguments: ['UpDate ${tabBarValue.value}',getAchievementsList[index]]);
    onInit();
  }

}
