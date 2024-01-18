import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/circular_detail_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_methods/cm.dart';

class CircularController extends GetxController {
  final count = 0.obs;

  final apiResValue = true.obs;
  final isLastPage = false.obs;

  final menuName = ''.obs;

  DateTime currentDate = DateTime.now();
  DateTime? newDate;
  String? startDate;

  final searchController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  final circularDetailModal = Rxn<CircularDetailModal>();
  List<Circular> circularList = [];
  String limit = '10';
  final offset = 0.obs;
  Map<String, dynamic> bodyParamsForCircularDetail = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      menuName.value = Get.arguments[0];
      newDate = currentDate.subtract(const Duration(days: 30));
      startController.text =
          DateFormat('dd MMM yyyy').format(newDate ?? currentDate);
      endController.text = DateFormat('dd MMM yyyy').format(currentDate);
      await callingCircularDetailApi();
    } catch (e) {
      print('e::::::::  $e');
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

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnStartTextField() async {
    await CDT.iosPicker(
            context: Get.context!,
            dateController: startController,
            initialDate: startController.text.isNotEmpty
                ? DateFormat('dd MMM yyyy').parse(startController.text)
                : DateTime.now()).whenComplete(() async {
        CM.unFocusKeyBoard();
        apiResValue.value = true;
        offset.value = 0;
        await callingCircularDetailApi();
        apiResValue.value = false;
      }).then((value) {
        print('val:::::  $value');
    });
  }

  Future<void> clickOnEndTextField() async {
    CDT.iosPicker(
            context: Get.context!,
            dateController: endController,
            firstDate: DateFormat('dd MMM yyyy').parse(startController.text),
            initialDate: endController.text.isNotEmpty
                ? DateFormat('dd MMM yyyy').parse(endController.text)
                : DateTime.now()).whenComplete(() async {
        CM.unFocusKeyBoard();
        apiResValue.value = true;
        offset.value = 0;
        await callingCircularDetailApi();
        apiResValue.value = false;
      });
  }

  void clickOnCard({required int index}) {
    CM.unFocusKeyBoard();
    if (circularList.isNotEmpty) {
      Get.toNamed(Routes.CIRCULAR_DETAIL, arguments: [circularList[index]]);
    } else {
      CM.error();
    }
  }

  Future<void> callingCircularDetailApi() async {
    try{
      DateTime dateTimeStart = DateFormat('d MMM yyyy').parse(startController.text.trim().toString());
      String start = DateFormat('yyyy-MM-dd').format(dateTimeStart);

      DateTime dateTimeEnd = DateFormat('d MMM yyyy').parse(endController.text.trim().toString());
      String end = DateFormat('yyyy-MM-dd').format(dateTimeEnd);

      bodyParamsForCircularDetail = {
        AK.action: 'getCirculars',
        AK.limit: limit.toString(),
        AK.offset: offset.toString(),
        AK.search: searchController.text.trim().toString(),
        AK.startDate: start,
        AK.endDate: end,
      };
      circularDetailModal.value = await CAI.getCircularDetailApi(bodyParams: bodyParamsForCircularDetail);
      if (offset.value == 0) {
        circularList.clear();
        isLastPage.value = false;
      }
      if (circularDetailModal.value != null) {
        if (circularDetailModal.value?.circular != null && circularDetailModal.value!.circular!.isNotEmpty) {
          circularList.addAll(circularDetailModal.value?.circular ?? []);
          print('circularList:::::::::: ${circularList.length}');
        } else {
          isLastPage.value = true;
        }
      }
    }catch(e){
      apiResValue.value=false;
    }
    apiResValue.value=false;
  }

  Future<void> searchOnChange({required String value}) async {
    try {
      circularList.clear();
      await callingCircularDetailApi();
    } catch (e) {
      CM.error();
    }
  }

  Future<void> onLoadMore() async {
    offset.value = offset.value + 10;
    try {
      await callingCircularDetailApi();
    } catch (e) {
      CM.error();
    }
  }
}
