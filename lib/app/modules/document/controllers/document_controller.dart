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
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_bottomsheet/cbs.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:share_plus/share_plus.dart';

class DocumentController extends GetxController {

  final count = 0.obs;

  final accessType = ''.obs;
  final isChangeable = ''.obs;
  final profileMenuName = ''.obs;

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

  final docType = ''.obs;
  final docTypeLogo = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    accessType.value = Get.arguments[0];
    isChangeable.value = Get.arguments[1];
    profileMenuName.value = Get.arguments[2];
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
      String docTypeLocal = CM.getDocumentType(filePath: '${getDocumentDetails?[index].documentFile}');
      if (docTypeLocal == 'PDF') {
        await showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => Material(
            child: InteractiveViewer(
              child: SafeArea(
                child: SfPdfViewer.network(
                  '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',
                ),
              ),
            ),
          ),
        );
      }
      else if(docTypeLocal == 'Image'){
        await showGeneralDialog(
          context: context,
          barrierColor: Col.inverseSecondary,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Material(
              child: Center(
                child: InteractiveViewer(
                  child: SafeArea(
                    child: commonContainerForImage(
                      networkImage:
                          '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
      else{
        if (!await launcher.launchUrl(
          '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',
          const LaunchOptions(mode: PreferredLaunchMode.inAppBrowserView),
        )) {
          throw Exception('Could not launch ${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}');
        }
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
          text: 'Detail',
          onTap: () => clickOnDetailButton(index: index),
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
              if (pdfDownloadValue.value) SizedBox(height: 6.px),
              if (pdfDownloadValue.value)
                Obx(() {
                  return CW.commonLinearProgressBar(
                      value: pdfProgressBarValue.value);
                }),
              if (pdfDownloadValue.value) SizedBox(height: 4.px),
              if (pdfDownloadValue.value)
                Text(pdfProgressBarPerValue.value,
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                    textAlign: TextAlign.end),
            ],
          );
        }),
        SizedBox(height: 16.px),
      ],
    ).whenComplete(() {
      pdfDownloadValue.value = false;
    });
  }

  Future<void> clickOnDetailButton({required int index}) async {
    Get.back();
    await CBS.commonBottomSheet(children: [
      Text('Document Detail', style: Theme.of(Get.context!).textTheme.bodyLarge),
      SizedBox(height: 24.px),
      commonColumn(
          text: 'Name',
          text1: getDocumentDetails?[index].documentName != null &&
                  getDocumentDetails![index].documentName!.isNotEmpty
              ? '${getDocumentDetails?[index].documentName}'
              : 'Data not found!'),
      SizedBox(height: 14.px),
      commonColumn(
          text: 'Date',
          text1: getDocumentDetails?[index].createdDate != null &&
                  getDocumentDetails![index].createdDate!.isNotEmpty
              ? '${getDocumentDetails?[index].createdDate}'
              : 'Data not found!'),
      SizedBox(height: 14.px),
      commonColumn(
          text: 'Upload By',
          text1: getDocumentDetails?[index].createdByName != null &&
                  getDocumentDetails![index].createdByName!.isNotEmpty
              ? '${getDocumentDetails?[index].createdByName}'
              : 'Data not found!'),
      SizedBox(height: 24.px),
    ]);
  }

  Widget commonColumn({required String text, required String text1}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$text:', style: Theme.of(Get.context!).textTheme.labelMedium),
          SizedBox(height: 4.px),
          Text(text1, style: Theme.of(Get.context!).textTheme.titleLarge)
        ],
      );

  void clickOnShareButton({required int index}) {
    Share.share('check out my website https://example.com', subject: 'Look what I made!');
  }

  Future<void> clickOnDownloadButton({required int index}) async {
    try {
      pdfDownloadValue.value = true;
      Random random = Random();
      int randomNumber = random.nextInt(1000);
      if(getDocumentDetails![index].documentFile!.contains('.pdf')){
        await download(url: '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',filename:  "${getDocumentDetails?[index].documentName}$randomNumber.pdf");
        pdfDownloadValue.value = false;
        CM.showSnackBar(message: 'PDF downloaded successfully.');
      }else{
        await download(url: '${AU.baseUrlAllApisImage}${getDocumentDetails?[index].documentFile}',filename:  "${getDocumentDetails?[index].documentName}$randomNumber.image");
        pdfDownloadValue.value = false;
        CM.showSnackBar(message: 'File downloaded successfully.');
      }
      Get.back();
    } catch (e) {
      pdfDownloadValue.value = false;
      CM.error();
      Get.back();
    }
  }

  Widget commonRowForBottomSheet({required String imagePath,required String text,required GestureTapCallback onTap}) => SizedBox(
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
          errorBuilder: (context, error, stackTrace) => CW.commonNetworkImageView(height: 150.px,width: 250.px, path: 'assets/images/default_image.jpg', isAssetImage: true),
        ),
      ),
    );
  }

  Future<void> callingGetDocumentApi() async {
    try {
      bodyParams = {AK.action: ApiEndPointAction.getDocument};
      documentModal.value = await CAI.getDocumentApi(bodyParams: bodyParams);
      if (documentModal.value != null) {
        getDocumentDetails = documentModal.value?.getDocumentDetails;
        getDocumentDetails?.forEach((element) {
          if (element.documentFile!.contains('.pdf')) {
              pdfControllerList.value = {'${element.documentFile}': PdfViewerController()
            };
          }
        });
      }
    } catch (e) {
      apiResValue.value = false;
      CM.error();
    }
  }

  Future download({required String url, required String filename}) async {
    var savePath = '/storage/emulated/0/Download/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout:  const Duration(seconds: 0),
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
    }
  }

  Future<void> clickOnAddViewButton() async {
    await Get.toNamed(Routes.ADD_DOCUMENT);
    onInit();
  }

}
