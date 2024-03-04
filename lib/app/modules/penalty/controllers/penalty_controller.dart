import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/company_details_modal.dart';
import 'package:task/api/api_model/get_penalty_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/data_base/data_base_constant/data_base_constant.dart';
import 'package:task/data_base/data_base_helper/data_base_helper.dart';

class PenaltyController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;

  final companyDetailFromLocalDataBase = ''.obs;
  GetCompanyDetails? getCompanyDetails;

  final apiResValue = true.obs;

  final getPenaltyModal = Rxn<GetPenaltyModal>();
  List<Penalty> penaltyList = [];
  Map<String, dynamic> bodyPramsForGetPenaltyApi = {};
  final isLastPage = false.obs;
  String limit = '10';
  final offset = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    menuName.value = Get.arguments[0];
    await getCompanyDataFromLocalDataBase();
    await callingGetPenaltyApi();
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

  Future<void> getCompanyDataFromLocalDataBase() async {
    try {
      companyDetailFromLocalDataBase.value = await DataBaseHelper().getParticularData(key: DataBaseConstant.companyDetail, tableName: DataBaseConstant.tableNameForCompanyDetail);
      getCompanyDetails = CompanyDetailsModal.fromJson(jsonDecode(companyDetailFromLocalDataBase.value)).getCompanyDetails;
    } catch (e) {
      print('getCompanyDataFromLocalDataBase::: error::::  $e');
    }
  }

  onRefresh() async {
    penaltyList.clear();
    offset.value = 0;
    apiResValue.value = true;
    await getCompanyDataFromLocalDataBase();
    await callingGetPenaltyApi();
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> callingGetPenaltyApi() async {
    try{
      bodyPramsForGetPenaltyApi = {
        AK.action : ApiEndPointAction.getPenalty,
        AK.limit: limit.toString(),
        AK.offset: offset.toString(),
      };
      getPenaltyModal.value = await CAI.getPenaltyApi(bodyParams: bodyPramsForGetPenaltyApi);
      if(getPenaltyModal.value != null){
        penaltyList.addAll(getPenaltyModal.value?.penalty??[]);
      }
    }catch(e){
      apiResValue.value=false;
      CM.error();
      print('GetPenaltyApi::: error::::  $e');
    }
    apiResValue.value=false;
  }

  Future<void> onLoadMore() async {
    CM.unFocusKeyBoard();
    offset.value = offset.value + 1;
    try {
      if (int.parse(limit) <= penaltyList.length) {
        await callingGetPenaltyApi();
      }
    } catch (e) {
      CM.error();
    }
  }
}
