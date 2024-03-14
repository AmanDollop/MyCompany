import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_date_calender_modal.dart';
import 'package:task/api/api_model/get_leave_type_balance_modal.dart';
import 'package:task/api/api_model/get_leave_type_modal.dart';
import 'package:task/app/modules/add_leave/views/add_leave_view.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import 'package:http/http.dart' as http;

class AddLeaveController extends GetxController with GetTickerProviderStateMixin {
  final count = 0.obs;
  final apiResValue = true.obs;
  final pageName = ''.obs;

  final applyLeaveButtonValue = false.obs;
  final addButtonValue = false.obs;

  final isAfterAndBeforeCalenderDateValue = false.obs;

  final applyBulkLeaveValue = false.obs;
  final applyBulkLeaveButtonHideAndShowValue = false.obs;

  final leaveTypeListClickValue = false.obs;

  final allMonthsSameValue = false.obs;

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final monthTotalDaysList = [];
  final currentMonth = DateTime.now().obs;

  final dateAddForLeaveList = [];

  List<String> formattedDateListForApi = [];

  final key = GlobalKey<FormState>();
  final keyForLeaveReason = GlobalKey<FormState>();
  final leaveTypeController = TextEditingController();
  final reasonController = TextEditingController();

  final fullAndHalfDayText = ['Full Day', 'Half Day'];
  final fullAndHalfDayIndexValue = '0'.obs;
  final fullAndHalfDayType = 'Full Day'.obs;

  final firstAndSecondHalfText = ['First Half', 'Second Half'];
  final firstAndSecondHalfIndexValue = '0'.obs;
  final firstAndSecondHalfType = 'First Half'.obs;

  final paidAndUnPaidText = ['Paid', 'UnPaid'];
  final paidAndUnPaidIndexValue = '1'.obs;
  final paidAndUnPaidType = 'UnPaid'.obs;

  final result = Rxn<FilePickerResult>();
  final imageFile = Rxn<File>();

  final getLeaveDateCalenderModal = Rxn<GetLeaveDateCalenderModal>();
  List<LeaveCalender>? leaveDateCalenderList;
  List<MonthDates>? monthDatesList;
  Map<String, dynamic> bodyParamsForGetLeaveDateCalenderApi = {};

  final getLeaveTypeModal = Rxn<GetLeaveTypeModal>();
  List<LeaveType>? leaveTypeList;
  Map<String, dynamic> bodyParamsForGetLeaveTypeApi = {};

  final getLeaveTypeBalanceModal = Rxn<GetLeaveTypeBalanceModal>();
  final availableLeave = 0.0.obs;
  final availableLeaveValue = false.obs;
  Map<String, dynamic> bodyParamsForGetLeaveTypeBalanceApi = {};

  List<LocalData> localData = [];
  List<LocalDataForLeaveType> localDataForLeaveType = [];

  final leaveTypeIdFromApi = ''.obs;
  final leaveTypeForAttachmentRequired = ''.obs;

  Map<String, dynamic> bodyParamsForAddLeaveApi = {};

  PageController pageController = PageController();

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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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

  Future<void> clickOnReverseIconButton() async {
    CM.unFocusKeyBoard();
    monthTotalDaysListDataAdd();
    await pageController.previousPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
    currentMonth.value = CMForDateTime.subtractMonths(date: currentMonth.value, months: 1);
    count.value--;
  }

  Future<void> clickOnForwardIconButton() async {
    CM.unFocusKeyBoard();
    monthTotalDaysListDataAdd();
    await pageController.nextPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
    currentMonth.value = CMForDateTime.addMonths(date: currentMonth.value, months: 1);
    count.value++;
  }

