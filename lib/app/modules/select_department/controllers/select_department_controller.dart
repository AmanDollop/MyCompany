import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/department_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class SelectDepartmentController extends GetxController {

  final count = 0.obs;

  final apiResponseValue = true.obs;

  final departmentIndexValue = ''.obs;
  final departmentId = ''.obs;
  final branchId = ''.obs;
  String companyId = '';

  final departmentModal = Rxn<DepartmentModal?>();
  List<DepartmentList>? departmentList;

  @override
  Future<void> onInit() async {
    super.onInit();

    getArgumentsMethod();
    await callingDepartmentApi();

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

  void getArgumentsMethod() {
    companyId = Get.arguments[0] ?? '';
    branchId.value= Get.arguments[1] ?? '';
    departmentIndexValue.value = Get.arguments[2] ?? '';
    departmentId.value= Get.arguments[3] ?? '';
  }

  clickOnBackButton() {
    Get.back(/*result: departmentIndexValue.value.toString()*/);
  }

  void clickOnContinueButton() {

      Get.back(result: [departmentIndexValue.value.toString(),departmentId.value.toString()]);

  }

  Future<void> callingDepartmentApi() async {
    try{
      departmentModal.value = await CAI.departmentApi(bodyParams: {
        AK.companyId :companyId,
        AK.action :ApiEndPointAction.getDepartments,
        AK.branchId :branchId.value.toString(),
      });
      if (departmentModal.value != null) {
        departmentList = departmentModal.value?.data ?? [];
      }
    }catch(e){
      apiResponseValue.value=false;
      CM.error();
    }
    apiResponseValue.value=false;
  }


}
