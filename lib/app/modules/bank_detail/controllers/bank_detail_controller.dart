import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/bank_detail_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:http/http.dart' as http;
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/theme/colors/colors.dart';

class BankDetailController extends GetxController with GetTickerProviderStateMixin {
  final apiResValue = true.obs;

  final count = 0.obs;
  final downAndUpValue = [];

  late AnimationController rotationController;

  final rotationValue = false.obs;
  final getBankDetailModal = Rxn<BankDetailModal>();
  List<GetBankDetails>? getBankList;
  GetBankDetails? getBankDetailsForUpDate;

  Map<String, dynamic> bodyParamsForGetBanks = {};
  Map<String, dynamic> bodyParamsForSelectPrimaryBanks = {};
  Map<String, dynamic> bodyParamsForRemoveBanks = {};


  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    apiResValue.value = true;
    try {
      accessType.value = Get.arguments[0];
      isChangeable.value = Get.arguments[1];
      profileMenuName.value = Get.arguments[2];
      rotationController = AnimationController(duration: const Duration(milliseconds: 30000), vsync: this);
      rotationController.forward(from: 0.0); // it starts the animation
      await Future.delayed(const Duration(seconds: 1));
      rotationController.stop();
      await callingGetBankDetailApi();
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

  void clickOnMenuButton({required int index}) {
    if(accessType.value != '1' && isChangeable.value != '1') {
      CBS.commonBottomSheet(
      children: [
        Center(child: Text('Choose Action', style: Theme.of(Get.context!).textTheme.displaySmall)),
        SizedBox(height: 16.px),
        commonRowForBottomSheet(
          imagePath: 'assets/icons/edit_pen_icon.png',
          text: 'Edit',
          onTap: () => clickOnEditButton(index: index),
        ),
        if (getBankList?[index].isPrimary == '0')
          Obx(() {
            count.value;
            return SizedBox(
              height: 35.px,
              child: InkWell(
                onTap: !rotationValue.value
                    ? () => clickOnSetPrimary(index: index)
                    : () => null,
                borderRadius: BorderRadius.circular(6.px),
                child: Row(
                  children: [
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 30.0).animate(rotationController),
                      child: GradientImageWidget(
                          assetPath: 'assets/icons/sync_icon.png',
                          width: 20.px,
                          height: 20.px),
                    ),
                    SizedBox(width: 12.px),
                    Text(
                      'Set as Primary',
                      style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
                    ),
                  ],
                ),
              ),
            );
          }),
        if (getBankList?[index].isPrimary == '0')
          commonRowForBottomSheet(
            imagePath: 'assets/icons/delete_icon.png',
            text: 'Remove',
            onTap: () => clickOnRemove(index: index),
          ),
        SizedBox(height: 25.px),
      ],
    );
    }
  }

  Future<void> clickOnEditButton({required int index}) async {
    if (getBankList?[index] != null) {
      getBankDetailsForUpDate = getBankList?[index];
      Get.back();
      await Get.toNamed(Routes.ADD_BANK, arguments: ['UpDate Bank Detail', getBankDetailsForUpDate]);
      downAndUpValue.clear();
      onInit();
    } else {
      CM.error();
      Get.back();
    }
  }

  Future<void> clickOnSetPrimary({required int index}) async {
    if(getBankList?[index].bankId !=null && getBankList![index].bankId!.isNotEmpty){
      rotationValue.value = true;
      rotationController.forward(from: 0.0);
      await Future.delayed(const Duration(seconds: 2),() async {
        await callingBankRemoveOrSetPrimaryApi(apiActionType: ApiEndPointAction.primaryKeySet,bankId: getBankList?[index].bankId ?? '',index:index);
      },);
      rotationController.stop();
      rotationValue.value = false;
    }
    else{
      CM.error();
      Get.back();
    }
  }

  Future<void> clickOnRemove({required int index}) async {
    if(getBankList?[index].bankId !=null && getBankList![index].bankId!.isNotEmpty) {
      await callingBankRemoveOrSetPrimaryApi(apiActionType:ApiEndPointAction.deleteBankDetail,bankId: getBankList?[index].bankId ?? '',index:index);
    }
    else{
      CM.error();
      Get.back();
    }
  }

  Widget commonRowForBottomSheet({required String imagePath, required String text, required GestureTapCallback onTap}) => SizedBox(
        height: 35.px,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.px),
          child: Row(
            children: [
              GradientImageWidget(
                  assetPath: imagePath,
                  width: 20.px,
                  height: 20.px),
              SizedBox(width: 12.px),
              Text(text, style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary)),
            ],
          ),
        ),
      );

  void clickOnDropDownButton({required int index}) {
    if (downAndUpValue[index] != index.toString()) {
      downAndUpValue[index] = index.toString();
    } else {
      downAndUpValue[index] = '-1';
    }
    count.value++;
  }

  Future<void> clickOnAddNewBankAccountButton() async {
    await Get.toNamed(Routes.ADD_BANK, arguments: ['Add Bank']);
    downAndUpValue.clear();
    onInit();
  }

  Future<void> callingGetBankDetailApi() async {
    bodyParamsForGetBanks = {AK.action: ApiEndPointAction.getBankDetails};
    getBankDetailModal.value = await CAI.getBankDetailApi(bodyParams: bodyParamsForGetBanks);
    if (getBankDetailModal.value != null) {
      getBankList = getBankDetailModal.value?.getBankDetails;
      getBankList?.forEach((element) {
        downAndUpValue.add('-1');
      });
    }
  }

  Future<void> callingBankRemoveOrSetPrimaryApi({required String bankId,required String apiActionType, required int index}) async {
    apiResValue.value = true;
    try {
      bodyParamsForRemoveBanks = {AK.action: apiActionType, AK.bankId: bankId};
      http.Response? response = await CAI.updateUserControllerApi(bodyParams: bodyParamsForRemoveBanks);
      if (response != null) {
        if (response.statusCode == 200) {
          Get.back();
          if(apiActionType == 'deleteBankDetail') {
            getBankList?.removeAt(index);
          }
          else{
            onInit();
          }
          apiResValue.value = false;
        } else {
          CM.error();
          Get.back();
          apiResValue.value = false;
        }
      } else {
        apiResValue.value = false;
        CM.error();
        Get.back();
      }
    } catch (e) {
      apiResValue.value = false;
      CM.error();
      Get.back();
    }
  }

}
