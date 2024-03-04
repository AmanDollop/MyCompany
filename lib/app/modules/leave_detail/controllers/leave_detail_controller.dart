import 'package:get/get.dart';
import 'package:task/api/api_constants/ac.dart';
import 'package:task/api/api_intrigation/api_intrigation.dart';
import 'package:task/api/api_model/get_leave_detail_modal.dart';
import 'package:task/app/routes/app_pages.dart';
import 'package:task/common/common_methods/cm.dart';

class LeaveDetailController extends GetxController {

  final count = 0.obs;
  final getLeaveId = ''.obs;

  final apiResValue = true.obs;

  final getLeaveDetailModal = Rxn<GetLeaveDetailModal>();
  GetLeaveDetails? getLeaveDetailsList;
  Map<String, dynamic> bodyParamsForGetLeaveDetailApi = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    getLeaveId.value = Get.arguments[0];
    await callingGetLeaveDetailApi();
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

  onRefresh() async {
    apiResValue.value = true;
    await onInit();
  }

  void clickOnBackButton() {
    Get.back();
  }

  void clickOnEditButton() {
    Get.toNamed(Routes.ADD_LEAVE,arguments: ['Update Leave']);
  }

  Future<void> callingGetLeaveDetailApi() async {
    try{
      bodyParamsForGetLeaveDetailApi = {
        AK.action : ApiEndPointAction.getLeaveDetails,
        AK.leaveId : getLeaveId.value
      };
      getLeaveDetailModal.value = await CAI.getLeaveDetailApi(bodyParams: bodyParamsForGetLeaveDetailApi);
      if(getLeaveDetailModal.value != null){
        getLeaveDetailsList = getLeaveDetailModal.value?.getLeaveDetails;
        print('getLeaveDetailsList::::   $getLeaveDetailsList');
      }
    }catch(e){
      CM.error();
      apiResValue.value = false;
      print('callingGetLeaveDetailApi:::::  error :::::  $e');
    }
    apiResValue.value = false;
  }

}
