import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/experience_modal.dart';
import 'package:task/app/routes/app_pages.dart';

class ExperienceController extends GetxController {

  final apiResValue = true.obs;
  final experienceModal = Rxn<ExperienceModal>();
  List<GetExperienceDetails>? getExperienceDetails;

  final count = 0.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    apiResValue.value = true;
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
    await callingExperienceApi();
    apiResValue.value = false;
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

  Future<void> clickOnExperience({required int index}) async {
    await Get.toNamed(Routes.ADD_EXPERIENCE,arguments: ['UpDate Experience',getExperienceDetails?[index]]);
    onInit();
  }

  Future<void> callingExperienceApi() async {
    try {
      experienceModal.value =
      await CAI.getExperienceApi(bodyParams: {AK.action: ApiEndPointAction.getExperience});
      if (experienceModal.value != null) {
        getExperienceDetails = experienceModal.value?.getExperienceDetails;
        print('getExperienceDetails:::: $getExperienceDetails');

      }
    } catch (e) {
      apiResValue.value = false;
      print('e::::: $e');
    }
  }

  Future<void> clickOnAddViewButton() async {
    await Get.toNamed(Routes.ADD_EXPERIENCE,arguments: ['Add Experience']);
    onInit();
  }

}
