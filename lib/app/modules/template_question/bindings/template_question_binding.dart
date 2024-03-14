import 'package:get/get.dart';

import '../controllers/template_question_controller.dart';

class TemplateQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplateQuestionController>(
      () => TemplateQuestionController(),
    );
  }
}
