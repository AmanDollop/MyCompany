import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_type_balance_count_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/theme/constants/constants.dart';

class LeaveBalanceController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;

  final yearForMonthViewValue = DateFormat('yyyy').format(DateTime.now()).obs;

  List<String> yearForMonthViewList = <String>[
    DateFormat('yyyy').format(DateTime.now().subtract(const Duration(days: 365))),
    DateFormat('yyyy').format(DateTime.now()),
    DateFormat('yyyy').format(DateTime.now().add(const Duration(days: 365))),
  ];

  final getLeaveTypeBalanceCountModal = Rxn<GetLeaveTypeBalanceCountModal>();
  List<LeaveBalanceCountList>? leaveBalanceCountList;
  Map<String,dynamic> bodyParmaForLeaveBalanceApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingLeaveBalanceApi();
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
    leaveBalanceCountList?.clear();
    await onInit();
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnYear() async {
    await CBS.commonBottomSheet(
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
        ],
    );
  }

  Future<void> clickOnYearValue({required int index}) async {
    yearForMonthViewValue.value = yearForMonthViewList[index];
    apiResValue.value=true;
    await callingLeaveBalanceApi();
    count.value++;
    Get.back();
  }

  Future<void> callingLeaveBalanceApi() async {
    apiResValue.value = true;
    try{
      bodyParmaForLeaveBalanceApi = {
        AK.action : ApiEndPointAction.getLeaveTypeBalanceCount,
        AK.year : yearForMonthViewValue.value.toString()
      };
      getLeaveTypeBalanceCountModal.value = await CAI.getLeaveBalanceCountApi(bodyParams: bodyParmaForLeaveBalanceApi);
      if(getLeaveTypeBalanceCountModal.value != null){
        leaveBalanceCountList = getLeaveTypeBalanceCountModal.value?.leaveBalanceCountList;
        print('getLeaveTypeBalanceCountList:::: ${leaveBalanceCountList?.length}');
      }
    }catch(e){
      CM.error();
      print('callingLeaveBalanceApi:::: error:::  $e');
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

}
