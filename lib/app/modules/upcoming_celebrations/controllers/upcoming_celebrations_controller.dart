import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/upcoming_celebration_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class UpcomingCelebrationsController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;
  final getUpcomingCelebrationModal = Rxn<UpcomingCelebrationModal>();
  List<Celebration> upcomingCelebrationList = [];
  Map<String, dynamic> bodyParamsForGetUpcomingCelebrationApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetUpcomingCelebrationApi();
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

  Future<void> callingGetUpcomingCelebrationApi() async {
    try{
      apiResValue.value=true;
      bodyParamsForGetUpcomingCelebrationApi={
        AK.action:ApiEndPointAction.getCelebration
      };
      getUpcomingCelebrationModal.value = await CAI.getUpcomingCelebrationApi(bodyParams: bodyParamsForGetUpcomingCelebrationApi);
      if(getUpcomingCelebrationModal.value != null){
        upcomingCelebrationList.addAll(getUpcomingCelebrationModal.value?.celebration ?? []);
        upcomingCelebrationList.addAll(getUpcomingCelebrationModal.value?.celebration ?? []);
        upcomingCelebrationList.addAll(getUpcomingCelebrationModal.value?.celebration ?? []);
      }
    }catch(e){
      apiResValue.value=false;
      CM.error();
      print('getUpcomingCelebrationApi::::: error::::  $e');
    }
    apiResValue.value=false;
  }

}
