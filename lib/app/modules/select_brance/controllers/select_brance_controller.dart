import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class SelectBranceController extends GetxController {
  final count = 0.obs;

  final apiResponseValue = true.obs;

  final branchIndexValue = ''.obs;
  final branchId = ''.obs;
  String companyId = '';

  final branchModel = Rxn<BranchModal?>();
  List<BranchList>? branchList;

  @override
  Future<void> onInit() async {
    super.onInit();
    branchIndexValue.value = Get.arguments[0] ?? '';
    companyId = Get.arguments[1] ?? '';
    branchId.value = Get.arguments[2] ?? '';
    await callingBranchApi();
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

  clickOnBackButton() {
    Get.back(/*result: branchIndexValue.value.toString()*/);
  }

  void clickOnContinueButton() {
      Get.back(result: [branchIndexValue.value.toString(),branchId.value.toString()]);
  }

  Future<void> callingBranchApi() async {
    try{
      branchModel.value = await CAI.branchApi(bodyParams: {
        AK.companyId :companyId,
        AK.action :ApiEndPointAction.getBranches,
      });
      if (branchModel.value != null) {
        branchList = branchModel.value?.data ?? [];
      }
    }catch(e){
      apiResponseValue.value=false;
      CM.error();
    }
    apiResponseValue.value=false;
  }
}
