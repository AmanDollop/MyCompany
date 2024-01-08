import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/shift_details_modal.dart';

class ShiftDetailController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  final shiftDetailsModal = Rxn<ShiftDetailsModal>();
  ShiftDetails? shiftDetails;
  List<ShiftTime>? shiftTimeList;
  Map<String, dynamic> bodyParamsForShiftDetail={};


  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      accessType.value = Get.arguments[0];
      isChangeable.value = Get.arguments[1];
      profileMenuName.value = Get.arguments[2];
      await callingGetShiftDetailApi();
    }catch(e){
      apiResValue.value= false;
    }
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

  void clickOnBack() {
    Get.back();
  }

  Future<void> callingGetShiftDetailApi() async {

    bodyParamsForShiftDetail ={
      AK.action:'getShiftDetail'
    };

    shiftDetailsModal.value = await CAI.getShiftDetailApi(bodyParams:bodyParamsForShiftDetail);

    if(shiftDetailsModal.value!= null){

      shiftDetails = shiftDetailsModal.value?.shiftDetails;
      shiftTimeList = shiftDetails?.shiftTime;

    }else{
      apiResValue.value= false;
    }

  }

}
