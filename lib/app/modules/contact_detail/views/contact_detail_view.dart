import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/contact_detail_controller.dart';

class ContactDetailView extends GetView<ContactDetailController> {
  const ContactDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: Obx(() {
        controller.count.value;
        return SafeArea(
          child: WillPopScope(
            onWillPop: () => controller.clickOnBackButton(),
            child: GestureDetector(
              onTap: () {
                CM.unFocusKeyBoard();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                // appBar: appBarView(),
                body: Column(
                  children: [
                    appBarView(),
                    Expanded(
                      child: Obx(() {
                        controller.count.value;
                        if (controller.apiResponseValue.value) {
                          return Center(
                            child: CW.commonProgressBarView(color: Col.primary),
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                               Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: ListView(
                                  padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 20.px),
                                  children: [
                                    AnimatedCrossFade(
                                      crossFadeState: controller.valueForEditFiled.value
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration: const Duration(milliseconds: 500),
                                      firstChild: Form(
                                        key: controller.key,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          children: [
                                            SizedBox(height: 8.px),
                                            contactTextField(),
                                            SizedBox(height: 20.px),
                                            whatsappNumberTextField(),
                                            SizedBox(height: 20.px),
                                            companyEmailTextField(),
                                            SizedBox(height: 20.px),
                                            personalEmailTextField(),
                                            SizedBox(height: 20.px),
                                            currentAddressTextField(),
                                            SizedBox(height: 10.px),
                                            if(controller.currentAddressController.text.isNotEmpty)
                                            Row(
                                              children: [
                                                checkBoxForPermanentAddressView(),
                                                SizedBox(width: 5.px),
                                                permanentAddressTextView(),
                                              ],
                                            ),
                                            SizedBox(height: 10.px),
                                            permanentAddressTextField(),
                                            SizedBox(height: 20.px),
                                          ],
                                        ),
                                      ),
                                      secondChild: ListView(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        children: [
                                          commonRowForContactDetailView(
                                              imagePath: 'assets/icons/contact_phone_icon.png',
                                              title: 'Contact',
                                              subTitle: controller.countryCode.value.isNotEmpty || controller.mobileNumber.value.isNotEmpty
                                                  ? '${controller.countryCode.value} ${controller.mobileNumber}'
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                          commonRowForContactDetailView(
                                              imagePath: 'assets/icons/contact_phone_icon.png',
                                              title: 'Whatsapp Number',
                                              subTitle: controller.countryCode.value.isNotEmpty &&
                                                      controller.whatsappController.text.isNotEmpty
                                                  ? '${controller.countryCode} ${controller.whatsappController.text}'
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                          commonRowForContactDetailView(
                                              imagePath: 'assets/icons/email_icon.png',
                                              title: 'Company Email',
                                              subTitle: controller.companyEmailController.text.isNotEmpty
                                                  ? controller.companyEmailController.text
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                          commonRowForContactDetailView(
                                              imagePath: 'assets/icons/email_icon.png',
                                              title: 'Personal Email',
                                              subTitle: controller.personalEmailController.text.isNotEmpty
                                                  ? controller.personalEmailController.text
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                          commonRowForContactDetailView(
                                              imagePath:
                                                  'assets/icons/current_location_icon.png',
                                              title: 'Current Address',
                                              subTitle: controller.currentAddressController.text.isNotEmpty
                                                  ? controller.currentAddressController.text
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                          commonRowForContactDetailView(
                                              imagePath: 'assets/icons/location_icon.png',
                                              title: 'Permanent Address',
                                              subTitle: controller.permanentAddressController.text.isNotEmpty
                                                  ? controller.permanentAddressController.text
                                                  : 'No Data Available!'),
                                          SizedBox(height: 5.px),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (controller.valueForEditFiled.value)
                                Container(
                                  height: 80.px,
                                  padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CW.myElevatedButton(
                                        onPressed: () => controller.clickOnEditUpdateButton(),
                                        buttonText: 'Save',
                                      isLoading: controller.saveButtonValue.value
                                    ),
                                  ),
                                )
                            ],
                          );
                        }
                      }),
                    ),
                  ],
                ),
                floatingActionButton: controller.accessType.value != '1' && controller.isChangeable.value != '1'
                    ? controller.valueForEditFiled.value
                    ? const SizedBox()
                    : CW.commonFloatingActionButton(icon: Icons.edit, onPressed: () => controller.clickOnEditViewButton(),)
                    : const SizedBox(),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: 'Update ${controller.profileMenuName.value}',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

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

  Widget contactTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.contactController,
        focusNode: controller.focusNodeForContact,
        labelText: 'Contact',
        hintText: 'Contact',
        readOnly: true,
        maxLength: 10,
        suffixIcon: Icon(Icons.lock, color: Col.gray, size: 20.px),
        selectedCountryCode: controller.countryCode.value,
        countryFlagPath: controller.countryImagePath.value,
        clickOnArrowDown: () => controller.clickOnCountryCode(),
        prefixIconPath:  'assets/icons/email_icon.png',
        isCountrySelection: true,
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget whatsappNumberTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.whatsappController,
        focusNode: controller.focusNodeForWhatsapp,
        keyboardType: TextInputType.number,
        labelText: 'Whatsapp Number',
        hintText: 'Whatsapp Number',
        maxLength: 10,
        validator: (value) => V.isValid(value: value, title: 'Please enter whatsapp number'),
        isCountrySelection: true,
        selectedCountryCode: controller.countryCode.value,
        countryFlagPath: controller.countryImagePath.value,
         prefixIconPath:  'assets/icons/email_icon.png',
        clickOnArrowDown: () => controller.clickOnCountryCode(),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget companyEmailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.companyEmailController,
        focusNode: controller.focusNodeForCompanyEmail,
        labelText: 'Company Email',
        hintText: 'Company Email',
        readOnly: true,
        suffixIcon: Icon(Icons.lock, color: Col.gray, size: 20.px),
        keyboardType: TextInputType.emailAddress,
       textCapitalization: TextCapitalization.none,
        prefixIconPath:  'assets/icons/email_icon.png',
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget personalEmailTextField() => CW.commonTextField(
        fillColor: Colors.transparent,
        controller: controller.personalEmailController,
        focusNode: controller.focusNodeForPersonalEmail,
        labelText: 'Personal Email',
        hintText: 'Personal Email',
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        prefixIconPath: 'assets/icons/email_icon.png',
        validator: (value) => V.isEmailValid(value: value),
        onChanged: (value) {
          controller.count.value++;
        },
      );

  Widget locationIconView() => Icon(
        Icons.my_location_rounded,
        size: 18.px,
        color: Col.inverseSecondary,
      );

  Widget currentAddressTextField() => CW.commonTextFieldForMultiline(
        fillColor: Colors.transparent,
        controller: controller.currentAddressController,
        focusNode: controller.focusNodeForCurrentAddress,
        labelText: 'Current Address',
        hintText: 'Current Address',
        prefixIconPath:  'assets/icons/current_location_icon.png',
        validator: (value) => V.isValid(value: value, title: 'Please enter current address'),
        onChanged: (value) {
          controller.count.value++;
        },
        suffixIcon: SizedBox(
          width: 40.px,
          child: Center(
            child: InkWell(
              onTap: controller.isUseMyLocationButtonClickedForCurrent.value
                  ? () => null
                  : () => controller.clickOnMyLocationCurrentAddressIconButton(),
              child: controller.isUseMyLocationButtonClickedForCurrent.value
                  ? SizedBox(width: 16.px,height: 16.px,child: Center(child: CW.commonProgressBarView(color: Col.primary),),)
                  : locationIconView(),
            ),
          ),
        ),
      );

  Widget checkBoxForPermanentAddressView() => SizedBox(
    width: 24.px,
    height: 24.px,
    child: CW.commonCheckBoxView(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.px)),
      changeValue: controller.permanentAddressCheckBoxValue.value,
      onChanged: (value) {
        controller.permanentAddressCheckBoxValue.value = value ?? false;
        if(controller.permanentAddressCheckBoxValue.value){
          controller.permanentAddressController.text = controller.currentAddressController.text;
        }else{
          controller.permanentAddressController.clear();
        }
      },
    ),
  );

  Widget permanentAddressTextView() => Text('Permanent address same as above',style: Theme.of(Get.context!).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500,color: Col.inverseSecondary));

  Widget permanentAddressTextField() => CW.commonTextFieldForMultiline(
        fillColor: Colors.transparent,
        controller: controller.permanentAddressController,
        focusNode: controller.focusNodeForPermanentAddress,
        labelText: 'Permanent Address',
        hintText: 'Permanent Address',
        prefixIconPath: 'assets/icons/location_icon.png',
        validator: (value) => V.isValid(value: value, title: 'Please enter permanent address'),
        onChanged: (value) {
          controller.count.value++;
        },
        suffixIcon: SizedBox(
      width: 40.px,
      child: Center(
        child: InkWell(
          onTap: controller.isUseMyLocationButtonClickedForPermanentAddress.value
              ? () => null
              : () => controller.clickOnMyLocationPermanentAddressIconButton(),
          child: controller.isUseMyLocationButtonClickedForPermanentAddress.value
              ? SizedBox(width: 16.px,height: 16.px,child: Center(child: CW.commonProgressBarView(color: Col.primary),),)
              : locationIconView(),
        ),
      ),
    ),
      );

  Widget commonRowForContactDetailView({required String imagePath, required String title, required String subTitle}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonIconImageForTextField(imagePath: imagePath, imageColor: Col.primary),
            SizedBox(width: 10.px),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonTitleTextView(
                      title: title,
                      textAlign: TextAlign.start,
                      color: Col.gray,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: 6.px),
                  if (subTitle.isNotEmpty)
                    commonTitleTextView(title: subTitle, textAlign: TextAlign.start, maxLines: 3,color: Col.inverseSecondary),
                ],
              ),
            ),
          ],
        ),
        if (subTitle.isNotEmpty) SizedBox(height: 4.px),
        CW.commonDividerView(leftPadding: 20.px),
        SizedBox(height: 10.px),
      ],
    );
  }

  Widget commonTitleTextView({required String title, TextAlign? textAlign, int? maxLines, Color? color, FontWeight? fontWeight}) =>
      Text(
        title,
        style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 14.px, color: color, fontWeight: fontWeight),
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
      );
}
