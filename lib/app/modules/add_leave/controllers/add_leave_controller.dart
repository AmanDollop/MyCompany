import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_date_calender_modal.dart';
import 'package:task/api/api_model/get_leave_type_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/theme/colors/colors.dart';

class AddLeaveController extends GetxController {
  final count = 0.obs;
  final apiResValue = true.obs;
  final pageName = ''.obs;

  final applyLeaveButtonValue = false.obs;

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final monthTotalDaysList = [];
  final currentMonth = DateTime.now().obs;

  final dateAddForLeaveList = [];
  List<String> formattedDateListForApi = [];

  final leaveTypeController = TextEditingController();
  final reasonController = TextEditingController();

  final fullAndHalfDayText = ['Full Day', 'Half Day'];
  final fullAndHalfDayIndexValue = '-1'.obs;
  final fullAndHalfDayType = ''.obs;

  final firstAndSecondHalfText = ['First Half', 'Second Half'];
  final firstAndSecondHalfIndexValue = '-1'.obs;
  final firstAndSecondHalfType = ''.obs;

  final paidAndUnPaidText = ['Paid', 'UnPaid'];
  final paidAndUnPaidIndexValue = '-1'.obs;
  final paidAndUnPaidType = ''.obs;

  final getLeaveDateCalenderModal = Rxn<GetLeaveDateCalenderModal>();
  List<LeaveCalender>? leaveDateCalenderList;
  Map<String, dynamic> bodyParamsForGetLeaveDateCalenderApi = {};

  final getLeaveTypeModal = Rxn<GetLeaveTypeModal>();
  List<LeaveType>? leaveTypeList;
  Map<String, dynamic> bodyParamsForGetLeaveTypeApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      pageName.value = Get.arguments[0];
      await callingGetLeaveDateCalenderApi();
      await callingGetLeaveTypeApi();
    } catch (e) {
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

  void monthTotalDaysListDataAdd() {
    monthTotalDaysList.clear();
    for (var i = 1; i <= 31; i++) {
      monthTotalDaysList.add(i);
    }
  }

  Future<void> clickOnReverseIconButton({required index}) async {
    CM.unFocusKeyBoard();
    currentMonth.value = CMForDateTime.subtractMonths(date: currentMonth.value, months: 1);
    await callingGetLeaveDateCalenderApi();
  }

  Future<void> clickOnForwardIconButton({required index}) async {
    CM.unFocusKeyBoard();
    currentMonth.value = CMForDateTime.addMonths(date: currentMonth.value, months: 1);
    await callingGetLeaveDateCalenderApi();
  }

  Future<void> clickOnLeaveTypeField() async {
    if(getLeaveTypeModal.value != null){
      if(leaveTypeList != null && leaveTypeList!.isNotEmpty){
        await CBS.commonBottomSheet(
          showDragHandle: false,
          isDismissible: false,
          isFullScreen: true,
          children: [
            SizedBox(height: 20.px),
            ListView.builder(
              shrinkWrap: true,
              itemCount: leaveTypeList?.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  count.value;
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.px),
                    padding: EdgeInsets.symmetric(vertical: 6.px, horizontal: 10.px),
                    height: 46.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.px),
                      color: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                          ? Col.primary.withOpacity(.08)
                          : Colors.transparent,
                      border: Border.all(
                        color: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                            ? Col.primary
                            : Col.darkGray,
                        width: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                            ? 1.5.px
                            : 1.px,
                      ),
                    ),
                    child: InkWell(
                      onTap: () => clickOnLeaveTypeList(index: index),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${leaveTypeList?[index].leaveTypeName}',
                            style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                                ? 18.px
                                : 16.px,
                            width: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                                ? 18.px
                                : 16.px,
                            padding: EdgeInsets.all(2.px),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                                    ? Col.primary
                                    : Col.text,
                                width: 1.5.px,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: leaveTypeController.text == leaveTypeList?[index].leaveTypeName
                                      ? Col.primary
                                      : Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
            SizedBox(height: 20.px),
          ],
        ).whenComplete(
              () => CM.unFocusKeyBoard(),
        );
      }
    }
  }

  void clickOnLeaveTypeList({required int index}) {
    leaveTypeController.text = leaveTypeList?[index].leaveTypeName ?? '';
    Get.back();
  }

  void clickOnAttachmentButton() {
    CM.unFocusKeyBoard();
  }

  void clickOnApplyLeaveButton() {}

  Future<void> callingGetLeaveDateCalenderApi() async {
    try {
      apiResValue.value = true;
      bodyParamsForGetLeaveDateCalenderApi = {
        AK.action: ApiEndPointAction.getLeaveCalender,
        AK.year: '${currentMonth.value.year}',
        AK.month: '${currentMonth.value.month}',
      };
      getLeaveDateCalenderModal.value = await CAI.getLeaveDateCalenderApi(
          bodyParams: bodyParamsForGetLeaveDateCalenderApi);
      if (getLeaveDateCalenderModal.value != null) {
        leaveDateCalenderList = getLeaveDateCalenderModal.value?.leaveCalender;
      }
    } catch (e) {
      CM.error();
      print('callingGetLeaveDateCalenderApi::::   error:::  $e');
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> callingGetLeaveTypeApi() async {
    try {
      apiResValue.value = true;
      bodyParamsForGetLeaveTypeApi = {
        AK.action: ApiEndPointAction.getLeaveType,
        AK.year: '${currentMonth.value.year}',
      };
      getLeaveTypeModal.value = await CAI.getLeaveTypeModalApi(
          bodyParams: bodyParamsForGetLeaveTypeApi);
      if (getLeaveTypeModal.value != null) {
        leaveTypeList = getLeaveTypeModal.value?.leaveType;
      }
    } catch (e) {
      CM.error();
      print('callingGetLeaveTypeApi::::   error:::  $e');
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }
}
