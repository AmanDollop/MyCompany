import 'package:get/get.dart';

import '../controllers/add_template_question_controller.dart';

class AddTemplateQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTemplateQuestionController>(
      () => AddTemplateQuestionController(),
    );
  }
}
