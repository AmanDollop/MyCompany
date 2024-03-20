import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/bank_detail_controller.dart';

class BankDetailView extends GetView<BankDetailController> {
  const BankDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(() {
                  controller.count.value;
                  return CW.commonRefreshIndicator(
                    onRefresh: () async {
                      await controller.onInit();
                    },
                    child: AC.isConnect.value
                        ? ModalProgress(
                      inAsyncCall: controller.apiResValue.value,
                      child: controller.apiResValue.value
                          ? shimmerView()
                          : controller.getBankDetailModal.value != null
                          ? controller.getBankList != null && controller.getBankList!.isNotEmpty
                              ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.getBankList?.length,
                                padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: index==controller.getBankList!.length-1?60.px :10.px),
                                    child: CustomOutlineButton(
                                      strokeWidth: 1.px,
                                      gradient: CW.commonLinearGradientForButtonsView(),
                                      radius: 8.px,
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: controller.getBankList?[index].isPrimary == '0'
                                              ? Col.gCardColor
                                              : Col.primary.withOpacity(.2),
                                          borderRadius: BorderRadius.circular(8.px),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: controller.getBankList?[index].isPrimary == '0'
                                          //         ? Col.primary.withOpacity(.1)
                                          //         : Col.inverseSecondary,
                                          //     // blurRadius: 1,
                                          //     spreadRadius: 2 ,
                                          //     blurRadius: 4 ,
                                          //     // offset: const Offset(0, 3),
                                          //   )
                                          // ],
                                          // border: Border.all(
                                          //     color: controller.getBankList?[index].isPrimary == '0'
                                          //         ? Colors.transparent
                                          //         : Col.primary,
                                          //     width: controller.getBankList?[index].isPrimary == '0'
                                          //         ? 0.px
                                          //         : 1.px
                                          // )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 12.px),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      bankNameTextView(text: controller.getBankList?[index].bankName != null && controller.getBankList![index].bankName!.isNotEmpty
                                                          ? '${controller.getBankList?[index].bankName}'
                                                          : 'Data not found!'),
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
                                                  text: controller.getBankList?[index].accountNo != null && controller.getBankList![index].accountNo!.isNotEmpty
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        commonRowForDetailView(
                                                            text1: 'Account Holder Name',
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
                                              crossFadeState: controller.downAndUpValue[index] != index.toString()
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState.showSecond,
                                              duration:
                                                  const Duration(milliseconds: 500),
                                              secondCurve: Curves.easeInOutSine,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                           : CW.commonNoDataFoundText()
                          :  CW.commonNoDataFoundText(text: controller.apiResValue.value ? '':'No Data Found!'),
                    )
                        : CW.commonNoNetworkView(),
                  );
                }),
              ),
            ],
          ),
          floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
              ? CW.commonFloatingActionButton(icon: Icons.add, onPressed: () => controller.clickOnAddNewBankAccountButton(),)
              : const SizedBox(),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.profileMenuName.value,
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget bankNameTextView({required String text}) => Text(text, style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(color: Col.inverseSecondary));

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
      color: Col.inverseSecondary);

  Widget accountNumberTextView({required String text}) => Text(text.replaceRange(0, text.length - 4, "*" * (text.length - 4)),
          style: Theme.of(Get.context!)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
  );

  Widget commonDividerView() => Center(
        child: Dash(
            direction: Axis.horizontal,
            length: 88.w,
            dashLength: 5.px,
            dashThickness: .5.px,
            dashColor: Col.inverseSecondary),
      );

  Widget viewAccountDetailsTextView() => Text('View Account Details',
      style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600,color: Col.inverseSecondary),
  );

  Widget downAndUpArrowButtonView({required int index}) => CW.commonIconButton(
      onPressed: () => controller.clickOnDropDownButton(index: index),
      isAssetImage: false,
      icon: controller.downAndUpValue[index] == index.toString()
          ? Icons.keyboard_arrow_down
          : Icons.keyboard_arrow_up,
      color: controller.getBankList?[index].isPrimary == '1'
          ? Col.primary
          : Col.inverseSecondary);

  Widget commonRowForDetailView({required String text1, required String text2}) =>
      Row(
        children: [
          Expanded(
            child: commonTextForDetailView(text: text1, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 6.px),
          commonTextForDetailView(text: ':', textAlign: TextAlign.center, fontSize: 18.px),
          SizedBox(width: 6.px),
          Expanded(
            child: commonTextForDetailView(text: text2, textAlign: TextAlign.end),
          ),
        ],
      );

  Widget commonTextForDetailView({required String text, FontWeight? fontWeight, TextAlign? textAlign, double? fontSize, Color? color}) =>
      Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: fontWeight ?? FontWeight.w700, fontSize: fontSize,color:color ?? Col.inverseSecondary),
        textAlign: textAlign ?? TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget shimmerView()=> ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
      itemBuilder:(context, index) => Container(
        decoration: BoxDecoration(
            color: index != 0
                ? Col.gCardColor
                : Col.primary.withOpacity(.2),
            borderRadius: BorderRadius.circular(8.px),
           /* boxShadow: [
              BoxShadow(
                color:  index != 0
                    ? Col.primary.withOpacity(.1)
                    : Col.gCardColor,
                // blurRadius: 1,
                spreadRadius: 2 ,
                blurRadius: 4 ,
                // offset: const Offset(0, 3),
              )
            ],*/
            border: Border.all(
                color: Col.primary,
                width: 1.px
            )
        ),
        margin: EdgeInsets.only(bottom: 10.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.px),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CW.commonShimmerViewForImage(height: 25.px,width: 250.px),
                  CW.commonShimmerViewForImage(height: 20.px,width: 5.px)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.px),
              child: CW.commonShimmerViewForImage(height: 18.px,width: 150.px),
            ),
            commonDividerView(),
            Padding(
              padding: EdgeInsets.all(12.px),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CW.commonShimmerViewForImage(height: 25.px,width: 200.px),
                  CW.commonShimmerViewForImage(height: 20.px,width: 20.px)
                ],
              ),
            ),
          ],
        ),
      ),
  );

}
