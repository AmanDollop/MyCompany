import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/experience_modal.dart';
import 'package:task/api/api_model/promotion_modal.dart';

class PromotionController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;
  final experienceModal = Rxn<ExperienceModal>();
  List<GetExperienceDetails>? getExperienceDetails;

  final promotionModal = Rxn<PromotionModal>();
  List<GetPromotionDetails>? getPromotionDetails;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingExperienceApi();
    await callingPromotionApi();
    apiResValue.value= false;
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


  Future<void> callingExperienceApi() async {
    try{
      experienceModal.value = await CAI.getExperienceApi(bodyParams: {AK.action:'getExperience'});
      if(experienceModal.value != null){
        getExperienceDetails = experienceModal.value?.getExperienceDetails;
        print('getExperienceDetails:::: $getExperienceDetails');
      }
    }catch(e){
      apiResValue.value= false;
      print('e::::: $e');
    }
  }

  Future<void> callingPromotionApi() async {
    try{
      promotionModal.value = await CAI.getPromotionApi(bodyParams: {AK.action:'getPromotion'});
      if(promotionModal.value != null){
        getPromotionDetails = promotionModal.value?.getPromotionDetails;
        print('getPromotionDetails:::: $getPromotionDetails');
      }
    }catch(e){
      apiResValue.value= false;
      print('e::::: $e');
    }
  }


}