  Future<void> clickOnAttachmentButton() async {
    CM.unFocusKeyBoard();
    result.value = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      // allowedExtensions: [
      //   'jpg',
      //   'png',
      //   'svg',
      // ],
    );
    print('result.value?.paths:::: ${result.value?.paths}');
    if (result.value?.paths != null && result.value!.paths.isNotEmpty) {
      imageFile.value =
          await CM.pickFilePickerResultAndConvertFile(result1: result.value);
      print('imageFile.value:::: ${imageFile.value}');
    }
  }

  Future<void> callingGetLeaveDateCalenderApi() async {
    try {
      apiResValue.value = true;
      bodyParamsForGetLeaveDateCalenderApi = {
        AK.action: ApiEndPointAction.getLeaveCalender,
        // AK.year: '${currentMonth.value.year}',
        // AK.month: '${currentMonth.value.month}',
      };
      getLeaveDateCalenderModal.value = await CAI.getLeaveDateCalenderApi(bodyParams: bodyParamsForGetLeaveDateCalenderApi);
      if (getLeaveDateCalenderModal.value != null) {
        leaveDateCalenderList = getLeaveDateCalenderModal.value?.leaveCalender;
        for (var i = 0; i < leaveDateCalenderList!.length; i++) {
          if(leaveDateCalenderList?[i].monthName == DateFormat('MMMM').format(DateTime.now())){
            pageController = PageController(initialPage: i);
            count.value++;
          }
        }
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
      getLeaveTypeModal.value = await CAI.getLeaveTypeModalApi(bodyParams: bodyParamsForGetLeaveTypeApi);
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

  Future<void> openBottomSheet({required int index}) async {
    await CBS.commonBottomSheet(
      elevation: 0,
      children: [
        Obx(() {
          count.value;
          return Form(
            key: key,
            child: ListView(
              shrinkWrap: true,
              children: [
                leaveTypeTextField(index: index),
                SizedBox(height: 10.px),
                if (availableLeaveValue.value)
                  Text(
                    availableLeave.value == 0.0
                        ? 'Paid leaves not available : ${availableLeave.value}'
                        : 'Available paid leaves : ${availableLeave.value}',
                    style:
                        Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                              fontSize: 10.px,
                              // color: availableLeave.value == 0.0
                              //     ? Col.error
                              //     : Col.success,
                            ),
                  ),
                if (availableLeaveValue.value) SizedBox(height: 10.px),
                fullAndHalfDayView(),
                if (fullAndHalfDayType.value != 'Full Day')
                  SizedBox(height: 10.px),
                if (fullAndHalfDayType.value != 'Full Day')
                  firstAndSecondHalfView(),
                SizedBox(height: 10.px),
                paidAndUnPaidView(),
                SizedBox(height: 20.px),
                CW.commonElevatedButton(
                    onPressed: addButtonValue.value
                        ? () => null
                        : () => clickOnAddButton(index: index),
                    buttonText: 'Add',
                    isLoading: addButtonValue.value),
                SizedBox(height: 20.px),
              ],
            ),
          );
        })
      ],
    ).whenComplete(() {
      leaveTypeController.clear();
      fullAndHalfDayType.value = 'Full Day';
      fullAndHalfDayIndexValue.value = '0';

      firstAndSecondHalfType.value = 'First Half';
      firstAndSecondHalfIndexValue.value = '0';

      paidAndUnPaidType.value = 'UnPaid';
      paidAndUnPaidIndexValue.value = '1';

      availableLeaveValue.value = false;
      addButtonValue.value = false;
    });
  }

  Widget leaveTypeTextField({required int index}) => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: leaveTypeController,
        labelText: 'Leave Type',
        hintText: 'Leave Type',
        keyboardType: TextInputType.name,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select leave type'),
        onChanged: (value) {
          count.value++;
        },
        readOnly: true,
        onTap: () => clickOnLeaveTypeField(),
        suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary),
      );

  Future<void> clickOnLeaveTypeField() async {
    if (getLeaveTypeModal.value != null) {
      if (leaveTypeList != null && leaveTypeList!.isNotEmpty) {
        await CBS.commonBottomSheet(
          showDragHandle: false,
          isDismissible: false,
          isFullScreen: true,
          children: [
            SizedBox(height: 20.px),
            ListView.builder(
              shrinkWrap: true,
              itemCount: leaveTypeList?.length,
              itemBuilder: (context, i) {
                return Obx(() {
                  count.value;
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.px),
                    padding:
                        EdgeInsets.symmetric(vertical: 6.px, horizontal: 10.px),
                    height: 46.px,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.px),
                      color: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                          ? Col.primary.withOpacity(.08)
                          : Colors.transparent,
                      border: Border.all(
                        color: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                            ? Col.primary
                            : Col.darkGray,
                        width: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                            ? 1.5.px
                            : 1.px,
                      ),
                    ),
                    child: InkWell(
                      onTap: leaveTypeListClickValue.value
                          ? () => null
                          : () => clickOnLeaveTypeList(i: i),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${leaveTypeList?[i].leaveTypeName}',
                            style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                                ? 18.px
                                : 16.px,
                            width: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                                ? 18.px
                                : 16.px,
                            padding: EdgeInsets.all(2.px),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
                                    ? Col.primary
                                    : Col.text,
                                width: 1.5.px,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: leaveTypeController.text == leaveTypeList?[i].leaveTypeName
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

  Future<void> clickOnLeaveTypeList({required int i}) async {
    leaveTypeListClickValue.value = true;
    leaveTypeController.text = leaveTypeList?[i].leaveTypeName ?? '';
    leaveTypeIdFromApi.value = leaveTypeList?[i].leaveTypeId ?? '';
    if (leaveTypeList?[i].attachmentRequired == '1') {
      leaveTypeForAttachmentRequired.value = leaveTypeList?[i].attachmentRequired ?? '';
    }
    await callingGetLeaveTypeBalanceApi();
    Get.back();
    leaveTypeListClickValue.value = false;
  }

  Widget commonContainerView({required Widget child}) => Container(
        height: 50.px,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.px),
            border: Border.all(color: Col.gray)),
        child: child,
      );

  Widget radioButtonLabelTextView({required String text, Color? color}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500, color: color),
      );

  Widget fullAndHalfDayView() => commonContainerView(
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (availableLeave.value == 0.5) {
              fullAndHalfDayType.value = 'Half Day';
              fullAndHalfDayIndexValue.value = '1';
            }
            return Padding(
              padding: EdgeInsets.only(right: 15.px),
              child: Row(
                children: [
                  CustomRadio(
                    activeColor: Col.gray,
                    onChanged: (value) {
                      CM.unFocusKeyBoard();
                      if (value != null && availableLeave.value != 0.5) {
                        fullAndHalfDayIndexValue.value = value;
                        fullAndHalfDayType.value = fullAndHalfDayText[index];
                        count.value++;
                      }
                    },
                    value: index.toString(),
                    groupValue: fullAndHalfDayIndexValue.value.toString(),
                  ),
                  SizedBox(width: 6.px),
                  radioButtonLabelTextView(
                      text: fullAndHalfDayText[index],
                      color: fullAndHalfDayText[index] == fullAndHalfDayType.value
                              ? Col.text
                              : Col.darkGray)
                ],
              ),
            );
          },
        ),
      );

  Widget firstAndSecondHalfView() => SizedBox(
        height: 33.px,
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 15.px),
              child: Row(
                children: [
                  CustomRadio(
                    onChanged: (value) {
                      CM.unFocusKeyBoard();
                      if (value != null) {
                        firstAndSecondHalfIndexValue.value = value;
                        firstAndSecondHalfType.value =
                            firstAndSecondHalfText[index];
                        count.value++;
                      }
                    },
                    value: index.toString(),
                    groupValue: firstAndSecondHalfIndexValue.value.toString(),
                    activeColor: Col.gray,
                  ),
                  SizedBox(width: 6.px),
                  radioButtonLabelTextView(
                      text: firstAndSecondHalfText[index],
                      color: firstAndSecondHalfText[index] == firstAndSecondHalfType.value
                          ? Col.text
                          : Col.darkGray)
                ],
              ),
            );
          },
        ),
      );

  Widget paidAndUnPaidView() => commonContainerView(
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          itemBuilder: (context, index) {
            if (availableLeave.value == 0.0) {
              paidAndUnPaidType.value = 'UnPaid';
              paidAndUnPaidIndexValue.value = '1';
            }
            return Padding(
              padding: EdgeInsets.only(right: 15.px),
              child: Row(
                children: [
                  CustomRadio(
                    onChanged: (value) {
                      CM.unFocusKeyBoard();
                      if (value != null && availableLeave.value != 0.0) {
                        paidAndUnPaidIndexValue.value = value;
                        paidAndUnPaidType.value = paidAndUnPaidText[index];
                        count.value++;
                      }
                    },
                    value: index.toString(),
                    groupValue: paidAndUnPaidIndexValue.value.toString(),
                    activeColor: Col.gray,
                  ),
                  SizedBox(width: 6.px),
                  radioButtonLabelTextView(
                      text: paidAndUnPaidText[index],
                      color: paidAndUnPaidText[index] == paidAndUnPaidType.value
                          ? Col.text
                          : Col.darkGray)
                ],
              ),
            );
          },
        ),
      );

  void clickOnAddButton({required int index}) {
    if (key.currentState!.validate()) {
      addButtonValue.value = true;
      LocalData data = LocalData(
          date: localData[index].date,
          value: true,
          firstAndSecondHalf: fullAndHalfDayType.value != 'Full Day'
              ? firstAndSecondHalfType.value
              : '',
          fullAndHalfDay: fullAndHalfDayType.value,
          leaveType: leaveTypeController.text.trim(),
          paidAndUnPaid: paidAndUnPaidType.value,
          leaveTypeId: leaveTypeIdFromApi.value);

      updateLocalDataByDate(date: '${localData[index].date}', newData: data);

      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          addButtonValue.value = false;
          applyBulkLeaveButtonHideAndShowValue.value = true;
          Get.back();
        },
      );
    }
  }

  void addLocalData({required LocalData data}) {
    dateAddForLeaveList.add('${data.date}');
    localData.add(data);
  }

  void removeLocalDataByDate({required String date}) {
    dateAddForLeaveList.remove(date);

    localData.removeWhere((element) => element.date == date);
  }

  void updateLocalDataByDate({required String date, required LocalData newData}) {
    int index = localData.indexWhere((element) => element.date == date);
    if (index != -1) {
      localData[index] = newData;
    } else {
      print("No data found with the provided date.");
    }
  }

  Future<void> openBottomSheetForApplyBulkLeaves() async {
    availableLeaveValue.value = false;
    addButtonValue.value = false;
    await CBS.commonBottomSheet(
      elevation: 0,
      children: [
        Obx(() {
          count.value;
          return Form(
            key: key,
            child: ListView(
              shrinkWrap: true,
              children: [
                leaveTypeTextFieldForApplyBulkLeave(),
                SizedBox(height: 10.px),
                if (availableLeaveValue.value)
                  Text(
                    availableLeave.value == 0.0
                        ? 'Paid leaves not available : ${availableLeave.value}'
                        : 'Available paid leaves : ${availableLeave.value}',
                    style: Theme.of(Get.context!)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 10.px),
                  ),
                if (availableLeaveValue.value) SizedBox(height: 10.px),
                fullAndHalfDayView(),
                if (fullAndHalfDayType.value != 'Full Day')
                  SizedBox(height: 10.px),
                if (fullAndHalfDayType.value != 'Full Day')
                  firstAndSecondHalfView(),
                SizedBox(height: 10.px),
                paidAndUnPaidViewForApplyBulkLeaves(),
                SizedBox(height: 20.px),
                CW.commonElevatedButton(
                    onPressed: addButtonValue.value
                        ? () => null
                        : () => clickOnAddForApplyBulkLeaveButton(),
                    buttonText: 'Add',
                    isLoading: addButtonValue.value),
                SizedBox(height: 20.px),
              ],
            ),
          );
        })
      ],
    ).whenComplete(() {
      leaveTypeController.clear();
      fullAndHalfDayType.value = 'Full Day';
      fullAndHalfDayIndexValue.value = '0';

      firstAndSecondHalfType.value = 'First Half';
      firstAndSecondHalfIndexValue.value = '0';

      paidAndUnPaidType.value = 'UnPaid';
      paidAndUnPaidIndexValue.value = '1';
    });
  }

  Widget leaveTypeTextFieldForApplyBulkLeave() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: leaveTypeController,
        labelText: 'Leave Type',
        hintText: 'Leave Type',
        keyboardType: TextInputType.name,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select leave type'),
        onChanged: (value) {
          count.value++;
        },
        readOnly: true,
        onTap: () => clickOnLeaveTypeField(),
        suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary),
      );

  Widget paidAndUnPaidViewForApplyBulkLeaves() => commonContainerView(
        child: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          itemBuilder: (context, index) {
            if (availableLeave.value == 0.0) {
              paidAndUnPaidType.value = 'UnPaid';
              paidAndUnPaidIndexValue.value = '1';
            }
            return Padding(
              padding: EdgeInsets.only(right: 15.px),
              child: Row(
                children: [
                  CustomRadio(
                    onChanged: (value) {
                      CM.unFocusKeyBoard();
                      if (value != null && availableLeave.value != 0.0) {
                        paidAndUnPaidIndexValue.value = value;
                        paidAndUnPaidType.value = paidAndUnPaidText[index];
                        count.value++;
                      }
                    },
                    value: index.toString(),
                    groupValue: paidAndUnPaidIndexValue.value.toString(),
                    activeColor: Col.gray,
                  ),
                  SizedBox(width: 6.px),
                  radioButtonLabelTextView(
                      text: paidAndUnPaidText[index] == 'Paid'
                          ? 'Applicable leaves'
                          : 'All unpaid leaves',
                      color: paidAndUnPaidText[index] == paidAndUnPaidType.value
                          ? Col.text
                          : Col.darkGray)
                ],
              ),
            );
          },
        ),
      );

  void clickOnAddForApplyBulkLeaveButton() {
    if (key.currentState!.validate()) {
      addButtonValue.value = true;
      String? date;
      if (availableLeave.value.toInt() != 0 && fullAndHalfDayType.value == 'Half Day') {
        availableLeave.value = availableLeave.value.toInt() * 2;
      }

      for (var element in dateAddForLeaveList) {
        if (element != null && element!.isNotEmpty) {
          if (paidAndUnPaidType.value == 'Paid') {
            if (availableLeave.value.toInt() != 0 && fullAndHalfDayType.value == 'Full Day') {
              date = element;
              LocalData data = LocalData(
                  date: date,
                  value: true,
                  firstAndSecondHalf: fullAndHalfDayType.value == 'Full Day'
                      ? ''
                      : firstAndSecondHalfType.value,
                  fullAndHalfDay: fullAndHalfDayType.value,
                  leaveType: leaveTypeController.text.trim(),
                  paidAndUnPaid: paidAndUnPaidType.value,
                  leaveTypeId: leaveTypeIdFromApi.value);
              updateLocalDataByDate(date: date ?? '', newData: data);
              availableLeave.value--;
              if (availableLeave.value.toInt() == 0) {
                paidAndUnPaidType.value = "UnPaid";
              }
            }
            else if (availableLeave.value.toInt() != 0 && fullAndHalfDayType.value == 'Half Day') {
              date = element;
              LocalData data = LocalData(
                  date: date,
                  value: true,
                  firstAndSecondHalf: fullAndHalfDayType.value == 'Full Day'
                      ? ''
                      : firstAndSecondHalfType.value,
                  fullAndHalfDay: fullAndHalfDayType.value,
                  leaveType: leaveTypeController.text.trim(),
                  paidAndUnPaid: paidAndUnPaidType.value,
                  leaveTypeId: leaveTypeIdFromApi.value);
              updateLocalDataByDate(date: date ?? '', newData: data);
              availableLeave.value--;
              if (availableLeave.value.toInt() == 0) {
                paidAndUnPaidType.value = "UnPaid";
              }
            }
          }
          else {
            date = element;
            LocalData data = LocalData(
                date: date,
                value: true,
                firstAndSecondHalf: fullAndHalfDayType.value == 'Full Day'
                    ? ''
                    : firstAndSecondHalfType.value,
                fullAndHalfDay: fullAndHalfDayType.value,
                leaveType: leaveTypeController.text.trim(),
                paidAndUnPaid: paidAndUnPaidType.value,
                leaveTypeId: leaveTypeIdFromApi.value);
            updateLocalDataByDate(date: date ?? '', newData: data);
          }
        }
      }

      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          addButtonValue.value = false;
          applyBulkLeaveValue.value = true;
          Get.back();
        },
      );
    }
  }

  Future<void> callingGetLeaveTypeBalanceApi() async {
    try {
      bodyParamsForGetLeaveTypeBalanceApi = {
        AK.action: ApiEndPointAction.getLeaveTypeBalance,
        AK.leaveTypeId: leaveTypeIdFromApi.value,
        AK.leaveDate: formattedDateListForApi.first,
      };
      getLeaveTypeBalanceModal.value = await CAI.getLeaveTypeBalanceApi(bodyParams: bodyParamsForGetLeaveTypeBalanceApi);
      if (getLeaveTypeBalanceModal.value != null) {
        availableLeave.value = double.parse(getLeaveTypeBalanceModal.value?.availableLeave ?? '0.0');
        localDataForLeaveTypeMethod(leaveTypeId: leaveTypeIdFromApi.value);
        availableLeaveValue.value = true;
      }
    } catch (e) {
      CM.error();
      print('callingGetLeaveTypeBalanceApi::::   error:::  $e');
      apiResValue.value = false;
      leaveTypeListClickValue.value = false;
    }
    apiResValue.value = false;
  }

  void localDataForLeaveTypeMethod({required String leaveTypeId}){
    LocalDataForLeaveType data = LocalDataForLeaveType(
      leaveId: leaveTypeId,
      availablePaidAndUnPaidLeaveValue: availableLeave.value,
    );

    int index = localDataForLeaveType.indexWhere((element) => element.leaveId == data.leaveId);

    if (index != -1) {
      localData.forEach((element) {
        if (element.paidAndUnPaid == 'Paid' &&
            element.fullAndHalfDay == 'Full Day' &&
            element.leaveTypeId == localDataForLeaveType[index].leaveId) {
          availableLeave.value--;
        } else if (element.paidAndUnPaid == 'Paid' &&
            element.fullAndHalfDay == 'Half Day' &&
            element.leaveTypeId == localDataForLeaveType[index].leaveId) {
          availableLeave.value = availableLeave.value - .5;
        }
      });

      data = LocalDataForLeaveType(
        leaveId: leaveTypeId,
        availablePaidAndUnPaidLeaveValue: availableLeave.value,
      );
      // update it
      localDataForLeaveType[index] = data;
    } else {
      // insert data
      localDataForLeaveType.add(data);
    }
  }

  Future<void> clickOnApplyLeaveButton() async {
    if(keyForLeaveReason.currentState!.validate()){
      if (imageFile.value == null && leaveTypeForAttachmentRequired.value == '1') {
        CM.showSnackBar(message: 'Required Attachment');
      } else {
        applyLeaveButtonValue.value = true;
        getIdsForApi();
        await callingAddLeaveApi();
      }
    }
  }

  String? leaveTypeIds;
  String? paidAndUnPaidIds;
  String? fullAndHalfDayIds;
  String? firstAndSecondHalfIds;

  void getIdsForApi() {

    leaveTypeIds = localData.map((data) {
      if(data.leaveTypeId != null && data.leaveTypeId!.isNotEmpty){
        return data.leaveTypeId;
      }
    }).join(',');

    paidAndUnPaidIds = localData.map((data) {
      if (data.paidAndUnPaid != null && data.paidAndUnPaid!.isNotEmpty) {
        if (data.paidAndUnPaid == 'Paid') {
          return '1';
        } else {
          return '0';
        }
      }
    }).join(',');

    fullAndHalfDayIds = localData.map((data) {
      if (data.fullAndHalfDay != null && data.fullAndHalfDay!.isNotEmpty) {
        if (data.fullAndHalfDay == 'Full Day') {
          return '0';
        }else{
          return '1';
        }
      }
    }).join(',');

    firstAndSecondHalfIds = localData.map((data) {
      if (data.fullAndHalfDay != null && data.fullAndHalfDay!.isNotEmpty) {
        if (data.fullAndHalfDay == 'Full Day') {
          return '0';
        } else {
          if(data.firstAndSecondHalf != null && data.firstAndSecondHalf!.isNotEmpty){
            if (data.firstAndSecondHalf == 'First Half') {
              return '1';
            } else {
              return '2';
            }
          }
        }
      }
    }).join(',');

  }

  Future<void> callingAddLeaveApi() async {
    try {
      bodyParamsForAddLeaveApi = {
        AK.action: ApiEndPointAction.addLeave,
        AK.leaveDate: formattedDateListForApi.join(','),
        AK.leaveTypeId: leaveTypeIds,
        AK.leaveDayType: fullAndHalfDayIds,
        AK.leaveDayTypeSession: firstAndSecondHalfIds,
        AK.isPaid: paidAndUnPaidIds,
        AK.leaveReason: reasonController.text.trim().toString(),
      };
      http.Response? response = await CAI.addLeaveApi(bodyParams: bodyParamsForAddLeaveApi, filePath: imageFile.value);
      if (response != null && response.statusCode == 200) {
        CM.showSnackBar(message: 'Add Leave Successfully');
        Get.back();
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
      applyLeaveButtonValue.value = false;
      print('callingAddLeaveApi:::  error::::  $e');
    }
    applyLeaveButtonValue.value = false;
  }
}
