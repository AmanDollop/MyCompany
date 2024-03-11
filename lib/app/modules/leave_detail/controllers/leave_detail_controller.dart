import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_detail_modal.dart';
import 'package:task/api/api_model/get_leave_type_balance_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

class LeaveDetailController extends GetxController {

  final count = 0.obs;
  final getLeaveId = ''.obs;

  final image = Rxn<File?>();

  final key = GlobalKey<FormState>();
  final leaveTypeController = TextEditingController();

  final getLeaveTypeBalanceModal = Rxn<GetLeaveTypeBalanceModal>();
  final availableLeave = 0.0.obs;
  final availableLeaveValue = false.obs;
  Map<String, dynamic> bodyParamsForGetLeaveTypeBalanceApi = {};

  final fullAndHalfDayText = ['Full Day', 'Half Day'];
  final fullAndHalfDayIndexValue = '0'.obs;
  final fullAndHalfDayType = 'Full Day'.obs;

  final firstAndSecondHalfText = ['First Half', 'Second Half'];
  final firstAndSecondHalfIndexValue = '0'.obs;
  final firstAndSecondHalfType = 'First Half'.obs;

  final paidAndUnPaidText = ['Paid', 'UnPaid'];
  final paidAndUnPaidIndexValue = '1'.obs;
  final paidAndUnPaidType = 'UnPaid'.obs;

  final updateButtonValue = false.obs;

  final apiResValue = true.obs;

  final getLeaveDetailModal = Rxn<GetLeaveDetailModal>();
  GetLeaveDetails? getLeaveDetailsList;
  Map<String, dynamic> bodyParamsForGetLeaveDetailApi = {};

  Map<String, dynamic> bodyParamsForUpDateAndDeleteLeaveApi = {};

  // final TextEditingController textEditingController = TextEditingController();
  // late final FocusNode focusNode;

  @override
  Future<void> onInit() async {
    // textEditingController.addListener(() => count.value++);
    // focusNode = FocusNode();
    super.onInit();
    getLeaveId.value = Get.arguments[0];
    await callingGetLeaveDetailApi();
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
    // textEditingController.dispose();
    // focusNode.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  onRefresh() async {
    apiResValue.value = true;
    await onInit();
  }

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnEditButton() async {
    await openBottomSheet();
  }

  Future<void> openBottomSheet() async {
    leaveTypeController.text = getLeaveDetailsList?.leaveTypeName ?? '';
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
                leaveTypeTextField(),
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
                if (availableLeaveValue.value)
                  SizedBox(height: 10.px),
                fullAndHalfDayView(),
                if (fullAndHalfDayType.value != 'Full Day')
                  SizedBox(height: 10.px),
                if (fullAndHalfDayType.value != 'Full Day')
                  firstAndSecondHalfView(),
                SizedBox(height: 10.px),
                paidAndUnPaidView(),
                SizedBox(height: 20.px),
                CW.commonElevatedButton(
                    onPressed: updateButtonValue.value
                        ? () => null
                        : () => clickOnUpdateButton(),
                    buttonText: 'Update',
                    isLoading: updateButtonValue.value),
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

      updateButtonValue.value = false;
    });
  }

  Widget leaveTypeTextField() => CW.commonTextField(
    fillColor: Colors.transparent,
    controller: leaveTypeController,
    labelText: 'Leave Type',
    hintText: 'Leave Type',
    keyboardType: TextInputType.name,
    validator: (value) => V.isValid(value: value, title: 'Please select leave type'),
    onChanged: (value) {
      count.value++;
    },
    readOnly: true,
    suffixIcon: Icon(Icons.arrow_drop_down, color: Col.secondary),
  );

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

  Future<void> clickOnUpdateButton() async {
    if (key.currentState!.validate()) {
      updateButtonValue.value = true;
      bodyParamsForUpDateAndDeleteLeaveApi.clear();
      bodyParamsForUpDateAndDeleteLeaveApi = {
        AK.action: ApiEndPointAction.updateLeave,
        AK.leaveId: getLeaveId.value,
        AK.leaveDayType: fullAndHalfDayType.value == 'Full Day'
                         ? '0'
                         : '1',
        AK.leaveDayTypeSession: fullAndHalfDayType.value == 'Full Day'
                                ? '0'
                                : firstAndSecondHalfType.value == 'First Half'
                                ? '1'
                                : '2',
        AK.isPaid: paidAndUnPaidType.value == 'paidAndUnPaidType'
                   ? '0'
                   : '1',
      };
      await callingUpDateAndDeleteLeaveApi();
      Get.back();
      updateButtonValue.value = false;
    }
  }

  Future<void> clickOnDeleteButton() async {
    CD.commonIosDeleteConfirmationDialog(
      clickOnCancel: () => Get.back(),
      clickOnDelete: () async {
        bodyParamsForUpDateAndDeleteLeaveApi.clear();
        bodyParamsForUpDateAndDeleteLeaveApi = {
          AK.action: ApiEndPointAction.deleteLeave,
          AK.leaveId: getLeaveId.value,
        };
        await callingUpDateAndDeleteLeaveApi();
        Get.back();
      },
    );
  }

  Future<void> callingGetLeaveDetailApi() async {
    try{
      bodyParamsForGetLeaveDetailApi = {
        AK.action : ApiEndPointAction.getLeaveDetails,
        AK.leaveId : getLeaveId.value
      };
      getLeaveDetailModal.value = await CAI.getLeaveDetailApi(bodyParams: bodyParamsForGetLeaveDetailApi);
      if(getLeaveDetailModal.value != null){
        getLeaveDetailsList = getLeaveDetailModal.value?.getLeaveDetails;
        print('getLeaveDetailsList::::   $getLeaveDetailsList');
        await callingGetLeaveTypeBalanceApi();
      }
    }catch(e){
      CM.error();
      apiResValue.value = false;
      print('callingGetLeaveDetailApi:::::  error :::::  $e');
    }
    apiResValue.value = false;
  }

  Future<void> callingGetLeaveTypeBalanceApi() async {
    try {
      bodyParamsForGetLeaveTypeBalanceApi = {
        AK.action: ApiEndPointAction.getLeaveTypeBalance,
        AK.leaveTypeId: getLeaveDetailsList?.leaveTypeId ?? '',
        AK.leaveDate: getLeaveDetailsList?.leaveStartDate ?? '',
      };
      getLeaveTypeBalanceModal.value = await CAI.getLeaveTypeBalanceApi(bodyParams: bodyParamsForGetLeaveTypeBalanceApi);
      if (getLeaveTypeBalanceModal.value != null) {
        availableLeave.value = double.parse(getLeaveTypeBalanceModal.value?.availableLeave ?? '0.0');
        availableLeaveValue.value = true;
      }
    } catch (e) {
      CM.error();
      print('callingGetLeaveTypeBalanceApi::::   error:::  $e');
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> callingUpDateAndDeleteLeaveApi() async {
    try {
      http.Response? response = await CAI.addLeaveApi(bodyParams: bodyParamsForUpDateAndDeleteLeaveApi, filePath: image.value);
      if (response != null && response.statusCode == 200) {
        Get.back();
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
      print('callingAddLeaveApi:::  error::::  $e');
    }
  }

}
