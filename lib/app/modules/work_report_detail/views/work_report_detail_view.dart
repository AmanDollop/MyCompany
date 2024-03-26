import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_model/get_work_report_detail_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/app/modules/add_template_question/views/add_template_question_view.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/common/my_drop_down/my_drop_down.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/work_report_detail_controller.dart';

class WorkReportDetailView extends GetView<WorkReportDetailController> {
  const WorkReportDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              Expanded(
                child: Obx(
                  () {
                    controller.count.value;
                    if (AC.isConnect.value) {
                      return ModalProgress(
                        inAsyncCall: controller.apiResValue.value,
                        isLoader: true,
                        child: controller.getWorkReportDetailModal.value != null
                            ? controller.workDetails != null
                                ? controller.workDetails?.workReportType == '0'
                                ? ListView(
                                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                    children: [
                                      dateTextFormFiledForWorkReport(),
                                      SizedBox(height: 10.px),
                                      editorView(index: 0),
                                      cardView(),
                                    ],
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                    shrinkWrap: true,
                                    itemCount: controller.workDetails?.workReportQueAns?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: index == controller.workDetails!.workReportQueAns!.length - 1 ? 100.px :10.px),
                                        child: buildQuestionWidget(
                                          index: index,
                                          questionType: '${controller.workReportQueAns?[index].templateQuestions?.templateQuestionType}',
                                          questionText: controller.workDetails?.workReportQueAns?[index].templateQuestions?.templateQuestion != null && controller.workDetails!.workReportQueAns![index].templateQuestions!.templateQuestion!.isNotEmpty
                                              ?  controller.workDetails!.workReportQueAns![index].templateQuestions!.templateQuestion!.contains("?")
                                              ? '${controller.workDetails?.workReportQueAns?[index].templateQuestions?.templateQuestion}'
                                              : '${controller.workDetails?.workReportQueAns?[index].templateQuestions?.templateQuestion} ?'
                                              :  '?',
                                        ),
                                      );
                                    }
                                 )
                                : controller.apiResValue.value?const SizedBox():CW.commonNoDataFoundText()
                            : controller.apiResValue.value?const SizedBox():CW.commonNoDataFoundText(),
                      );
                    } else {
                      return CW.commonNoNetworkView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: 'Work Report Detail',
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding:
            EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  /// TODO Work Report Detail View

  Widget dateTextFormFiledForWorkReport() => CW.commonTextField(
        labelText: 'Date',
        hintText: 'Date',
        controller: controller.dateForWorkReportController,
        focusNode: controller.focusNodeDateForWorkReport,
        validator: (value) =>
            V.isValid(value: value, title: 'Please select date'),
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
      );

  Widget editorView({required int index}) {
    return Container(
      height: 200.px,
      decoration: BoxDecoration(color: Col.gCardColor, borderRadius: BorderRadius.circular(10.px)),
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
            CW.commonDividerView(height: 0, wight: 1.px),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  QuillHtmlEditor(
                    isEnabled: false,
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
                      controller.quillEditorController.onEditorLoaded(() {
                        if (controller.workDetails?.workReportType == '0') {
                          if (controller.workDetails?.workReport != null && controller.workDetails!.workReport!.isNotEmpty) {
                            controller.quillEditorController.setText(controller.workDetails?.workReport ?? '');
                          }
                        }else{
                          if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
                            controller.quillEditorController.setText(controller.workReportQueAns?[index].templateAnswer?[0] ??'?');
                          }
                        }
                      });
                      return Container(
                        height: 150.px,
                        color: Col.gCardColor,
                        child: Center(
                          child: Text('Loading...',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Col.primary)),
                        ),
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
                    onEditorResized: (height) =>
                        debugPrint('1111:::::Editor resized $height'),
                    onSelectionChanged: (sel) => debugPrint(
                        '1111:::::index ${sel.index}, range ${sel.length}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardView() => Container(
        padding: EdgeInsets.all(12.px),
        margin: EdgeInsets.only(top: 10.px),
        decoration: BoxDecoration(
          color: Col.gCardColor,
          borderRadius: BorderRadius.circular(6.px),
        ),
        child: filesList(),
      );

  Widget filesList() {
    return SizedBox(
      height: 60.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.workDetails?.workReportFile?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          print('controller.workDetails?.workReportFile::::: ${controller.workDetails?.workReportFile?[index]}');
          return Container(
            width: 60.px,
            padding: EdgeInsets.all(2.px),
            margin: EdgeInsets.only(right: 10.px),
            decoration: BoxDecoration(
              color: Col.primary.withOpacity(.05),
              borderRadius: BorderRadius.circular(4.px),
              border: Border.all(color: Col.primary, width: .5.px),
            ),
            child: imageView(index: index,forWorkReport: true,indexForQuestion: 0),
          );
        },
      ),
    );
  }

  Widget imageView({required int index,required int indexForQuestion,bool forWorkReport = false}) {
    if(forWorkReport) {
      controller.docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '${controller.workDetails?.workReportFile?[index]}'));
      return InkWell(
        onTap: () => controller.clickOnImageViewForWorkReport(index: index),
        child: CW.commonNetworkImageView(
            path: controller.docType.value == 'Image'
                ? '${AU.baseUrlAllApisImage}${controller.workDetails?.workReportFile?[index]}'
                : controller.docType.value,
            isAssetImage: controller.docType.value == 'Image' ? false : true,
            height: 40.px,
            width: 40.px),
      );
    }else{
        controller.docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '${controller.workReportQueAns?[indexForQuestion].templateAnswer?[index]}'));
        return InkWell(
          // onTap: () => controller.clickOnImageView(index: index),
          child: CW.commonNetworkImageView(
              path: controller.docType.value == 'Image'
                  ? '${AU.baseUrlAllApisImage}${controller.workReportQueAns?[indexForQuestion].templateAnswer?[index]}'
                  : controller.docType.value,
              isAssetImage: controller.docType.value == 'Image' ? false : true,
              height: 40.px,
              width: 40.px),
        );
    }
  }

  /// TODO Work Report Question Answer View

  Widget commonColumnForQuestionAndAnswer({required String questionText, required Widget answerWidget, bool isQuestionRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: questionText,
            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12.px, color: Col.inverseSecondary),
            children: [
              if (isQuestionRequired)
                TextSpan(
                    text: '  *',
                    style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700, color: Col.error)),
            ],
          ),
        ),
        SizedBox(height: 8.px),
        answerWidget
      ],
    );
  }

  Widget buildQuestionWidget({required String questionType, required String questionText, required int index}) {
    if (controller.workDetails?.workReportQueAns?[index] != null) {
      int questionNumber = index + 1;

      bool isQuestionRequiredValue = controller.workDetails?.workReportQueAns?[index].templateQuestions?.isTemplateQuestionRequired == '0'
          ? false
          : true;

      WorkReportQueAns workReportQueAns = controller.workDetails?.workReportQueAns?[index] ?? WorkReportQueAns();
      print(':::questionType::: $questionType');

      switch (questionType) {
        case '0':
          return paragraphWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '1':
          return editorWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '2':
          return radioWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index, workReportQueAns: workReportQueAns);
        case '3':
          return checkBoxWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index, workReportQueAns: workReportQueAns);
        case '4':
          if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty){
            if(controller.workReportQueAns?[index].templateAnswer?.length == 1){
              print(':::1111111111::: ${controller.workReportQueAns?[index].templateQuestions?.templateQuestionType}');
              return dropDownWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,workReportQueAns: workReportQueAns);
            }else{
              print(':::222222222::: ${controller.workReportQueAns?[index].templateQuestions?.templateQuestionType}');
              return dropDownMultipleValueWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,workReportQueAns: workReportQueAns);
            }
          }else{
            return const SizedBox();
          }
        case '5':
          /// Todo pending
          if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty){
            if(controller.workReportQueAns?[index].templateAnswer?.length == 1){
              return  filesListForSingle(questionText: questionText, index: index);
            }else{
              return filesListForMultiple(questionText: questionText, index: index);
            }
          }else{
            return const SizedBox();
          }
        case '6':
          return dateWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '7':
          return timeWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '8':
          return dateAndTimeWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '9':
          return ratingWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '10':
          return progressBarWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '11':
          return topicWithTimeWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '12':
          return paragraphWithTimeWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        case '13':
          return textWidget(questionText: 'Q.$questionNumber - $questionText', isQuestionRequired: isQuestionRequiredValue, index: index);
        default:
          // Handle other question types or return a default widget
          return const SizedBox();
      }
    } else {
      return Container(
        height: 100.px,
        width: double.infinity,
        color: Col.primary,
      );
    }
  }

  Widget paragraphWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.descriptionController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
    }
    print('$index:::::: ${controller.workReportQueAns?[index].templateAnswer?[0]}');
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonTextFieldForMultiline(
          hintText: 'Type here...',
          keyboardType: TextInputType.multiline,
          focusNode: controller.focusNodeParagraph,
          controller: controller.descriptionController,
          isSearchLabelText: false,
          readOnly: true,
          maxLines: null),
    );
  }

  Widget editorWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: editorView(index:index),
    );
  }

  Widget radioWidget({required String questionText, bool isQuestionRequired = false, required WorkReportQueAns workReportQueAns, required int index}) {
    if (workReportQueAns.templateAnswer != null && workReportQueAns.templateAnswer!.isNotEmpty) {
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: ListView.builder(
          itemCount: controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {

            if(workReportQueAns.templateAnswer!.contains(controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?[i])) {
              controller.radioIndexValue.value = i.toString();
            }

            return Row(
              children: [
                CW.commonRadioView(
                  visualDensity: VisualDensity(vertical: -4.px, horizontal: -4.px),
                  onChanged: (value) {},
                  index: i.toString(),
                  selectedIndex: controller.radioIndexValue.value.toString(),
                ),
                SizedBox(width: 10.px),
                Text(
                  controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?[i] ?? '',
                  style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: Col.inverseSecondary),
                )
              ],
            );
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget checkBoxWidget({required String questionText, bool isQuestionRequired = false, required WorkReportQueAns workReportQueAns, required int index}) {
    if (workReportQueAns.templateAnswer != null && workReportQueAns.templateAnswer!.isNotEmpty) {

      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            if(workReportQueAns.templateAnswer!.contains(controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?[i])) {
              controller.checkBoxType = controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue ?? [];
            }
            return Obx(() {
              controller.count.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 10.px),
                child: Row(
                  children: [
                    controller.checkBoxType.contains(controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?[i])
                        ? SizedBox(
                            height: 18.px,
                            width: 18.px,
                            child: CustomOutlineButton(
                              strokeWidth: 2.px,
                              radius: 4.px,
                              padding: EdgeInsets.zero,
                              gradient: CW.commonLinearGradientForButtonsView(),
                              child: Container(
                                height: 15.px,
                                width: 15.px,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.px),
                                  gradient:
                                      CW.commonLinearGradientForButtonsView(),
                                ),
                                child: Icon(Icons.check,
                                    color: Col.gBottom, size: 16.px),
                              ),
                              onPressed: () {},
                            ),
                          )
                        : InkWell(
                            onTap: () {},
                            child: Container(
                              height: 17.px,
                              width: 17.px,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Col.primary, width: 1.px),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4.px),
                              ),
                            ),
                          ),
                    SizedBox(width: 10.px),
                    Flexible(
                      child: Text(
                        controller.workReportQueAns?[index].templateQuestions?.templateQuestionValue?[i] ?? '',
                        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Col.gTextColor),
                      ),
                    )
                  ],
                ),
              );
            });
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget dropDownWidget({required String questionText, bool isQuestionRequired = false, required WorkReportQueAns workReportQueAns, required int index}) {
    if (workReportQueAns.templateAnswer != null && workReportQueAns.templateAnswer!.isNotEmpty) {
      if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
        controller.dropDownController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
      }
      print('controller.dropDownController.text::: ${controller.dropDownController.text}');
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: MyDropdown(
          items: workReportQueAns.templateAnswer ?? [],
          nameList: workReportQueAns.templateAnswer ?? [],
          selectedItem: controller.selectedDropDownValue.value,
          hintText: 'Select Itemssss',
          textEditingController: controller.dropDownController,
          isOpenValue: false,
          onTapForTextFiled: () {},
          clickOnListOfDropDown: (value) {},
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget dropDownMultipleValueWidget({required String questionText, bool isQuestionRequired = false, required WorkReportQueAns workReportQueAns, required int index}) {
    if (workReportQueAns.templateAnswer != null && workReportQueAns.templateAnswer!.isNotEmpty) {
      controller.selectedItems.clear();
      controller.selectedItems.addAll(workReportQueAns.templateAnswer ?? []);
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: MyDropdownForMultiValue<String>(
          items: workReportQueAns.templateAnswer ?? [],
          nameList: workReportQueAns.templateAnswer ?? [],
          selectedItems: controller.selectedItems,
          hintText: 'Select Item',
          isOpenValue: false,
          clickOnListOfDropDown: (List<String> values) {},
          onTapForTextFiled: () {},
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget filesListForSingle({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Container(
        width: 80.px,
        height: 80.px,
        padding: EdgeInsets.all(4.px),
        margin: EdgeInsets.only(right: 10.px),
        decoration: BoxDecoration(
          color: Col.primary.withOpacity(.05),
          borderRadius: BorderRadius.circular(4.px),
          border: Border.all(color: Col.primary, width: .5.px),
        ),
        child: imageView(indexForQuestion: index,index: 0),
      ),
    );
  }

  Widget filesListForMultiple({required String questionText,bool isQuestionRequired = false,required int index}) {
    return SizedBox(
      height: 100.px,
      child: commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.workReportQueAns?[index].templateAnswer?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Container(
                width: 60.px,
                padding: EdgeInsets.all(2.px),
                margin: EdgeInsets.only(right: 10.px),
                decoration: BoxDecoration(
                  color: Col.primary.withOpacity(.05),
                  borderRadius: BorderRadius.circular(4.px),
                  border: Border.all(color: Col.primary, width: .5.px),
                ),
                child: imageView(indexForQuestion: index,index: i),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dateTextFormFiled({required TextEditingController controller, FocusNode? focusNode, GestureTapCallback? onTap, bool isQuestionRequired = false}) => CW.commonTextField(
        hintText: 'Date',
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: true,
        isSearchLabelText: false,
      );

  Widget timeTextFormFiled({required TextEditingController controller, FocusNode? focusNode, GestureTapCallback? onTap, bool isQuestionRequired = false}) => CW.commonTextField(
        hintText: 'Time',
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: true,
        isSearchLabelText: false,
      );

  Widget dateWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.dateController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: dateTextFormFiled(
          controller: controller.dateController,
          focusNode: controller.focusNodeDate,
          isQuestionRequired: isQuestionRequired),
    );
  }

  Widget timeWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.timeController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: timeTextFormFiled(
          controller: controller.timeController,
          focusNode: controller.focusNodeTime,
          isQuestionRequired: isQuestionRequired,
      ),
    );
  }

  Widget dateAndTimeWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.dateForDateAndTimeController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
      controller.timeForDateAndTimeController.text = controller.workReportQueAns?[index].templateAnswer?[1] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Row(
        children: [
          Expanded(
            child: dateTextFormFiled(
                controller: controller.dateForDateAndTimeController,
                focusNode: controller.focusNodeDateForDateAndTime,
                isQuestionRequired: isQuestionRequired),
          ),
          SizedBox(width: 10.px),
          Expanded(
            child: timeTextFormFiled(
                controller: controller.timeForDateAndTimeController,
                focusNode: controller.focusNodeTimeForDateAndTime,
                isQuestionRequired: isQuestionRequired),
          ),
        ],
      ),
    );
  }

  Widget ratingWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonRattingBuilder(
          rating: double.parse('${controller.workReportQueAns?[index].templateAnswer?[0]}'),
          onRatingUpdate: (value) {},
          size: 20.px,
          unratedColor: Col.inverseSecondary),
    );
  }

  Widget progressBarWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Row(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: 10.px,
                margin: EdgeInsets.symmetric(horizontal: 10.px),
                decoration: BoxDecoration(
                  color: Col.primary.withOpacity(.2),
                  boxShadow: [
                    BoxShadow(
                        color: Col.gTextColor.withOpacity(.1), spreadRadius: 3)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.px),
                  child: CustomPaint(
                    painter: ProgressBarPainter(int.parse('${controller.workReportQueAns?[index].templateAnswer?[0]}')),
                  ),
                ),
              ),
            ),
          ),
          Text('${'${controller.workReportQueAns?[index].templateAnswer?[0]}'}%',
              maxLines: 1,
              style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(color: Col.primary))
        ],
      ),
    );
  }

  Widget topicWithTimeWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.topicWithTimeForTopicController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
      controller.timeForTopicController.text = controller.workReportQueAns?[index].templateAnswer?[1] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Column(
        children: [
          CW.commonTextFieldForMultiline(
            hintText: 'Type here...',
            focusNode: controller.focusNodeTopicWithTimeForTopic,
            controller: controller.topicWithTimeForTopicController,
            isSearchLabelText: false,
              readOnly: true
          ),
          SizedBox(height: 10.px),
          CW.commonTextField(
            hintText: 'Time (in minutes)',
            focusNode: controller.focusNodeTimeForTopic,
            controller: controller.timeForTopicController,
            isSearchLabelText: false,
            keyboardType: TextInputType.number,
              readOnly: true
          ),
        ],
      ),
    );
  }

  Widget paragraphWithTimeWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.descriptionWithTimeForParagraphController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
      controller.timeForParagraphController.text = controller.workReportQueAns?[index].templateAnswer?[1] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Column(
        children: [
          CW.commonTextFieldForMultiline(
            focusNode: controller.focusNodeParagraphWithTimeForParagraph,
            controller: controller.descriptionWithTimeForParagraphController,
            isSearchLabelText: false,
            hintText: 'Type here...',
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: null,
            readOnly: true
          ),
          SizedBox(height: 10.px),
          CW.commonTextField(
            hintText: 'Time (in minutes)',
            focusNode: controller.focusNodeTimeForParagraph,
            controller: controller.timeForParagraphController,
            isSearchLabelText: false,
            keyboardType: TextInputType.number,
              readOnly: true
          )
        ],
      ),
    );
  }

  Widget textWidget({required String questionText, bool isQuestionRequired = false, required int index}) {
    if(controller.workReportQueAns?[index].templateAnswer != null && controller.workReportQueAns![index].templateAnswer!.isNotEmpty) {
      controller.textController.text = controller.workReportQueAns?[index].templateAnswer?[0] ??'?';
    }
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonTextField(
        hintText: 'Type here...',
        focusNode: controller.focusNodeText,
        controller: controller.textController,
        isSearchLabelText: false,
        readOnly: true
      ),
    );
  }
}
