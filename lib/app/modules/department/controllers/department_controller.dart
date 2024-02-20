import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_department_employee_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class DepartmentController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  final userDataFromLocalDataBase =''.obs;
  UserDetails? userData;
  JobInfo? jobInfo;

  final getDepartmentEmployeeModal = Rxn<GetDepartmentEmployeeModal>();
  List<GetEmployee>? getDepartmentEmployeeList;
  Map<String, dynamic> bodyParamsForGetDepartmentEmployeeApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      await getUserDataFromLocalDataBase();
      await callingGetDepartmentEmployeeApi();
    }catch(e){
      apiResValue.value=false;
    }
    apiResValue.value=false;
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

  void clickOnBackButton(){
    Get.back();
  }

  void clickOnCards({required int myTeamCardIndex}) {}

  Future<void> getUserDataFromLocalDataBase() async {
    try {
      userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

      userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;
      jobInfo = userData?.jobInfo;
    } catch (e) {}
  }

  Future<void> callingGetDepartmentEmployeeApi() async {
    try{
      bodyParamsForGetDepartmentEmployeeApi={
        AK.action : ApiEndPointAction.getBranchDeptUser,
        AK.branchId : jobInfo?.branchId ?? '',
        AK.departmentId : jobInfo?.departmentId ?? ''
      };
      getDepartmentEmployeeModal.value = await CAI.getDepartmentEmployeeApi(bodyParams: bodyParamsForGetDepartmentEmployeeApi);
      if(getDepartmentEmployeeModal.value != null){
        getDepartmentEmployeeList = getDepartmentEmployeeModal.value?.getEmployee;
      }
    }catch(e){
      CM.error();
      print('GetDepartmentEmployeeApi::::: error::::  $e');
    }
  }

}
