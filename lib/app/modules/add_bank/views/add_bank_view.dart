import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_bank_controller.dart';

class AddBankView extends GetView<AddBankController> {
  const AddBankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CW.commonAppBarView(
          title: controller.pageType == 'UpDate Bank Detail'
              ? 'Update Bank Detail'
              : 'Add Bank',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
          controller.count.value;
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Form(
                  key: controller.key,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                    children: [
                      accountHolderNameTextField(),
                      SizedBox(height: 20.px),
                      bankNameTextField(),
                      SizedBox(height: 20.px),
                      bankBranchNameTextField(),
                      SizedBox(height: 20.px),
                      accountNoTextField(),
                      SizedBox(height: 20.px),
                      reAccountNoTextField(),
                      SizedBox(height: 20.px),
                      iFSCCodeTextField(),
                      SizedBox(height: 20.px),
                      customerIDCRNNoTextField(),
                      SizedBox(height: 20.px),
                      esicNoTextField(),
                      SizedBox(height: 20.px),
                      panCardNoTextField(),
                      SizedBox(height: 20.px),
                      pFUANNoTextField(),
                      SizedBox(height: 20.px),
                      SizedBox(
                      height: 30.px,
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CW.commonRadioView(
                                  onChanged: (value) {
                                    CM.unFocusKeyBoard();
                                    controller.accountTypeIndexValue.value = value;
                                    controller.accountType.value = controller.accountTypeText[index];
                                    controller.count.value++;
                                  },
                                  index: index.toString(),
                                  selectedIndex: controller.accountTypeIndexValue.value.toString(),
                                ),
                                accountTypeLabelTextView(text: '${controller.accountTypeText[index]} Account')
                              ],
                            );
                          },
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal),
                    ),
                      SizedBox(height: 80.px),
                    ],
                  ),
                ),
                Container(
                  height: 80.px,
                  padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                  color: Col.inverseSecondary,
                  child: Center(
                    child: CW.commonElevatedButton(
                        onPressed: () =>
                            controller.clickOnAddAccountUpdateButton(),
                        buttonText: controller.pageType == 'UpDate Bank Detail'
                            ? 'Update Bank Detail'
                            : 'Add Account',
                        isLoading: controller.addAccountButtonValue.value),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget commonIconImageForTextField({required String imagePath, double? height, double? width, Color? imageColor, bool isAssetImage = true}) => SizedBox(
        width: height ?? 24.px,
        height: width ?? 24.px,
        child: Center(
          child: CW.commonNetworkImageView(
              path: imagePath,
              isAssetImage: isAssetImage,
              color: imageColor,
              width: width ?? 24.px,
              height: height ?? 24.px),
        ),
      );

  Widget accountHolderNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.accountHolderNameController,
        labelText: 'Account Holder Name',
        hintText: 'Account Holder Name',
        prefixIcon: commonIconImageForTextField(
            imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter account holder name'),
      );

  Widget bankNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.bankNameController,
        labelText: 'Bank Name',
        hintText: 'Bank Name',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter bank name'),
      );

  Widget bankBranchNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.bankBranchNameController,
        labelText: 'Bank Branch Name',
        hintText: 'Bank Branch Name',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter bank branch name'),
      );

  Widget accountNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.accountNoController,
        keyboardType: TextInputType.number,
        labelText: 'Account No.',
        hintText: 'Account No.',
        maxLength: 17,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter account no.'),
      );

  Widget reAccountNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.reAccountNoController,
        labelText: 'Re-Enter Account No.',
        hintText: 'Re-Enter Account No.',
        keyboardType: TextInputType.number,
        maxLength: 17,
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) {
          if (value == null || value.trim().toString().isEmpty) {
            return "Please enter account no";
          } else if (controller.accountNoController.text.trim().toString() ==
              value.trim().toString()) {
            return null;
          } else {
            return "Please enter correct account no";
          }
        },
      );

  Widget iFSCCodeTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.ifscCodeController,
        labelText: 'IFSC Code',
        hintText: 'IFSC Code',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) =>
            V.isValid(value: value, title: 'Please enter IFSC code'),
      );

  Widget customerIDCRNNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.customerIDCRNNoController,
        labelText: 'Customer ID/CRN No',
        hintText: 'Customer ID/CRN No',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter customer ID/CRN no'),
      );

  Widget esicNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.esicNoController,
        labelText: 'ESIC No',
        hintText: 'ESIC No',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter ESIC no'),
      );

  Widget panCardNoTextField() {
    return CW.commonTextField(
      fillColor: Colors.transparent,
      controller: controller.panCardNoController,
      labelText: 'Pan Card No',
      hintText: 'Pan Card No',
      prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
      onChanged: (value) {
        controller.count.value++;
      },
      // validator: (value) => V.isValid(value: value, title: 'Please enter pan card no.'),
    );
  }

  Widget pFUANNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.pFUANNoController,
        labelText: 'PF/UAN No',
        hintText: 'PF/UAN No',
        prefixIcon: commonIconImageForTextField(imagePath: 'assets/icons/contact_phone_icon.png'),
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter PF/UAN no'),
      );

  Widget accountTypeLabelTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
  );

}

// var separator = ' - ';
// inputFormatters: [
// LengthLimitingTextInputFormatter(18 + separator.length * 4),
// CardFormatter(separator: separator),
// ],