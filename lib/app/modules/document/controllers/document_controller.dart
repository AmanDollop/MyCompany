// ignore_for_file: avoid_function_literals_in_foreach_calls, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/document_modal.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class DocumentController extends GetxController {
  final count = 0.obs;
  final apiResValue = true.obs;

  final documentModal = Rxn<DocumentModal>();
  List<GetDocumentDetails>? getDocumentDetails;
  Map<String, dynamic> bodyParams = {};
  final PdfViewerController pdfViewerController = PdfViewerController();
  final pdfControllerList = <String, PdfViewerController>{}.obs;
  final pdfDownloadValue = false.obs;
  final pdfProgressBarValue = 0.0.obs;
  final pdfProgressBarPerValue = '0 %'.obs;
  final pdfDownloadLocalPath = ''.obs;
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetDocumentApi();
    apiResValue.value = false;
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

  Future<void> clickOnDocument({required int index, required BuildContext context}) async {
    if (getDocumentDetails?[index].documentFile != null && getDocumentDetails![index].documentFile!.isNotEmpty) {
      if (getDocumentDetails![index].documentFile!.contains('.pdf')) {
        await showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => SafeArea(
            child: SfPdfViewer.network(
              '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',
            ),
          ),
        );
      } else {
        await showGeneralDialog(
          context: context,
          barrierColor: Col.inverseSecondary,
          pageBuilder: (context, animation, secondaryAnimation) {
            return InteractiveViewer(
              child: SafeArea(
                child: commonContainerForImage(
                  networkImage: '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',
                ),
              ),
            );
          },
        );
      }
    }
  }

  Future<void> clickOnMenuButton({required int index, required BuildContext context}) async {
    await CBS.commonBottomSheet(
      isDismissible: false,
      children: [
        commonRowForBottomSheet(
          imagePath: 'assets/icons/view_icon.png',
          text: 'View',
          onTap: () async {
            Get.back();
            await clickOnDocument(index: index, context: context);
          },
        ),
        SizedBox(height: 10.px),
        commonRowForBottomSheet(
          imagePath: 'assets/icons/share_icon.png',
          text: 'Share',
          onTap: () => clickOnShareButton(index: index),
        ),
        SizedBox(height: 10.px),
        commonRowForBottomSheet(
          imagePath: 'assets/icons/download_icon.png',
          text: 'Download',
          onTap: () => clickOnDownloadButton(index: index),
        ),
        Obx(() {
          count.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(pdfDownloadValue.value)
                SizedBox(height: 6.px),
              if(pdfDownloadValue.value)
                Obx(() {
                  return CW.commonLinearProgressBar(value: pdfProgressBarValue.value);
                }),
              if(pdfDownloadValue.value)
                SizedBox(height: 4.px),
              if(pdfDownloadValue.value)
              Text(pdfProgressBarPerValue.value, style: Theme.of(Get.context!).textTheme.titleLarge,textAlign: TextAlign.end),
            ],
          );
        }),
        SizedBox(height: 16.px),
      ],
    ).whenComplete(() {
      pdfDownloadValue.value=false;
    });
  }

  void clickOnShareButton({required int index}) {}

  Future<void> clickOnDownloadButton({required int index}) async {
    try {
      pdfDownloadValue.value = true;
      Random random = Random();
      int randomNumber = random.nextInt(1000);
      await download('${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}', "${getDocumentDetails?[index].documentName}$randomNumber");
      pdfDownloadValue.value = false;
      CM.showSnackBar(message: 'PDF downloaded successfully.');
      Get.back();
    } catch (e) {
      pdfDownloadValue.value = false;
      CM.error();
      Get.back();
    }
  }

  Widget commonRowForBottomSheet({required String imagePath, required String text, required GestureTapCallback onTap,}) => SizedBox(
        height: 35.px,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.px),
          child: Row(
            children: [
              CW.commonNetworkImageView(
                  path: imagePath,
                  isAssetImage: true,
                  width: 20.px,
                  height: 20.px,
                  color: Col.secondary),
              SizedBox(width: 12.px),
              Text(text,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

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
          errorBuilder: (context, error, stackTrace) =>
              CW.commonNetworkImageView(
                  path: 'assets/images/default_image.jpg', isAssetImage: true),
        ),
      ),
    );
  }

  Future<void> callingGetDocumentApi() async {
    try {
      bodyParams = {AK.action: 'getDocument'};
      documentModal.value = await CAI.getDocumentApi(bodyParams: bodyParams);
      if (documentModal.value != null) {
        getDocumentDetails = documentModal.value?.getDocumentDetails;
        getDocumentDetails?.forEach((element) {
          if (element.documentFile!.contains('.pdf')) {
            pdfControllerList.value = {
              '${element.documentFile}': PdfViewerController()
            };
          }
        });
      }
    } catch (e) {
      apiResValue.value = false;
      CM.error();
    }
  }

  Future download(String url, String filename) async {
    var savePath = '/storage/emulated/0/Download/$filename.pdf';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 0),
        ),
      );
      var file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
       pdfDownloadLocalPath.value = raf.path;
      await raf.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      pdfProgressBarValue.value = received / total;
      pdfProgressBarPerValue.value = '${(received / total * 100).toStringAsFixed(0) + '%'}';
      debugPrint('pdfProgressBarValue.value::::::  ${pdfProgressBarValue.value}');
      debugPrint('pdfProgressBarPerValue.value ::::::  ${pdfProgressBarPerValue.value }');
    }
  }
}
