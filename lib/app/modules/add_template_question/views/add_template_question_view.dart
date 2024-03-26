import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_model/get_template_question_modal.dart';
import 'package:task/app/app_controller/ac.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/common/custom_outline_button.dart';
import 'package:task/common/gradient_image_convert.dart';
import 'package:task/common/model_proress_bar/model_progress_bar.dart';
import 'package:task/common/my_drop_down/my_drop_down.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:task/validator/v.dart';
import '../controllers/add_template_question_controller.dart';

class AddTemplateQuestionView extends GetView<AddTemplateQuestionController> {
  const AddTemplateQuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CW.commonScaffoldBackgroundColor(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            CM.unFocusKeyBoard();
            controller.isDropDownOpenValue.value = false;
            controller.isMultipleSelectDropDownOpenValue.value = false;
            controller.quillEditorController.unFocus();
            controller.count.value++;
          },
          child: Scaffold(body: Obx(() {
            controller.count.value;
            if (AC.isConnect.value) {

              return ModalProgress(
                inAsyncCall: controller.apiResValue.value,
                isLoader: true,
                child: Stack(
                   alignment: Alignment.bottomCenter,
                   children: [
                    Column(
                      children: [
                        appBarView(),
                        // Html(data: htmlContent)
                        if(!controller.apiResValue.value)
                        Expanded(
                          child: controller.getTemplateQuestionModal.value != null
                              ? controller.templateQuestionList != null && controller.templateQuestionList!.isNotEmpty
                                  ? Form(
                                    key: controller.key,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
                                      shrinkWrap: true,
                                      itemCount: controller.templateQuestionList?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: index == controller.templateQuestionList!.length - 1 ? 100.px :10.px),
                                          child: buildQuestionWidget(
                                              index: index,
                                              questionType: '${controller.templateQuestionList?[index].templateQuestionType}',
                                              questionText: controller.templateQuestionList?[index].templateQuestion != null && controller.templateQuestionList![index].templateQuestion!.isNotEmpty
                                                  ?  controller.templateQuestionList![index].templateQuestion!.contains("?")
                                                  ? '${controller.templateQuestionList?[index].templateQuestion}'
                                                  : '${controller.templateQuestionList?[index].templateQuestion} ?'
                                                  :  '?',
                                          ),
                                        );
                                      }
                                     ),
                                  )
                                  : CW.commonNoDataFoundText()
                              : CW.commonNoDataFoundText(),
                        ),
                      ],
                    ),
                    submitButtonView()
                  ],
                ),
              );
            } else {
              return CW.commonNoNetworkView();
            }
          })),
        ),
      ),
    );
  }

  Widget appBarView() => CW.myAppBarView(
        title: 'Add Template Question',
        onLeadingPressed: () => controller.clickOnBackButton(),
        padding: EdgeInsets.only(left: 12.px, right: 6.px, top: 12.px, bottom: 6.px),
      );

  Widget commonColumnForQuestionAndAnswer({required String questionText,required Widget answerWidget,bool isQuestionRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(
          text: questionText,
          style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12.px,color: Col.inverseSecondary),
          children: [
            if(isQuestionRequired)
            TextSpan(
              text: '  *', style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700,color: Col.error)
            ),
          ],
         ),
        ),
        SizedBox(height: 8.px),
        answerWidget
      ],
    );
  }

  // 0-Paragraph ,
  // 1-Editor,
  // 2-Radio Button,
  // 3-Checkbox,
  // 4-Dropdown,
  // 5-File Upload,
  // 6-Date,
  // 7-Time,
  // 8-Date and Time,
  // 9-Rating,
  // 10-Progress Bar,
  // 11-Topic With Time,
  // 12-Paragraph With Time,
  // 13-Text

  Widget buildQuestionWidget({required String questionType,required String questionText,required int index}) {
    if(controller.templateQuestionList?[index] != null){

      int questionNumber = index+1;

      bool isQuestionRequiredValue = controller.templateQuestionList?[index].isTemplateQuestionRequired == '0' ? false : true;

      TemplateQuestion templateQuestionList = controller.templateQuestionList?[index] ?? TemplateQuestion();
      switch (questionType) {
        case '0':
          return paragraphWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '1':
          return editorWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '2':
          return radioWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,templateQuestionList: templateQuestionList);
        case '3':
          return checkBoxWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,templateQuestionList: templateQuestionList);
        case '4':
          if(controller.templateQuestionList?[index].templateQuestionDropdownType == '0'){
            return dropDownWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,templateQuestionList: templateQuestionList);
          }else{
            return dropDownMultipleValueWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,templateQuestionList: templateQuestionList);
          }
        case '5': /// Todo pending
          if(controller.templateQuestionList?[index].templateQuestionUploadType == '0'){
            return fileUploadForBothWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,);
          }else{
            return fileUploadForOnlyCameraWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index,);
          }
        case '6':
          return dateWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '7':
          return timeWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '8':
          return dateAndTimeWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '9':
          return ratingWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '10':
          return progressBarWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '11':
          return topicWithTimeWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '12':
          return paragraphWithTimeWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        case '13':
          return textWidget(questionText: 'Q.$questionNumber - $questionText',isQuestionRequired : isQuestionRequiredValue,index:index);
        default:
        // Handle other question types or return a default widget
          return const SizedBox();
      }
    }else{
      return Container(
        height: 100.px,
        width: double.infinity,
        color: Col.primary,
      );
    }
  }

  Widget paragraphWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonTextFieldForMultiline(
          hintText: 'Type here...',
          keyboardType: TextInputType.multiline,
          focusNode: controller.focusNodeParagraph,
          controller: controller.descriptionController,
          isSearchLabelText: false,
          onChanged: (value) {
            if(value.isNotEmpty) {
              controller.localDataList[index].answer = controller.descriptionController.text.trim().toString();
            }
            controller.count.value++;
          },
          validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
          minLines: 5,
          maxLines: null),
    );
  }

  Widget editorWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: editorView(index: index),
    );
  }

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
                    text: "",
                    autoFocus: controller.hasFocus.value,
                    hintText: 'Type here...',
                    controller: controller.quillEditorController,
                    minHeight: 150.px,
                    textStyle: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(color: Col.inverseSecondary),
                    hintTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
                    hintTextAlign: TextAlign.start,
                    padding: EdgeInsets.all(6.px),
                    hintTextPadding: EdgeInsets.only(left: 10.px),
                    backgroundColor: Col.gCardColor,
                    inputAction: InputAction.newline,
                    loadingBuilder: (context) {
                      controller.quillEditorController.onEditorLoaded(() {
                        if(controller.localDataList[index].answer != null && controller.localDataList[index].answer!.isNotEmpty){
                          controller.quillEditorController.setText('${controller.localDataList[index].answer}');
                        }
                        debugPrint('Editor has been loaded::::::  ${controller.localDataList[index].answer}');
                      });
                      return Container(
                        height: 150.px,
                        color: Col.gCardColor,
                        child: Center(
                          child: Text('Loading...',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Col.primary),
                          ),
                        ),
                      );
                    },
                    onTextChanged: (text) {
                      debugPrint('1111:::::widget text change $text');
                      if(text.isNotEmpty) {
                        controller.localDataList[index].answer = text;
                      }
                      print('controller.localDataList:::: ${controller.localDataList[index].answer}');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioWidget({required String questionText,bool isQuestionRequired = false,required TemplateQuestion templateQuestionList,required int index}) {
    if(templateQuestionList.templateQuestionValue != null && templateQuestionList.templateQuestionValue!.isNotEmpty) {
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: ListView.builder(
          itemCount: templateQuestionList.templateQuestionValue?.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return Row(
              children: [
                CW.commonRadioView(
                  visualDensity: VisualDensity(vertical: -4.px, horizontal: -4.px),
                  onChanged: (value) {
                    CM.unFocusKeyBoard();
                    controller.radioIndexValue.value = value;
                    controller.radioType.value = templateQuestionList.templateQuestionValue?[i] ?? '';
                    if(value.isNotEmpty) {
                      controller.localDataList[index].answer = controller.radioType.value.toString();
                    }
                    controller.count.value++;
                  },
                  index: i.toString(),
                  selectedIndex: controller.radioIndexValue.value.toString(),
                ),
                SizedBox(width: 10.px),
                Text(
                  templateQuestionList.templateQuestionValue?[i] ?? '',
                  style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: Col.inverseSecondary),
                )
              ],
            );
          },
        ),
      );
    }else{
      return const SizedBox();
    }
  }

  Widget checkBoxWidget({required String questionText,bool isQuestionRequired = false,required TemplateQuestion templateQuestionList,required int index}) {
    if(templateQuestionList.templateQuestionValue != null && templateQuestionList.templateQuestionValue!.isNotEmpty){
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: templateQuestionList.templateQuestionValue?.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return Obx(() {
              controller.count.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 10.px),
                child: Row(
                  children: [
                     controller.checkBoxType.contains(templateQuestionList.templateQuestionValue?[i])
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
                             onPressed: () {
                               controller.checkBoxType.remove(templateQuestionList.templateQuestionValue?[i]);
                               controller.localDataList[index].answer = controller.checkBoxType.join('~~~');
                               controller.count.value++;
                             },
                           ),
                          )
                        : InkWell(
                          onTap: () {
                            if(controller.checkBoxType.contains(templateQuestionList.templateQuestionValue?[i])) {

                            }else{
                              controller.checkBoxType.add(templateQuestionList.templateQuestionValue?[i] ?? '');
                            }
                              controller.localDataList[index].answer = controller.checkBoxType.join('~~~');
                               print('controller.checkBoxType::  ${controller.checkBoxType}');
                              controller.count.value++;
                          },
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
                        templateQuestionList.templateQuestionValue?[i] ?? '',
                        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: Col.gTextColor),
                      ),
                    )
                  ],
                ),
              );
            });
          },
        ),
      );
    }else{
      return const SizedBox();
    }
  }

  Widget dropDownWidget({required String questionText,bool isQuestionRequired = false,required TemplateQuestion templateQuestionList,required int index}) {
    if(templateQuestionList.templateQuestionValue != null && templateQuestionList.templateQuestionValue!.isNotEmpty){
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: MyDropdown(
          items: templateQuestionList.templateQuestionValue ?? [],
          nameList: templateQuestionList.templateQuestionValue ?? [],
          selectedItem: controller.selectedDropDownValue.value,
          hintText: 'Select Item',
          textEditingController: controller.dropDownController,
          isOpenValue: controller.isDropDownOpenValue.value,
          onTapForTextFiled: () {
            controller.isDropDownOpenValue.value = !controller.isDropDownOpenValue.value;
            controller.count.value++;
          },
          clickOnListOfDropDown: (value) {
            CM.unFocusKeyBoard();
            controller.isDropDownOpenValue.value = false;
            controller.selectedDropDownValue.value = value ?? '';
            controller.dropDownController.text = value ?? '';
            if(value.isNotEmpty) {

              controller.localDataList[index].answer = controller.dropDownController.text.trim().toString();
            }
            // controller.dropDownList.remove(value);
            // controller.dropDownList.insert(0, value ?? '');
            controller.count.value++;
          },
          validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
        ),
      );
    }else{
      return const SizedBox();
    }
  }

  Widget dropDownMultipleValueWidget({required String questionText,bool isQuestionRequired = false,required TemplateQuestion templateQuestionList,required int index}) {
    if(templateQuestionList.templateQuestionValue != null && templateQuestionList.templateQuestionValue!.isNotEmpty){
      return commonColumnForQuestionAndAnswer(
        questionText: questionText,
        isQuestionRequired: isQuestionRequired,
        answerWidget: MyDropdownForMultiValue<String>(
          items: templateQuestionList.templateQuestionValue ?? [],
          nameList: templateQuestionList.templateQuestionValue ?? [],
          selectedItems: controller.selectedItems,
          hintText: 'Select Items',
          isOpenValue: controller.isMultipleSelectDropDownOpenValue.value,
          clickOnListOfDropDown: (List<String> values) {
            controller.selectedItems = values;
            if(values.isNotEmpty) {
              controller.localDataList[index].answer = values.join('~~~').toString();
            }
            controller.count.value++;
          },
          onTapForTextFiled: () {
            controller.isMultipleSelectDropDownOpenValue.value =
            !controller.isMultipleSelectDropDownOpenValue.value;
            controller.count.value++;
          },
        ),
      );
    }else{
      return const SizedBox();
    }
  }

  Widget dateTextFormFiled({required TextEditingController controller, FocusNode? focusNode, GestureTapCallback? onTap,bool isQuestionRequired = false,ValueChanged<String>? onChanged}) => CW.commonTextField(
        hintText: 'Date',
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: true,
         validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
        isSearchLabelText: false,
      );

  Widget timeTextFormFiled({required TextEditingController controller, FocusNode? focusNode, GestureTapCallback? onTap,bool isQuestionRequired = false,ValueChanged<String>? onChanged}) => CW.commonTextField(
        hintText: 'Time',
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: true,
        validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
        isSearchLabelText: false,
      );

  Widget dateWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    controller.dateController.addListener(() {
      if(controller.dateController.text.isNotEmpty) {
        controller.localDataList[index].answer = controller.dateController.text.trim().toString();
      }
    });
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: dateTextFormFiled(
          controller: controller.dateController,
          focusNode: controller.focusNodeDate,
          onTap: () => controller.clickOnDateTextField(),
          isQuestionRequired: isQuestionRequired
      ),
    );
  }

  Widget timeWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    controller.timeController.addListener(() {
      if(controller.timeController.text.isNotEmpty) {
        controller.localDataList[index].answer = controller.timeController.text.trim().toString();
      }
    });
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: timeTextFormFiled(
          controller: controller.timeController,
          focusNode: controller.focusNodeTime,
          onTap: () => controller.clickOnTimeTextField(),
        isQuestionRequired: isQuestionRequired
      ),
    );
  }

  Widget dateAndTimeWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    controller.dateForDateAndTimeController.addListener(() {controller.onValueChangedForDateWithTime(index:index);});
    controller.timeForDateAndTimeController.addListener(() {controller.onValueChangedForDateWithTime(index: index);});
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Row(
        children: [
          Expanded(
            child: dateTextFormFiled(
                controller: controller.dateForDateAndTimeController,
                focusNode: controller.focusNodeDateForDateAndTime,
                onTap: () => controller.clickOnDateForDateAndTimeTextField(),
                isQuestionRequired: isQuestionRequired
            ),
          ),
          SizedBox(width: 10.px),
          Expanded(
            child: timeTextFormFiled(
                controller: controller.timeForDateAndTimeController,
                focusNode: controller.focusNodeTimeForDateAndTime,
                onTap: () => controller.clickOnTimeForDateAndTimeTextField(),
                isQuestionRequired: isQuestionRequired
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonRattingBuilder(
          rating: 1,
          onRatingUpdate: (value) {
            if(value != 0.0) {
              controller.localDataList[index].answer = value.toString();
            }
          },
          size: 20.px,
          unratedColor: Col.inverseSecondary),
    );
  }

  Widget progressBarWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                double dx = details.localPosition.dx;
                double screenWidth = MediaQuery.of(Get.context!).size.width;
                double swipeProgress = (dx / screenWidth * 100).clamp(0.0, 100.0);
                controller.progress.value = swipeProgress.clamp(0, 100).toInt();
                controller.count.value++;
                if(controller.progress.value != 0) {
                  controller.localDataList[index].answer = controller.progress.value.toString();
                }
              },
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 10.px,
                  margin: EdgeInsets.symmetric(horizontal: 10.px),
                  decoration: BoxDecoration(
                    color: Col.primary.withOpacity(.2),
                    boxShadow: [
                      BoxShadow(color: Col.gTextColor.withOpacity(.1), spreadRadius: 3)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.px),
                    child: CustomPaint(
                      painter: ProgressBarPainter(controller.progress.value),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text('${controller.progress.value.toInt()}%',
              maxLines: 1,
              style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(color: Col.primary))
        ],
      ),
    );
  }

  Widget topicWithTimeWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    controller.topicWithTimeForTopicController.addListener(() {controller.onValueChangedForTopicWithTime(index:index);});
    controller.timeForTopicController.addListener(() {controller.onValueChangedForTopicWithTime(index: index);});
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
            validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
          ),
          SizedBox(height: 10.px),
          CW.commonTextField(
              hintText: 'Time (in minutes)',
              focusNode: controller.focusNodeTimeForTopic,
              controller: controller.timeForTopicController,
              isSearchLabelText: false,
              keyboardType: TextInputType.number,
             validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
          ),
        ],
      ),
    );
  }

  Widget paragraphWithTimeWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    controller.descriptionWithTimeForParagraphController.addListener(() {controller.onValueChangedForParagraphWithTime(index: index);});
    controller.timeForParagraphController.addListener(() {controller.onValueChangedForParagraphWithTime(index: index);});
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
             validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
          ),
          SizedBox(height: 10.px),
          CW.commonTextField(
              hintText: 'Time (in minutes)',
              focusNode: controller.focusNodeTimeForParagraph,
              controller: controller.timeForParagraphController,
              isSearchLabelText: false,
              keyboardType: TextInputType.number,
              validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
          )
        ],
      ),
    );
  }

  Widget textWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: CW.commonTextField(
        hintText: 'Type here...',
        focusNode: controller.focusNodeText,
        controller: controller.textController,
        isSearchLabelText: false,
        onChanged: (value) {
          if(value.isNotEmpty) {
            controller.localDataList[index].answer = controller.textController.text.trim().toString();
          }
          controller.count.value++;
        },
        validator: isQuestionRequired ? (value) => V.isValid(value: value, title: 'These filed is required') : null,
      ),
    );
  }

  Widget fileUploadForOnlyCameraWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.imageFileFormCamera.length < int.parse(controller.templateQuestionList?[index].templateQuestionMultipleFileLimit ?? '0'))
            attachFile(index: index),
          if (controller.imageFileFormCamera.isNotEmpty)
            SizedBox(height: 10.px),
          if (controller.imageFileFormCamera.isNotEmpty)
             filesList(index: index),
        ],
      ),
    );
  }

  Widget fileUploadForBothWidget({required String questionText,bool isQuestionRequired = false,required int index}) {
    return commonColumnForQuestionAndAnswer(
      questionText: questionText,
      isQuestionRequired: isQuestionRequired,
      answerWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.imageFile.length < int.parse(controller.templateQuestionList?[index].templateQuestionMultipleFileLimit ?? '0') && controller.attachFileShowAndHiedValue.value)
            attachFile(index: index),
          if (controller.imageFile.isNotEmpty)
            SizedBox(height: 10.px),
          if (controller.imageFile.isNotEmpty)
            filesList(index: index),
          if (controller.imageFile.length < int.parse(controller.templateQuestionList?[index].templateQuestionMultipleFileLimit ?? '0') && !controller.attachFileShowAndHiedValue.value)
            SizedBox(height: 6.px),
          if (controller.imageFile.length < int.parse(controller.templateQuestionList?[index].templateQuestionMultipleFileLimit ?? '0') && !controller.attachFileShowAndHiedValue.value)
            addMoreButtonView(),
        ],
      ),
    );
  }

  Widget attachFile({required int index}) {
    return Center(
      child: InkWell(
        onTap: controller.templateQuestionList?[index].templateQuestionUploadType == '0'
        ? () => controller.clickOnAttachFileForBothOptionButton(indexForLocalData:index)
        : () => controller.clickOnAttachFileOnlyCameraButton(indexForLocalData:index),
        borderRadius: BorderRadius.circular(10.px),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Col.primary.withOpacity(.5),
          radius: Radius.circular(12.px),
          child: Container(
            width: double.infinity,
            height: 44.px,
            padding: EdgeInsets.all(12.px),
            decoration: BoxDecoration(color: Col.primary.withOpacity(.1), borderRadius: BorderRadius.circular(10.px)),
            child: attachRowTextView(templateQuestionUploadType:  '${controller.templateQuestionList?[index].templateQuestionUploadType}'),
          ),
        ),
      ),
    );
  }

  Widget attachRowTextView({required String templateQuestionUploadType}) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      templateQuestionUploadType == '0'
          ? GradientImageWidget(assetPath: 'assets/icons/attach_file_icon.png', width: 20.px, height: 20.px)
          : Icon(Icons.camera_alt,size: 20.px,color: Col.primary),
      SizedBox(width: 5.px),
      Text(
        'Attachment',
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(color: Col.primary, fontWeight: FontWeight.w600),
      )
    ],
  );

  Widget filesList({required int index}) {
    return SizedBox(
      height: 60.px,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.templateQuestionList?[index].templateQuestionUploadType == '0'
            ? controller.imageFile.length
            : controller.imageFileFormCamera.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
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
                      border: Border.all(color: Col.primary, width: .5.px)),
                  child: controller.templateQuestionList?[index].templateQuestionUploadType == '1'
                      ? Image.file(
                        controller.imageFileFormCamera[i],
                        fit: BoxFit.contain,
                        height: 60.px,
                       )
                      : CM.isAssetImage(assetImagePath: controller.imageFile[i])
                      ? Image.asset(
                    '${controller.imageFile[i]}',
                    fit: BoxFit.contain,
                    height: 60.px,
                  )
                      : Image.file(
                    File(controller.imageFile[i]),
                    fit: BoxFit.contain,
                    height: 60.px,
                  ),
                ),
                InkWell(
                  onTap: () => controller.clickOnRemoveFileButton(i: i,indexForLocalData:index),
                  borderRadius: BorderRadius.circular(7.px),
                  child: Container(
                    height: 14.px,
                    width: 14.px,
                    decoration: BoxDecoration(shape: BoxShape.circle, gradient: CW.commonLinearGradientForButtonsView()),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: Col.gBottom,
                        size: 10.px,
                      ),
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
            Icon(Icons.add, color: Col.primary, size: 18.px),
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

  Widget submitButtonView() => Container(
    height: 80.px,
    padding: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 24.px, top: 10.px),
    color: Col.gBottom,
    child: Center(
      child: CW.myElevatedButton(
        onPressed: controller.submitButtonValue.value
            ? () => null
            : () => controller.clickOnSubmitButton(),
        buttonText:  'Submit',
        borderRadius: 10.px,
        isLoading: controller.submitButtonValue.value,
      ),
    ),
  );

}

class ProgressBarPainter extends CustomPainter {
  final int progress;

  ProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = CW
          .commonLinearGradientForButtonsView()
          .createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    double filledWidth = (progress / 100) * size.width;
    Rect filledRect = Rect.fromLTRB(0, 0, filledWidth, size.height);
    canvas.drawRect(filledRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
