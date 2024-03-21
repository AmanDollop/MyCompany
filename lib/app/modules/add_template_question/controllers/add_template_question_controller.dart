import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_template_question_modal.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_packages/image_picker/ip.dart';
import '../../../../common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class AddTemplateQuestionController extends GetxController {

  final count = 0.obs;

  final apiResValue = true.obs;

  final key = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  FocusNode focusNodeParagraph = FocusNode();

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

  final radioIndexValue = '-1'.obs;
  final radioType = ''.obs;

  final checkBoxText = [
    'User experience and User interface designer1.',
    'User experience and User interface designer2.',
    'User experience and User interface designer4.',
  ];
  final checkBoxIndexValue = '-1'.obs;
  List<String> checkBoxType = [];

  final isDropDownOpenValue = false.obs;
  final dropDownController = TextEditingController();
  final selectedDropDownValue = ''.obs;


  List<String> selectedItems = [];
  final isMultipleSelectDropDownOpenValue = false.obs;

  final dateController = TextEditingController();
  FocusNode focusNodeDate = FocusNode();

  final timeController = TextEditingController();
  FocusNode focusNodeTime = FocusNode();

  String dateAndTimeBothValueAdd = '';
  final dateForDateAndTimeController = TextEditingController();
  FocusNode focusNodeDateForDateAndTime = FocusNode();
  final timeForDateAndTimeController = TextEditingController();
  FocusNode focusNodeTimeForDateAndTime = FocusNode();

  final progress = 0.obs;

  String topicAndTimeBothValueAdd = '';
  final topicWithTimeForTopicController = TextEditingController();
  FocusNode focusNodeTopicWithTimeForTopic = FocusNode();
  final timeForTopicController = TextEditingController();
  FocusNode focusNodeTimeForTopic = FocusNode();

  String paragraphAndTimeBothValueAdd = '';
  final descriptionWithTimeForParagraphController = TextEditingController();
  FocusNode focusNodeParagraphWithTimeForParagraph = FocusNode();
  final timeForParagraphController = TextEditingController();
  FocusNode focusNodeTimeForParagraph = FocusNode();

  final attachFileShowAndHiedValue = true.obs;
  final result = Rxn<FilePickerResult>();
  List<File> imageFilePath = [];
  final imageFile = [];
  List<File> imageFileFormCamera = [];
  Set<String> existingFilePaths = <String>{};
  final image = Rxn<File?>();


  final textController = TextEditingController();
  FocusNode focusNodeText = FocusNode();

  final submitButtonValue = false.obs;

  final getTemplateQuestionModal = Rxn<GetTemplateQuestionModal>();
  List<TemplateQuestion>? templateQuestionList;
  Map<String, dynamic> bodyParamsForGetTemplateQuestionApi = {};

  final templateId = ''.obs;

  List<LocalDataForQuestionAndAnswer> localDataList = [];
  List<LocalDataForImages> localDataForImages = [];

  Map<String, dynamic> bodyParamsForSubmitTemQuestionApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    templateId.value = Get.arguments[0];
    await callingGetTemplateQuestionApi();
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

  Future<void> clickOnDateTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: dateController,
      initialDate: dateController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateController.text)
          : DateTime.now(),
      lastDate: dateController.text.isNotEmpty
          ? DateTime(DateFormat('dd MMM yyyy').parse(dateController.text).year+5)
          : DateTime(DateTime.now().year + 5),
    ).whenComplete(
          () => CM.unFocusKeyBoard(),
    );
  }

  Future<void> clickOnTimeTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: timeController,
      mode: CupertinoDatePickerMode.time,
      firstDate: timeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeController.text)
          : DateTime.now(),
      initialDate: timeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeController.text)
          : DateTime.now(),
      lastDate: timeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeController.text).add(const Duration(hours: 12))
          : DateTime.now().add(const Duration(hours: 12)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  Future<void> clickOnDateForDateAndTimeTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: dateForDateAndTimeController,
      initialDate: dateForDateAndTimeController.text.isNotEmpty
          ? DateFormat('dd MMM yyyy').parse(dateForDateAndTimeController.text)
          : DateTime.now(),
      lastDate: dateForDateAndTimeController.text.isNotEmpty
          ? DateTime(DateFormat('dd MMM yyyy').parse(dateForDateAndTimeController.text).year+5)
          : DateTime(DateTime.now().year + 5),
    ).whenComplete(
          () => CM.unFocusKeyBoard(),
    );
  }

  Future<void> clickOnTimeForDateAndTimeTextField() async {
    await CDT.iosPicker1(
      context: Get.context!,
      dateController: timeForDateAndTimeController,
      mode: CupertinoDatePickerMode.time,
      firstDate: timeForDateAndTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeForDateAndTimeController.text)
          : DateTime.now(),
      initialDate: timeForDateAndTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeForDateAndTimeController.text)
          : DateTime.now(),
      lastDate: timeForDateAndTimeController.text.isNotEmpty
          ? DateFormat('hh:mm a').parse(timeForDateAndTimeController.text).add(const Duration(hours: 12))
          : DateTime.now().add(const Duration(hours: 12)),
    ).whenComplete(() async {
      CM.unFocusKeyBoard();
    });
  }

  onValueChangedForDateWithTime({required int index}) {
    String value1 = dateForDateAndTimeController.text.trim().toString();
    String value2 = timeForDateAndTimeController.text.trim().toString();

    if (value1.isNotEmpty && value2.isNotEmpty) {
      dateAndTimeBothValueAdd = '$value1~~~$value2';
    } else if (value1.isNotEmpty) {
      dateAndTimeBothValueAdd = value1;
    } else if (value2.isNotEmpty) {
      dateAndTimeBothValueAdd = value2;
    }
    if(dateAndTimeBothValueAdd.isNotEmpty) {
      localDataList[index].answer = dateAndTimeBothValueAdd.toString();
    }
    print('dateAndTimeBothValueAdd:::: $dateAndTimeBothValueAdd');

  }

  onValueChangedForTopicWithTime({required int index}) {
    String value1 = topicWithTimeForTopicController.text.trim().toString();
    String value2 = timeForTopicController.text.trim().toString();

    if (value1.isNotEmpty && value2.isNotEmpty) {
      topicAndTimeBothValueAdd = '$value1~~~$value2';
    } else if (value1.isNotEmpty) {
      topicAndTimeBothValueAdd = value1;
    } else if (value2.isNotEmpty) {
      topicAndTimeBothValueAdd = value2;
    }
    if(topicAndTimeBothValueAdd.isNotEmpty) {
      localDataList[index].answer = topicAndTimeBothValueAdd.toString();
    }
    print('topicAndTimeBothValueAdd:::: $topicAndTimeBothValueAdd');

  }

  onValueChangedForParagraphWithTime({required int index}) {
    String value1 = descriptionWithTimeForParagraphController.text.trim().toString();
    String value2 = timeForParagraphController.text.trim().toString();

    if (value1.isNotEmpty && value2.isNotEmpty) {
      paragraphAndTimeBothValueAdd = '$value1~~~$value2';
    } else if (value1.isNotEmpty) {
      paragraphAndTimeBothValueAdd = value1;
    } else if (value2.isNotEmpty) {
      paragraphAndTimeBothValueAdd = value2;
    }
    if(paragraphAndTimeBothValueAdd.isNotEmpty) {
      localDataList[index].answer = paragraphAndTimeBothValueAdd.toString();
    }
    print('paragraphAndTimeBothValueAdd:::: $paragraphAndTimeBothValueAdd');

  }

  methodForLocalDataForImages({required String templateQuestionId,required List<File> attachment}){
    LocalDataForImages localDataForImages = LocalDataForImages(
      templateQuestionId: templateQuestionId,
      attachments: attachment
    );
    return localDataForImages;
  }

  Future<void> clickOnTakePhoto({required int indexForLocalData}) async {
    Get.back();
    image.value = await IP.pickImage(
      isCropper: true,
    );
    if(image.value != null && image.value?.path != null && image.value!.path.isNotEmpty){
      imageFile.add(image.value?.path);
      imageFilePath.add(image.value!);
      existingFilePaths.add(image.value!.path);
      attachFileShowAndHiedValue.value = false;
      // localDataForImages[indexForLocalData].attachment = imageFilePath.toList();
      localDataForImages.add(methodForLocalDataForImages(templateQuestionId: templateQuestionList?[indexForLocalData].templateQuestionId??'', attachment: imageFilePath),);
    }
    print('imageFilePath:::: $imageFilePath');
    count.value++;
  }

  Future<void> clickOnChooseFromLibrary({required int indexForLocalData}) async {
    Get.back();
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
          localDataForImages.add(methodForLocalDataForImages(templateQuestionId: templateQuestionList?[indexForLocalData].templateQuestionId??'', attachment: imageFilePath),);
        }
      }
      // localDataForImages[indexForLocalData].attachment = imageFilePath;
      attachFileShowAndHiedValue.value = false;
      count.value++;
    }
    count.value++;
  }

  Future<void> clickOnAttachFileForBothOptionButton({required int indexForLocalData}) async {
    CM.unFocusKeyBoard();
    CBS.commonBottomSheetForImagePicker(
      clickOnTakePhoto: () async => await clickOnTakePhoto(indexForLocalData: indexForLocalData),
      clickOnChooseFromLibrary: () async => await clickOnChooseFromLibrary(indexForLocalData: indexForLocalData),
    );
  }

  Future<void> clickOnAttachFileOnlyCameraButton({required int indexForLocalData}) async {
    image.value = await IP.pickImage(
      isCropper: true,
    );
    if(image.value != null && image.value?.path != null && image.value!.path.isNotEmpty){
      imageFileFormCamera.add(image.value!);
      // localDataForImages[indexForLocalData].attachment = imageFileFormCamera.toList();
      localDataForImages.add(methodForLocalDataForImages(templateQuestionId: templateQuestionList?[indexForLocalData].templateQuestionId??'', attachment: imageFileFormCamera),);
    }
    count.value++;
  }

  void clickOnAddMoreButton() {
    attachFileShowAndHiedValue.value = true;
    count.value++;
  }

  void clickOnRemoveFileButton({required int i, required int indexForLocalData}) {
    if(templateQuestionList?[indexForLocalData].templateQuestionUploadType == '0'){
      existingFilePaths.remove(imageFilePath[i].path);
      imageFilePath.removeAt(i);
      imageFile.removeAt(i);
      if(imageFile.isEmpty && imageFilePath.isEmpty){
        attachFileShowAndHiedValue.value = true;
      }
      // localDataForImages[indexForLocalData].attachment = imageFilePath.toList();
      localDataForImages.remove(methodForLocalDataForImages(templateQuestionId: templateQuestionList?[indexForLocalData].templateQuestionId??'', attachment: imageFilePath),);
    }else{
      imageFileFormCamera.removeAt(i);
      // localDataForImages[indexForLocalData].attachment = imageFileFormCamera.toList();
      localDataForImages.remove(methodForLocalDataForImages(templateQuestionId: templateQuestionList?[indexForLocalData].templateQuestionId??'', attachment: imageFileFormCamera),);
    }
    count.value++;
  }

  Future<void> callingGetTemplateQuestionApi() async {
    try{
      apiResValue.value = true;
      bodyParamsForGetTemplateQuestionApi = {
        AK.action : ApiEndPointAction.getTemplateQuestion,
        AK.templateId : templateId.value
      };
      getTemplateQuestionModal.value = await CAI.getTemplateQuestionApi(bodyParams: bodyParamsForGetTemplateQuestionApi);
      if(getTemplateQuestionModal.value != null){

       templateQuestionList = getTemplateQuestionModal.value?.templateQuestion;

       templateQuestionList?.forEach((element) {
         LocalDataForQuestionAndAnswer localData1 = LocalDataForQuestionAndAnswer(
           templateQuestionId: element.templateQuestionId,
           templateQuestionType: element.templateQuestionType,
           answer: '',
         );
         localDataList.add(localData1);
        },
       );

      }
    }catch(e){
      print('callingGetTemplateQuestionApi::::::::  Error::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> clickOnSubmitButton() async {
    if(key.currentState!.validate()){
      submitButtonValue.value = true;
      await callingSubmitTemQuestionApi();
    }
  }

  Future<void> callingSubmitTemQuestionApi() async {
    try{
      log('log:    localDataList::::  ${json.encode(localDataList)}');

      bodyParamsForSubmitTemQuestionApi = {
        AK.action: ApiEndPointAction.submitWorkReportTemplate,
        AK.templateId: templateId.value,
        AK.workReportDate: CMForDateTime.dateTimeFormatForApi(dateTime: dateController.text.trim().toString()),
        AK.templateAnswer: json.encode(localDataList),
      };

      Map<String, List<File>>? imageMap = {};

      for (LocalDataForImages data in localDataForImages) {

        String? templateQuestionId = data.templateQuestionId;

        String key = 'attachment_$templateQuestionId[]';

        List<File> attachmentsList = data.attachments ?? [];

        imageMap[key] = attachmentsList;

        log('bodyParams $bodyParamsForSubmitTemQuestionApi');
        log('imageMap $imageMap');

      }

      http.Response? response = await CAI.submitTemQuestionApi(bodyParams: bodyParamsForSubmitTemQuestionApi, imageMap: imageMap);
      if(response != null && response.statusCode == 200){
        Get.back();
      }else{
        CM.error();
      }

    }catch(e){
      CM.error();
      print('callingAddWorkReportApi ::::  error::::  $e');
      submitButtonValue.value = false;
    }
    submitButtonValue.value = false;
  }

 /* Future<void> callingSubmitTemQuestionApi() async {
    try{

      bodyParamsForSubmitTemQuestionApi = {
        AK.action: ApiEndPointAction.submitWorkReportTemplate,
        AK.templateId: templateId.value,
        AK.workReportDate: CMForDateTime.dateTimeFormatForApi(dateTime: dateController.text.trim().toString()),
        AK.templateAnswer: json.encode(localDataList),
      };

      Map<String, List<File>>? m = {};

      for (LocalDataForImages data in localDataForImages) {

        String? templateQuestionId = data.templateQuestionId;

        String key = 'Q_$templateQuestionId';

        List<File> attachmentsList = data.attachments ?? [];

        m[key] = attachmentsList;

        print('attachmentsList::::  ${attachmentsList}');

        log('bodyParams $bodyParamsForSubmitTemQuestionApi');
        log('imageMap $m');

      }

     http.Response? re = await uploadFilesToApi(bodyParams: bodyParamsForSubmitTemQuestionApi, imageMap: m,);
      if(re != null){
        Map<String, dynamic> responseMap = jsonDecode(re.body);
        print('resS:::::  ${responseMap[AK.message]}');
      }

    }catch(e){
      CM.error();
      print('callingAddWorkReportApi ::::  error::::  $e');
      submitButtonValue.value = false;
    }
    submitButtonValue.value = false;
  }*/

}



class LocalDataForQuestionAndAnswer {
  String? templateQuestionId;
  String? templateQuestionType;
  String? answer;
  // bool? isQuestionRequired;

  LocalDataForQuestionAndAnswer({
    this.templateQuestionId,
    this.templateQuestionType,
    this.answer,
    // this.isQuestionRequired
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question_id'] = templateQuestionId;
    data['template_question_type'] = templateQuestionType;
    data['answer'] = answer;
    // data['isQuestionRequired'] = isQuestionRequired;
    return data;
  }

  factory LocalDataForQuestionAndAnswer.fromJson(Map<String, dynamic> json) {
    return LocalDataForQuestionAndAnswer(
      templateQuestionId: json['template_question_id'],
      templateQuestionType: json['template_question_type'],
      answer: json['answer'],
      // isQuestionRequired: json['isQuestionRequired'],
    );
  }
}

/*class LocalDataForImages {
  String? templateQuestionId;
  File? attachments;

  LocalDataForImages({
    this.templateQuestionId,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question_id'] = templateQuestionId;
    data['answer'] = attachments;
    return data;
  }

  factory LocalDataForImages.fromJson(Map<String, dynamic> json) {
    return LocalDataForImages(
      templateQuestionId: json['template_question_id'],
      attachments: json['answer'] != null ? File(json['answer']) : null,
    );
  }
}*/

class LocalDataForImages {
  String? templateQuestionId;
  List<File>? attachments;

  LocalDataForImages({
    this.templateQuestionId,
    this.attachments,
  });

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question_id'] = templateQuestionId;
    data['answer'] = attachments;
    // data['isQuestionRequired'] = isQuestionRequired;
    return data;
  }

  factory LocalDataForImages.fromJson(Map<String, dynamic> json) {
    return LocalDataForImages(
      templateQuestionId: json['template_question_id'],
      attachments: json['answer'],
      // isQuestionRequired: json['isQuestionRequired'],
    );
  }*/

Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['template_question_id'] = templateQuestionId;
    data['attachments'] = attachments?.map((file) => file.path).toList();
    return data;
  }

  factory LocalDataForImages.fromJson(Map<String, dynamic> json) {
    return LocalDataForImages(
      templateQuestionId: json['template_question_id'],
      attachments: (json['attachments'] as List<dynamic>?)?.map((path) => File(path as String)).toList(),
    );
  }
}

