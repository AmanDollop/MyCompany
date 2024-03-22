import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_notification_modal.dart';
import 'package:task/common/common_methods/cm.dart';

class NotificationController extends GetxController {

  final count = 0.obs;

  final apiResValue = true.obs;

  final getNotificationModal = Rxn<GetNotificationModal>();
  List<UserNotification>? userNotificationList;


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

  clickOnBackButton() {
    Get.back();
  }

  onRefresh() async {
    userNotificationList?.clear();
    await callingGetNotificationApi();
  }

  Future<void> callingGetNotificationApi() async {
    try{
      apiResValue.value = true;
      getNotificationModal.value = await CAI.getNotificationApi(bodyParams: {AK.action:ApiEndPointAction.getUserNotification});
      if(getNotificationModal.value != null){
        userNotificationList = getNotificationModal.value?.userNotification;
      }
    }catch(e){
      print('callingGetNotificationApi :::::  error:::  $e');
      CM.error();
      apiResValue.value = false;
    }
    apiResValue.value = false;
  }

}
