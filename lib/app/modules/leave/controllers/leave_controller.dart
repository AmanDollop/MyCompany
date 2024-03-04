import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_all_leave_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

class LeaveController extends GetxController {

  final count = 0.obs;
  final menuName = ''.obs;
  final apiResValue = true.obs;

  final yearForMonthViewValue = DateFormat('yyyy').format(DateTime.now()).obs;

  List<String> yearForMonthViewList = <String>[
    DateFormat('yyyy').format(DateTime.now().subtract(const Duration(days: 365))),
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.now().add(const Duration(days: 365))),
  ];

  final getAllLeaveModal = Rxn<GetAllLeaveModal>();
  List<GetLeave>? getLeaveList;
  Map<String, dynamic> bodyParamsForGetAllLeaveApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    apiResValue.value = true;
    menuName.value = Get.arguments[0];
    await callingGetAllLeaveApi();
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

  onRefresh() async {
    await onInit();
  }

  void clickOnBackButton(){
    Get.back();
  }

  Future<void> clickOnYear() async {
    await CBS.commonBottomSheet(
      // initialChildSize: 0.38,
      // maxChildSize: 0.50,
        isDismissible: false,
        horizontalPadding: 0,
        children: [
          Center(
            child: Text(
              'Select Year',
              style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 14.px),
          Wrap(
            children: List.generate(
              yearForMonthViewList.length,
                  (index) => Obx(() {
                count.value;
                final cellWidth = MediaQuery.of(Get.context!).size.width / 2;
                return SizedBox(
                  width: cellWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index % 2 == 0 ? C.margin : C.margin / 2,
                        right: index % 2 == 0 ? C.margin / 2 : C.margin,
                        top: C.margin / 2,
                        bottom: 0.px),
                    child: Container(
                      height: 46.px,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.px),
                        color: yearForMonthViewValue.value == yearForMonthViewList[index]
                            ? Col.primary.withOpacity(.08)
                            : Colors.transparent,
                        border: Border.all(
                          color: yearForMonthViewValue.value == yearForMonthViewList[index]
                              ? Col.primary
                              : Col.darkGray,
                          width: yearForMonthViewValue.value == yearForMonthViewList[index]
                              ? 1.5.px
                              : 1.px,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => clickOnYearValue(index: index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.px, horizontal: 10.px),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                yearForMonthViewList[index],
                                style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 30.px)
        ]);
  }

  Future<void> clickOnYearValue({required int index}) async {
    yearForMonthViewValue.value = yearForMonthViewList[index];
    apiResValue.value=true;
    await callingGetAllLeaveApi();
    count.value++;
    Get.back();
  }

  void clickOnViewMoreButton({required int index}) {
    if(getLeaveList?[index].leaveId != null && getLeaveList![index].leaveId!.isNotEmpty) {
      Get.toNamed(Routes.LEAVE_DETAIL,arguments: [getLeaveList?[index].leaveId]);
    }
  }

  void clickOnAddButton() {
    Get.toNamed(Routes.ADD_LEAVE,arguments: ['Add Leave']);
  }

  Future<void> callingGetAllLeaveApi() async {
    try{
      bodyParamsForGetAllLeaveApi = {
        AK.action : ApiEndPointAction.getLeave,
        AK.leaveYear : yearForMonthViewValue.value
      };
      getAllLeaveModal.value = await CAI.getAllLeaveApi(bodyParams: bodyParamsForGetAllLeaveApi);
      if(getAllLeaveModal.value != null){
        getLeaveList = getAllLeaveModal.value?.getLeave;
        print('getLeaveList::::   ${getLeaveList?.length}');
      }
    }catch(e){
      CM.error();
      apiResValue.value = false;
      print('callingGetAllLeaveApi:::::  error :::::  $e');
    }
    apiResValue.value = false;
  }


}
