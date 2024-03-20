import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/add_work_report/controllers/add_work_report_controller.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';

class AddWorkReportView extends GetView<AddWorkReportController> {
  const AddWorkReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            CM.unFocusKeyBoard();
            controller.quillEditorController.unFocus();
          },
          child: Scaffold(
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: Obx(() {
                    controller.count.value;
                    if (AC.isConnect.value) {
                      return ModalProgress(
                        inAsyncCall: false,
                        child:  Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Form(
                              key: controller.key,
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 12.px,vertical: 16.px),
                                children: [
                                  dateTextFormFiled(context: context),
                                  SizedBox(height: 10.px),
                                    editorView(),
                                  SizedBox(height: 10.px),
                                  if(controller.attachFileShowAndHiedValue.value)
                                    attachFile(),
                                  if(controller.attachFileShowAndHiedValue.value)
                                    SizedBox(height: 10.px),
                                  if(controller.imageFile.isNotEmpty)
                                    filesList(),
                                  if(controller.imageFile.length <= 4 && !controller.attachFileShowAndHiedValue.value)
                                    SizedBox(height: 6.px),
                                  if(controller.imageFile.length <= 4 && !controller.attachFileShowAndHiedValue.value)
                                    addMoreButtonView(),
                                ],
                              ),
                            ),
                            addButtonView(),
                          ],
                        ),
                      );
                    } else {
                      return CW.commonNoNetworkView();
                    }
                  }),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
    title: 'Add Work Report',
    onLeadingPressed: () => controller.clickOnBackButton(),
    padding: EdgeInsets.only(left: 12.px,right: 6.px,top: 12.px,bottom: 6.px),
  );

  Widget dateTextFormFiled({required BuildContext context}) => CW.commonTextField(
    labelText: 'Date',
    hintText: 'Date',
    controller: controller.dateController,
    focusNode: controller.focusNodeDate,
    validator: (value) => V.isValid(value: value, title: 'Please select date'),
    suffixIcon: SizedBox(
      height: 22.px,
      width: 22.px,
      child: Center(
        child: CW.commonNetworkImageView(
            path: 'assets/icons/working_days_icon.png',
            isAssetImage: true,
            height: 22.px,
            width: 22.px,
            color: Col.gTextColor),
      ),
    ),
    readOnly: true,
    onTap: () => controller.clickOnDateTextFormFiled(context: context),
  );

  Widget editorView() {
    return Container(
      height: 200.px,
      decoration: BoxDecoration(
        color: Col.gCardColor,
        borderRadius: BorderRadius.circular(10.px)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50.px,
              child: Center(
                child: ToolBar(
                  toolBarConfig: controller.customToolBarList,
                  toolBarColor: Col.gCardColor,
                  padding: EdgeInsets.all(6.px),
                  spacing: 8.px,
                  iconSize: 22.px,
                  iconColor: Col.gTextColor,
                  activeIconColor: Col.primary,
                  controller: controller.quillEditorController,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                ),
              ),
            ),
            CW.commonDividerView(height: 0,wight: 1.px),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  QuillHtmlEditor(
                    text: "",
                    autoFocus: controller.hasFocus.value,
                    hintText: 'Enter work report',
                    controller: controller.quillEditorController,
                    minHeight: 166.px,
                    textStyle: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                    hintTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
                    hintTextAlign: TextAlign.start,
                    padding: EdgeInsets.all(6.px),
                    hintTextPadding: EdgeInsets.only(left: 10.px),
                    backgroundColor: Col.gCardColor,
                    inputAction: InputAction.newline,
                    onEditingComplete: (s) => debugPrint('1111:::::Editing completed $s'),
                    loadingBuilder: (context) {
                      return Container(
                        height: 150.px,
                        color: Col.gCardColor,
                        child: Center(child: Text('Loading...',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Col.primary)),),
                      );
                    },
                    onFocusChanged: (focus) {
                      debugPrint('1111:::::has focus $focus');
                      controller.hasFocus.value = focus;
                    },
                    onTextChanged: (text) {
                      debugPrint('1111:::::widget text change $text');
                      controller.editorText.value = text;
                    },
                    onEditorCreated: () async {
                      debugPrint('Editor has been loaded');
                      // await controller.quillEditorController.setText('Testing text on load on editor created method');
                    },
                    onEditorResized: (height) => debugPrint('1111:::::Editor resized $height'),
                    onSelectionChanged: (sel) => debugPrint('1111:::::index ${sel.index}, range ${sel.length}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget attachFile() {
    return Center(
      child: InkWell(
        onTap: () => controller.clickOnAttachFileButton(),
        borderRadius: BorderRadius.circular(10.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(12.px),
          // padding: EdgeInsets.all(12.px),
          child: Container(
            width: double.infinity,
            height: 44.px,
            padding: EdgeInsets.all(12.px),
            decoration: BoxDecoration(
                color: Col.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.px)),
            child:  attachRowTextView(),
          ),
        ),
      ),
    );
  }

  Widget attachRowTextView() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GradientImageWidget(
          assetPath: 'assets/icons/attach_file_icon.png',
          width: 20.px,
          height: 20.px),
      SizedBox(width: 5.px),
      Text(
        'Attachment',
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
      )
    ],
  );

  Widget filesList() {
    return SizedBox(
      height: 60.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.imageFile.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 10.px),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 60.px,
                  padding: EdgeInsets.all(2.px),
                  margin: EdgeInsets.only(right: 8.px),
                  decoration: BoxDecoration(
                      color: Col.primary.withOpacity(.05),
                      borderRadius: BorderRadius.circular(4.px),
                      border: Border.all(color: Col.primary,width: .5.px)
                  ),
                  child: CM.isAssetImage(assetImagePath: controller.imageFile[index])
                      ?  Image.asset(
                    '${controller.imageFile[index]}',
                    fit: BoxFit.contain,
                    height: 60.px,
                  )
                      :  Image.file(
                    File(controller.imageFile[index]),
                    fit: BoxFit.contain,
                    height: 60.px,
                  ),
                ),
                InkWell(
                  onTap: () => controller.clickOnRemoveFileButton(index:index),
                  borderRadius: BorderRadius.circular(7.px),
                  child: Container(
                    height: 14.px,
                    width: 14.px,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Col.primary
                    ),
                    child: Center(
                      child: Icon(Icons.cancel_outlined,color: Col.inverseSecondary,size: 14.px,),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addMoreButtonView() => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CW.commonTextButton(
        onPressed: () => controller.clickOnAddMoreButton(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.add,color: Col.primary,size: 18.px),
            SizedBox(width: 2.px),
            Text(
              'Add More',
              style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 12.px, color: Col.primary),
            )
          ],
        ),
      ),
    ],
  );

  Widget addButtonView() {
    return Container(
      height: 80.px,
      padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
      color: Col.gBottom,
      child: Center(
        child: CW.myElevatedButton(
            onPressed: !controller.addButtonValue.value
                ? controller.editorText.value.isNotEmpty
                ? () => controller.clickOnAddButton()
                : () {CM.showSnackBar(message: 'Please enter work report');}
                : () => null,
            buttonText: 'Add',
            borderRadius: 10.px,
            isLoading: controller.addButtonValue.value),
      ),
    );
  }

}
