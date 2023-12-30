import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import '../controllers/bank_detail_controller.dart';

class BankDetailView extends GetView<BankDetailController> {
  const BankDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CW.commonAppBarView(title: 'Bank Detail', isLeading: true, onBackPressed: () => controller.clickOnBackButton()),
      body: Obx(() {
        controller.count.value;
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
          children: [
            Card(
              color: Col.inverseSecondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px),
                  side: BorderSide(color: Col.primary, width: 1.px)),
              elevation: 0,
              margin: EdgeInsets.zero,
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
                            bankNameTextView(text: 'Bank of India'),
                            SizedBox(width: 12.px),
                            primaryContainerView()
                          ],
                        ),
                        menuButtonView()
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.px, right: 12.px, bottom: 12.px),
                    child:
                        accountNumberTextView(text: controller.aNumber.value),
                  ),
                  commonDividerView(),
                  Padding(
                    padding: EdgeInsets.only(left: 12.px),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        viewAccountDetailsTextView(),
                        downAndUpArrowButtonView()
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
                                  text2: 'Aman Rathore'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'Account Number',
                                  text2: '**** **** 1890'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'IFSC Code', text2: 'ABCD123'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'Customer ID / CRN / No',
                                  text2: 'ABCD123'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'ESIC No', text2: '12345'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'PAN Card No', text2: '1234567890'),
                              SizedBox(height: 5.px),
                              commonRowForDetailView(
                                  text1: 'PF/UAN No', text2: '1234567890'),
                            ],
                          ),
                        )
                      ],
                    ),
                    crossFadeState: controller.downAndUpValue.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 500),
                    secondCurve: Curves.easeInOutSine,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.px),
            addNewBankAccountButtonView()
          ],
        );
      }),
    );
  }

  Widget bankNameTextView({required String text}) => Text(text, style: Theme.of(Get.context!).textTheme.bodyLarge);

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

  Widget menuButtonView() => CW.commonIconButton(
      onPressed: () => controller.clickOnMenuButton(),
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

  Widget downAndUpArrowButtonView() => CW.commonIconButton(
      onPressed: () {
        controller.downAndUpValue.value = !controller.downAndUpValue.value;
      },
      isAssetImage: false,
      icon: controller.downAndUpValue.value
          ? Icons.keyboard_arrow_down
          : Icons.keyboard_arrow_up,
      color: Col.primary);

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

  Widget commonTextForDetailView({required String text, FontWeight? fontWeight, TextAlign? textAlign, double? fontSize}) => Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(
            fontWeight: fontWeight ?? FontWeight.w700, fontSize: fontSize),
        textAlign: textAlign ?? TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget addNewBankAccountButtonView() => Center(
    child: SizedBox(
      width: 276.px,
      child: CW.commonElevatedButton(
        onPressed: () => controller.clickOnAddNewBankAccountButton(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Col.inverseSecondary, size: 22.px),
            SizedBox(width: 8.px),
            Text(
              'Add New Bank Account',
              style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 14.px),
            )
          ],
        ),
      ),
    ),
  );

}
