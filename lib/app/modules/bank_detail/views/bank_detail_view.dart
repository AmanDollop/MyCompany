import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/bank_detail_controller.dart';

class BankDetailView extends GetView<BankDetailController> {
  const BankDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(
          title: controller.profileMenuName.value,
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return CW.commonRefreshIndicator(
          onRefresh: () async {
            await controller.onInit();
          },
          child: ModalProgress(
            inAsyncCall: controller.apiResValue.value,
            child: controller.getBankDetailModal.value != null
                ? controller.getBankList != null && controller.getBankList!.isNotEmpty
                    ? ListView.builder(
                      // physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.getBankList?.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Col.inverseSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.px),
                            side: BorderSide(
                                color: controller.getBankList?[index].isPrimary == '0'
                                    ? Col.gray
                                    : Col.primary,
                                width: controller.getBankList?[index].isPrimary == '0'
                                    ? .5.px
                                    : 1.5.px),
                          ),
                          elevation: 0,
                          margin: EdgeInsets.only(bottom: index==controller.getBankList!.length-1?60.px :10.px),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.px),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        bankNameTextView(text: 'Bank of India'),
                                        SizedBox(width: 12.px),
                                        if (controller.getBankList?[index].isPrimary == '1')
                                          primaryContainerView()
                                      ],
                                    ),
                                    menuButtonView(index: index)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 12.px),
                                child: accountNumberTextView(
                                    text: controller.getBankList?[index].accountNo != null &&
                                            controller.getBankList![index].accountNo!.isNotEmpty
                                        ? '${controller.getBankList?[index].accountNo}'
                                        : 'Data not found!'),
                              ),
                              commonDividerView(),
                              Padding(
                                padding: EdgeInsets.only(left: 12.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    viewAccountDetailsTextView(),
                                    downAndUpArrowButtonView(index: index)
                                  ],
                                ),
                              ),
                              AnimatedCrossFade(
                                firstChild: const SizedBox(),
                                secondChild: Column(
                                  children: [
                                    commonDividerView(),
                                    Padding(
                                      padding: EdgeInsets.all(12.px),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          commonRowForDetailView(
                                              text1:
                                                  'Account Holder Name',
                                              text2: controller.getBankList?[index].accountHoldersName != null &&
                                                      controller.getBankList![index].accountHoldersName!.isNotEmpty
                                                  ? '${controller.getBankList?[index].accountHoldersName}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1: 'Account Number',
                                              text2: controller.getBankList?[index].accountNo != null &&
                                                      controller.getBankList![index].accountNo!.isNotEmpty
                                                  ? '${controller.getBankList?[index].accountNo}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1: 'IFSC Code',
                                              text2: controller.getBankList?[index].ifscCode != null &&
                                                      controller.getBankList![index].ifscCode!.isNotEmpty
                                                  ? '${controller.getBankList?[index].ifscCode}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1:
                                                  'Customer ID / CRN / No',
                                              text2: controller.getBankList?[index].crnNo != null &&
                                                      controller.getBankList![index].crnNo!.isNotEmpty
                                                  ? '${controller.getBankList?[index].crnNo}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1: 'ESIC No',
                                              text2: controller.getBankList?[index].esicNo != null &&
                                                  controller.getBankList![index].esicNo!.isNotEmpty
                                                  ? '${controller.getBankList?[index].esicNo}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1: 'PAN Card No',
                                              text2: controller.getBankList?[index].panCardNo != null &&
                                                      controller.getBankList![index].panCardNo!.isNotEmpty
                                                  ? '${controller.getBankList?[index].panCardNo}'
                                                  : 'Data not found!'),
                                          SizedBox(height: 5.px),
                                          commonRowForDetailView(
                                              text1: 'PF/UAN No',
                                              text2: controller.getBankList?[index].pfNo != null &&
                                                      controller.getBankList![index].pfNo!.isNotEmpty
                                                  ? '${controller.getBankList?[index].pfNo}'
                                                  : 'Data not found!'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                crossFadeState:
                                    controller.downAndUpValue[index] != index.toString()
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                duration:
                                    const Duration(milliseconds: 500),
                                secondCurve: Curves.easeInOutSine,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                    : CW.commonNoDataFoundText()
                :  CW.commonNoDataFoundText(text: controller.apiResValue.value ? '':'No Data Found!'),
          ),
        );
      }),
      floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
          ? Padding(
        padding: EdgeInsets.only(bottom: 10.px),
        child: CW.commonOutlineButton(
            onPressed: () => controller.clickOnAddNewBankAccountButton(),
            child: Icon(
              Icons.add,
              color: Col.inverseSecondary,
              size: 22.px,
            ),
            height: 50.px,
            width: 50.px,
            backgroundColor: Col.primary,
            borderColor: Colors.transparent,
            borderRadius: 25.px),
      )
          : const SizedBox(),
    );
  }

  Widget bankNameTextView({required String text}) =>
      Text(text, style: Theme.of(Get.context!).textTheme.bodyLarge);

  Widget primaryContainerView() => Container(
        height: 20.px,
        width: 60.px,
        decoration: BoxDecoration(
            color: Col.success, borderRadius: BorderRadius.circular(10.px)),
        child: Center(
          child: Text('Primary',
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 10.px, fontWeight: FontWeight.w500)),
        ),
      );

  Widget menuButtonView({required int index}) => CW.commonIconButton(
      onPressed: () => controller.clickOnMenuButton(index: index),
      isAssetImage: true,
      imagePath: 'assets/icons/menu_icon.png',
      color: Col.secondary);

  Widget accountNumberTextView({required String text}) =>
      Text(text.replaceRange(0, text.length - 4, "*" * (text.length - 4)),
          style: Theme.of(Get.context!)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w500));

  Widget commonDividerView() => Center(
        child: Dash(
            direction: Axis.horizontal,
            length: 88.w,
            dashLength: 5.px,
            dashThickness: .5.px,
            dashColor: Col.secondary),
      );

  Widget viewAccountDetailsTextView() => Text('View Account Details',
      style: Theme.of(Get.context!)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w600));

  Widget downAndUpArrowButtonView({required int index}) => CW.commonIconButton(
      onPressed: () => controller.clickOnDropDownButton(index: index),
      isAssetImage: false,
      icon: controller.downAndUpValue[index] == index.toString()
          ? Icons.keyboard_arrow_down
          : Icons.keyboard_arrow_up,
      color: controller.getBankList?[index].isPrimary == '1'
          ? Col.primary
          : Col.secondary);

  Widget commonRowForDetailView({required String text1, required String text2}) =>
      Row(
        children: [
          Expanded(
            child: commonTextForDetailView(
                text: text1, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 6.px),
          commonTextForDetailView(
              text: ':', textAlign: TextAlign.center, fontSize: 18.px),
          SizedBox(width: 6.px),
          Expanded(
            child:
                commonTextForDetailView(text: text2, textAlign: TextAlign.end),
          ),
        ],
      );

  Widget commonTextForDetailView({required String text, FontWeight? fontWeight, TextAlign? textAlign, double? fontSize}) =>
      Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w700, fontSize: fontSize),
        textAlign: textAlign ?? TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

}
