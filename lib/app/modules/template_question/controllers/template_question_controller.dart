import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

class TemplateQuestionController extends GetxController {

  final count = 0.obs;
  final apiResValue = true.obs;
  final submitButtonValue = false.obs;

  @override
  void onInit() {
    super.onInit();
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

  void clickOnSubmitButton() {
    Get.toNamed(Routes.ADD_TEMPLATE_QUESTION);
  }

}
