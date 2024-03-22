import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_document_controller.dart';

class AddDocumentView extends GetView<AddDocumentController> {
  const AddDocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => CM.unFocusKeyBoard(),
          child: Scaffold(
            // appBar: CW.commonAppBarView(
            //     title: 'Document',
            //     isLeading: true,
            //     onBackPressed: () => controller.clickOnBackButton()),
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(() {
                    controller.count.value;
                    print('imageFile::: ${controller.imageFile.value}');
                    return AC.isConnect.value
                        ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 24.px),
                      child: Form(
                        key: controller.key,
                        child: Column(
                          children: [
                            docNameTextFormFiled(),
                            SizedBox(height: 10.px),
                            remarkTextFormFiled(),
                            SizedBox(height: 10.px),
                            attachFile(),
                            const Spacer(),
                            if(controller.imageFile.value != null)
                            CW.myElevatedButton(
                              onPressed:controller.addButtonValue.value? () => null : () => controller.clickOnAddAndUpdateButton(),
                              buttonText: 'Add',
                              isLoading: controller.addButtonValue.value
                            ),
                            SizedBox(height: 20.px),
                          ],
                        ),
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
    title: 'Document',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget docNameTextFormFiled() => CW.commonTextField(
        labelText: 'Enter Document Name',
        hintText: 'Enter Document Name',
        controller: controller.docNameController,
        focusNode: controller.focusNodeForDocName,
        validator: (value) => V.isValid(value: value, title: 'Please enter doc name'),
      );

  Widget remarkTextFormFiled() => CW.commonTextFieldForMultiline(
      labelText: 'Remark',
      hintText: 'Remark',
      controller: controller.remarkController,
      focusNode: controller.focusNodeForRemark,
      maxLines: 3);

  Widget attachFile() {
    return Center(
      child: InkWell(
        onTap: () => controller.clickOnAttachFileButton(),
        borderRadius: BorderRadius.circular(12.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(10.px),
          padding: EdgeInsets.all(12.px),
          child: SizedBox(
            width: double.infinity,
            height: 100.px,
            child: controller.result.value?.paths != null && controller.result.value!.paths.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: controller.docType.value != 'Image'
                            ? CW.commonNetworkImageView(
                                path: controller.docType.value,
                                isAssetImage: true,
                                height: 88.px)
                            : Container(
                                height: 100.px,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Col.primary, width: .5.px),
                                    borderRadius: BorderRadius.circular(6.px)),
                                child: Center(
                                  child: Image.file(
                                    File('${controller.imageFile.value?.path}'),
                                    fit: BoxFit.contain,
                                    height: 88.px,
                                    width: 100.px,
                                  ),
                                ),
                              ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(6.px),
                        onTap: () => controller.clickOnRemoveFileButton(),
                        child: Ink(
                          height: 30.px,
                          width: 30.px,
                          decoration: BoxDecoration(
                              gradient: CW.commonLinearGradientForButtonsView(),
                              borderRadius: BorderRadius.circular(6.px),
                          ),
                          child: Icon(Icons.close,
                              color: Col.gBottom, size: 20.px
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientImageWidget(
                          assetPath: 'assets/icons/attach_file_icon.png',
                          // isAssetImage: true,
                          width: 24.px,
                          height: 24.px),
                      SizedBox(width: 10.px),
                      Text(
                        'Attach File',
                        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.inverseSecondary),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
