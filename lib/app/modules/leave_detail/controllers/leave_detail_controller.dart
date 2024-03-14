import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_detail_modal.dart';
import 'package:task/api/api_model/get_leave_type_balance_modal.dart';
import 'package:task/api/api_model/get_leave_type_modal.dart';
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
  final availableLeave = 0.obs;
  final availableLeaveValue = false.obs;
  Map<String, dynamic> bodyParamsForGetLeaveTypeBalanceApi = {};

  final paidAndUnPaidText = ['Paid', 'UnPaid'];
  final paidAndUnPaidIndexValue = '1'.obs;
  final paidAndUnPaidType = 'UnPaid'.obs;

  final updateButtonValue = false.obs;

  final isDelete = false.obs;
  final isUpDate = false.obs;

  final apiResValue = true.obs;

  final getLeaveDetailModal = Rxn<GetLeaveDetailModal>();
  LeaveDetails? getLeaveDetails;
  Map<String, dynamic> bodyParamsForGetLeaveDetailApi = {};

  Map<String, dynamic> bodyParamsForUpDateAndDeleteLeaveApi = {};

  // final TextEditingController textEditingController = TextEditingController();
  // late final FocusNode focusNode;

  final getLeaveTypeModal = Rxn<GetLeaveTypeModal>();
  List<LeaveType>? leaveTypeList;
  Map<String, dynamic> bodyParamsForGetLeaveTypeApi = {};
  final currentMonth = DateTime.now().obs;
  final leaveTypeListClickValue = false.obs;
  final leaveTypeIdFromApi = ''.obs;

  @override
  Future<void> onInit() async {
    // textEditingController.addListener(() => count.value++);
    // focusNode = FocusNode();
    super.onInit();
    getLeaveId.value = Get.arguments[0];
    await callingGetLeaveDetailApi();
    await callingGetLeaveTypeApi();
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
    leaveTypeController.text = getLeaveDetails?.leaveTypeName ?? '';
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
                    availableLeave.value == 0
                        ? 'Paid leaves not available : ${availableLeave.value}'
                        : 'Available paid leaves : ${availableLeave.value}',
                    style:
                    Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                      fontSize: 10.px,
                    ),
                  ),
                if (availableLeaveValue.value)
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
    onTap: () => clickOnLeaveTypeField(),
    readOnly: true,
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
                      color: leaveTypeController.text ==
                          leaveTypeList?[i].leaveTypeName
                          ? Col.primary.withOpacity(.08)
                          : Colors.transparent,
                      border: Border.all(
                        color: leaveTypeController.text ==
                            leaveTypeList?[i].leaveTypeName
                            ? Col.primary
                            : Col.darkGray,
                        width: leaveTypeController.text ==
                            leaveTypeList?[i].leaveTypeName
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

  Widget paidAndUnPaidView() => commonContainerView(
    child: ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      itemBuilder: (context, index) {
        if (availableLeave.value == 0) {
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
                  if (value != null && availableLeave.value != 0) {
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
        AK.leaveTypeId: leaveTypeIdFromApi.value,
        AK.isPaid: paidAndUnPaidType.value == 'UnPaid'
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
        getLeaveDetails = getLeaveDetailModal.value?.leaveDetails;
        isDelete.value = getLeaveDetailModal.value?.leaveDetails?.isDelete?? false;
        isUpDate.value = getLeaveDetailModal.value?.leaveDetails?.isEdit ?? false;
      }
    }catch(e){
      CM.error();
      apiResValue.value = false;
      print('callingGetLeaveDetailApi:::::  error :::::  $e');
    }
    apiResValue.value = false;
  }

  Future<void> callingGetLeaveTypeApi() async {
    try {
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
  }

  Future<void> callingGetLeaveTypeBalanceApi() async {
    try {
      bodyParamsForGetLeaveTypeBalanceApi = {
        AK.action: ApiEndPointAction.getLeaveTypeBalance,
        AK.leaveTypeId: leaveTypeIdFromApi.value,
        AK.leaveDate: getLeaveDetails?.leaveStartDate ?? '',
      };
      getLeaveTypeBalanceModal.value = await CAI.getLeaveTypeBalanceApi(bodyParams: bodyParamsForGetLeaveTypeBalanceApi);
      if (getLeaveTypeBalanceModal.value != null) {
        availableLeave.value = int.parse(getLeaveTypeBalanceModal.value?.availableLeave ?? '0');
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
