import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/branch_modal.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/department_modal.dart';
import 'package:task/api/api_model/get_department_employee_modal.dart';
import 'package:task/api/api_model/user_data_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class DepartmentController extends GetxController {

  final count = 0.obs;

  late OverlayEntry overlayEntry;

  final apiResValue = true.obs;
  final apiResValueForDepartment = true.obs;

  final isDropDownOpenValue = false.obs;

  final userDataFromLocalDataBase =''.obs;
  UserDetails? userData;
  JobInfo? jobInfo;
  final companyDetailFromLocalDataBase = ''.obs;

  GetCompanyDetails? getCompanyDetails;
  final getDepartmentEmployeeModal = Rxn<GetDepartmentEmployeeModal>();
  List<GetEmployee>? getDepartmentEmployeeList;

  Map<String, dynamic> bodyParamsForGetDepartmentEmployeeApi = {};

  final branchModel = Rxn<BranchModal?>();
  List<BranchList>? branchList;
  List<String> branchNameList = [];
  final branchData = Rxn<BranchList>();
  final selectedBranchValue = ''.obs;
  final branchId = ''.obs;
  final selectBranchController = TextEditingController();

  final departmentModal = Rxn<DepartmentModal?>();
  List<DepartmentList>? departmentList;
  final List<String> departmentNameList = [];
  final departmentId = ''.obs;
  final selectedDepartments = ''.obs;
  final selectedDepartmentsValue = false.obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    try{
      await getUserDataFromLocalDataBase();
      await callingBranchApi();
    }catch(e){
      apiResValue.value = false;
    }
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

  void clickOnBackButton(){
    Get.back();
  }

  void clickOnCards({required int myTeamCardIndex}) {}

  Future<void> getUserDataFromLocalDataBase() async {
    try {
      userDataFromLocalDataBase.value = await DataBaseHelper().getParticularData(key:DataBaseConstant.userDetail,tableName: DataBaseConstant.tableNameForUserDetail);

      userData = UserDataModal.fromJson(jsonDecode(userDataFromLocalDataBase.value)).userDetails;
      jobInfo = userData?.jobInfo;

      companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail,tableName: DataBaseConstant.tableNameForCompanyDetail);
      getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;

    } catch (e) {}
  }

  Future<void> callingBranchApi() async {
    try{
      branchList?.clear();
      selectBranchController.text = jobInfo?.branchName ?? '';
      branchId.value = jobInfo?.branchId ?? '';
      branchModel.value = await CAI.branchApi(bodyParams: {
        AK.companyId : getCompanyDetails?.companyId ?? '',
        AK.action : ApiEndPointAction.getBranches,
      });
      if (branchModel.value != null) {
        branchList = branchModel.value?.data ?? [];
        branchList?.forEach((element) {
          branchNameList.add(element.branchName ?? '');
          if(jobInfo?.branchId == element.branchId){
           selectBranchController.text = element.branchName ?? '';
           selectedBranchValue.value = element.branchName ?? '';
           branchId.value = element.branchId ?? '';
           branchNameList.remove(element.branchName);
           branchNameList.insert(0, selectBranchController.text);
           branchList?.remove(element);
           branchList?.insert(0, element);

          }
        });
        await callingDepartmentApi(bId: branchId.value);
      }
    }catch(e){
      apiResValue.value=false;
      CM.error();
    }
  }

  Future<void> callingDepartmentApi({required String bId,String? companyId}) async {
    try{
      apiResValueForDepartment.value = true;
      departmentList?.clear();
      departmentNameList.clear();
      departmentModal.value = await CAI.departmentApi(bodyParams: {
        AK.companyId : getCompanyDetails?.companyId ?? companyId,
        AK.action : ApiEndPointAction.getDepartments,
        AK.branchId : bId,
      });
      if (departmentModal.value != null) {
        departmentList = departmentModal.value?.data ?? [];
        departmentList?.forEach((element) {
          departmentNameList.add(element.departmentName ?? '');
          if(jobInfo?.departmentId == element.departmentId){
            departmentId.value = element.departmentId ?? '';
            selectedDepartments.value = element.departmentName ?? '';
          }
        });
        await callingGetDepartmentEmployeeApi(bId: bId,dId: departmentId.value);
      }
    }catch(e){
      apiResValue.value=false;
      apiResValueForDepartment.value=false;
      CM.error();
    }
    apiResValueForDepartment.value=false;
  }

  Future<void> callingGetDepartmentEmployeeApi({String? bId,String? dId}) async {
    try{
      bodyParamsForGetDepartmentEmployeeApi={
        AK.action : ApiEndPointAction.getBranchDeptUser,
        AK.branchId : bId ?? jobInfo?.branchId,
        AK.departmentId : dId ?? jobInfo?.departmentId
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

  void clickOnSelectPriorityTextFormFiled() {}

  Future<void> clickOnListOfDropDown({required value}) async {
    apiResValue.value = true;
    CM.unFocusKeyBoard();
    isDropDownOpenValue.value = false;
    branchData.value = value;
    selectedBranchValue.value = branchData.value?.branchName ?? '';
    selectBranchController.text = branchData.value?.branchName ?? '';
    branchNameList.remove(branchData.value?.branchName);
    branchNameList.insert(0, selectBranchController.text);

    branchList?.remove(branchData.value);
    branchList?.insert(0, value);

    await callingDepartmentApi(bId: branchData.value?.branchId ?? '', companyId: getCompanyDetails?.companyId ?? '');
    apiResValue.value = false;
  }

  Future<void> clickOnDepartmentListFilter({/*required bool selected, */required String dId, required String dName}) async {
    // if (selected) {
      apiResValueForDepartment.value = true;
      selectedDepartments.value = dName;
      await callingGetDepartmentEmployeeApi(dId: dId);
      apiResValueForDepartment.value = false;
      print('1111111111111111111111');
    // } else {
      // selectedDepartments.value = dName;
    // }
    count.value++;
  }

}
