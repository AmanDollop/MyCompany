import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:task/common/common_methods/cm.dart';

class AddSubTaskController extends GetxController {

  final count = 0.obs;
  final pageName = ''.obs;

  final key = GlobalKey<FormState>();
  final image = Rxn<File?>();

  final subTaskNameController = TextEditingController();
  final selectPriorityController = TextEditingController();
  final taskStartDateController = TextEditingController();
  final taskDueDateController = TextEditingController();
  final dueTimeController = TextEditingController();
  final remarkController = TextEditingController();

  final notCompletedTaskValue = false.obs;
  final repeatTaskValue = false.obs;

  final result = Rxn<FilePickerResult>();
  final docType = ''.obs;
  final imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pageName.value = Get.arguments[0];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnAttachFileButton() async {
    result.value = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'xls', 'xlsx', 'doc', 'docx', 'ppt', 'pptx'],
    );
    print('result.value:::::  ${result.value}');

    if(result.value?.paths !=null && result.value!.paths.isNotEmpty){
      for (var element in result.value!.paths) {
          docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '$element'));
          if(docType.value == 'Image'){
            imagePath.value = '$element';
          }
         print('docType.value::::: ${docType.value}');
      }
    }


  }

  void clickOnAddAndUpdateButton() {
    if(key.currentState!.validate() && notCompletedTaskValue.value && repeatTaskValue.value){
      Get.back();
    }
  }

}
