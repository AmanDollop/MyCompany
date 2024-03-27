import 'dart:convert';

import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_notification_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_dialog/cd.dart';
import 'package:task/common/common_methods/cm.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  final count = 0.obs;

  final apiResValue = true.obs;

  final getNotificationModal = Rxn<GetNotificationModal>();
  List<Notification>? notificationList;
  Map<String, dynamic> bodyParamsForGetNotificationApi = {};

  Map<String, dynamic> bodyParamsForDeleteNotificationApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    await callingGetNotificationApi();
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

  onRefresh() async {
    notificationList?.clear();
    await callingGetNotificationApi();
  }

  Future<void> callingGetNotificationApi() async {
    try {
      apiResValue.value = true;
      bodyParamsForGetNotificationApi = {
        AK.action: ApiEndPointAction.getUserNotification
      };
      getNotificationModal.value = await CAI.getNotificationApi(bodyParams: bodyParamsForGetNotificationApi);
      if (getNotificationModal.value != null) {
        notificationList = getNotificationModal.value?.notification;
        print('notificationList:::: ${notificationList?.length}');
      }
    } catch (e) {
      print('callingGetNotificationApi :::::  error:::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

  void clickOnDeleteNotificationButton({required int index}) {
    CD.commonIosDeleteConfirmationDialog(
      clickOnCancel: () => Get.back(),
      clickOnDelete: () async => await callingDeleteNotificationApi(
          userNotificationId: notificationList?[index].userNotificationId ?? '',
      ),
    );
  }

  Future<void> callingDeleteNotificationApi({required String userNotificationId}) async {
    try {
      bodyParamsForDeleteNotificationApi = {
        AK.action: ApiEndPointAction.deleteUserNotification,
        AK.userNotificationId: userNotificationId,
      };
      http.Response? response = await CAI.updateUserControllerApi(bodyParams: bodyParamsForDeleteNotificationApi);
      if (response != null) {
        if (response.statusCode == 200) {
          notificationList?.clear();
          await callingGetNotificationApi();
        } else {
          CM.error();
        }
      } else {
        CM.error();
      }
    } catch (e) {
      CM.error();
    }
    Get.back();
  }

  void clickOnNotification({required int index}) {
    if (notificationList?[index].clickAction == 'task') {
      Get.toNamed(Routes.SUB_TASK, arguments: [
        notificationList?[index].notificationJson?.taskCategoryId,
        notificationList?[index].notificationJson?.taskCategoryName
      ]);
    }
  }

}
