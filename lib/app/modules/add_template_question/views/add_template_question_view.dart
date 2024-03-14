import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_template_question_controller.dart';

class AddTemplateQuestionView extends GetView<AddTemplateQuestionController> {
  const AddTemplateQuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CM.unFocusKeyBoard();
        controller.quillEditorController.unFocus();
      },
      child: Scaffold(
        appBar: CW.commonAppBarView(
          title: 'Add Template Question',
          isLeading: true,
          onBackPressed: () => controller.clickOnBackButton(),
        ),
        body: Obx(() {
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
    );
  }

  Widget dateTextFormFiled({required BuildContext context}) => CW.commonTextField(
    labelText: 'Date',
    hintText: 'Date',
    controller: controller.dateController,
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
            color: Col.secondary),
      ),
    ),
    readOnly: true,
    onTap: () => controller.clickOnDateTextFormFiled(context: context),
  );

  Widget editorView() {
    return Container(
      height: 200.px,
      decoration: BoxDecoration(
          color: Col.inverseSecondary,
          border: Border.all(width: 1.px,color: Col.gray),
          borderRadius: BorderRadius.circular(10.px)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.px),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ToolBar(
              toolBarConfig: controller.customToolBarList,
              toolBarColor: Colors.grey.shade200,
              padding: EdgeInsets.all(6.px),
              spacing: 12.px,
              iconSize: 22.px,
              iconColor: Colors.black87,
              activeIconColor: Colors.greenAccent.shade400,
              controller: controller.quillEditorController,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
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
                    textStyle: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w400),
                    hintTextStyle: Theme.of(Get.context!).textTheme.bodyMedium,
                    hintTextAlign: TextAlign.start,
                    padding: EdgeInsets.all(6.px),
                    hintTextPadding: EdgeInsets.only(left: 10.px),
                    backgroundColor: Colors.white70,
                    inputAction: InputAction.newline,
                    onEditingComplete: (s) => debugPrint('1111:::::Editing completed $s'),
                    loadingBuilder: (context) {
                      return SizedBox(
                          height: 166.px,
                        child: Center(child: Text('Loading...',style: Theme.of(context).textTheme.bodyMedium),),
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
      CW.commonNetworkImageView(
          path: 'assets/icons/attach_file_icon.png',
          isAssetImage: true,
          width: 20.px,
          height: 20.px),
      SizedBox(width: 5.px),
      Text(
        'Attachment',
        style: Theme.of(Get.context!)
            .textTheme
            .titleMedium
            ?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
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
      color: Col.inverseSecondary,
      child: Center(
        child: CW.commonElevatedButton(
            onPressed: !controller.addButtonValue.value
                ? () => controller.clickOnAddButton()
                : () => null,
            buttonColor:  controller.editorText.value.isNotEmpty
                ? Col.primary
                : Col.primary.withOpacity(.6),
            buttonText: 'Add',
            borderRadius: 10.px,
            isLoading: controller.addButtonValue.value),
      ),
    );
  }

}
