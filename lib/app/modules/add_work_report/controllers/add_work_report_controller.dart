import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class AddWorkReportController extends GetxController {
  final count = 0.obs;

  final key = GlobalKey<FormState>();

  final apiResValue = true.obs;

  final addButtonValue = false.obs;

  final QuillEditorController quillEditorController = QuillEditorController();
  final hasFocus = false.obs;
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    // ToolBarStyle.addTable,
    // ToolBarStyle.editTable,
  ];
  final editorText = ''.obs;

  final dateController = TextEditingController();
  FocusNode focusNodeDate = FocusNode();


  final attachFileShowAndHiedValue = true.obs;
  final result = Rxn<FilePickerResult>();
  List<File> imageFilePath = [];
  final imageFile = [];
  Set<String> existingFilePaths = <String>{};

  Map<String, dynamic> bodyParamsForAddWorkReportApi = {};


  @override
  void onInit() {
    super.onInit();
    dateController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${DateTime.now()}');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    quillEditorController.dispose();
    super.dispose();
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnDateTextFormFiled({required BuildContext context}) async {
    quillEditorController.unFocus();
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: dateController,
      // firstDate: DateTime.now(),
      initialDate: dateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateController.text)
          : DateTime.now(),
      lastDate: dateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateController.text).add(const Duration(days: 20))
          : DateTime.now().add(const Duration(days: 20)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnAttachFileButton() async {
    result.value = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'jpg',
        'pdf',
        'doc',
        'doc',
        'docx',
      ],
    );
    if (result.value != null) {

      final files = result.value?.paths.map((path) => File(path!)).toList();

      for (File file in files!) {
        if (!existingFilePaths.contains(file.path)){
          if (CM.isImage(file: file)) {
            imageFile.add(file.path);
          } else if (CM.isPDF(file: file)) {
            imageFile.add('assets/images/pdf_log_image.png');
          }else if (CM.isExcel(file: file)) {
            imageFile.add('assets/images/excel_log_image.png');
          } else if (CM.isDoc(file: file)) {
            imageFile.add('assets/images/document_log_image.png');
          } else if (CM.isPPT(file: file)) {
            imageFile.add('assets/images/ppt_log_image.png');
          } else {
            print('Other file: ${file.path}');
          }
          imageFilePath.add(file);
          existingFilePaths.add(file.path);
        }
      }

      attachFileShowAndHiedValue.value = false;
      count.value++;
    }

  }

  void clickOnAddMoreButton() {
    attachFileShowAndHiedValue.value = true;
  }

  void clickOnRemoveFileButton({required int index}) {
    existingFilePaths.remove(imageFilePath[index].path);

    imageFilePath.removeAt(index);

    imageFile.removeAt(index);

    if(imageFile.isEmpty && imageFilePath.isEmpty){
      attachFileShowAndHiedValue.value = true;
    }
    count.value++;
  }

  Future<void> clickOnAddButton() async {
    if(key.currentState!.validate()){
      if(editorText.value.isNotEmpty) {
        await callingAddWorkReportApi(editorText: editorText.value);
      }else{
        CM.showSnackBar(message: 'Enter work report');
      }
    }
  }

  Future<void> callingAddWorkReportApi({required String editorText}) async {
    try{
      addButtonValue.value = true;
      bodyParamsForAddWorkReportApi = {
        AK.action: ApiEndPointAction.addWorkReport,
        AK.workReport: CM.removeHtmlTags(editorText),
        AK.workReportDate: CMForDateTime.dateTimeFormatForApi(dateTime: dateController.text.trim().toString()),
      };
      http.Response? response = await CAI.addWorkReportApi(bodyParams: bodyParamsForAddWorkReportApi, filePath: imageFilePath);
      if(response != null && response.statusCode == 200){
        Get.back();
      }else{
        CM.error();
      }

    }catch(e){
      CM.error();
      print('callingAddWorkReportApi ::::  error::::  $e');
      addButtonValue.value = false;
    }
    addButtonValue.value = false;
  }

}
