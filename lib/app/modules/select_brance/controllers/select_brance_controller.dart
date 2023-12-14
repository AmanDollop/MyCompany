import 'package:get/get.dart';

class SelectBranceController extends GetxController {

  final count = 0.obs;
  final branchList = [
    'Ahmedabad',
    'Gandhinagar',
    'Baroda',
    'Surat',
    'Bhavnagar',
    'Goa',
    'Jamnagar',
    'Mumbai',
    'Junagadh',
    'Anand',
    'Pune',
    'Nagpur',
    'Delhi',
    'Ajmer',
    'Hyderabad',
    'Ranchi',
    'Indore',
    'Bengaluru',
  ].obs;

  final branchIndexValue = ''.obs;

  @override
  void onInit() {
    super.onInit();
    branchIndexValue.value = Get.arguments[0] ?? '';
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
    Get.back(result: branchIndexValue.value.toString());
  }

  void clickOnContinueButton() {
    Get.back(result: branchIndexValue.value.toString());
  }
}
