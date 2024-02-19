import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task/common/common_method_for_date_time/common_methods_for_date_time.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/circular_detail_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/commmon_date_time/cdt.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:task/common/common_widgets/cw.dart';
import 'package:task/theme/colors/colors.dart';


class CircularController extends GetxController {
  final count = 0.obs;

  final apiResValue = true.obs;
  final isLastPage = false.obs;
  final hideSearchFieldValue = false.obs;

  final menuName = ''.obs;

  DateTime currentDate = DateTime.now();
  DateTime? newDate;
  String? startDate;

  final searchController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  final circularDetailModal = Rxn<CircularDetailModal>();
  List<Circular> circularList = [];
  String limit = '10';
  final offset = 0.obs;
  Map<String, dynamic> bodyParamsForCircularDetail = {};
  final docType = ''.obs;

  Timer? searchOnStoppedTyping;

  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      menuName.value = Get.arguments[0];
      newDate = currentDate.subtract(const Duration(days: 30));
      startController.text = CMForDateTime.dateFormatForDateMonthYear(date: '${newDate ?? currentDate}');
      endController.text = CMForDateTime.dateFormatForDateMonthYear(date: '$currentDate');
      await callingCircularDetailApi();
    } catch (e) {
      print('e::::::::  $e');
      apiResValue.value = false;
    }
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

  Future<void> clickOnStartTextField() async {
     await CDT.iosPicker1(
            context: Get.context!,
            dateController: startController,
            initialDate: startController.text.isNotEmpty
                ? DateFormat('dd MMM yyyy').parse(startController.text)
                : DateTime.now(),
     ).whenComplete(() async {
       CM.unFocusKeyBoard();
       apiResValue.value = true;
       offset.value = 0;
       await callingCircularDetailApi();
       apiResValue.value = false;
     });

  }

  Future<void> clickOnEndTextField() async {
   await CDT.iosPicker1(
            context: Get.context!,
            dateController: endController,
            firstDate: DateFormat('dd MMM yyyy').parse(startController.text),
            initialDate: endController.text.isNotEmpty
                ? DateFormat('dd MMM yyyy').parse(endController.text)
                : DateTime.now(),
   ).whenComplete(() async {
      CM.unFocusKeyBoard();
      apiResValue.value = true;
      offset.value = 0;
      await callingCircularDetailApi();
      apiResValue.value = false;
    });
  }

  void clickOnViewMoreButton({required int index}) {
    CM.unFocusKeyBoard();
    if (circularList.isNotEmpty) {
      Get.toNamed(Routes.CIRCULAR_DETAIL, arguments: [circularList[index]]);
    } else {
      CM.error();
    }
  }

  Future<void> clickOnImageView({required int index,}) async {
    if (circularList[index].attachment != null && circularList[index].attachment!.isNotEmpty) {

      String docTypeValue = CM.getDocumentType(filePath: '${circularList[index].attachment}');

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
                      networkImage: '${AU.baseUrlAllApisImage}${circularList[index].attachment}',
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
      else if(docTypeValue == 'PDF'){
        await showGeneralDialog(
          context: Get.context!,
          pageBuilder: (context, animation, secondaryAnimation) => Material(
            child: InteractiveViewer(
              child: SafeArea(
                child: SfPdfViewer.network(
                  '${AU.baseUrlAllApisImage}${circularList[index].attachment}',
                ),
              ),
            ),
          ),
        );
      }
      else{
        if (!await launcher.launchUrl(
          '${AU.baseUrlAllApisImage}${circularList[index].attachment}',
          const LaunchOptions(mode: PreferredLaunchMode.inAppBrowserView),
        )) {
          throw Exception('Could not launch ${AU.baseUrlAllApisImage}${circularList[index].attachment}');
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

  Future<void> callingCircularDetailApi() async {
    try {

      bodyParamsForCircularDetail = {
        AK.action: ApiEndPointAction.getCirculars,
        AK.limit: limit.toString(),
        AK.offset: offset.toString(),
        AK.search: searchController.text.trim().toString(),
        AK.startDate: CMForDateTime.dateTimeFormatForApi(dateTime: startController.text.trim().toString()),
        AK.endDate: CMForDateTime.dateTimeFormatForApi(dateTime: endController.text.trim().toString()),
      };
      circularDetailModal.value = await CAI.getCircularDetailApi(bodyParams: bodyParamsForCircularDetail);
      if (offset.value == 0) {
        apiResValue.value = true;
        circularList.clear();
        isLastPage.value = false;
      }
      if (circularDetailModal.value != null) {
        if (circularDetailModal.value?.circular != null && circularDetailModal.value!.circular!.isNotEmpty) {
          circularList.addAll(circularDetailModal.value?.circular ?? []);
        } else {
          isLastPage.value = true;
        }
      }
    } catch (e) {
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  Future<void> searchOnChange({String? value}) async {
    try {
      if (value != null) {
        const duration = Duration(milliseconds: 800); // set the duration that you want call search() after that.
        if (searchOnStoppedTyping != null) {
          searchOnStoppedTyping?.cancel(); // clear timer
        }
        searchOnStoppedTyping = Timer(duration, () async {
          circularList.clear();
          await callingCircularDetailApi();
        });
      }
    } catch (e) {
      CM.error();
    }
  }

  Future<void> onLoadMore() async {
    offset.value = offset.value + 10;
    try {
      await callingCircularDetailApi();
    } catch (e) {
      CM.error();
    }
  }

  Future<void> onRefresh() async {
    apiResValue.value=true;
    offset.value=0;
    // circularList.clear();
    await onInit();
  }
}

