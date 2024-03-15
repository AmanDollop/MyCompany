import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_bank_controller.dart';

class AddBankView extends GetView<AddBankController> {
  const AddBankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () =>  CM.unFocusKeyBoard(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // appBar: CW.commonAppBarView(
            //   title: controller.pageType == 'UpDate Bank Detail'
            //       ? 'Update Bank Detail'
            //       : 'Add Bank',
            //   isLeading: true,
            //   onBackPressed: () => controller.clickOnBackButton(),
            // ),
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(() {
                    controller.count.value;
                    return AC.isConnect.value
                        ? Padding(
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
                                panCardNoTextField(),
                                SizedBox(height: 20.px),
                                customerIDCRNNoTextField(),
                                SizedBox(height: 20.px),
                                esicNoTextField(),
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
                                    itemCount: controller.accountTypeText.length,
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
                            color: Col.gBottom,
                            child: Center(
                              child: CW.myElevatedButton(
                                  onPressed: () => controller.clickOnAddAccountUpdateButton(),
                                  buttonText: controller.pageType == 'UpDate Bank Detail'
                                      ? 'Update Bank Detail'
                                      : 'Add Account',
                                  isLoading: controller.addAccountButtonValue.value),
                            ),
                          )
                        ],
                      ),
                    ) : CW.commonNoNetworkView();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: controller.pageType == 'UpDate Bank Detail'
            ? 'Update Bank Detail'
            : 'Add Bank',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget accountHolderNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.accountHolderNameController,
        focusNode: controller.focusNodeForAccountHolderName,
        labelText: 'Account Holder Name',
        hintText: 'Account Holder Name',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter account holder name'),
      );

  Widget bankNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.bankNameController,
        focusNode: controller.focusNodeForBankName,
        labelText: 'Bank Name',
        hintText: 'Bank Name',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter bank name'),
      );

  Widget bankBranchNameTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.bankBranchNameController,
        focusNode: controller.focusNodeForBankBranchName,
        labelText: 'Bank Branch Name',
        hintText: 'Bank Branch Name',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter bank branch name'),
      );

  Widget accountNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.accountNoController,
        focusNode: controller.focusNodeForAccountNo,
        keyboardType: TextInputType.number,
        labelText: 'Account No.',
        hintText: 'Account No.',
        maxLength: 17,
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter account no.'),
      );

  Widget reAccountNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.reAccountNoController,
        focusNode: controller.focusNodeForReAccountNo,
        labelText: 'Re-Enter Account No.',
        hintText: 'Re-Enter Account No.',
        keyboardType: TextInputType.number,
        maxLength: 17,
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
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
        focusNode: controller.focusNodeForIfscCode,
        labelText: 'IFSC Code',
        hintText: 'IFSC Code',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        validator: (value) => V.isValid(value: value, title: 'Please enter IFSC code'),
      );

  Widget customerIDCRNNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.customerIDCRNNoController,
        focusNode: controller.focusNodeForCustomerIDCRNNo,
        labelText: 'Customer ID/CRN No',
        hintText: 'Customer ID/CRN No',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter customer ID/CRN no'),
      );

  Widget esicNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.esicNoController,
        focusNode: controller.focusNodeForEsicNo,
        labelText: 'ESIC No',
        hintText: 'ESIC No',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter ESIC no'),
      );

  Widget panCardNoTextField() {
    return CW.commonTextField(
      fillColor: Colors.transparent,
      controller: controller.panCardNoController,
      focusNode: controller.focusNodeForPanCardNo,
      labelText: 'Pan Card No',
      hintText: 'Pan Card No',
      prefixIconPath: 'assets/icons/contact_phone_icon.png',
      onChanged: (value) {
        controller.count.value++;
      },
      validator: (value) => V.isValid(value: value, title: 'Please enter pan card no.'),
    );
  }

  Widget pFUANNoTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.pFUANNoController,
        focusNode: controller.focusNodeForPFUANNo,
        labelText: 'PF/UAN No',
        hintText: 'PF/UAN No',
        prefixIconPath: 'assets/icons/contact_phone_icon.png',
        onChanged: (value) {
          controller.count.value++;
        },
        // validator: (value) => V.isValid(value: value, title: 'Please enter PF/UAN no'),
      );

  Widget accountTypeLabelTextView({required String text}) => Text(
    text,
    style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary),
  );

}

// var separator = ' - ';
// inputFormatters: [
// LengthLimitingTextInputFormatter(18 + separator.length * 4),
// CardFormatter(separator: separator),
// ],