import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_work_report_detail_modal.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class WorkReportDetailController extends GetxController {
  final count = 0.obs;
  final apiResValue = true.obs;
  final workReportId = ''.obs;

  final getWorkReportDetailModal = Rxn<GetWorkReportDetailModal>();
  WorkReportDetail? workDetails;
  List<WorkReportQueAns>? workReportQueAns;
  Map<String, dynamic> bodyParamsForGetWorkReportDetailApi = {};

  final docType = ''.obs;



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

  final dateForWorkReportController = TextEditingController();
  FocusNode focusNodeDateForWorkReport = FocusNode();

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;


  final key = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  FocusNode focusNodeParagraph = FocusNode();

  final radioIndexValue = '-1'.obs;

  List<String> checkBoxType = [];

  final dropDownController = TextEditingController();
  final selectedDropDownValue = ''.obs;


  List<String> selectedItems = [];

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

  final textController = TextEditingController();
  FocusNode focusNodeText = FocusNode();

  @override
  Future<void> onInit() async {
    super.onInit();
    workReportId.value = Get.arguments[0];
    await callingWorkReportDetailApi();
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

  Future<void> callingWorkReportDetailApi() async {
    try {
      bodyParamsForGetWorkReportDetailApi = {
        AK.action: ApiEndPointAction.workReportDetail,
        AK.workReportId: workReportId.value,
      };
      getWorkReportDetailModal.value = await CAI.getWorkReportDetailApi(bodyParams: bodyParamsForGetWorkReportDetailApi);
      if (getWorkReportDetailModal.value != null) {
        workDetails = getWorkReportDetailModal.value?.workReportDetail;

        if(workDetails?.workReportType == '0'){
          if(workDetails?.createdDate != null && workDetails!.createdDate!.isNotEmpty) {
            dateForWorkReportController.text = CMForDateTime.dateFormatForDateMonthYear(date: workDetails?.createdDate ?? '');
          }
        }
        workReportQueAns = workDetails?.workReportQueAns ?? [];
        log('workDetails:::::: ${workReportQueAns}');
      }
    } catch (e) {
      print('callingWorkReportDetailApi:::: error:::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> clickOnImageViewForWorkReport({required int index}) async {
    if (workDetails?.workReportFile?[index] != null && workDetails!.workReportFile![index].isNotEmpty) {
      String docTypeValue = CM.getDocumentType(filePath: '${workDetails?.workReportFile?[index]}');
      if (docTypeValue == 'Image') {
        await showGeneralDialog(
          context: Get.context!,
          barrierColor: Col.inverseSecondary,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Material(
              child: Center(
                child: InteractiveViewer(
                  child: SafeArea(
                    child: commonContainerForImage(
                      networkImage: '${AU.baseUrlAllApisImage}${workDetails?.workReportFile?[index]}',
                    ),
                  ),
                ),
              ),
            );
          },
        );
      } else if (docTypeValue == 'PDF') {
        await showGeneralDialog(
          context: Get.context!,
          pageBuilder: (context, animation, secondaryAnimation) => Material(
            child: InteractiveViewer(
              child: SafeArea(
                child: SfPdfViewer.network(
                  '${AU.baseUrlAllApisImage}${workDetails?.workReportFile?[index]}',
                ),
              ),
            ),
          ),
        );
      } else {
        if (!await launcher.launchUrl('${AU.baseUrlAllApisImage}${workDetails?.workReportFile?[index]}', const LaunchOptions(mode: PreferredLaunchMode.inAppBrowserView))) {
          throw Exception('Could not launch ${AU.baseUrlAllApisImage}${workDetails?.workReportFile?[index]}');
        }
      }
    }
  }

  Widget commonContainerForImage({required String networkImage}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.px, vertical: 4.px),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3.px),
        child: Image.network(
          networkImage,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: Padding(
                padding: EdgeInsets.all(8.px),
                child: CW.commonShimmerViewForImage(),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => CW.commonNetworkImageView(height: 150.px,width: 250.px, path: 'assets/images/default_image.jpg', isAssetImage: true),
        ),
      ),
    );
  }

}
