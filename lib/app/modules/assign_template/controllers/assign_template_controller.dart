import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_assign_template_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';

class AssignTemplateController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  final dateController = TextEditingController();
  FocusNode focusNodeDate = FocusNode();

  final getAssignTemplateModal = Rxn<GetAssignTemplateModal>();
  List<TemplateAssign>? templateAssignList;
  Map<String, dynamic> bodyParamsForGetAssignTemplateApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    dateController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${DateTime.now()}');
    await callingGetAssignTemplateApi();
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

  Future<void> clickOnDateTextFormFiled({required BuildContext context}) async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: dateController,
      // firstDate: DateTime.now(),
      initialDate: dateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateController.text)
          : DateTime.now(),
      lastDate: dateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateController.text).add(const Duration(days: 20))
          : DateTime.now().add(const Duration(days: 20)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> callingGetAssignTemplateApi() async {
    try{
      apiResValue.value = true;
      bodyParamsForGetAssignTemplateApi = {
        AK.action : ApiEndPointAction.getAssignTemplate,
      };
      getAssignTemplateModal.value = await CAI.getAssignTemplateApi(bodyParams: bodyParamsForGetAssignTemplateApi);
      if(getAssignTemplateModal.value != null){
        templateAssignList = getAssignTemplateModal.value?.templateAssign;
      }
    }catch(e){
      print('callingGetAssignTemplateApi::::::::  Error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  void clickOnRightArrowButton({required int index}) {
    if(templateAssignList?[index].templateId != null && templateAssignList![index].templateId!.isNotEmpty) {
      Get.toNamed(Routes.ADD_TEMPLATE_QUESTION,arguments: [templateAssignList?[index].templateId]);
    }else{
      CM.error();
    }
  }

}
