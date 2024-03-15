import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class AddDocumentController extends GetxController {

  final count = 0.obs;
  final key = GlobalKey<FormState>();
  final docNameController = TextEditingController();
  FocusNode focusNodeForDocName = FocusNode();

  final remarkController = TextEditingController();
  FocusNode focusNodeForRemark = FocusNode();


  final result = Rxn<FilePickerResult>();
  final imageFile = Rxn<File>();
  final docType = ''.obs;

  final addButtonValue = false.obs;

  Map<String,dynamic> bodyParamsForAddDocument = {};

  @override
  void onInit() {
    super.onInit();
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

    if(result.value != null){
      imageFile.value = await CM.pickFilePickerResultAndConvertFile(result1: result.value);
      print('imageFile.value::::: ${imageFile.value}');
      if(result.value?.paths != null && result.value!.paths.isNotEmpty){
        for (var element in result.value!.paths) {
          docType.value = CM.getDocumentTypeLogo(fileType: CM.getDocumentType(filePath: '$element'));
        }
      }
    }
  }

  void clickOnRemoveFileButton() {
    result.value = null;
    imageFile.value = null;
    docType.value = '';
  }



  Future<void> clickOnAddAndUpdateButton() async {
    CM.unFocusKeyBoard();
    if(key.currentState!.validate()){
      addButtonValue.value=true;
      await callingAddDocumentApi();
    }
  }

  Future<void> callingAddDocumentApi() async {
    try{
      bodyParamsForAddDocument = {
        AK.action : ApiEndPointAction.addDocument,
        AK.documentName : docNameController.text.trim().toString(),
        AK.remark : remarkController.text.trim().toString(),
      };
      http.Response? response = await CAI.addDocumentApi(
        bodyParams: bodyParamsForAddDocument,
        filePath: imageFile.value,
      );
      if(response != null){
        if(response.statusCode == 200){
          Map<String,dynamic> mapRes = {};
          mapRes = jsonDecode(response.body);
          CM.showSnackBar(message: mapRes['message']);
          Get.back();
          addButtonValue.value=false;
        }
      }else{
        CM.error();
        addButtonValue.value=false;
      }
    }catch(e){
      CM.error();
      addButtonValue.value=false;
    }
  }

}
