import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/shift_time_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class SelectShiftTimeController extends GetxController {

  final count = 0.obs;

  final apiResponseValue = true.obs;

  final shiftTimeIndexValue = ''.obs;
  final shiftTimeId = ''.obs;

  String companyId = '';

  final shiftTimeModal = Rxn<ShiftTimeModal?>();
  List<ShiftTimeList>? shiftTimeList;

  @override
  Future<void> onInit() async {
    super.onInit();
    getArguments();

    await callingShiftTimeApi();
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

  void getArguments() {
    companyId = Get.arguments[0] ?? '';
    shiftTimeIndexValue.value = Get.arguments[1] ?? '';
    shiftTimeId.value = Get.arguments[2] ?? '';
  }

  clickOnBackButton() {
    Get.back(/*result: branchIndexValue.value.toString()*/);
  }

  void clickOnContinueButton() {
    Get.back(result: [shiftTimeIndexValue.value.toString(),shiftTimeId.value],);
  }

  Future<void> callingShiftTimeApi() async {
    try{
      shiftTimeModal.value = await CAI.shiftTimeApi(bodyParams: {
        AK.companyId :companyId,
        AK.action :ApiEndPointAction.getShifts,
      });
      if (shiftTimeModal.value != null) {
        shiftTimeList = shiftTimeModal.value?.data ?? [];
      }
    }catch(e){
      apiResponseValue.value=false;
      CM.error();
    }
    apiResponseValue.value=false;
  }

}
