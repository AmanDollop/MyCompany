import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:task/api/api_model/sub_task_data_modal.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
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

  TaskDetails? subTaskList;

  @override
  void onInit() {
    super.onInit();
    pageName.value = Get.arguments[0];
    if (pageName.value == 'Update Sub Task') {
      subTaskList = Get.arguments[1];
      setDefaultData();
    }
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

  void setDefaultData() {
    subTaskNameController.text = subTaskList?.taskName ?? '';
    selectPriorityController.text = subTaskList?.taskPriority ?? '';
    taskStartDateController.text = DateFormat('dd MMM yyyy').format(DateTime.parse('${subTaskList?.taskStartDate}'));
    taskDueDateController.text = DateFormat('dd MMM yyyy').format(DateTime.parse('${subTaskList?.taskDueDate}'));
    dueTimeController.text = subTaskList?.taskDueTime ?? '-';
  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnSelectPriorityTextFormFiled() {}

  Future<void> clickOnTaskStartDateTextFormFiled() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: taskStartDateController,
      firstDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      initialDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      lastDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text)
          : DateTime.now(),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnTaskDueDateTextFormFiled() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: taskDueDateController,
      firstDate: taskStartDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskStartDateController.text)
          : DateTime.now(),
      initialDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text)
          : DateTime.now(),
      lastDate: taskDueDateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(taskDueDateController.text)
          : DateTime.now().add(const Duration(days: 20)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  TimeOfDay convertToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  void clickOnDueTimeTextFormFiled() {
    CDT.androidTimePicker(
      context: Get.context!,
      initialTime: dueTimeController.text.isNotEmpty
          ? convertToTimeOfDay(dueTimeController.text)
          : TimeOfDay.now(),
    ).then((value) {
      dueTimeController.text = '${value?.hour}:${value?.minute}';
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
        'xls',
        'xlsx',
        'doc',
        'docx',
        'ppt',
        'pptx'
      ],
    );
    if (result.value?.paths != null && result.value!.paths.isNotEmpty) {
      for (var element in result.value!.paths) {
        docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '$element'));
        if (docType.value == 'Image') {
          imagePath.value = '$element';
        }
      }
    }
  }

  void clickOnAddAndUpdateButton() {
    if (key.currentState!.validate() && notCompletedTaskValue.value && repeatTaskValue.value) {
      Get.back();
    }
  }
}
