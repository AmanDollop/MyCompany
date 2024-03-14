import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_work_report_detail_modal.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class WorkReportDetailController extends GetxController {
  final count = 0.obs;
  final apiResValue = true.obs;
  final workReportId = ''.obs;

  final getWorkReportDetailModal = Rxn<GetWorkReportDetailModal>();
  WorkDetails? workDetails;
  Map<String, dynamic> bodyParamsForGetWorkReportDetailApi = {};

  final docType = ''.obs;

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

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
        AK.action: ApiEndPointAction.workDetails,
        AK.workReportId: workReportId.value,
      };
      getWorkReportDetailModal.value = await CAI.getWorkReportDetailApi(
          bodyParams: bodyParamsForGetWorkReportDetailApi);
      if (getWorkReportDetailModal.value != null) {
        workDetails = getWorkReportDetailModal.value?.workDetails;
        print('workDetails:::::: ${workDetails?.workReport}');
      }
    } catch (e) {
      print('callingWorkReportDetailApi:::: error:::::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> clickOnImageView({required int index}) async {
    if (workDetails?.workReportFile?[index] != null && workDetails!.workReportFile![index].isNotEmpty) {
      String docTypeValue =
          CM.getDocumentType(filePath: '${workDetails?.workReportFile?[index]}');
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
