import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_work_report_modal.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import '../../../routes/app_pages.dart';

class WorkReportController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;
  final apiResValue = true.obs;

  final startController = TextEditingController();
  final endController = TextEditingController();

  DateTime currentDate = DateTime.now();
  DateTime? newDate;
  String? startDate;

  final getWorkReportModal = Rxn<GetWorkReportModal>();
  List<WorkReport> workReportList = [];
  Map<String, dynamic> bodyParamsWorkReportListApi ={};

  final isLastPage = false.obs;
  String limit = '15';
  final offset = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    menuName.value = Get.arguments[0];
    newDate = currentDate.subtract(const Duration(days: 30));
    startController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${newDate ?? currentDate}');
    endController.text = CMForDateTime.dateFormatForDateMonthYear(date: '$currentDate');
    await callingGetWorkReportApi();
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

  clearData(){
    offset.value = 0;
    workReportList.clear();
    apiResValue.value = true;
    isLastPage.value = false;
  }

  onRefresh() async {
    clearData();
    await callingGetWorkReportApi();
  }

  Future<void> clickOnStartTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: startController,
      initialDate: startController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(startController.text)
          : DateTime.now(),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
      clearData();
      await callingGetWorkReportApi();
    });

  }

  Future<void> clickOnEndTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: endController,
      firstDate: DateFormat('dd MMM yyyy').parse(startController.text),
      initialDate: endController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(endController.text)
          : DateTime.now(),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
      clearData();
       await callingGetWorkReportApi();
    });
  }

  Future<void> callingGetWorkReportApi() async {
    try{
      bodyParamsWorkReportListApi = {
        AK.action:ApiEndPointAction.getWorkReport,
        AK.limit: limit.toString(),
        AK.offset: offset.toString(),
        AK.monthStartDate : CMForDateTime.dateTimeFormatForApi(dateTime: startController.text.trim().toString()),
        AK.monthEndDate : CMForDateTime.dateTimeFormatForApi(dateTime: endController.text.trim().toString()),
      };
      getWorkReportModal.value = await CAI.getWorkReportApi(bodyParams: bodyParamsWorkReportListApi);
      if(getWorkReportModal.value != null){

        if(getWorkReportModal.value?.workReport != null && getWorkReportModal.value!.workReport!.isNotEmpty){
          workReportList.addAll(getWorkReportModal.value?.workReport ?? []);
        }else {
          isLastPage.value = true;
        }
      }
    }catch(e){
      CM.error();
      print('callingGetWorkReportApi::::: error::::: $e');
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> clickOnViewMoreButton({required int index}) async {
    await Get.toNamed(Routes.WORK_REPORT_DETAIL,arguments: [workReportList[index].workReportId]);
    clearData();
    callingGetWorkReportApi();
  }

  Future<void> onLoadMore() async {
    CM.unFocusKeyBoard();
    offset.value = offset.value + 1;
    try {
      if (int.parse(limit) <= workReportList.length) {
        await callingGetWorkReportApi();
      }
    } catch (e) {
      CM.error();
    }
  }

  Future<void> clickOnAddWorkReportButton() async {
    await Get.toNamed(Routes.ADD_TEMPLATE_QUESTION);
    clearData();
    callingGetWorkReportApi();
  }

}
